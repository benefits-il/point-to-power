---
name: power-parse-point-handoff
description: Activate at POWER session start to read a raw handoff (filesystem read or pasted body) and produce a structured AST of meta, slides, and tail.
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Parse Point Handoff

## Purpose

נקודת הכניסה של POWER. ממיר טקסט גולמי של handoff ל-AST מובנה שאפשר לוולדר ולפעול עליו. הסקיל הוא transformation טהור, בלי לוגיקה דומיין, בלי ולידציה, בלי החלטות תוכן. רק parse.

## Inputs

- **source** (enum: `filesystem` | `paste`). קובע מאיפה מגיע הטקסט.
- **payload** (string או path):
  - אם source=filesystem -> path לקובץ markdown תחת `build\<slug>\handoff\` (אופציונלי; אם חסר, קרא את `../../shared/filesystem-conventions.md` ובחר את קובץ ה-handoff האחרון מכל תיקיות הפרויקט). אפשר גם להעביר project slug, ואז נבחר ה-handoff האחרון תחת `build\<slug>\handoff\`.
  - אם source=paste -> מחרוזת ה-markdown הגולמית שהלומד הדביק כהודעה ראשונה.

## Outputs

מבנה AST יחיד:

```yaml
header_version: v1.0          # מחרוזת, נשאב מ-`# PointToPower Handoff vX.Y`. null אם header חסר.
meta:                          # 10 שדות (7 חובה + 3 אופציונליים), keys הם שמות snake_case מהחוזה.
  target: ...
  audience: ...
  genre: ...
  duration_minutes: ...
  output_type: ...
  speaker_notes: ...
  language: ...
  style_preference: ...        # אופציונלי
  generated_at: ...            # אופציונלי
  session_id: ...              # אופציונלי
slides:                        # רשימה של slide objects בסדר שהופיעו בקובץ.
  - number: 1
    title: ...
    fields:
      key_message: ...
      content: ...              # multi-line, שני-רווחים הזחה נשמר כפי שהוא
      bullets_allowed: ...
      visual_placeholder: ...
      speaker_notes: ...         # אופציונלי
tail:
  notebooklm_recommendations:    # רשימה, יכולה להיות ריקה
    - index: 1
      fields:
        feature: ...
        prompt: ...
        warnings: ...
        serves_slides: ...
  visual_queue:                  # רשימה
    - slide_number: 1
      placeholder: ...
  notes_to_power: ...            # מחרוזת אופציונלית
parse_errors:                    # רשימה. ריקה אם הניתוח עבר נקי.
  - code: header-missing | header-malformed | block-malformed | ...
    detail: ...                  # מחרוזת חופשית באנגלית, לדיבאג של validator
