---
name: power-validate-handoff-against-contract
description: Activate after parse-point-handoff produces an AST , walk the AST against every rejection rule and the warning rule from the contract, and return ok/rejected with Hebrew messages.
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Validate Handoff Against Contract

## Purpose

הסקיל מוודא ש-AST שעבר parse עומד בחוזה. הוא מריץ את כל 15 כללי ה-rejection ואת כלל ה-warning, ומחזיר מבנה שמכיל סטטוס + הודעות עבריות מוכנות להצגה ללומד. הסקיל לא מנסה לתקן, רק מודיע.

## Inputs

- **ast** מ-`parse-point-handoff`. כולל header_version, meta, slides, tail, parse_errors.

## Outputs

```yaml
status: ok | rejected
rejections:
  - code: header-missing | meta-field-missing | slide-enum-invalid | ...
    hebrew_message: "..."          # תוצר ההחלפה של {curly} variables מתוך ה-AST
    location: meta.audience | slide_3.bullets_allowed | tail.nb_rec_1.warnings | ...
warnings:
  - code: forbidden-glyph
    hebrew_message: "..."
    location: ...
```

`status` הוא `rejected` אם יש לפחות rejection אחד; אחרת `ok`. warnings לא משפיעים על status.

## Process

1. קרא את `../../shared/validation-rules.md` במלואו. שם נמצאים 15 הכללים + כלל ה-warning, עם הקודים, ה-triggers, ה-predicates וההודעות העבריות המדויקות.
2. אם ל-AST יש parse_errors לא ריק, התייחס אליהם כסיגנלים שיש לתרגם לקודי rejection רשמיים:
   - `header-missing` -> rule 1.
   - `header-malformed` -> rule 1 (הלומד אמור לראות את אותה ההודעה).
   - `meta-block-missing` -> rule 3.
   - `tail-block-missing` -> rule 11.
   - `key-non-english` -> rule 15.
   - אחרים -> תרגם ל-rule הקרוב או דווח כ-rejection פנימי עם message כללי.
3. *הרץ כללים בסדר הקבוע ב-`shared/validation-rules.md`:*
   - *קבוצה 1 (Header):* rule 1, אחר כך rule 2. עצור על rule 1, בלי header אי אפשר להמשיך.
   - *קבוצה 2 (Meta):* rule 3 -> rule 4 (אסוף את כל השדות החסרים) -> rule 5 (לכל שדה enum) -> rule 6.
   - *קבוצה 3 (Slides):* rule 7 -> rule 8 -> ללולאה על כל slide: rule 9 (לכל שדה חסר) ו-rule 10.
   - *קבוצה 4 (Tail):* rule 11 -> rule 12 -> rule 13.
   - *קבוצה 5 (Recommendations):* rule 14 על כל recommendation.
   - *קבוצה 6 (Cross-cutting):* rule 15.
   - *Warnings:* rule W1 על כל ערך שדה (meta, slide, recommendation, notes_to_power).
4. עבור כל כלל שנכשל:
   - חלץ את הערכים הנדרשים לתחליפי {curly} מה-AST. לדוגמה, ל-rule 5: {field}=שם השדה, {value}=הערך הגולמי, {allowed}=רשימה מ-`META_ENUMS` או `SLIDE_ENUMS`.
   - הרכב את ההודעה בעברית עם החלפת {curly} בערכים אמיתיים. אל תתרגם, אל תשנה ניסוח. השתמש בתבנית בדיוק כפי שהיא ב-`shared/validation-rules.md`.
   - מלא את ה-`location` בנתיב קנוני (לדוגמה: `meta.duration_minutes`, `slide_3.bullets_allowed`, `tail.nb_rec_2.warnings`).
   - הוסף ל-rejections list.
