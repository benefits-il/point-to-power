# Expected outputs

## html_prompt_md

```markdown
# פרומפט לבניית מצגת HTML single-file , ColorTune pitch

הדבק את הפרומפט הזה ב-Claude.ai (לא ב-Claude Code). Claude יחזיר קובץ HTML יחיד שאפשר לפתוח בכל דפדפן ולשלוח כקובץ.

## הקשר

מצגת pitch של ColorTune ל-seed round, 12 דקות, 6 שקופיות.
הקהל: משקיעי seed ומנהלי מוצר במיט-אפ דיזיין-טק בתל אביב, כ-30 איש, מעורב טכני-משקיעי.
סגנון: Editorial Light , מינימליסטי, הרבה לבן, אקצנט יחיד בכחול.
שפה: עברית עם איים LTR לשמות מותגים ולמספרים.

## דרישות טכניות מחייבות

הפלט חייב להיות:

- **קובץ HTML יחיד.** כל ה-CSS וה-JavaScript ב-inline או ב-`<style>` ו-`<script>` בתוך הקובץ.
- **ללא localStorage, ללא sessionStorage, ללא IndexedDB.** המצגת מצב in-memory בלבד. אם הלומד מרענן את הדף, היא מתחילה מחדש משקופית 1.
- **ללא תלויות חיצוניות.** מותר בלבד CDN libraries מהרשימה הבאה:
  - Google Fonts (links ל-`fonts.googleapis.com`) ל-Inter ו-Rubik.
- **aspect ratio: 16:9**, פיקסל קבוע: 1920x1080.
- **keyboard navigation:**
  - ArrowRight / ArrowDown / Space -> שקופית הבאה.
  - ArrowLeft / ArrowUp -> קודמת.
  - Esc -> מצב סקירה (grid של כל השקופיות).
- **RTL:** עברית כברירת מחדל (`<html dir="rtl" lang="he">`), איים LTR (שמות מותגים, מספרים) עם `<span dir="ltr">...</span>`.

## עיצוב , סגנון Editorial Light

- fonts:
  - heading: Inter, system-ui, sans-serif
  - body: Inter, system-ui, sans-serif
  - hebrew_pair: Rubik, sans-serif (לכל הטקסט בעברית, override על Inter ב-`:lang(he)`)
- palette:
  - primary: `#0F1419`
  - accent: `#2563EB`
  - background: `#FFFFFF`
  - text: `#0F1419`
- spacing base: 8px; rhythm: 8 / 16 / 24 / 48 / 96.
- motion: ברירת מחדל none; השתמש ב-fade-in רק היכן שמצוין בשקופית.

## שקופיות

### שקופית 1 , עיצוב נגיש לוקח שעות שלא תוקצבו

- grid: split-60-40 (טקסט מימין 60%, תמונה משמאל 40%).
- hierarchy:
  - title (text-3xl, Inter Semibold): "עיצוב נגיש לוקח שעות שלא תוקצבו"
  - key_message (text-xl, Rubik Medium):
    "מעצבים מבזבזים שעות שלמות בכל פרויקט על תיקוני נגישות שאף אחד לא תכנן עליהם."
  - content (text-base, Rubik, RTL):
    "בכל פרויקט יש את הרגע הזה. המעצב מסיים את הפלטה, פותח Contrast Checker, ומגלה שחצי מהקומבינציות נכשלות. החלפת צבע אחד שוברת את ההיררכיה של כל המסך. התיקון לוקח לפעמים יום שלם, ולא מופיע באף אומדן זמן בתחילת הפרויקט."
  - visual: התיקייה images/, קובץ slide-1.png. השאר 40% משמאל לתמונה.
- bullets: false
- motion: fade-in
- rtl_notes: "כל הטקסט מיושר ימינה. המילה Contrast Checker נשארת LTR בתוך פסקה עברית."

### שקופית 2 , הבעיה במספרים

- grid: hero (טקסט בלבד, במרכז, מספר ענק).
- hierarchy:
  - title (text-2xl, Inter Semibold): "הבעיה במספרים"
  - key_message (text-6xl, Inter Black, ממוקם במרכז):
    96.3% עם הסבר עברי קטן מתחת ("מחקר WebAIM 2025: שש מתוך עשר אתרים מובילים נכשלים בבדיקת ניגודיות ברמת AA")
  - content (text-base, RTL, תחתית): "הסיבה הראשונה במעלה: ניגודיות צבע. הסיבה שזה לא מתוקן: התיקון יקר במונחי זמן עיצוב."
- bullets: false
- motion: none
- rtl_notes: "המספר 96.3% נשאר LTR בתוך השורה העברית. עטוף ב-<span dir=ltr>."

### שקופית 3 , ColorTune

- grid: split-60-40 (טקסט מימין, תמונה משמאל).
- hierarchy:
  - title: "ColorTune"
  - key_message: "ColorTune מקבל פלטה ראשונית ומחזיר גרסה נגישה ששומרת על הזהות הוויזואלית."
  - content (RTL): "המעצב מעלה את הפלטה הראשונית או מחבר את ה-Figma שלו ישירות. ColorTune מריץ אנליזה של יחסי הניגודיות בכל הצירופים שבאמת קיימים ב-UI, לא בכל הקומבינציות התיאורטיות. החזרה היא פלטה מתוקנת ששומרת על ה-hue ועל ההיררכיה, ומסבירה למה כל שינוי נעשה."
  - visual: images/slide-3.png.
