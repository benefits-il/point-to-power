---
name: power-generate-ppt-prompt
description: Activate when target=powerpoint after write-per-slide-layout and generate-visual-prompts complete , emit the final Claude-in-PowerPoint add-in prompt plus a parallel image-prompt block for external image generation.
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Generate PPT Prompt

## Purpose

מייצר את הפרומפט הסופי שהלומד מדביק ב-Claude-in-PowerPoint add-in. הפרומפט מכיל את כל ה-directives של השקופיות, מפעיל את design-system skill, מצרף Notes Page handoff אם speaker_notes=on, ומציין stale-watch warnings מ-R4. הסקיל הזה רץ רק אם target=powerpoint. הסקיל גם מחזיר בנפרד את ה-image-prompt block, אותו הלומד מקבל בצד כדי להריץ אצל Gemini/GPT-Image/Recraft ולהדביק ידנית.

## Inputs

- **ast** (מלא).
- **style_record** מ-`select-style`.
- **layouts** מ-`write-per-slide-layout` (vocabulary PPT).
- **image_prompts** מ-`generate-visual-prompts`.

## Outputs

- **ppt_prompt_md** (מחרוזת Markdown), מוכן להדבקה ב-Claude-in-PowerPoint.
- **image_prompts_md** (מחרוזת Markdown), מוכן להדבקה ב-image-generation tool. נפרד.
- **stale_warnings** (list של אסימוני stale-watch שעלו, להצגה ללומד).

## Process

> **W-G1 , פרומפט בלבד.** הסקיל פולט פרומפט להדבקה ב-Claude-in-PowerPoint; הוא לעולם לא בונה את קובץ ה-PPTX בעצמו. הכלי החיצוני בונה את הדק.

### Design Quality Gate (W-G3)

הפרומפט הראשי שמוחזר חייב לעמוד בכל הבנדים הבאים *לפני* שהוא מוחזר. אם הוא נכשל בבנד כלשהו, ה-emitter *לא מחזיר אותו*; הוא מחזק את המפרט קודם:

- גופנים נעולים מפורשות (heading + body + fallback chain) מ-R3 Pairing Rules.
- פלטה עם כל ערכי ה-hex (primary, accent, background, text) verbatim בתוך הפרומפט.
- spacing rhythm מפורש (base unit plus סקאלה).
- מיקום-ויזואל לכל שקופית מפורש ולא עמום (לא "tbd", לא "image here"); הפניה לבלוק פרומפט-התמונה המתאים.
- RTL מפורש כש-language=he/mixed (כיוון, יישור, מספרים/מותג LTR).
- motion קונקרטי כשהסגנון דורש (למשל "fade-in 300ms", לא "תוסיף אנימציה").
- בלי תארים מעורפלים ("מודרני"/"מגניב"/"אלגנטי") בלי פירוט נצפה.
- סגנון אחד נעול (style_record.primary), לא "תשקול X או Y".

1. קרא את כל קבצי ה-R4 ברפרנסים. כל אחד תורם חלק אחר:
   - SA1-ch1-2: setup ושיתוף עם Copilot Pro / Teams. (`../../references/R4-SA1-ch1-2.md`)
   - SA2-ch3: prompt engineering ספציפי ל-PowerPoint (אוצר מילים, אסטרטגיות, מה עובד ומה לא). (`../../references/R4-SA2-ch3.md`)
   - SA3-ch4: slide generation + iteration. (`../../references/R4-SA3-ch4.md`)
   - SA4-ch5: design-system skill integration, איך להפעיל את ה-skill מתוך הפרומפט. (`../../references/R4-SA4-ch5.md`)
   - SA5-ch6-7: Notes Page handoff + Presenter Notes. (`../../references/R4-SA5-ch6-7.md`)
   - SA6-ch8: accessibility + RTL. (`../../references/R4-SA6-ch8.md`)
   - templates.md: תבניות מוכנות שאפשר להפנות אליהן. (`../../references/R4-siblings-templates.md`)
   - stale-watch.md: freshness flags לטיפול בידע מתיישן. (`../../references/R4-siblings-stale-watch.md`)
2. הרכב את ppt_prompt_md בעברית, במבנה הבא:

