---
name: point-elicit-content-from-user
description: Activate when starting a Point session and the learner has not yet supplied a complete intake , collect raw content plus the seven required meta fields needed to invoke structuring.
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Elicit Content From User

## Purpose

הסקיל הזה הוא נקודת הכניסה של Point. תפקידו לאסוף מהלומד את החומר הגולמי למצגת, ולמלא את שבעת שדות ה-Meta הנדרשים כדי שהסקיל הבא בשרשרת יוכל לבנות מתווה שקופיות תקף. הסקיל לא מבנה תוכן, לא ממליץ על סגנון ולא כותב פרומפטים, רק אוסף מידע.

## Inputs

- **learner_message** (free text, he/en): ההודעה הראשונה של הלומד. עשויה להכיל חומר מלא, חומר חלקי, או רק כותרת.
- **session_context** (optional): היסטוריית שיחה קודמת באותה סשן אם קיימת.

## Outputs

מבנה נתונים יחיד בשם `intake_record` עם שני מקטעים:

- **meta** (object): שבעה שדות חובה + שלושה אופציונליים, מתואמים בדיוק ל-Section 2 של החוזה.
  - שדות חובה: `target` (enum: html | powerpoint | slides | ask), `audience` (טקסט עברי חופשי), `genre` (enum), `duration_minutes` (int 1-240), `output_type` (enum), `speaker_notes` (on | off), `language` (he | en | mixed).
  - שדות אופציונליים: `style_preference` (טקסט חופשי), `generated_at` (ISO 8601), `session_id` (slug אנגלי).
- **content_units** (ordered list): רשימת יחידות תוכן גולמיות בסדר זמני התחלתי. כל יחידה מכילה `raw_text` (טקסט עברי) ו-`tentative_position` (int).
- **project_slug** (string, ASCII lowercase, מקפים, עד 40 תווים): שם תיקיית הפרויקט `build/<slug>/`. עדיפות: session_id > label שהלומד נתן > `untitled`. נקבע מוקדם כי כל השלבים הבאים (Phase 3 כותב ל-`prompts/`, Phase 6 ל-`handoff/`) צריכים אותו. ראה `../../shared/filesystem-conventions.md` לכללי ה-slug.

## Process

1. קרא את `../../references/handoff-contract.md` Section 2 כדי לוודא שאתה זוכר את האניומים המדויקים של כל שדה Meta.
2. נתח את ההודעה הראשונה של הלומד וזהה אילו שדות Meta כבר ניתן להסיק (לדוגמה: "הצגה למשקיעים" -> `audience` חלקי + `genre: pitch`).
3. אם הלומד סיפק חומר עשיר (מעל 300 תווים, או רשימה מסודרת של נושאים), הפעל הסתעפות "rich-input": בנה מיד טיוטה של intake_record מההסקה, ושאל רק על שדות שלא ניתן להסיק (בדרך כלל `target`, `duration_minutes`, `speaker_notes`).
4. אם הלומד סיפק חומר דליל (פחות מ-300 תווים, נושא בלבד), הפעל הסתעפות "sparse-input": שאל שאלות פתוחות תחילה כדי להעמיק את התוכן, ורק אז שאל על Meta.
5. שאל שאלות בעברית, קצרות וישירות. שאלה אחת או שתיים בכל הודעה, לא שאלון של עשר שאלות בבת אחת.
6. בעת השאלה על `genre`, השתמש בקטגוריות מ-`../../references/R1-08-decision-tree.md` ובמיפוי המהיר מ-`../../references/R1-addon-A-decision-sheet.md` כדי להציע אפשרויות בשפת הלומד ("מצגת מכירה ללקוח", "הרצאה כנסית", "ברייפינג פנימי") במקום לבקש ממנו לבחור את ה-enum המדויק. תרגם אתה לעברית-לאנגלית בעת מילוי.
7. בעת השאלה על `audience`, הסתמך על טקסונומיית הקהל ב-R1 ch08 כדי לכוון את הלומד לתשובה מועילה (גודל קהל, רמת מומחיות, הקשר).
8. בעת השאלה על `target`, יש שלוש אפשרויות פלט: `html` (אתר יחיד דרך Claude הרגיל), `powerpoint` (קובץ דרך Claude-in-PowerPoint), ו-`slides` (Google Slides דרך Gemini, מתאים כשאין PowerPoint או כשרוצים שיתוף בענן ועבודה משותפת). אם הלומד יודע מה הוא רוצה, מלא את הערך. אם לא בטוח, אל תכריח: הצב `ask` ותן ל-POWER לשאול ולהציע את שלוש האפשרויות בעת הבנייה. זה חלק תקף מהחוזה.
9. בעת איסוף תוכן, שמור את הסדר שבו הלומד הזכיר את הנושאים כ-`tentative_position`. הסקיל הבא (structure-content-to-slides) רשאי לסדר מחדש, אבל הסדר הראשוני שלך הוא הנחת מוצא חשובה.
10. לולאה פנימית: המשך לשאול עד שכל שבעת שדות החובה ב-Meta הם non-empty ויש לפחות יחידת תוכן אחת. אל תקרא Done לפני זה.
11. אל תאמת ערכי enum מול האניומים בעצמך, זו אחריות של הסקיל `produce-handoff-md` עם הגייט הפנימי שלו. אתה רק אוסף.
12. **קבע `project_slug`.** אם הלומד נתן session_id או שם פרויקט, נרמל אותו (לפי `../../shared/filesystem-conventions.md`). אחרת, שאל שאלה קצרה אחת ("איך לקרוא לתיקיית הפרויקט? משהו קצר באנגלית"), ונרמל את התשובה. אם הלומד לא נותן, השתמש ב-`untitled`. ה-slug נקבע פעם אחת ומלווה את כל הסשן.
13. החזר את ה-`intake_record` המלא ואת `project_slug` כפלט. אל תכתוב לדיסק (יצירת התיקיות קורית כשהסקילים הבאים כותבים אליהן).

