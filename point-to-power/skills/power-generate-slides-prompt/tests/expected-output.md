# Expected outputs

## slides_prompt_md

```markdown
# פרומפט ל-Gemini (Google Slides)

הדבק את הפרומפט הזה ב-Gemini. שתי דרכים:
- ב-Gemini Canvas: בקש "צור מצגת" מהמבנה למטה, ואז ייצא ל-Google Slides בכפתור הייצוא.
- ב-Gemini בתוך Google Slides: השתמש ב-"Generate" כדי לבנות את השקופיות לפי המבנה.

הפלט הוא טיוטה. הקצֵה כשליש עד מחצית מהזמן לליטוש אחרי הייצוא: יישור RTL, פונטים, מיקום תמונות, וצפיפות.

## הקשר

מצגת pitch של ColorTune ל-seed round, 12 דקות, 6 שקופיות.
הקהל: משקיעי seed ומנהלי מוצר במיט-אפ דיזיין-טק בתל אביב, כ-30 איש, מעורב טכני-משקיעי.
סגנון: Editorial Light , מינימליסטי, הרבה לבן, אקצנט יחיד בכחול.
שפה: עברית עם איים LTR לשמות מותגים ולמספרים.

## עיצוב , סגנון Editorial Light

- fonts: heading Inter, body Inter, עברית Rubik (לכל הטקסט בעברית).
  כל הפונטים האלה זמינים ב-Google Fonts; Google Slides תומך בהם ישירות.
- palette: primary #0F1419, accent #2563EB, background #FFFFFF, text #0F1419. צבע אקצנט אחד בלבד.
- spacing: base 8px, rhythm 8/16/24/48/96.
- motion: none כברירת מחדל; מעבר fade עדין מותר בין שקופיות.

## שקופיות

### שקופית 1 , עיצוב נגיש לוקח שעות שלא תוקצבו

- layout: split-60-40 (טקסט בצד הרחב מימין, תמונה בצד הצר משמאל).
- title: "עיצוב נגיש לוקח שעות שלא תוקצבו".
- key_message: "מעצבים מבזבזים שעות שלמות בכל פרויקט על תיקוני נגישות שאף אחד לא תכנן עליהם."
- content (RTL): "בכל פרויקט יש את הרגע הזה. המעצב מסיים את הפלטה, פותח Contrast Checker,
  ומגלה שחצי מהקומבינציות נכשלות. החלפת צבע אחד שוברת את ההיררכיה של כל המסך."
- bullets: false.
- visual: ראה image_prompts , שקופית 1; הוויזואל יוכנס ידנית מהבלוק הנפרד למטה, או בקש מ-Gemini לייצר איור מתאים.
- speaker_notes: הכנס את ה-notes של שקופית 1 לפאנל ה-Speaker notes ב-Google Slides, לא לגוף השקופית.

### שקופית 2 , הבעיה במספרים

- layout: hero (מספר ענק במרכז).
- title: "הבעיה במספרים".
- key_message , הצב במרכז כמספר גדול: "96.3% מאתרים מובילים נכשלים." מתחת בקטן: "WebAIM Million 2025."
- content (RTL): טקסט הסבר קצר.
- bullets: false.
- visual: אין.
- speaker_notes: לפאנל ה-Speaker notes.

### שקופית 3 , ColorTune

- layout: split-60-40 (תמונה בצד הצר).
- title: "ColorTune".
- key_message: "ColorTune מקבל פלטה ראשונית ומחזיר גרסה נגישה ששומרת על הזהות הוויזואלית."
- content (RTL): תהליך השימוש ב-3-4 שורות.
- bullets: false.
- visual: ראה image_prompts , שקופית 3 (UI mock-up).
- speaker_notes: לפאנל ה-Speaker notes.

### שקופית 4 , ColorTune בפעולה

- layout: full-bleed (שקופית "Wow").
- title: "ColorTune בפעולה".
- key_message: "דמו חי, 90 שניות, פלטה אמיתית."
- content: אין טקסט מרכזי; הוויזואל ממלא את השקופית.
- bullets: false.
- visual: וידאו. Google Slides תומך בהטמעת וידאו (Insert > Video). הצב placeholder והדבק את הקובץ ידנית אחרי הייצוא. ה-keyframe מ-image_prompts , שקופית 4 ישמש כפתיחה.
- speaker_notes: אין (off).

### שקופית 5 , יש כבר משתמשים שמשלמים

- layout: split-50-50 (טקסט מימין, גרף משמאל).
- title: "יש כבר משתמשים שמשלמים".
- key_message: המספרים העיקריים בשורה אחת.
- content (RTL): bullets מותרים , רשימת 4 מטריקות.
- bullets: true (4 פריטים).
- visual: גרף עמודות בצד שמאל. ראה image_prompts , שקופית 5; עדיף להחליף בגרף אמיתי מ-Google Sheets (Google Slides מתחבר ל-Sheets ישירות).
- speaker_notes: לפאנל ה-Speaker notes.

### שקופית 6 , מה אנחנו מבקשים

- layout: split-60-40 (תמונה בצד הצר).
- title: "מה אנחנו מבקשים".
- key_message: "מגייסים סבב seed של 800K, מכירות בארה\"ב + תוסף Figma."
- content (RTL): שלוש שורות סגירה.
- bullets: false.
- visual: תמונת לפטופ רגוע. ראה image_prompts , שקופית 6.
- speaker_notes: לפאנל ה-Speaker notes.

## RTL ונגישות

- כל הטקסט בעברית מיושר לימין; כל הספרות והשמות באנגלית (ColorTune, WebAIM, Figma, seed) נשארים LTR בתוך השורה.
- ניגודיות #0F1419 על #FFFFFF עוברת WCAG AAA.
- שים לב: טיוטות Gemini נוטות ליישר טקסט עברי לשמאל. אחרי הייצוא, עברו שקופית-שקופית וודאו שכל תיבת טקסט עברית מוגדרת יישור-לימין.
- Rubik נבחר ל-body העברי כי Inter לבדה לא תומכת עברית טוב.

## ייצוא ל-Google Slides

ב-Gemini Canvas: לחצו על כפתור הייצוא ל-Google Slides. ב-Gemini בתוך Slides: המצגת כבר שם.
אחרי הבנייה, עברו שקופית-שקופית ולטשו לפי רשימת הליטוש למעלה. הקצֵה לכך כשליש עד מחצית מהזמן.
```

