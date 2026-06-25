---
name: power-generate-slides-prompt
description: Activate when target=slides after write-per-slide-layout and generate-visual-prompts complete , emit the final Gemini prompt for a Google Slides deck (Gemini Canvas or Gemini-in-Slides) plus a parallel image-prompt block for external image generation.
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Generate Slides Prompt

## Purpose

מייצר את הפרומפט הסופי שהלומד מדביק ב-Gemini כדי לבנות מצגת Google Slides. הפרומפט מנוסח ל-Gemini, לא ל-Claude: הלומד מדביק אותו ב-Gemini Canvas ומבקש "צור מצגת", או משתמש ב-Gemini בתוך Google Slides עצמו, ואז מייצא ל-Google Slides בקליק. הסקיל הזה רץ רק אם target=slides. הוא גם מחזיר בנפרד את ה-image-prompt block, אותו הלומד מקבל בצד כדי להריץ אצל Gemini/GPT-Image/Recraft ולהדביק ידנית, או לתת ל-Gemini Canvas לייצר את הוויזואלים בעצמו.

ההבדל המהותי מ-`generate-ppt-prompt`: אין הפעלת design-system skill (זה מנגנון של Claude-in-PowerPoint). במקום זה, ההגדרות של fonts, palette, spacing ו-motion נכתבות כהוראות עיצוב מפורשות ש-Gemini מיישם. כל הפונטים נמשכים מ-Google Fonts, ש-Google Slides תומך בהם ילידית.

## Inputs

- **ast** (מלא).
- **style_record** מ-`select-style`.
- **layouts** מ-`write-per-slide-layout` , אוצר המילים הסמנטי (CSS Grid), זהה ל-target=html. Gemini קורא תיאור layout בשפה טבעית, ולכן אוצר המילים הסמנטי (`hero`, `split-60-40`, `full-bleed`) מתאים לו, בניגוד ל-slot names של PowerPoint.
- **image_prompts** מ-`generate-visual-prompts`.

## Outputs

- **slides_prompt_md** (מחרוזת Markdown), מוכן להדבקה ב-Gemini Canvas או ב-Gemini בתוך Google Slides.
- **image_prompts_md** (מחרוזת Markdown), מוכן להדבקה ב-image-generation tool. נפרד.
- **notes** (list, אופציונלי), הערות שעלו (לדוגמה: draft-polish reminder, rtl-hazard, aspect_ratio).

## Process

1. קרא את `../../references/R5-gemini-slides.md` במלואו. זה המקור ליכולות Gemini Canvas / Gemini-in-Slides, לאיך לנסח לו פרומפט, לזרימת הייצוא ל-Google Slides, ולמגבלה המרכזית (הפלט הוא טיוטה שדורשת ליטוש).
2. קרא את `../../references/R3-stage-3-output.md`, מקטע הסגנון שנבחר, כדי לחלץ implementation cues (פלטה, טיפוגרפיה, צפיפות) שיתורגמו להוראות עיצוב מפורשות ל-Gemini.
3. קרא את `../../references/R1-01-typography.md` ו-`../../references/R1-02-density.md` להבטחת baseline טיפוגרפי ו-pacing נכון בדק (slide יחיד = רעיון אחד + visual, לא wall of text).
4. הרכב aspect_ratio. Google Slides הוא 16:9 כברירת מחדל; 4:3 אפשרי. teleprompter אינו מקרה טבעי ל-Slides (ראה Edge cases).
5. הרכב את slides_prompt_md בעברית, במבנה הבא:

```markdown
# פרומפט ל-Gemini (Google Slides)

הדבק את הפרומפט הזה ב-Gemini. שתי דרכים:
- ב-Gemini Canvas: בקש "צור מצגת" מהמבנה למטה, ואז ייצא ל-Google Slides בכפתור הייצוא.
- ב-Gemini בתוך Google Slides: השתמש ב-"Generate" כדי לבנות את השקופיות לפי המבנה.

הפלט הוא טיוטה. הקצֵה כשליש עד מחצית מהזמן לליטוש אחרי הייצוא: יישור RTL, פונטים, מיקום תמונות, וצפיפות.

## הקשר

<פסקה קצרה בעברית: מה אנחנו בונים, לאיזה קהל, כמה שקופיות, באיזה סגנון.>

## עיצוב , סגנון <style_record.primary>

- fonts: heading <heading font>, body <body font>, עברית <Rubik / Alef / וכו'>.
  כל הפונטים האלה זמינים ב-Google Fonts; Google Slides תומך בהם ישירות.
- palette: primary <hex>, accent <hex>, background <hex>, text <hex>. צבע אקצנט אחד בלבד.
- spacing: base 8px, rhythm <8/16/24/48/96>.
- motion: <none / מעברים עדינים>. Google Slides תומך ב-slide transitions בסיסיים.

## שקופיות

### שקופית 1 , <title>

- layout: <מ-layouts[0].grid: hero | split-60-40 | full-bleed | ...>
- title: "<ast.slides[0].title>"
- key_message: "<ast.slides[0].fields.key_message>"
- content (RTL): "<ast.slides[0].fields.content, multi-line>"
- bullets: <true | false מ-ast.slides[0].fields.bullets_allowed>
- visual: <reference ל-image_prompts[0].slide_number; הוויזואל יוכנס ידנית מהבלוק הנפרד למטה, או בקש מ-Gemini לייצר תמונה מתאימה>
- speaker_notes: <אם meta.speaker_notes=on ולא off: הכנס לפאנל ה-notes של Google Slides (Speaker notes), לא לגוף השקופית>

### שקופית 2 , ...
(וכן הלאה)

## RTL ונגישות

<אם meta.language=he או mixed: עברית כברירת מחדל, יישור לימין; ספרות ושמות לועזיים (מותגים, אנגלית) נשארים LTR בתוך השורה העברית. ניגודיות AA לפחות. שים לב: טיוטות Gemini נוטות ליישר טקסט עברי לשמאל, תקן ל-RTL אחרי הייצוא.>

## ייצוא ל-Google Slides

<מ-R5: ב-Gemini Canvas יש כפתור ייצוא ל-Google Slides; ב-Gemini בתוך Slides המצגת כבר שם. אחרי הבנייה, עברו שקופית-שקופית ולטשו לפי רשימת הליטוש למעלה.>
```

