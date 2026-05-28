---
name: power-select-style
description: Activate after detect-target-html-or-ppt , extract signals from the AST, run the R3 Decision Tree, fall back to Mood Map when ambiguous, apply Pairing Rules, and emit a style record.
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Select Style

## Purpose

בוחר סגנון מצגת מ-R3. הסקיל מריץ את Decision Tree כראשי, ואם נשארות אי-בהירויות הוא נופל ל-Mood Clustering Map ומיישם את Style Pairing Rules כדי לנעול fonts/colors/spacing. הסקיל מחזיר tuple אחד: primary + alternative + wildcard + warnings.

## Inputs

- **ast** (כל ה-AST: meta + slides). הסקיל מחלץ ממנו signals.
- **target** מ-`detect-target-html-or-ppt`. משפיע על Pairing Rules (HTML vs PPT).

## Outputs

```yaml
primary:
  style_name: ...           # שם הסגנון מ-R3
  rationale: ...             # משפט עברי קצר למה זה הסגנון
alternative:
  style_name: ...
  rationale: ...
wildcard:                    # בחירה נועזת יותר, ללומד אם רוצה לסטות
  style_name: ...
  rationale: ...
locked:
  fonts:
    heading: ...
    body: ...
  colors:
    primary: "#......"
    accent: "#......"
    background: "#......"
    text: "#......"
  spacing:
    base_unit: 8px           # למשל
    rhythm: ...
warnings:
  - accessibility-tier-c     # אם הסגנון לא עומד ב-WCAG AA
  - rtl-hazard               # אם הסגנון מבוסס על fonts/layout שמתפרקים ב-RTL
  - ...
```

## Process

1. קרא את `../../references/R3-stage-3-output.md`. הקובץ הזה הוא העוגן היחיד שלך, Decision Tree, Mood Map, Master Style Table, Style Pairing Rules, ו-15 הסגנונות עצמם (11 ראשיים + 4 appendix).
2. *שלב 1 , extract signals (5-6 ערכים):*
   - `audience_type`, מתוך ast.meta.audience. סווג לאחת: `executive`, `investor`, `general_public`, `students`, `technical`, `creative`, `mixed`.
   - `tone`, הסק מתוך style_preference וקטעי תוכן. אחת: `formal`, `warm`, `playful`, `urgent`, `meditative`.
   - `industry`, אם נדחק (לדוגמה: fintech, design, healthcare). אחרת `general`.
   - `novelty`, האם הקהל יודע על הנושא? `expected`, `novel`, `disruptive`.
   - `brand_constraint`, האם יש style_preference מפורש? אם כן, השתמש בו כ-weight גבוה. אחרת `none`.
   - `format`, מתוך target + output_type: `html-deck`, `html-slidedoc`, `ppt-deck`, `ppt-slidedoc`, `teleprompter`.
3. *שלב 2 , Run Decision Tree (R3 stage-3-output.md, line 419).* הזן את ה-signals וקבל מועמד style ראשוני. שמור את הענפים שעברת בהם.
4. *שלב 3 , Internal clarifying loop.* אם הוצאת מהעץ 2+ tensions שלא הוכרעו (לדוגמה: audience מתאים לסגנון A אבל tone מתאים לסגנון B):
   - איטרציה 1: הוסף משקל ל-style_preference אם זמין; אם לא, הוסף משקל ל-audience.
   - איטרציה 2: הוסף משקל ל-format.
   - אם אחרי 2 איטרציות עדיין נשארו 2+ tensions -> עבור ל-Mood Map.
5. *שלב 4 , Mood Clustering Map fallback (R3 line 554).* ה-Map ממפה רגש כללי (calm, energetic, sharp, soft, etc.) לסגנונות. אם השלב 3 נכשל, השתמש ב-Map: מיקום ה-signals על שתי צירים (חמימות-קור, פשטות-עושר) -> אשכול -> סגנון.
6. *שלב 5 , Pairing Rules (R3 line 621).* קח את ה-style שנבחר ויישם את Pairing Rules ל-target הנכון (HTML vs PPT). ה-rules נועלים:
   - fonts (heading + body), כולל fallback chain.
   - palette (primary, accent, background, text), כולל בדיקת WCAG AA contrast.
   - spacing (base unit + rhythm).
7. *שלב 6 , בחר alternative ו-wildcard:*
   - *alternative:* סגנון נוסף מתוך אותו אשכול ב-Master Style Table (R3 line 576). תן ללומד אופציה נוספת קרובה.
   - *wildcard:* סגנון נועז יותר, מתוך appendix או מתוך אשכול רחוק יותר. נימוק קצר.
8. *שלב 7 , warnings:*
   - אם בדיקת ה-contrast ב-pairing rules החזירה fail על שילוב primary/text -> הוסף `accessibility-tier-c`.
   - אם meta.language=`he` או `mixed` והסגנון מבוסס על font שלא תומך עברית טוב (לדוגמה: Playfair Display) -> הוסף `rtl-hazard`.
   - אם הסגנון דורש assets חיצוניים שלא יהיו זמינים (לדוגמה: סגנון שמבוסס על video backgrounds) -> הוסף `asset-dependency`.
   - אם style_preference של הלומד התעלם בגלל הכרעות העץ -> הוסף `preference-overridden` עם הסבר קצר.
9. החזר את ה-style record.

## Edge cases

- meta.style_preference ריק לגמרי -> ה-Decision Tree רץ ללא prior. נורמלי.
- meta.style_preference במחרוזת ארוכה ועמומה ("משהו יפה") -> התעלם, כאילו ריק. אל תנסה לפענח.
- audience מעורב (חצי טכני חצי משקיעים) -> סווג ל-`mixed`. ה-Tree יודע להתמודד.
- target=html ו-output_type=teleprompter -> השתמש ב-`teleprompter` format. סגנון teleprompter בדרך כלל מינימליסטי, פונט גדול, ניגודיות גבוהה.
- duration_minutes קצר מאוד (1-3) -> חשוב לבחור סגנון שלא דורש אנימציות ארוכות. סנן הצעות עם heavy transitions.
- כל ה-signals מצביעים על אותו סגנון (case ברור) -> אין צורך ב-alternative או wildcard מהירים; עדיין החזר אותם לטובת בחירה נוספת ללומד.

## Failure modes

- R3 לא נטען (קובץ חסר או corrupt) -> החזר שגיאה גלובלית, בקש מהלומד לבדוק את הספרייה.
- Decision Tree מחזיר 0 sigeons (אף ענף לא תפס) -> ברירת מחדל לסגנון "Editorial Light" (אם זמין ב-R3) או אחר נייטרלי, סמן warning שהסגנון נבחר כברירת מחדל.
- Pairing Rules מחזירים contrast fail על כל הצירופים -> בחר סגנון אחר מאותו אשכול והעבר warning.
- target=`powerpoint` אבל הסגנון שנבחר תוכנן ל-HTML בלבד (לדוגמה: סגנון שמסתמך על SVG animations) -> חזור ל-Tree ובחר חלופה תואמת PPT.

## Test fixtures

See `tests/` for a clean pitch fixture and expected style record.