## image_prompts_md

```markdown
# פרומפטים ליצירת תמונות

יש שתי דרכים לוויזואלים:
- תן ל-Gemini Canvas לייצר אותם ישירות בתוך המצגת (מהיר, פחות שליטה).
- או הרץ כל פרומפט בנפרד ב-tool המומלץ בראש הבלוק, ואז הדבק ידנית בשקופית המתאימה ב-Google Slides (יותר שליטה).

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

## notes

```yaml
- slides-draft-polish
```

Notes for human reviewer:

- The slides prompt is in Hebrew because the audience and content are Hebrew. Technical vocabulary (font names, "Google Slides", "Speaker notes") stays in English inside the Hebrew prompt , this is correct.
- There is NO "design-system skill activation" section , that is a Claude-in-PowerPoint mechanism. Fonts/palette/spacing are written as explicit design instructions Gemini applies.
- The layout vocabulary is the HTML semantic-grid set (`hero`, `split-60-40`, `full-bleed`, `split-50-50`), NOT PowerPoint slot names. Gemini reads natural-language layout.
- `slides-draft-polish` is always emitted: every Gemini output is a draft, so the learner is always reminded to allocate roughly a third to half the time to post-export polish.
- Slide 4 has no speaker_notes per AST (`speaker_notes: "off"`); the slide line explicitly says "אין (off)".
- image_prompts_md is intentionally separate from slides_prompt_md, and its header notes that Gemini Canvas can also generate the visuals natively if the learner prefers.