6. הרכב את image_prompts_md (נפרד), מבנה זהה ל-generate-ppt-prompt, עם הערת-ראש שמסבירה שאפשר גם לתת ל-Gemini Canvas לייצר את הוויזואלים בעצמו:

```markdown
# פרומפטים ליצירת תמונות

יש שתי דרכים לוויזואלים:
- תן ל-Gemini Canvas לייצר אותם ישירות בתוך המצגת (מהיר, פחות שליטה).
- או הרץ כל פרומפט בנפרד ב-tool המומלץ בראש הבלוק, ואז הדבק ידנית בשקופית המתאימה ב-Google Slides (יותר שליטה).

## שקופית 1 , recraft (ראשי)

<image_prompts[0].image_prompt>

## שקופית 3 , recraft (ראשי)

<image_prompts[1].image_prompt>

(וכן הלאה)
```

7. חלץ notes: תמיד הוסף את ה-draft-polish reminder (`slides-draft-polish`) כי כל פלט של Gemini הוא טיוטה. אם style_record.warnings מכיל `rtl-hazard` -> הוסף `rtl-polish-needed` והנחיה ספציפית בסעיף RTL. אם מכיל `accessibility-tier-c` -> הוסף הנחיית contrast ב-RTL ונגישות.
8. ודא שהפרומפט ספציפי ופעולתי, בלי הנחיות סותרות ובלי שאלות-תוך-הנחיה.
9. החזר את שלושת ה-outputs.

## Edge cases

- meta.speaker_notes=off -> אל תכלול הנחיית speaker notes. אל תייצר notes "ליתר ביטחון".
- visual_queue ריק -> image_prompts_md הוא מחרוזת ריקה או מילולית `(אין ויזואלים)`. slides_prompt_md לא מציין `visual:` בשקופיות.
- meta.language=`en` -> כתוב את slides_prompt_md באנגלית. ההוראות הטכניות (שמות פונטים, "export to Google Slides") נשארות באנגלית גם כשהתוכן בעברית.
- meta.output_type=`teleprompter` -> Google Slides אינו הכלי הטבעי לטלפרומפטר. הוסף note שמומלץ HTML או PowerPoint לטלפרומפטר; אם הלומד מתעקש על Slides, הנחה פונט 40pt+, ניגודיות מקסימלית, slot title-only.
- meta.output_type=`slidedoc` -> Google Slides הוא slide-based ולא scroll; הנחה כל "שקופית" כשקופית מלאה עם יותר טקסט, והוסף note שלצפיפות slidedoc ייתכן ש-HTML מתאים יותר.
- 30+ שקופיות -> Gemini Canvas עלול לקצר טיוטות ארוכות. הנחה את הלומד לבנות בשני סבבים (שקופיות 1-15, ואז 16-N) ולמזג ב-Google Slides.

## Failure modes

- layouts ריק (write-per-slide-layout לא רץ) -> שגיאת בנייה. החזר.
- image_prompts לא תואם ל-ast.slides (slide ב-queue אבל לא ב-layouts) -> סמן warning ב-notes, המשך עם מה שיש.
- `R5-gemini-slides.md` לא נטען -> אל תמציא יכולות של Gemini; דווח ל-POWER עם הודעת תקלה ובקש בדיקה ידנית של הקובץ.
- slides_prompt_md ארוך מ-30K תווים -> חתוך לפרומפט גרעין + הוראות תוספת, וסמן ללומד שייתכן צורך בשני סבבי בנייה ב-Gemini.

## Test fixtures

See `tests/` for a full input fixture and the expected slides_prompt + image_prompts.
