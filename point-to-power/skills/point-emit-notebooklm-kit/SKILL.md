---
name: point-emit-notebooklm-kit
description: Activate right after intake (meta + raw content collected), before any slide structuring. Emit the complete NotebookLM kit in one pass to the project prompts/ folder, source document to upload, Deep Research prompt, and the Studio artifact prompts relevant to this deck, each labeled with its purpose.
version: 2.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
  - Write
---

# Emit NotebookLM Kit

## Purpose

בונה בפעימה אחת את תיקיית ה-NotebookLM המסודרת, לפני שנבנתה שקופית אחת. המחברת היחידה משרתת שני דברים בו-זמנית: (א) **מסמכי BRIEF** שמסדרים את התוכן (מזינים את חוברת-המנחה ואת תוכן-השקופיות), (ב) **ויזואלים-להשראה** בסגנון-העיצוב של המותג (Infographic, Slide Deck, Video). התוכן והוויזואלים שחוזרים זורמים אל Point דרך `03-returns/`. הסקיל לא מבנה שקופיות, לא בוחר סגנון, ולא מייצר תמונות.

> כלל-ברזל G6: **תוצרים ויזואליים plus briefs בלבד. אסור Audio (Brief/Deep Dive) ואסור Mind Map.** הם לא משרתים בניית מצגת.
> כלל-ברזל G7: **כל פרומפט נקי (רק הפרומפט, בלי רעש מסביב) ועצמאי לחלוטין.** פרומפט ויזואלי מטמיע גם את מלוא המפרט-הוויזואלי לפי ה-design system וגם את התוכן המדויק, לא "תוסיף כאן תוכן".

## Inputs

- **intake_record** מ-`point-elicit-content-from-user`:
  - `meta` (לפחות genre, audience, language, duration_minutes, output_type, target).
  - `content_units` (התוכן הגולמי, להרכבת מסמך המקור ולהעתקת קבצי-המקור).
  - `style_preference` / brand design system אם נאסף. אם אין design system והכוונה כוללת ויזואלים, בקש מהמשתמש את ערכת-המותג (פלטה, פונטים, מוטיבים) או הצע ברירת-מחדל לפני שאתה כותב פרומפט ויזואלי.
- **source_files** (אופציונלי): קבצי-המקור הגולמיים שהמשתמש סיפק, להעתקה ל-`01-upload-to-notebooklm/`.
- **project_slug** (להרכבת נתיב הכתיבה `build/<slug>/`).
- **channel** (enum: `filesystem` | `paste`). ב-filesystem (Cowork) הסקיל כותב קבצים; ב-paste הוא מחזיר את אותו תוכן כבלוקים מתויגים, plus הנחיה לאיזו תיקייה כל בלוק שייך.

## Outputs

ב-`channel=filesystem`, הסקיל כותב את שתי תיקיות-הקלט ל-`build/<slug>/` ומחזיר ל-Point `kit_summary` (מה נכתב + הנחיית content). ב-`channel=paste`, מחזיר את אותו תוכן כבלוקים מתויגים.

**`01-upload-to-notebooklm/`** (מה המשתמש מעלה ל-NotebookLM):
- `00-source-document.md` - מסמך מקור נקי (מורכב מ-content_units + כוונת המצגת).
- העתקי קבצי-המקור הרלוונטיים עצמם (כשסופקו), כדי שהמשתמש יעלה את הקבצים, לא תקציר.
- `_manifest.md` - רשימת כל הקבצים, כל אחד מסומן `[signal]` (העלה) או `[noise]` (אל תעלה, כאן לרפרנס).

**`02-notebooklm-prompts/`** (מה המשתמש מריץ, כל קובץ = רק הפרומפט):
- `00-INDEX.md` - סדר ההרצה, מטרת כל פרומפט, וההנחיה לשמור תוצרים ל-`03-returns/` plus לסמן `_liked.md`.
- `01-deep-research.md` - פרומפט Discover/Deep Research לאיסוף ההקשר החיצוני.
- `02-brief-<name>.md` ... - 2-3 פרומפטים ל-Briefing Doc (תוכן), כל אחד בזווית אחרת.
- `03-visual-<name>.md` ... - פרומפטים ל-Infographic (2-3), Slide Deck (2-3), ו-Video (1), כל אחד עצמאי עם DS plus תוכן.

## Process

1. קרא את `../../references/R2-notebooklm-kit-catalog.md` במלואו (חלק 5 = לוגיקת ההרכבה, חלק 4 = תבניות, חלק 2 = כללי פרומפט).
2. קרא את `../../references/R2-ch11-limitations-flags.md` ל-warnings ואת `../../references/R2-ch12-recommendation-patterns.md` לדפוסים.
3. **בנה את `01-upload-to-notebooklm/`:**
   - `00-source-document.md`: כותרת הנושא, שורת קהל וכוונה, ואז כל ה-content_units מסודרים. בראש: `> העלה קובץ זה ל-NotebookLM כ-source.`
   - העתק את קבצי-המקור הרלוונטיים (`source_files`) לתיקייה כפי שהם.
   - `_manifest.md`: רשום כל קובץ עם `[signal]` (העלה) או `[noise]` (אל תעלה), כדי שהמשתמש ידע בדיוק מה להעלות.
