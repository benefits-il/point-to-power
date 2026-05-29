---
name: power-generate-visual-prompts
description: Activate after select-style , process the AST's Visual Queue in batch and emit one image-generation prompt per visual placeholder, aligned to the selected style and ranked for target tools.
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Generate Visual Prompts

## Purpose

מעבד את Visual Queue של ה-AST ב-batch, כדי לשמור עקביות חזותית בין שקופיות. כל פלייסהולדר הופך לפרומפט image-generation מוכן עם תיוג של ה-tools המתאימים (Gemini, GPT-Image, Recraft). הסקיל לא בוחר את הסגנון, הוא מקבל אותו כקלט וצובע איתו את כל הפרומפטים.

## Inputs

- **ast.tail.visual_queue**, list של {slide_number, placeholder}.
- **style_record** מ-`select-style`. מספק את ה-style anchors: palette, illustration vs photo, motion language.

## Outputs

```yaml
image_prompts:
  - slide_number: 1
    image_prompt: |
      <multi-line prompt באנגלית או עברית, לפי target tool>
    target_tools:        # מסודר לפי התאמה, הראשון הוא ההמלצה
      - gemini
      - recraft
      - gpt-image
    style_anchors:
      palette: ["#0F1419", "#FFFFFF", "#2563EB"]
      illustration_or_photo: illustration
      motion_language: static
      composition_keywords: [flat, editorial, centered, generous-whitespace]
```

## Process

1. אם visual_queue ריק -> החזר list ריק. אל תייצר פרומפטים מומצאים.
2. קרא את `../../references/R3-stage-3-output.md`, מקטע הסגנון שנבחר (style_record.primary.style_name) כדי לחלץ את:
   - palette מדויק (3-5 צבעים).
   - האם הסגנון משתמש ב-illustration, photo, mixed media, או diagram.
   - motion language (static, micro-motion, animated).
   - composition keywords (flat, editorial, brutal, organic, etc.).
3. קרא את `../../references/R1-05-visuals.md` כדי לוודא שכל פרומפט עומד בכללי PSE (Picture Superiority Effect), Dual-Coding, ו-Coherence. בלי דקורציה ריקה.
4. עבור כל פריט ב-visual_queue:
   - נתח את ה-placeholder. אם זה גרף או נתון -> קרא גם את `../../references/R1-03-data-viz.md` להחלטת סוג הגרף.
   - הרכב פרומפט image-generation:
     - *subject:* מה הוויזואל מתאר. הפוך את ה-placeholder ל-subject ספציפי, לא תיאור כללי.
     - *style:* משוך מ-style_anchors. לדוגמה: `flat editorial illustration, generous whitespace, single accent color #2563EB on a near-black and white palette`.
     - *mood:* מתבסס על tone מ-style_record (calm, urgent, playful).
     - *composition:* מבוסס על image_placement מ-write-per-slide-layout אם זמין; אחרת ברירת מחדל.
     - *technical:* aspect ratio, רזולוציה. ל-HTML deck ברירת מחדל 16:9 (1920x1080). ל-PPT 16:9 (1280x720). ל-hero/full-bleed: 21:9.
   - אם ה-placeholder מציין `וידאו` -> סמן בפרומפט שזה still keyframe להחלפה ידנית בווידאו (שום tool כאן לא מייצר וידאו).
   - אם ה-placeholder מציין `צילום מסך` -> סמן בפרומפט שזה mock-up UI לפי תיאור הסגנון; הלומד יחליף לצילום מסך אמיתי.
5. דרג את ה-target_tools לכל פרומפט:
   - *gemini (Imagen)*, חזק ל-photorealistic, mid-range edits, captions accurate.
   - *gpt-image*, חזק ל-illustration עם טקסט בתוך התמונה, gist-style, abstract.
   - *recraft*, חזק ל-flat illustration, vector style, brand consistency, single-accent palettes.
   - בחר את הראשון לפי ה-style. סגנון Editorial Light/Minimal -> recraft ראשון. סגנון Documentary/Photoreal -> gemini ראשון. סגנון Editorial עם טקסט בתוך -> gpt-image ראשון.
6. הוסף style_anchors לכל פריט, palette, illustration_or_photo, motion_language, composition_keywords. זה מאפשר עקביות אם הלומד מחליט להריץ פרומפט במכשיר אחר.
7. בדיקת stub (per contract Anti-pattern 7): אם placeholder קצר מ-5 מילים (לדוגמה: `תמונה`, `image`, `tbd`) -> כלול את הפרומפט בכל מקרה אבל הוסף ב-image_prompt הערה: `# soft note: placeholder היה כללי, הפרומפט נכתב כברירת מחדל לפי הסגנון.`
8. החזר את ה-list.

## Edge cases

- visual_queue עם רק video / רק UI mockup -> אל תייצר פרומפט photoreal. סמן `still keyframe` / `UI mock`.
- שקופית עם chart -> ייצר פרומפט להמחשה אבל הוסף הערה שעדיף chart אמיתי מ-tool ייעודי (Datawrapper, Flourish, או Excel).
- meta.language=`he` ובפלייסהולדר יש טקסט עברי שצריך להיכלל בתמונה -> תכלול את הטקסט בעברית בפרומפט. הזהר שלא כל tools מטפלים טוב בעברית; ציין warning בפרומפט עצמו.
- כל ה-placeholders זהים מבחינת style -> צייר את כולם עם אותו seed/style key אם ה-tool תומך, כדי לשמור consistency.
- אין style מוגדר חד-משמעית ל-illustration vs photo -> ברירת מחדל ל-illustration (פחות risk, יותר עקבי לסגנון מינימליסטי).

## Failure modes

- style_record חסר palette -> השלם משדות ברירת מחדל monochrome + accent אחד. סמן warning.
- placeholder ארוך מאוד (קרוב ל-280 תווים) -> השתמש בו כפי שהוא; אל תקצר. כל מילה היא סיגנל.
- אין tool שתומך בדרישות (לדוגמה: PNG עם שקיפות + טקסט בתוך) -> בחר את הראשי, סמן הערה שדורש post-edit.

## Test fixtures

See `tests/` for a 5-visual queue and expected image prompts.