```markdown
# פרומפט ל-Claude in PowerPoint

## הקשר

<פסקה קצרה בעברית: מה אנחנו בונים, לאיזה קהל, כמה שקופיות, באיזה סגנון.>

## הפעלת design-system skill

<קריאה לסקיל לפי המוסכמה ב-SA4-ch5. שם הסקיל המדויק וההגדרות:
fonts, palette, spacing, motion, מה-style_record.locked>

## הוראות לכל שקופית

### שקופית 1: <title>

- layout: <מ-layouts[0].grid>
- title: <ast.slides[0].title>
- key_message: <ast.slides[0].fields.key_message>
- content: <ast.slides[0].fields.content, multi-line>
- bullets: <true | false מ-ast.slides[0].fields.bullets_allowed>
- visual: <reference ל-image_prompts[0].slide_number; הוויזואל יוכנס ידנית, ראה בלוק הנפרד למטה>
- speaker_notes: <ast.slides[0].fields.speaker_notes אם meta.speaker_notes=on ולא off; אחרת השמט>

### שקופית 2: ...
(וכן הלאה)

## RTL ו-נגישות

<אם meta.language=he או mixed: הנחיות RTL מתוך SA6-ch8, יישור ימינה, ספרות LTR בתוך טקסט עברי, הימנעות מ-fonts שלא תומכים עברית.>

## Notes Page handoff

<אם meta.speaker_notes=on: הוראה מ-SA5-ch6-7 איך לייצר Notes Page בנפרד מהשקופית עצמה, עם הצפיפות הנכונה למעבר ל-Presenter View.>

## stale watch

<אם יש freshness flags מ-stale-watch.md שחלים על התוכן: ציין אותם בקצרה.>
```

3. הרכב את image_prompts_md (נפרד), מבנה:

```markdown
# פרומפטים ליצירת תמונות

הדבק את כל פרומפט בנפרד ב-tool המומלץ בראש כל בלוק.
אחרי שיצרת את התמונה, הדבק אותה לידנית בשקופית המתאימה ב-PowerPoint.

## שקופית 1 , recraft (ראשי)

<image_prompts[0].image_prompt>

## שקופית 3 , recraft (ראשי)

<image_prompts[1].image_prompt>

(וכן הלאה)
```

4. חלץ stale_warnings: סרוק את stale-watch.md ובדוק אם אחד מה-flags חל על תוכן השקופיות (לדוגמה: גרסת PowerPoint, יכולות Copilot, מחירי Microsoft 365). אם כן -> הוסף אסימון ל-stale_warnings.
5. ודא שהפרומפט עומד בכללי SA2-ch3 ל-prompt engineering: ספציפי, פעולה, ללא הנחיות סותרות, ללא שאלות-תוך-הנחיה.
6. אם style_record.warnings מכיל `accessibility-tier-c` או `rtl-hazard` -> כלול הנחיה ספציפית ב-RTL ו-נגישות לטפל בכך.
7. החזר את שלושת ה-outputs.

## Edge cases

- meta.speaker_notes=off -> השמט את Notes Page handoff. אל תייצר אותו "ליתר ביטחון".
- visual_queue ריק -> image_prompts_md הוא מחרוזת ריקה או מילולית `(אין ויזואלים)`. ppt_prompt_md לא מציין `visual:` בשקופיות.
- כל השקופיות עם speaker_notes=off (שקופית-שקופית) -> תייצר Notes Page ריק לכל שקופית (per SA5 , Notes Page יכול להיות null).
- meta.output_type=`teleprompter` -> PPT prompt צריך להנחות לפונט 60pt+, contrast מקסימלי, slot title-only. SA3 מציין את ההבדלים.
- meta.language=`en` -> כתוב את ה-PPT prompt באנגלית. שם הסקיל וההנחיות הטכניות יכולים להישאר באנגלית גם כשהתוכן בעברית.
- 30+ שקופיות -> PPT prompt עשוי להגיע ל-token limit של add-in. שקול לחלק לשני prompts (חלק א וחלק ב) ולסמן ללומד שיש להריץ ברצף.

## Failure modes

- layouts ריק (write-per-slide-layout לא רץ) -> שגיאת בנייה. החזר.
- image_prompts לא תואם ל-ast.slides (slide ב-queue אבל לא ב-layouts) -> סמן warning ב-stale_warnings, המשך עם מה שיש.
- stale-watch.md לא נטען -> דלג על stale_warnings, סמן warning פנימי.
- ppt_prompt_md ארוך מ-30K תווים -> נסה לדחוס speaker_notes לטיוטה קצרה ולציין שהלומד יקבל את ה-notes הארוכים מ-Notes Page handoff שיופק נפרד.

## Test fixtures

See `tests/` for a full input fixture and expected ppt_prompt + image_prompts.
