---
name: point-produce-handoff-md
description: Activate in Phase 6, only after the user has explicitly approved the co-edited content (content_approved=true). Assemble the final PointToPower Handoff v1.0 Markdown from the approved slides, self-validate against the contract, and write it to the project handoff/ folder.
version: 2.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
  - Write
---

# Produce Handoff MD

## Purpose

מרכיב את קובץ ההעברה הסופי בפורמט PointToPower Handoff v1.0 **מתוכן מאושר בלבד**, ומריץ נגדו את כל כללי ה-rejection מ-`shared/validation-rules.md` לפני שהוא חוזר. אם כלל נכשל, הסקיל מתקן באופן מקומי ומריץ מחדש. הסקיל הזה הוא הקצה האחרון של זרימת Point.

## Inputs

- **content_approved** (boolean). **precondition קשיח:** אם הוא לא `true`, אל תרץ. החזר לפונקציה הקוראת שצריך אישור (Phase 5). ה-handoff מורכב רק מתוכן שהלומד אישר, לעולם לא לפני.
- **intake_record** (meta + content_units מקוריים, לרפרנס).
- **slides** מ-`structure-content-to-slides` (התוכן הערוך והמאושר).
- **project_slug** (לחישוב נתיב הכתיבה `build/<slug>/handoff/`).
- **notebooklm_recommendations** (אופציונלי, ברירת מחדל list ריק). בזרימה הנוכחית הערכה כבר נפלטה ל-`prompts/` ב-Phase 3, אז בדרך כלל זה ריק. אם הלומד ביקש שתיעוד של תוצר NotebookLM ספציפי ילווה את ה-handoff, אפשר לכלול 0..N רשומות לפי החוזה.
- **notes_to_power** (טקסט עברי חופשי, אופציונלי, עד 400 מילים).
- **channel** (enum: `filesystem` | `paste`). קובע אם הסקיל גם כותב לדיסק.

## Outputs

- **handoff_markdown** (מחרוזת Markdown יחידה, תואמת מדויקת לחוזה).
- **filesystem_path** (אם channel=filesystem), נתיב יחסי לקובץ שנכתב, למשל `build\<slug>\handoff\20260604-2214-colortune-pitch-01.md`.
- **warnings** (list אופציונלי), אזהרות שעלו בעת הגייט הפנימי אך לא חסמו (כרגע רק `forbidden-glyph`).

## Process

0. **בדוק `content_approved`.** אם אינו `true`, עצור והחזר שצריך אישור (Phase 5). אל תרכיב כלום לפני אישור.
1. קרא את `../../references/handoff-contract.md` במלואו. ההעברה חייבת להיות תואמת מדויקת לכל סעיף, Header, Meta, Slide blocks, Tail.
2. קרא את `../../references/example-handoff.md` כדי לראות את המבנה המדויק על דוגמה חיה. השתמש בה כאנקור צורני.
3. קרא את `../../shared/validation-rules.md` כדי להחזיק במוח את 15 כללי ה-rejection. אלה הכללים שתבדוק כל בנייה מולם.
4. הרכב את הכותרת: השורה הראשונה היא בדיוק `# PointToPower Handoff v1.0`. ללא וריאציות.
5. הרכב את ה-Meta block:
   - H2 בדיוק `## Meta`.
   - שורה ריקה אחרי הכותרת.
   - שבעת שדות החובה לפי הסדר: target, audience, genre, duration_minutes, output_type, speaker_notes, language.
   - שלושת שדות האופציונליים אם זמינים: style_preference, generated_at, session_id.
   - כל שורה במבנה בדיוק `- **key:** value` (bold על המפתח, נקודתיים, רווח, ערך).
   - אם generated_at חסר, מלא ב-ISO 8601 של רגע ההפעלה (`YYYY-MM-DDTHH:MM:SS`).
6. הרכב Slide blocks:
   - H2 בדיוק `## Slide <N>: <title>` עבור כל שקופית, מ-1 עד N.
   - שורה ריקה אחרי כל H2.
   - חמשת השדות לפי הסדר: key_message, content, bullets_allowed, visual_placeholder, speaker_notes.
   - שדות רב-שורתיים (content, speaker_notes, prompt), שורת המשך עם הזחה של שני רווחים בדיוק.
   - אם meta.speaker_notes=`off` -> דלג על speaker_notes בכל השקופיות.
   - אם meta.speaker_notes=`on` ושקופית מסומנת `speaker_notes: "off"` באובייקט -> כתוב `- **speaker_notes:** off` (שורה אחת).
   - אם meta.speaker_notes=`on` ולשקופית יש notes רב-שורתיים -> כתוב אותם עם ההזחה.
   - אם meta.speaker_notes=`on` ואין notes לשקופית -> זו שגיאה, חזור לסקיל הקודם או הוסף notes ריקים מהמקור. אל תפלט handoff בלי notes לשקופית במקרה הזה.
