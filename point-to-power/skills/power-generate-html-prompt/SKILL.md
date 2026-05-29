---
name: power-generate-html-prompt
description: Activate when target=html after write-per-slide-layout and generate-visual-prompts complete , emit the final regular-Claude (claude.ai) prompt for a single-file HTML deck with in-memory state only, plus a parallel image-prompt block.
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Generate HTML Prompt

## Purpose

מייצר את הפרומפט שהלומד מדביק ב-Claude.ai רגיל (לא Claude Code) כדי לבנות מצגת HTML single-file. הפרומפט מנעל את ההגבלות הקריטיות: קובץ יחיד, ללא localStorage / sessionStorage / IndexedDB, ללא תלויות חיצוניות מלבד CDN libraries מוגדרים. הסקיל גם מחזיר נפרד את ה-image-prompt block. הסקיל הזה רץ רק אם target=html.

## Inputs

- **ast** (מלא).
- **style_record** מ-`select-style`.
- **layouts** מ-`write-per-slide-layout` (vocabulary CSS Grid).
- **image_prompts** מ-`generate-visual-prompts`.

## Outputs

- **html_prompt_md** (מחרוזת Markdown), מוכן להדבקה ב-Claude.ai.
- **image_prompts_md** (מחרוזת Markdown), מוכן להדבקה ב-image-generation tool. נפרד.
- **warnings** (list, אופציונלי), אזהרות שעלו (לדוגמה: aspect_ratio mismatch, missing fallback fonts).

## Process

1. קרא את `../../references/R3-stage-3-output.md`, מקטע הסגנון שנבחר, כדי לחלץ HTML/CSS implementation cues, אילו CSS techniques הסגנון מצפה (Grid vs Flexbox, custom properties, animations, dark mode handling).
2. קרא את `../../references/R1-01-typography.md` להבטחת baseline טיפוגרפי נכון ל-HTML (line-height, font-feature-settings, optical sizing).
3. קרא את `../../references/R1-02-density.md` כדי לוודא slide pacing נכון בדק HTML, לרוב slide יחיד מציג שורה אחת + visual, לא wall of text.
4. קרא את `../../references/handoff-contract.md` לסעיף שמדבר על מגבלות target=html (single file, no storage, etc.).
5. הרכב aspect_ratio:
   - genre=pitch / keynote / ted / sales -> 16:9.
   - genre=workshop / lecture עם output_type=slidedoc -> 4:3 או auto-height (scroll).
   - output_type=teleprompter -> portrait או wide-screen מותאם לקריאה.
6. הרכב את html_prompt_md בעברית, במבנה:

```markdown
# פרומפט לבניית מצגת HTML single-file

הדבק את הפרומפט הזה ב-Claude.ai (לא ב-Claude Code). Claude יחזיר קובץ HTML יחיד שאפשר לפתוח בכל דפדפן ולשלוח כקובץ.

## הקשר

<פסקה קצרה: מה אנחנו בונים, קהל, אורך, סגנון.>

## דרישות טכניות מחייבות

הפלט חייב להיות:

- *קובץ HTML יחיד.* כל ה-CSS וה-JavaScript ב-inline או ב-`<style>` ו-`<script>` בתוך הקובץ.
- *ללא localStorage, ללא sessionStorage, ללא IndexedDB.* המצגת מצב in-memory בלבד. אם הלומד מרענן את הדף, היא מתחילה מחדש.
- *ללא תלויות חיצוניות.* מותר בלבד CDN libraries מהרשימה הבאה:
  - Google Fonts (links ל-`fonts.googleapis.com`).
  - <אם הסגנון דורש לוגיקה ייעודית, ציין specific library, לדוגמה: Reveal.js או Swiper>.
- *aspect ratio: <16:9 | 4:3 | scroll>*, פיקסל קבוע: <1920x1080 | 1280x960 | scroll>.
- *keyboard navigation:* Arrow Right / Arrow Down -> שקופית הבאה. Arrow Left / Arrow Up -> קודמת. Space -> הבאה. Esc -> מצב סקירה.
- *RTL:* עברית כברירת מחדל (dir="rtl"), איים LTR לפי הצורך.

## עיצוב , סגנון <שם הסגנון מ-style_record.primary>

- fonts:
  - heading: <heading font + fallback>
  - body: <body font + fallback>
  - hebrew_pair: <Rubik / Alef / וכו'>
- palette:
  - primary: <hex>
  - accent: <hex>
  - background: <hex>
  - text: <hex>
- spacing base: <8px>; rhythm: <8/16/24/48/96>.
- motion: <none / fade-in / subtle>.

## שקופיות

### שקופית 1 , <title>

- grid: <split-60-40 | hero | full-bleed>
- hierarchy:
  - title (<text-3xl>): "<ast.slides[0].title>"
  - key_message (<text-xl>): "<ast.slides[0].fields.key_message>"
  - content (<text-base>, RTL): "<ast.slides[0].fields.content>"
  - visual: <left | right | full-bleed | none>; ראה image_prompts[0], הוויזואל יוטמע לפי הוראה למטה.
- bullets: <true | false>
- motion: <none | fade-in | build-by-bullet>
- rtl_notes: <מ-layouts[0].rtl_notes>

### שקופית 2 , ...
(וכן הלאה)

## איך לטפל בוויזואלים

הוויזואלים אינם נכללים בפרומפט הזה. בנפרד תקבל בלוק עם פרומפטים לכל ויזואל;
הריץ אותם ב-Gemini/GPT-Image/Recraft, שמור את הקבצים תחת `images/` באותו נתיב,
והפנה אליהם ב-HTML באמצעות `<img src="images/slide-1.png" alt="...">`.
לחלופין, אם תרצה demo מהיר, השתמש ב-`<div>` עם רקע צבעוני וטקסט placeholder.

## דרישות נגישות

- ניגודיות AA לפחות (style_record כבר בדק).
- alt text לכל img.
- focusable navigation עם tab.
- aria-label על navigation controls.

## תוצר

קובץ אחד: `colortune-pitch.html` (או שם דומה).
פתח בדפדפן כדי לראות. שלח את הקובץ כקובץ יחיד, ללא assets נפרדים מלבד התמונות שהוספת ידנית ב-`images/`.
```

7. הרכב את image_prompts_md בנפרד, בדומה ל-generate-ppt-prompt: כותרת לפי slide_number, ציון ה-tool המומלץ, גוף הפרומפט.
8. החזר את שלושת ה-outputs.

## Edge cases

- meta.language=`en` -> כתוב את html_prompt_md באנגלית. ההוראה הטכנית הולכת עם השפה של הקהל.
- meta.output_type=`teleprompter` -> aspect ratio מותאם לקריאה (לדוגמה: portrait או full-width); fonts גדולים מאוד; navigation שמתקדם אוטומטית עם spacebar.
- meta.output_type=`slidedoc` -> scroll-based layout (אין הפרדה שקופית-שקופית), כל "שקופית" היא section בדף.
- style_record דורש library שלא ב-CDN allowlist -> הוסף ל-allowlist בפרומפט עם הסבר; וודא שזה library נפוץ.
- אין visual_queue -> דלג על image_prompts_md (החזר מחרוזת ריקה).
- שקופית 4 בדק היא וידאו -> ההוראה ב-HTML שונה: השתמש ב-`<video>` עם source ל-file MP4 ידני, או אם אין וידאו עדיין -> השתמש ב-keyframe כתמונת placeholder עם overlay של icon "play".

## Failure modes

- layouts ריק -> שגיאת בנייה. החזר.
- aspect ratio שלא תואם ל-style (לדוגמה: סגנון שדורש landscape, אבל ביקשת portrait) -> סמן warning, השאר את הבחירה ללומד.
- html_prompt_md ארוך מ-30K תווים -> תזכורת ללומד שייתכן צורך בכמה בקשות עוקבות ב-Claude.ai. חתוך לפרומפט גרעין + הוראות תוספת.
- meta.language לא ידוע -> ברירת מחדל ל-`he` (זה ה-default לקורס בנפיטים).

## Test fixtures

See `tests/` for full input fixture and expected html_prompt + image_prompts.
