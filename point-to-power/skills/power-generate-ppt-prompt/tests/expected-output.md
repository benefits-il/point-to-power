# Expected outputs

## ppt_prompt_md

```markdown
# פרומפט ל-Claude in PowerPoint

## הקשר

מצגת pitch של ColorTune ל-seed round, 12 דקות, 6 שקופיות.
הקהל: משקיעי seed ומנהלי מוצר במיט-אפ דיזיין-טק בתל אביב, כ-30 איש, מעורב טכני-משקיעי.
סגנון: Editorial Light , מינימליסטי, הרבה לבן, אקצנט יחיד בכחול.
שפה: עברית עם איים LTR לשמות מותגים ולמספרים.

## הפעלת design-system skill

הפעל את design-system skill עם ההגדרות:
- fonts: heading Inter, body Inter, hebrew_pair Rubik (לכל הטקסט בעברית).
- palette: primary #0F1419, accent #2563EB, background #FFFFFF, text #0F1419.
- spacing: base 8px, rhythm 8/16/24/48/96.
- motion: ברירת מחדל none; השתמש ב-fade-in רק היכן שמצוין.
- accent rule: צבע אקצנט אחד בלבד, אל תוסיף צבעים נוספים.

## הוראות לכל שקופית

### שקופית 1: עיצוב נגיש לוקח שעות שלא תוקצבו

- layout: title-image (slot title + content + image_right_half).
- title (44pt, Inter, נעוץ עליון ימני, עברית RTL): "עיצוב נגיש לוקח שעות שלא תוקצבו".
- key_message (24pt, Inter Medium, אזור content עליון):
  "מעצבים מבזבזים שעות שלמות בכל פרויקט על תיקוני נגישות שאף אחד לא תכנן עליהם."
- content (16pt, Rubik, אזור content תחתון, RTL):
  "בכל פרויקט יש את הרגע הזה. המעצב מסיים את הפלטה, פותח Contrast Checker,
   ומגלה שחצי מהקומבינציות נכשלות. החלפת צבע אחד שוברת את ההיררכיה של כל המסך.
   התיקון לוקח לפעמים יום שלם, ולא מופיע באף אומדן זמן בתחילת הפרויקט."
- bullets: false.
- visual: שמור את slot image_right_half ריק; הוויזואל יוכנס ידנית, ראה בלוק הפרומפטים למטה (שקופית 1).
- speaker_notes: לפי בלוק Notes Page handoff בהמשך.

### שקופית 2: הבעיה במספרים

- layout: section-header (slot title-only עם מספר גדול במרכז).
- title (40pt, Inter, עליון ימני, עברית RTL): "הבעיה במספרים".
- key_message , הצב במרכז כמספר ענק (96pt, Inter Black, צבע #0F1419):
  "96.3% מאתרים מובילים נכשלים." מתחת בעברית קטנה (18pt): "WebAIM Million 2025."
- content (16pt, Rubik, תחתית): טקסט הסבר קצר ב-RTL.
- bullets: false.
- visual: אין.
- speaker_notes: לפי בלוק Notes Page.

### שקופית 3: ColorTune

- layout: title-image (image_right_half).
- title (44pt): "ColorTune".
- key_message (24pt): "ColorTune מקבל פלטה ראשונית ומחזיר גרסה נגישה ששומרת על הזהות הוויזואלית."
- content (16pt, RTL): תהליך השימוש ב-3-4 שורות.
- bullets: false.
- visual: slot image_right_half , UI mock-up. הוויזואל מהבלוק למטה (שקופית 3).
- speaker_notes: לפי בלוק Notes Page.

### שקופית 4: ColorTune בפעולה

- layout: title-image (image_fullbleed) , שקופית "Wow".
- title (40pt): "ColorTune בפעולה".
- key_message (24pt): "דמו חי, 90 שניות, פלטה אמיתית."
- content: אין טקסט מרכזי; הוידאו ימלא את השקופית.
- bullets: false.
- visual: וידאו במקום תמונה. הצב בשקופית placeholder לוידאו 21:9 והדבק את הקובץ ידנית. הקליפ מ-keyframe ב-image_prompts ישמש כפתיחה לוידאו.
- speaker_notes: אין (off).

### שקופית 5: יש כבר משתמשים שמשלמים

- layout: two-content (text_right + chart_left).
- title (44pt): "יש כבר משתמשים שמשלמים".
- key_message (24pt): המספרים העיקריים בשורה אחת.
- content (16pt, RTL): bullets מותרים , רשימת 4 מטריקות.
- bullets: true (4 פריטים, build-by-bullet).
- visual: גרף עמודות באזור chart_left. הוויזואל מבלוק הפרומפטים (שקופית 5); עדיף להחליף בגרף אמיתי מ-Excel/Datawrapper.
- speaker_notes: לפי בלוק Notes Page.

### שקופית 6: מה אנחנו מבקשים

- layout: title-image (image_right_half).
- title (44pt): "מה אנחנו מבקשים".
- key_message (24pt): "מגייסים סבב seed של 800K, מכירות בארה\"ב + תוסף Figma."
- content (16pt, RTL): שלוש שורות סגירה.
- bullets: false.
- visual: תמונת לפטופ רגוע, אזור image_right_half. מבלוק הפרומפטים (שקופית 6).
- speaker_notes: לפי בלוק Notes Page.

## RTL ו-נגישות

- כל הטקסט בעברית מיושר לימין; כל הספרות והשמות באנגלית (ColorTune, WebAIM, Figma, seed) נשארים LTR בתוך השורה.
- ניגודיות #0F1419 על #FFFFFF עוברת WCAG AAA.
- שקופית 2 , המספר 96.3% נשאר LTR. הסמל "%" מימין למספר.
- שקופית 5 , ציר X של הגרף בעברית מימין-לשמאל; ערכי ציר Y LTR.
- Rubik נבחר ל-body העברי כי Inter לבדה לא תומכת חצוי עברית טוב.

## Notes Page handoff

הפק Notes Page נפרד לכל שקופית עם תוכן speaker_notes מתוך ה-handoff:

- שקופית 1: <speaker_notes>
- שקופית 2: <speaker_notes>
- שקופית 3: <speaker_notes>
- שקופית 4: אין (off).
- שקופית 5: <speaker_notes>
- שקופית 6: <speaker_notes>

צפיפות notes לפי SA5-ch6-7: 3-5 שורות לכל שקופית, נימה כיוונית (אל תקריאי, השתהי, התחילי, סיימי).

## stale watch

- Claude-in-PowerPoint add-in דורש Copilot Pro או Microsoft 365 Copilot חי בארגון. ודא שהלומד מחובר לפני הדבקת הפרומפט.
- כל הפרטים מ-SA1-ch1-2 על setup נכונים נכון לאחזור האחרון של R4; אם חלפו 6+ חודשים, ודא שה-add-in לא שינה ממשק.
```