- bullets: false
- motion: fade-in
- rtl_notes: "ColorTune, Figma, hue, UI , נשארים LTR. שאר הטקסט עברי RTL."

### שקופית 4 , ColorTune בפעולה

- grid: hero (full-bleed, וידאו במרכז).
- hierarchy:
  - title (text-3xl): "ColorTune בפעולה"
  - key_message (text-xl): "דמו חי, 90 שניות, פלטה אמיתית."
  - visual: וידאו ב-`<video src="images/slide-4.mp4" autoplay muted loop controls>`. אם אין וידאו, השתמש ב-images/slide-4-keyframe.png עם overlay של icon play (SVG inline).
- bullets: false
- motion: none
- rtl_notes: "הוידאו ללא קול, הכיתוביות בלבן ב-RTL."

### שקופית 5 , יש כבר משתמשים שמשלמים

- grid: split-60-40 (טקסט מימין, גרף משמאל).
- hierarchy:
  - title: "יש כבר משתמשים שמשלמים"
  - key_message: "במאי 2026 הגענו ל-340 משתמשים פעילים חודשי ול-12,000 דולר ARR מ-47 צוותים משלמים."
  - content (RTL, bullets=true): רשימה של 4 פריטים , Growth 28%, Churn 4%, גידול 6 חודשים בלי שיווק, 3 סטודיות בפיילוט.
  - visual: images/slide-5.png (גרף עמודות).
- bullets: true (build-by-bullet, fade-in stagger 200ms)
- motion: build-by-bullet
- rtl_notes: "המספרים והאחוזים נשארים LTR. ציר X של הגרף בעברית ימין-לשמאל."

### שקופית 6 , מה אנחנו מבקשים

- grid: split-60-40 (טקסט מימין, תמונה משמאל).
- hierarchy:
  - title: "מה אנחנו מבקשים"
  - key_message: "מגייסים סבב seed של 800 אלף דולר, להאצת המכירות לסטודיות בארה\"ב ולהשלמת חיבור ל-Figma."
  - content (RTL): שלוש שורות סגירה.
  - visual: images/slide-6.png (תמונת לפטופ רגוע).
- bullets: false
- motion: fade-in
- rtl_notes: "seed, ColorTune , LTR. שאר הטקסט עברי RTL."

## איך לטפל בוויזואלים

הוויזואלים אינם נכללים בפרומפט הזה. בנפרד תקבל בלוק עם פרומפטים לכל ויזואל;
הריץ אותם ב-Gemini/GPT-Image/Recraft, שמור את הקבצים תחת `images/` באותו נתיב,
והפנה אליהם ב-HTML באמצעות `<img src="images/slide-1.png" alt="...">`.
לחלופין, אם תרצה demo מהיר, השתמש ב-`<div>` עם רקע אפור #F5F5F5 וטקסט placeholder עברי.

## דרישות נגישות

- ניגודיות AA לפחות. #0F1419 על #FFFFFF = יחס 18.7:1 (AAA).
- alt text לכל `<img>` (תרגום קצר של ה-placeholder ל-alt).
- focusable navigation עם tab.
- aria-label על navigation controls (כפתורי קודם/הבא אם תוסיף).
- prefers-reduced-motion: השבת fade-in.

## תוצר

קובץ אחד: `colortune-pitch.html`.
פתח בדפדפן (Chrome / Edge / Firefox / Safari) כדי לראות.
שלח את הקובץ כקובץ יחיד; ה-images/ תיקייה נפרדת לקבצי תמונה אם הכנסת.
```

## image_prompts_md

```markdown
# פרומפטים ליצירת תמונות , ColorTune pitch

הדבק כל פרומפט בנפרד ב-tool המומלץ בראש כל בלוק. שמור כל קובץ תחת `images/slide-<N>.png`.

## שקופית 1 , recraft (ראשי)

<prompt body from image_prompts[0].image_prompt>

## שקופית 3 , recraft (ראשי)

<prompt body from image_prompts[1].image_prompt>

## שקופית 4 , gemini (ראשי) , keyframe לוידאו

<prompt body from image_prompts[2].image_prompt>

הערה: זה keyframe בלבד. את הוידאו האמיתי הפק נפרד (Loom / OBS / ScreenStudio) ושמור כ-`images/slide-4.mp4`.

## שקופית 5 , recraft (ראשי) , אבל עדיף chart אמיתי

<prompt body from image_prompts[3].image_prompt>

הערה: עדיף לייצר את הגרף ב-Excel או Datawrapper מהנתונים האמיתיים. הפרומפט פה הוא לשמירת מקום בלייאוט.

## שקופית 6 , gemini (ראשי)

<prompt body from image_prompts[4].image_prompt>
```

## warnings

```yaml
[]
```

Notes for human reviewer:

- The HTML prompt is paste-ready into a fresh Claude.ai chat. Claude responds with a single HTML file.
- The single-file / no-storage / no-external-deps directives are mandatory and stated explicitly at the top of the technical-requirements section.
- The image prompts are kept separate so the learner runs them in their own loop and drops the resulting files into `images/`.
- aspect ratio 16:9 fits the pitch genre; for slidedoc it would be `scroll` and the structure would shift to long-form sections.
- prefers-reduced-motion is explicitly handled because motion was added per slide.
