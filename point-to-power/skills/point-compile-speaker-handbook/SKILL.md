---
name: point-compile-speaker-handbook
description: Activate in Phase 6, after content_approved=true, alongside produce-handoff-md. Compile a per-slide presenter handbook (חוברת מנחה) , what the presenter says on each slide , from the approved slides, their speaker_notes, and the returned BRIEF documents. Writes presenter-handbook.md at the project root. For the human presenter, never a POWER input.
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
  - Write
---

# Compile Speaker Handbook (חוברת מנחה)

## Purpose

מרכיב את **חוברת-המנחה**: מסמך פר-שקף שמסביר מה המנחה אומר בכל שקופית. נכתב בשלב האריזה (Phase 6), אחרי אישור-המבנה, לצד `point-produce-handoff-md`. החוברת היא חבילה ל**אדם** שמציג, לא קלט ל-POWER, ו-POWER לעולם לא קורא אותה. היא נשענת על השקופיות המאושרות, על ה-speaker_notes שלהן, ועל מסמכי-ה-BRIEF שחזרו מ-NotebookLM (`03-returns/`). היא לא ממציאה תוכן חדש, רק מקמפלת ומסדרת לתסריט-דובר רציף.

## Inputs

- **content_approved** (boolean). **precondition קשיח (G5):** אם אינו `true`, אל תרץ.
- **slides** מ-`structure-content-to-slides` (המאושרות): number, title, key_message, content, speaker_notes.
- **intake_record.meta** (genre, audience, language, duration_minutes, output_type, speaker_notes).
- **briefs** (אופציונלי): מסמכי ה-BRIEF שהלומד החזיר ל-`03-returns/`, להעשרת התסריט בהקשר ובמעברים.
- **project_slug** (לחישוב נתיב הכתיבה).
- **channel** (enum: `filesystem` | `paste`).

## Outputs

- **handbook_markdown** (מחרוזת Markdown יחידה).
- **filesystem_path** (אם channel=filesystem): `build\<slug>\presenter-handbook.md`.

## Process

0. **בדוק `content_approved`.** אם אינו `true`, עצור והחזר שצריך אישור (Phase 5).
1. קרא את `../../references/R1-06-speaker-notes.md` לסגנון ולצפיפות notes לפי (genre, audience, output_type).
2. קרא את מסמכי-ה-BRIEF ב-`03-returns/` (אם קיימים) להקשר, מעברים, וניסוחים. אל תמציא מעבר למה שיש בשקופיות וב-briefs.
3. **עמוד 1 , מבט-על:** כותרת (`חוברת מנחה , <נושא>`), שורת קהל plus משך plus מספר שקופיות, ואז רשימה ממוספרת של כל השקופיות עם ה-key_message של כל אחת (מפה מהירה למנחה).
4. **עמודים 2 ואילך , פר-שקף:** לכל שקופית, H2 בפורמט `## שקופית <N>: <title>`, ואחריו:
   - **המסר:** ה-key_message.
   - **מה אומרים:** תסריט-דובר רציף בעברית, מבוסס על ה-speaker_notes plus ה-BRIEF. אורך וסגנון לפי R1-06 (pitch , קצר ורומז; lecture , מלא ופדגוגי).
   - **דגשים:** הערות-במה קצרות אם רלוונטי (איפה להשתהות, מה להדגיש, מה לדלג אם הזמן קצר).
5. אם meta.speaker_notes=`off`: עדיין הפק חוברת, אבל ה"מה אומרים" נגזר מה-key_message ומה-content בלבד (אין notes ייעודיים), וסמן זאת בראש החוברת.
6. **לא מתרגמים שמות (G8):** שמות-מותג ושמות פרטיים נשארים כפי שהם.
7. בלי אימוג'ים, בלי em-dashes, הדגשות ב-asterisks. עברית בגוף; מונחים אנגליים במקור.
8. אם channel=filesystem: כתוב `build\<slug>\presenter-handbook.md` ב-UTF-8 בלי BOM, שורות LF. צור תיקייה אם חסרה. אם channel=paste: החזר את ה-Markdown כבלוק plus הערה ששמו `presenter-handbook.md`.
9. החזר את handbook_markdown (plus filesystem_path אם נכתב).

## Edge cases

- **speaker_notes=off** -> חוברת עדיין נכתבת מ-key_message plus content, עם הערה בראש שאין notes ייעודיים.
- **אין briefs ב-`03-returns/`** -> בנה מהשקופיות בלבד; אל תמציא הקשר חיצוני.
- **`language: en`** -> כתוב את החוברת באנגלית; שמור שמות כפי שהם.
- **שקופית בלי speaker_notes כש-meta=on** -> זו שגיאת-מקור; דווח ל-Point (כמו ב-produce-handoff), אל תמציא notes.
- **channel=paste** -> אל תכתוב לדיסק, החזר כבלוק.

## Failure modes

- כתיבה לדיסק נכשלת -> fallback ל-paste, החזר את ה-Markdown plus warning.
- handbook_markdown מעל 32K תווים -> חלק לשני בלוקים בערוץ paste.

## Test fixtures

See `tests/` for an approved-slides fixture and the expected handbook markdown.