## Edge cases

- הלומד מציין שם פרויקט קודם או מזהה סשן בהודעה -> מלא אותו ב-`session_id` (אחרי נרמול לאסקי lowercase עם מקפים, עד 60 תווים).
- הלומד מציין אורך בדקות בתוך הטקסט החופשי ("הרצאה של 20 דקות") -> חלץ ל-`duration_minutes` בלי לשאול שוב.
- הלומד נותן רמז סגנוני ("משהו נקי, מינימליסטי") -> מלא ל-`style_preference` (עד 120 תווים). אם הוא לא מציין, השאר ריק.
- הלומד מתחיל באנגלית -> זהה את השפה לפי שדה ה-content העיקרי. אם רוב התוכן בעברית עם מילים באנגלית, סמן `language: he`. אם מעורב באמת, סמן `mixed`. רק תוכן באנגלית בלבד -> `en`.
- הלומד מערבב שאלות בתוך התוכן ("מה אתה ממליץ?") -> ענה בקצרה והחזר את השיחה למסלול האיסוף.
- הלומד מציין מספר שלילי או אפסי לדקות -> שאל שוב, אל תקבל.

## Failure modes

- שדה חובה נשאר ריק אחרי שתי סיבובי שאלות -> שאל פעם נוספת בניסוח שונה. אם גם הפעם אין תשובה, החזר את ה-intake_record החלקי עם הערה ב-`notes_to_power` שהשדה נשאר פתוח. ה-rule `meta-field-missing` יתפוס את זה בגייט של produce-handoff-md.
- אין תוכן בכלל אחרי שלוש שאלות -> הצע ללומד לחזור כשיש לו חומר ראשוני, או הצע לו לסכם בעל פה ואתה תתעד.
- הלומד מבקש לדלג על השאלות -> כבד, אך הסבר שבלי שדות החובה הסקיל הבא לא יוכל לרוץ. הצע מינימום סופר-חסכוני: שלוש שאלות בלבד שמכסות את שבעת השדות (לדוגמה: "קהל ומטרה?", "אורך ומבנה?", "פלט והערות?").
- תווים אסורים (אימוג'י, em-dash) בתוך תשובות הלומד -> נקה לפני שמירה ב-intake_record. אל תעביר אותם לסקיל הבא. אזהרה `forbidden-glyph` היא רק לפלט הסופי של ההעברה, לא לטיוטה.

## Test fixtures

See `tests/` for input fixtures (rich + sparse) and an expected intake_record example.