## image_prompts_md

```markdown
# פרומפטים ליצירת תמונות

הדבק כל פרומפט בנפרד ב-tool המומלץ בראש כל בלוק.
אחרי שיצרת את התמונה, הדבק אותה ידנית בשקופית המתאימה ב-PowerPoint.

## שקופית 1 , recraft (ראשי)

<prompt body from image_prompts[0].image_prompt>

## שקופית 3 , recraft (ראשי)

<prompt body from image_prompts[1].image_prompt>

## שקופית 4 , gemini (ראשי) , keyframe לוידאו

<prompt body from image_prompts[2].image_prompt>

## שקופית 5 , recraft (ראשי) , אבל עדיף chart אמיתי

<prompt body from image_prompts[3].image_prompt>

## שקופית 6 , gemini (ראשי)

<prompt body from image_prompts[4].image_prompt>
```

## stale_warnings

```yaml
- copilot-pro-required
- powerpoint-add-in-ui-may-shift
```

Notes for human reviewer:

- The PPT prompt is in Hebrew because the audience and content are Hebrew. Technical PowerPoint vocabulary (slot names, font names) is in English inside the Hebrew prompt , this is correct.
- The image_prompts_md is intentionally separate from ppt_prompt_md because the learner pastes them in different tools.
- stale_warnings flags are surfaced to the learner alongside the prompts so they know to verify Copilot setup before pasting.
- Slide 4 has no speaker_notes per AST (`speaker_notes: "off"`); the Notes Page handoff explicitly says "אין (off)".
