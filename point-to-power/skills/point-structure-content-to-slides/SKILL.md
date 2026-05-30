---
name: point-structure-content-to-slides
description: Activate in Phase 4 (Co-edit), after the user returned NotebookLM outputs to content/. Co-edit the returned, researched content together with the user into a slide-by-slide outline that complies with R1 content discipline rules. Runs on returned content, not on guesses.
version: 2.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Structure Content to Slides

## Purpose

הסקיל הכבד ביותר ב-Point. מקבל את intake_record יחד עם **התוכן שחזר מ-NotebookLM** (תיקיית `content/`) ומחזיר רשימת שקופיות מסודרת שכבר עומדת בכללי המשמעת של R1, צפיפות, נוקדים, מבנה סיפור, צפיפות notes. זו פעולה של **עריכה משותפת איטרטיבית** עם הלומד, מבוססת על המחקר והתוצרים שחזרו, לא על ניחושים. הסקיל לא ממליץ על NotebookLM, לא בוחר סגנון, ולא מפיק את ההעברה הסופית.

## Inputs

- **intake_record** מ-`elicit-content-from-user`. מכיל meta (10 שדות) ו-content_units (רשימה מסודרת).
- **returned_content** מתיקיית `build/<slug>/content/`, מה שהלומד החזיר מ-NotebookLM (מקורות Deep Research, תמלילי אודיו, מפות מושגים, briefing docs). זה המקור המרכזי לתוכן השקופיות; ה-content_units הגולמיים הם רק נקודת ההתחלה.

## Outputs

- **slides** (ordered list, 1-based). כל שקופית מכילה:
  - `number` (int)
  - `title` (טקסט עברי, יחיד לכל שקופית)
  - `key_message` (משפט אחד, עד 200 תווים, עברית)
  - `content` (טקסט עברי רב-שורתי)
  - `bullets_allowed` (true | false), החלטה מפורשת לפי Doumont conditional ב-R1 ch04
  - `bullets_justification` (משפט אחד שמסביר למה כן/לא נוקדים, לשימוש פנימי בלבד, לא נכנס להעברה)
  - `visual_placeholder` (טקסט עברי או "none"), תיאור מה הוויזואל צריך לתקשר
  - `speaker_notes` (טקסט עברי רב-שורתי, או "off" אם הלומד ביקש להחריג שקופית ספציפית, או null אם meta.speaker_notes=off)

## Process

1. קרא את ה-intake_record. ודא ש-meta.target, meta.genre, meta.duration_minutes ו-meta.output_type קיימים. אם משהו חסר, החזר שגיאה לסקיל הקודם, אל תמציא.
1a. **קרא את `build/<slug>/content/` לפני שאתה בונה.** זה המקור המרכזי לתוכן השקופיות, מה שחזר בפועל מ-NotebookLM. שלב אותו עם ה-content_units הגולמיים: מחקר מאמת או מעשיר נקודה, תמליל אודיו מספק ניסוח, מפת מושגים מציעה מבנה. אם `content/` ריק, אל תמציא, החזר לפונקציה הקוראת שצריך להמתין לתוכן (Phase 4 pause) או לבנות מה-intake בלבד עם סימון מפורש שזה לא מבוסס-מחקר. **עבוד איטרטיבית עם הלומד**, הצג טיוטה, קבל הערות, תקן.
2. קרא את `../../references/handoff-contract.md` Section 3 כדי לוודא את המבנה המדויק של שדה Slide שאתה הולך לייצר.
3. החלט על מספר השקופיות. החישוב הראשוני: לפחות שקופית אחת לכל דקה ב-`genre: pitch` או `briefing`, בערך 1.5 דקות לשקופית ב-`keynote` או `ted`, ו-2 דקות לשקופית ב-`lecture` או `workshop`. שמור גמישות של +/- 20%.
4. למיפוי content_units -> slides, השתמש במבנה הסיפור שב-`../../references/R1-07-story-structure.md`. בחר מבנה לפי genre: pitch -> Problem -> Solution -> Proof -> Ask; keynote/ted -> Hook -> Tension -> Resolution -> Echo; lecture/workshop -> Map -> Concept -> Demo -> Practice.
5. עבור כל שקופית, החלט על `bullets_allowed` לפי הכלל ב-`../../references/R1-04-bullets.md` (Doumont conditional). הכלל המהיר: בולטים מותרים רק כאשר התוכן הוא רשימה שאנשים מצליחים לעקוב אחריה בעין. ברירת המחדל היא `false`. תיעוד ההצדקה ב-`bullets_justification`.
6. עבור צפיפות, התייעץ ב-`../../references/R1-02-density.md` סעיף Glance Test. אם התוכן לא עובר את ה-Glance Test, פצל לשקופית נוספת או פשט.
7. עבור visual_placeholder: השתמש ב-`../../references/R1-05-visuals.md` להחליט אם השקופית באמת זקוקה לוויזואל (PSE + Dual-Coding + Coherence). אם לא, `none`. אם כן, תיאור עברי ספציפי (לא "תמונה", אלא "איור שטוח של X עם Y מסומן ב-Z"). אם השקופית כוללת data, התייעץ גם ב-`../../references/R1-03-data-viz.md`.
8. עבור speaker_notes: אם meta.speaker_notes=`on`, כתוב notes לכל שקופית. סגנון ה-notes לפי `../../references/R1-06-speaker-notes.md`. השתמש בטבלת ה-`(genre, audience, output_type) -> notes-style` כדי לבחור צפיפות:
   - pitch + investors + presentation -> notes קצרים, כיווני, רומזים (אל תקריאי, השתהי 2 שניות).
   - keynote/ted + general + presentation -> notes נרטיביים, מציינים אנרגיה ופעימה.
   - lecture/workshop + students + slidedoc -> notes פדגוגיים, מציינים מה לדגש, מה לדלג.
   - briefing + executive + slidedoc -> notes טקטיים, מציינים מה לדלג אם הזמן קצר.
   - sales + prospect + presentation -> notes שיחתיים, מציינים objections להכין.
   - demo + technical + presentation -> notes קצרים, מציינים מה לעשות בקליק.
   אם meta.speaker_notes=`off`, השאר null לכל השקופיות. אם הלומד ביקש להחריג שקופית ספציפית, סמן `off` עליה.
