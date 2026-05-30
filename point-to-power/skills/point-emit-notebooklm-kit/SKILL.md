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

פולט בפעימה אחת את **כל** ערכת ה-NotebookLM שהמשתמש צריך כדי לחקור ולהעמיק את התוכן, לפני שנבנתה שקופית אחת. הערכה גורמת לתוכן האמיתי (תחרות, מדע, הקשר שוק, תוצרי Studio) לזרום חזרה אל Point דרך תיקיית `content/`, במקום להישאר ניחושים. הסקיל לא מבנה שקופיות, לא בוחר סגנון, ולא מייצר תמונות.

> זה שינוי מהותי מ-v1: הערכה כבר לא תלויה ברשימת שקופיות ולא נדחפת בסוף. היא נדחפת מיד אחרי ה-intake, שלמה, ומתויגת.

## Inputs

- **intake_record** מ-`point-elicit-content-from-user`:
  - `meta` (לפחות genre, audience, language, duration_minutes, output_type, target).
  - `content_units` (התוכן הגולמי, להרכבת מסמך המקור).
- **project_slug** (להרכבת נתיב הכתיבה `build/<slug>/prompts/`).
- **channel** (enum: `filesystem` | `paste`). ב-filesystem (CoWork) הסקיל כותב קבצים; ב-paste הוא מחזיר את אותו תוכן כבלוקים בצ'אט.

## Outputs

ב-`channel=filesystem`, הסקיל כותב את קבצי הערכה ל-`build/<slug>/prompts/` ומחזיר ל-Point `kit_summary` (רשימת הקבצים שנכתבו + מטרת כל אחד + הנחיית content). ב-`channel=paste`, מחזיר את אותו תוכן כבלוקים מתויגים.

קבצי הערכה:
- `00-INDEX.md` - מפת הערכה: מה כל קובץ, באיזה סדר להריץ, ולאן לשמור כל תוצר חוזר.
- `01-source-document.md` - מסמך מקור נקי להעלאה ל-NotebookLM כ-source (מורכב מ-content_units + כוונת המצגת).
- `02-deep-research.md` - פרומפט Discover/Deep Research לאיסוף ההקשר החיצוני שהמצגת צריכה.
- `03-studio-<artifact>.md` ... - פרומפט אחד פר Studio artifact רלוונטי (לפי לוגיקת ההרכבה).

## Process

1. קרא את `../../references/R2-notebooklm-kit-catalog.md` במלואו. זה המקור לקטלוג, לכללי הפרומפט, ולתבניות.
2. קרא את `../../references/R2-ch11-limitations-flags.md` כדי לקבוע warnings נכונים, ואת `../../references/R2-ch12-recommendation-patterns.md` לדפוסי התאמה.
3. **הרכב את שלושת מרכיבי הליבה (תמיד):**
   - `01-source-document.md`: כותרת המצגת/הנושא, שורת קהל וכוונה, ואז כל ה-content_units מסודרים בקצרה. זה הזרע שכל ה-artifacts ימשכו ממנו. בראש הקובץ תווית: `> העלה קובץ זה ל-NotebookLM כ-source (Add source > Upload).`
   - `02-deep-research.md`: בחר את תבנית ה-Deep Research המתאימה (הרחבת ידע / ניתוח תחרותי / אימות טענות) לפי מה שהמצגת צריכה, מולאת לנושא. תווית: `> הרץ ב-Sources > Discover. שמור את המקורות שנבחרו, ואת הסיכום, ל-content/.`
   - `00-INDEX.md`: רשימה ממוספרת של כל קבצי הערכה עם משפט מטרה לכל אחד, סדר הרצה מומלץ, והנחיה מפורשת: "שמור כל תוצר שחוזר מ-NotebookLM ל-`build/<slug>/content/`, ואז חזור אליי."
4. **בחר Studio artifacts** לפי טבלת ההרכבה בחלק 5 של הקטלוג (genre → ערכה מומלצת), ומסנן את כללי הדיוק:
   - דמו חי בתוכן → אל תכלול Video של הדמו.
   - `output_type: teleprompter` → בדרך כלל ללא Studio artifacts (רק ליבה).
   - אל תכלול artifact בלי סיבה אמיתית. ערכה ממוקדת > ערכה מנופחת.
5. **לכל artifact שנבחר**, כתוב `03-studio-<artifact>.md`:
   - השתמש בתבנית מחלק 4 של הקטלוג, מולאת לנושא ולקהל.
   - פתח בפועל, ציין קהל, קבע היקף מספרי, אמור מה לכלול ומה להשמיט (כללי חלק 2).
   - עברית כברירת מחדל; אם `meta.language` הוא `en`, תרגם.
   - בראש כל קובץ תווית: `> Studio > <artifact>. מטרה: <משפט>. שמור את התוצר ל-content/.`
6. **קבע warnings** לכל artifact והצג אותם בתוך קובץ ה-prompt (לא כשדה נפרד): עברית + Audio/Video → הוסף שורת אזהרה על איכות TTS; Cinematic/Pro feature → אזהרת tier; נתונים שמתיישנים → אזהרת טריות.
7. **כתוב את הקבצים** ל-`build/<project_slug>/prompts/`. כלי Write יוצר את התיקייה אם חסרה. שמות קבצים ASCII, lowercase.
8. **החזר `kit_summary`** ל-Point: רשימת הקבצים + מטרת כל אחד + הנחיה אחת ברורה למשתמש להריץ את הערכה ולשמור את התוצרים ל-`content/`. אל תמשיך לבניית שקופיות, זו אחריות Phase 4 אחרי שהתוכן חוזר.

## Edge cases

- **content_units דליל מאוד (1-2)** → מסמך מקור עדיין נכתב; הערכה מצומצמת (ליבה + artifact אחד).
- **`language: mixed`** → מסמך מקור וקבצי ה-prompt בעברית; הוסף `rtl-audio-weak` לכל Audio/Video.
- **המשתמש כבר העלה מקורות בעצמו** → עדיין כתוב `02-deep-research.md` (להעשרה), אבל ב-`00-INDEX.md` ציין שזה אופציונלי.
- **genre לא ברשימה** → ברירת מחדל ליבה + Briefing Doc + Mind Map.
- **`channel: paste`** → אותו תוכן בדיוק, מוחזר כבלוקים מתויגים בצ'אט במקום קבצים; ההנחיה היא "הדבק כל תוצר חוזר בצ'אט".

## Failure modes

- קובץ קטלוג חסר/לא נקרא → אל תמציא קטלוג; דווח ל-Point עם הודעת תקלה ובקש בדיקה ידנית של `references/R2-notebooklm-kit-catalog.md`.
- כשל כתיבה ל-`prompts/` (הרשאות) → החלף ל-`channel=paste`, החזר את הערכה כבלוקים, הוסף warning.
- artifact שנבחר בלי תבנית בקטלוג → דלג עליו, רשום בלוג פנימי; אל תמציא תבנית.

## Test fixtures

See `tests/` for an intake fixture (pre-slides) and the expected emitted kit.