```

## Process

1. *טען טקסט.*
   - אם source=filesystem ויש path -> קרא את הקובץ ב-UTF-8.
   - אם source=filesystem ואין path -> קרא את `../../shared/filesystem-conventions.md` להבנת הקריטריון של "קובץ ה-handoff האחרון", סרוק את תיקיות ה-`build\<slug>\handoff\` ובחר.
   - אם source=paste -> השתמש במחרוזת ישירות.
2. *סור קוד-פנס חיצוני אחד.* לפי החוזה Section 8, סבול עד fence חיצוני אחד מסוג ` ``` `, ` ```markdown `, או ` ```md `. השאר fence-ים פנימיים בתוך ערכי שדות כפי שהם. אם יש fence חיצוני מסוג אחר (לדוגמה: ` ```python `) -> רשום parse_error קוד `header-malformed` והמשך כאילו אין fence (הוולידטור יתפוס את הכשל).
3. *גזור white-space מהתחלת הטקסט.* שורות ריקות לפני הכותרת מותרות.
4. *קרא את השורה הראשונה הלא-ריקה.*
   - אם זה בדיוק `# PointToPower Handoff v1.0` -> מלא header_version="v1.0".
   - אם זה `# PointToPower Handoff vX.Y` עם X.Y שונה -> מלא header_version עם הערך שנמצא.
   - אם זה משהו אחר -> מלא header_version=null, הוסף parse_error קוד `header-missing`. אל תעצור, המשך לנסות לחלץ מבנה כדי שה-validator יוכל לתת תמונה מלאה ללומד.
5. *חתוך את הטקסט לבלוקים לפי H2.* הבלוקים האפשריים: `## Meta`, `## Slide <N>: <title>`, `## Tail`. כל H2 פותח בלוק שמסתיים ב-H2 הבא או בסוף הקובץ.
6. *פרסר Meta block.*
   - מצא את הבלוק שכותרתו `## Meta`. אם אין -> השאר meta={}, הוסף parse_error קוד `meta-block-missing`.
   - הבלוק מורכב משורות bullet במבנה `- **<key>:** <value>`.
   - לכל שורה: חלץ key (בין `**` ל-`:`), חלץ value (אחרי `:` ועד סוף השורה).
   - שמור את הערכים כמחרוזות כפי שהן. אל תמיר ל-int/enum. הוולידטור עושה את זה.
   - אם תווי המפתח מכילים תווים בעברית -> רשום parse_error קוד `key-non-english` עם המפתח הסורר (זה יזרים לוולידטור עבור rule 15).
7. *פרסר Slide blocks.*
   - לכל בלוק שכותרתו תואמת `## Slide <N>: <title>`:
     - חלץ number מתוך `<N>` עם regex `^Slide\s+(\d+):`.
     - חלץ title מתוך מה שאחרי `:`. נקה רווחים בקצוות.
     - פרסר את הגוף כמו ב-Meta, bullets במבנה `- **<key>:** <value>`.
     - *חשוב לשדות רב-שורתיים:* ערך יכול להמשיך לשורות הבאות אם הן מוזחות בשני רווחים. אסוף את כל שורות ההמשך עד שורה ריקה או עד bullet הבא. שמור עם השמירה המקורית של הרווחים והשורות החדשות.
     - אם number חוזר על עצמו או חסר -> השאר את slide ברשימה אבל רשום parse_error `slide-number-duplicate` או `slide-number-missing` (הוולידטור יתמקד ב-rule 8).
8. *פרסר Tail block.*
   - מצא את `## Tail`. אם אין -> השאר tail={}, הוסף parse_error קוד `tail-block-missing`.
   - חתוך את גוף ה-Tail לפי H3 (`###`). H3 הוא העומק המקסימלי שמותר בחוזה.
   - לכל H3 שתואם `### NotebookLM Recommendation <i>`:
     - חלץ index מ-`<i>`.
     - פרסר את הגוף כ-bullets (כמו ב-Meta וב-Slide).
   - ה-H3 בדיוק `### Visual Queue`:
     - פרסר bullets במבנה `- **slide_<N>:** <placeholder>`. שמור כ-list של {slide_number, placeholder}.
   - ה-H3 בדיוק `### Notes To POWER`:
     - אסוף את כל הטקסט אחרי ה-H3 ועד סוף הקובץ או עד H3 הבא. שמור כמחרוזת.
9. *החזר את ה-AST.* parse_errors יכול להיות ריק (parse נקי) או מלא (parse פגום). אל תזרוק exception על parse_errors, תן ל-validator לטפל.

## Edge cases

- שורות עם רווחים סופיים (trailing whitespace) -> נקה לפני שמירה בערך.
- bullet שמתחיל ב-`-  **` (שני רווחים בין hyphen ל-bold) -> סבול, נרמל לפורמט הסטנדרטי.
- כותרת slide בלי `:` ("## Slide 1 בלי colon") -> רשום parse_error `slide-malformed-header`; נסה לקרוא number עדיין.
- מספר slide שלילי או 0 -> שמור כפי שהוא; rule 8 יתפוס בוולידציה.
- ערך bullet שמתחיל בתו ASCII control -> שמור כפי שהוא.
- שתי `### Visual Queue` באותו tail -> שמור את שתיהן ב-list נפרד ב-parse_errors כ-`tail-duplicate-h3`; ה-validator יתמקד.
- קובץ ריק לגמרי -> AST עם header_version=null, meta={}, slides=[], tail={}, parse_errors=[header-missing, meta-block-missing, no-slides, tail-block-missing].
- BOM בתחילת הקובץ -> סור.
- שורות שמתחילות ב-tab במקום ב-2 רווחים בשדה רב-שורתי -> סבול, התייחס כ-2-space indent.

## Failure modes

- קובץ ב-encoding לא UTF-8 -> נסה fallback ל-cp1255 (Windows Hebrew). אם נכשל, החזר AST ריק עם parse_error קוד `encoding-error`.
- קובץ גדול מאוד (מעל 5MB) -> חתוך והחזר parse_error `file-too-large`. handoff סביר הוא עד 50K.
- אין אף תיקיית `build\<slug>\handoff\` ו-source=filesystem בלי path -> החזר AST ריק עם parse_error `no-handoff-files` ובקש מהמשתמש להדביק במקום זאת.
- regex של slide heading לא תופס -> רשום `no-slides`.

## Test fixtures

See `tests/` for clean and fenced-paste fixtures plus expected AST.