4. **בנה את מרכיבי-הליבה ב-`02-notebooklm-prompts/`:**
   - `01-deep-research.md`: תבנית Deep Research מתאימה (הרחבת ידע / ניתוח תחרותי / אימות טענות), מולאת לנושא. רק הפרומפט בקובץ.
   - `00-INDEX.md`: סדר ההרצה, מטרת כל פרומפט, וההנחיה: "שמור כל תוצר חוזר ל-`build/<slug>/03-returns/`, סמן ב-`_liked.md` מה אהבת, ואז חזור אליי."
5. **בנה את חבילת ה-BRIEF (תוכן):** 2-3 קבצי `02-brief-<name>.md`, כל אחד פרומפט ל-Briefing Doc בזווית אחרת (תקציר-מנהלים, נקודות-מפתח עם נתונים, סיכונים-ופתרונות). רק הפרומפט בקובץ.
6. **בנה את חבילת הוויזואלים (השראה, בסגנון-העיצוב):** קבצי `03-visual-<name>.md` , 2-3 Infographic, 2-3 Slide Deck, ו-1 Video. השתמש בתבניות הוויזואליות בחלק 4 של הקטלוג. כל פרומפט ויזואלי **עצמאי לחלוטין**: בלוק design system מפורש (פלטה עם hex, טיפוגרפיה, סגנון, מוטיבים) plus התוכן המדויק שצריך להופיע. רק הפרומפט בקובץ, בלי רעש מסביב.
7. **כללי דיוק (חלק 5):** **אסור Audio ואסור Mind Map (G6).** דמו חי → אין Video של הדמו. teleprompter → ויזואלים מצומצמים, אבל ה-BRIEF מלא. פתח בפועל, ציין קהל, היקף מספרי, include/exclude (חלק 2). עברית כברירת מחדל; `meta.language=en` → תרגם.
8. **קבע warnings** והצג אותם בתוך קובץ ה-prompt: עברית + Video → אזהרת TTS; Cinematic/Pro → אזהרת tier; נתונים שמתיישנים → אזהרת טריות.
9. **כתוב את הקבצים** תחת `build/<project_slug>/`. כלי Write יוצר תיקיות אם חסרות. שמות קבצים ASCII, lowercase.
10. **החזר `kit_summary`** ל-Point: מה נכתב ב-`01-` וב-`02-`, plus הנחיה אחת ברורה למשתמש (מה להעלות לפי `_manifest.md`, מה להריץ לפי `00-INDEX.md`, ולשמור תוצרים ל-`03-returns/`). אל תמשיך לבניית שקופיות, זו Phase 4 אחרי שהתוכן חוזר.

## Edge cases

- **content_units דליל מאוד (1-2)** → מסמך מקור עדיין נכתב; חבילה מצומצמת (ליבה + brief אחד + infographic אחד), אבל עדיין ויזואלי, לא audio/mind-map.
- **`language: mixed`** → מסמך מקור וקבצי ה-prompt בעברית; הוסף `rtl-audio-weak` ל-Video.
- **אין design system למשתמש** → לפני כתיבת פרומפט ויזואלי, בקש את ערכת-המותג או הצע ברירת-מחדל; אל תכתוב פרומפט ויזואלי בלי בלוק DS.
- **המשתמש כבר העלה מקורות בעצמו** → עדיין כתוב `01-deep-research.md`, אבל ב-`00-INDEX.md` ציין שזה אופציונלי.
- **genre לא ברשימה** → ברירת מחדל = ליבה + 2 briefs + Infographic + Slide Deck (ויזואלי, לא Mind Map).
- **`channel: paste`** → אותו תוכן בדיוק, מוחזר כבלוקים מתויגים בצ'אט, plus הנחיה לאיזו תיקייה (`01-`/`02-`) כל בלוק שייך וההנחיה לשמור חזרה ל-`03-returns/`.

## Failure modes

- קובץ קטלוג חסר/לא נקרא → אל תמציא קטלוג; דווח ל-Point עם הודעת תקלה ובקש בדיקה ידנית של `references/R2-notebooklm-kit-catalog.md`.
- כשל כתיבה ל-`prompts/` (הרשאות) → החלף ל-`channel=paste`, החזר את הערכה כבלוקים, הוסף warning.
- artifact שנבחר בלי תבנית בקטלוג → דלג עליו, רשום בלוג פנימי; אל תמציא תבנית.

## Test fixtures

See `tests/` for an intake fixture (pre-slides) and the expected emitted kit.