9. עבור typography hints, אל תייצר פלט. R1 ch01 רלוונטי ל-POWER שיבחר פונטים. הסקיל הזה לא נוגע בפונטים.
10. החלט על `title` לכל שקופית. הכותרת היא משפט קצר (עד 8 מילים) שמתאר את הזווית של השקופית, לא את הנושא. השתמש ב-`../../references/R1-00-foundations.md` לעקרון "title as message, not topic".
11. עבור decision tree ב-`../../references/R1-08-decision-tree.md`, השתמש בו כאשר אתה מתלבט בין שני מבני סיפור או שתי החלטות צפיפות. הוא לא רץ אוטומטית, אתה קורא אותו רק כשיש קונפליקט.
12. עבור watch-fors ב-`../../references/R1-addon-B-watch-fors.md`, סרוק את הפלט שלך לפני החזרה ובדוק שלא נכנסו אנטי-דפוסים נפוצים (כותרת-נושא, בולטים מיותרים, וויזואל דקורטיבי).
13. בדוק את הספירה: total content_units מסקיל הקודם vs total slides. אם כל יחידה הופכת לשקופית 1:1, ייתכן שלא בנית מבנה, חזור לצעד 4.
14. החזר את הרשימה. אל תכתוב לדיסק. אל תייצר Visual Queue או recommendations, זה תפקיד הסקילים הבאים.

## Decision table , quick R1 lookup

| השאלה | קובץ ב-references/ | סעיף |
|---|---|---|
| כמה שקופיות לדקה? | R1-00-foundations.md | Pacing |
| האם הכותרת היא נושא או מסר? | R1-00-foundations.md | Title as message |
| צפיפות שקופית? | R1-02-density.md | Glance Test |
| בולטים כן/לא? | R1-04-bullets.md | Doumont conditional |
| צריך וויזואל? | R1-05-visuals.md | PSE + Dual-Coding |
| איזה גרף? | R1-03-data-viz.md | Chart selection |
| מבנה סיפור לפי genre? | R1-07-story-structure.md | Genre patterns |
| בחירה בין שני מבנים? | R1-08-decision-tree.md | Decision Tree |
| צפיפות notes? | R1-06-speaker-notes.md | Density by output_type |
| קוצרי דרך נפוצים? | R1-addon-B-watch-fors.md | Anti-patterns |
| מיפוי מהיר genre x audience? | R1-addon-A-decision-sheet.md | Quick sheet |

## Edge cases

- `genre: workshop` ו-`output_type: slidedoc` -> שקופיות צפופות יותר, פחות notes, יותר טקסט מודפס.
- `language: mixed` -> ייצר תוכן בעברית ושמור מילים אנגליות מקצועיות במקור. אל תתרגם "API" ל"ממשק". כן תרגם מילים כלליות.
- `audience` רחב מאוד או דליל -> השתמש ב-R1-addon-A כדי לבחור פרופיל אמצע ולסמן ב-`speaker_notes` שהקהל מעורב.
- content_unit ארוך מאוד (מעל 500 תווים) -> פצל לשתי שקופיות, אל תדחס.
- אין content_units בכלל -> החזר שגיאה, אל תייצר שקופיות ריקות.
- duration_minutes קצר (1-3 דקות) -> שקופית אחת או שתיים בלבד. אל תכפה מבנה של 5 שלבים על דקה אחת.
- duration_minutes ארוך (60+ דקות) -> חלק לסקציות עם שקופיות מעבר. R1 ch07 מציע מבני כותרת לסקציות.

## Failure modes

- אחרי מיפוי, כותרת השקופית עדיין מתארת נושא ולא מסר -> נסח מחדש. אם נכשל פעמיים, החזר את ה-key_message ככותרת זמנית והוסף הערה.
- כותרת ארוכה מ-8 מילים -> קצר.
- key_message ארוך מ-200 תווים -> פצל למשפט אחד עיקרי + פירוט ב-content.
- content ריק עם bullets_allowed=true -> זה אנטי-דפוס 6 בחוזה Section 9. אל תפלט פלט כזה. אם אין content, סמן bullets_allowed=false ובקש מ-elicit לחזור.
- visual_placeholder סתום ("תמונה", "tbd") -> הרחב לתיאור ספציפי או סמן none. אנטי-דפוס 7.
- ספירת שקופיות לא הולמת את duration_minutes -> שקול שוב בצעד 3.

## Test fixtures

See `tests/` for an intake fixture and the expected slide list.