7. הרכב Tail block:
   - H2 בדיוק `## Tail`.
   - אם יש notebooklm_recommendations, כתוב לכל אחד H3 בפורמט `### NotebookLM Recommendation <i>` (i=1..N), ואחריו ארבעת השדות feature, prompt, warnings, serves_slides.
   - חובה: כתוב H3 בדיוק `### Visual Queue` (גם אם הרשימה ריקה).
   - הרכב את Visual Queue: עבור על השקופיות לפי הסדר; לכל שקופית שבה visual_placeholder אינו `none`, כתוב שורה `- **slide_<N>:** <ערך_הפלייסהולדר>`. אם כל השקופיות `none`, כתוב את ה-H3 ולא כלום אחריו.
   - אם יש notes_to_power, כתוב H3 בדיוק `### Notes To POWER` ואחריו פסקה אחת בעברית עד 400 מילים. אם אין, דלג על ה-H3.
8. *הרץ את הגייט הפנימי.* עבור על המחרוזת המורכבת והפעל את כל 15 כללי ה-rejection מ-`shared/validation-rules.md`. עבור כל כשל:
   - אם זה שדה חסר -> הוסף אותו (אם יש לך את המידע) או החזר שגיאה לסקיל קודם.
   - אם זה enum לא חוקי -> תקן אם ברור (לדוגמה: `He` -> `he`); אם לא ברור, החזר שגיאה.
   - אם זה מספור שקופיות שבור -> סדר מחדש את ה-numbers ב-slides ובנה מחדש.
   - אם זה visual queue mismatch -> בנה מחדש את ה-queue מ-slides; ה-queue הוא תוצר נגזר ולא מקור עצמאי.
   - אם זה מפתח בעברית -> תרגם לאנגלית snake_case. זה אף פעם לא אמור לקרות אם אתה כותב את ההעברה, רק אם קיבלת אותה כתוצר חיצוני; כאן זה כשל בנייה.
9. הרץ את כלל ה-warning `forbidden-glyph` (אימוג'י, em-dash). אם נמצאו תווים אסורים:
   - אל תחסום. רשום את המיקום ואת התווים ב-`warnings`.
   - השאר את התווים בערך (החוזה דורש זאת, הלומד יראה אותם וינקה למחר).
10. אחרי שעבר הגייט, הרץ פעם נוספת כדי לוודא שהתיקונים שלך לא הפרו כללים אחרים. הגייט אמור לחזור עם 0 rejections.
11. אם channel=filesystem:
    - קרא את `../../shared/filesystem-conventions.md` לחישוב הנתיב.
    - חשב slug: עדיפות session_id > learner_label > "untitled". נקה לאסקי lowercase עם מקפים. בדרך כלל זה ה-project_slug שכבר נקבע ב-Phase 2.
    - חשב timestamp בפורמט `YYYYMMDD-HHMM` של רגע הכתיבה.
    - הרכב נתיב: `build\<slug>\handoff\<timestamp>-<slug>.md`.
    - צור את הספרייה אם לא קיימת.
    - כתוב את הקובץ ב-UTF-8 בלי BOM. שורות LF (לא CRLF).
12. החזר את handoff_markdown תמיד. אם channel=filesystem, החזר גם את filesystem_path. אם יש warnings, החזר אותן.

## Edge cases

- `meta.speaker_notes=on` ושקופית אחת או יותר חסרה notes -> בלוקר. אל תפלט handoff. בקש מ-structure-content-to-slides למלא, או הזרק notes ריקים עם פסקה אחת מתמצתת תוכן.
- visual_placeholder ריק (לא `none`, רק ריק) -> בלוקר rule 9. דרוש מהסקיל הקודם להמיר ל-`none` במפורש.
- session_id חסר ויש לומר label בעברית -> השתמש ב-`untitled` כ-slug; שמור את ה-label העברי בתוך meta.session_id (60 תווים מקסימום, אסקי בלבד, לכן בעצם השאר session_id ריק).
- שתי בניות באותה דקה -> הוסף סיומת `-a` ל-slug כדי להימנע מהתנגשות (לפי filesystem-conventions.md).
- channel=paste -> אל תכתוב לדיסק. רק החזר את ה-markdown.
- recommendations list ריק -> דלג על H3-ים של NotebookLM Recommendation. כתוב רק את `### Visual Queue` (וגם את `### Notes To POWER` אם יש).
- כל השקופיות `visual_placeholder: none` -> כתוב את `### Visual Queue` בלי שום bullet אחריו. ה-queue חייב להיות במבנה גם אם ריק.

## Failure modes

- הגייט מחזיר rejection שאי אפשר לתקן באופן מקומי (לדוגמה: meta.audience חסר ואין לך את הערך) -> החזר את ה-rejection לסקיל הקודם בשרשרת. אל תפלט handoff שבור.
- כתיבה לדיסק נכשלת (אין הרשאות, נתיב לא תקף) -> נסה fallback: שנה channel ל-paste, החזר את ה-markdown להדבקה ידנית, הוסף הערה ב-warnings על הכשל בכתיבה.
- markdown מורכב גדול מ-32K תווים -> בדוק שיש כיווץ ב-content / speaker_notes; אם לא, הזהר את הלומד שייתכנו בעיות paste בערוץ paste.
- forbidden-glyph נמצא -> זה לא בלוקר. רשום ב-warnings ועבור הלאה.
- אחרי הריצה השנייה של הגייט עדיין יש rejections -> שגיאה פנימית. החזר שגיאת בנייה ובקש מהמפעיל לפתוח באג.

## Test fixtures

See `tests/` for a full-input fixture and the expected handoff markdown output.