5. עבור כלל W1 (forbidden-glyph):
   - סרוק את כל הערכים: meta.audience, כל ערך בכל slide, כל ערך בכל recommendation, ו-notes_to_power.
   - regex לאיתור אימוג'י: השתמש ב-Unicode emoji ranges. ל-em-dash בדוק את התו המתאים.
   - אם נמצא, הרכב הודעת warning והוסף ל-warnings list. כלל זה לא משפיע על status.
6. קבע status:
   - אם rejections ריק -> status=ok.
   - אחרת -> status=rejected.
7. *חשוב:* אסוף כמה rejections שאפשר במעבר אחד, אל תעצור על הראשון. הלומד צריך לראות את כל הבעיות בבת אחת. *חריג יחיד:* אם header חסר (rule 1), לא ניתן לנתח את שאר המסמך אז עצור אחרי קבוצה 1 והחזר.
8. החזר את המבנה. POWER יחליט מה לעשות עם status: ok -> לעבור ל-`detect-target-html-or-ppt`. rejected -> להציג ללומד את rejections בעברית ולעצור.

## Substitution helpers

- `{found}` ל-rule 2: ערך header_version מה-AST.
- `{field}` ל-rules 4, 9, 14: שם השדה כפי שמופיע ב-AST.
- `{value}` ל-rules 5, 6, 10: הערך הגולמי מה-AST (גם אם הוא בעייתי, הצג אותו ללומד כדי שיוכל לזהות).
- `{allowed}` ל-rules 5, 10: רשימה מופרדת בפסיקים מ-`META_ENUMS` או `SLIDE_ENUMS` ב-`shared/validation-rules.md`.
- `{N}` ל-rules 9, 10: slide.number.
- `{sequence}` ל-rule 8: רצף ה-slide numbers שהופיעו, מופרד בפסיקים, בסדר הופעה בקובץ.
- `{diff}` ל-rule 13: תיאור עברי קצר של ההפרש, לדוגמה: `חסר slide_3 בתור; slide_7 בתור אך השקופית מסומנת none`.
- `{i}` ל-rule 14: index של ה-recommendation.
- `{fields}` ל-rule 14: רשימה מופרדת בפסיקים של שדות חסרים מ-{feature, prompt, warnings, serves_slides}.
- `{key}` ל-rule 15: המפתח העברי הסורר שנמצא ב-parse_errors.
- `{location}` ל-W1: canonical path. `{chars}` ל-W1: רשימה מופרדת בפסיקים של התווים האסורים שנמצאו.

## Edge cases

- AST עם header_version=null אבל slides תקינות -> rule 1 בלבד. אל תרוץ קבוצות אחרות (העצירה אחרי קבוצה 1).
- AST עם meta.target=`HTML` (capital) -> rule 5 ל-target. הוולידטור לא מקבל uppercase כתקין; הוא דורש lowercase.
- AST עם slide בלי number (parse_error קודם) -> rule 7 או 8 בהתאם להקשר; הוסף rejection מנימוק parse_error.
- visual_queue שיש בו slide_number שלא קיים בכלל ב-slides (לדוגמה: slide_99 ב-queue אבל יש רק 6 slides) -> rule 13 עם {diff}.
- recommendation עם feature ריק אבל יש prompt -> rule 14 עם {fields}=feature.
- forbidden-glyph בתוך notes_to_power -> location=`tail.notes_to_power`.
- em-dash בתוך style_preference -> warning, לא rejection (style_preference הוא ערך טקסט, w1 חל עליו).

## Failure modes

- AST חסר לחלוטין (null) -> החזר status=rejected עם rejection פנימי `internal-empty-ast`. כנראה parse-point-handoff נכשל.
- regex של emoji זורק exception -> רשום warning פנימי, אל תוסיף ל-rejections.
- {curly} נשאר ב-message אחרי החלפה -> זה באג. דווח בלוג, אבל החזר את ה-message כפי שהוא (הלומד יראה {field} ויפתח באג).

## Test fixtures

See `tests/` for a valid AST and a missing-meta AST.
