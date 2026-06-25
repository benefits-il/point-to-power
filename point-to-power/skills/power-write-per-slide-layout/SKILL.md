---
name: power-write-per-slide-layout
description: Activate after select-style , emit per-slide layout directives (grid, hierarchy, image placement, motion, RTL notes) consistent with the selected style; vocabulary diverges per target (PPT slots vs CSS grid; slides reuses the CSS grid vocabulary).
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Write Per-Slide Layout

## Purpose

עבור כל שקופית, מייצר רשומת layout שמתארת איך השקופית בנויה: רשת, היררכיה ויזואלית, מיקום תמונה, motion, ו-RTL notes. ה-shape של הרשומה זהה לכל target, אבל אוצר המילים בפנים שונה: PPT משתמש ב-slot vocabulary של PowerPoint, HTML משתמש ב-CSS grid vocabulary, ו-slides (Google Slides דרך Gemini) משתמש באותו אוצר מילים סמנטי כמו HTML, כי Gemini קורא תיאור layout בשפה טבעית.

## Inputs

- **ast.slides** (רשימה מהוולידטור).
- **style_record** מ-`select-style`.
- **target** (`html` | `powerpoint` | `slides`), קובע אוצר המילים בפנים. `slides` משתמש באותו אוצר מילים סמנטי כמו `html`.

## Outputs

```yaml
layouts:
  - slide_number: 1
    grid: ...           # PPT: "title-only" | "title-content" | "two-content" | "comparison" | "title-image" | "section-header" | "blank"
                        # HTML: "1col" | "2col" | "3col" | "hero" | "split-50-50" | "split-60-40" | "stack"
                        # slides: same vocabulary as HTML
    hierarchy:
      - element: title
        size: ...        # PPT: "title-44pt" / HTML: "text-4xl"
        position: ...    # PPT: slot name / HTML: grid area
      - element: key_message
        size: ...
        position: ...
      - element: content
        size: ...
        position: ...
      - element: visual
        size: ...
        position: ...
    image_placement: ...  # "right-half" | "left-half" | "full-bleed" | "inset-card" | "background" | "none"
    motion:               # "none" | "fade-in" | "slide-up" | "stagger" | "build-by-bullet"
    rtl_notes: ...        # מחרוזת בעברית, או null אם language=en
```

## Process

1. קרא את `../../references/R4-SA3-ch4.md` (slide generation grammar), זה הבסיס לאוצר המילים של layouts.
2. אם target=`powerpoint`, קרא גם את `../../references/R4-SA4-ch5.md` (design-system skill , layout vocabulary). שם נמצאים שמות ה-slots המדויקים של PowerPoint שמשתמשים בהם בהפנייה ל-Claude-in-PowerPoint add-in.
3. אם meta.language=`he` או `mixed`, קרא גם את `../../references/R4-SA6-ch8.md` (accessibility + RTL + captions + multi-language). שם נמצאים כללי ה-RTL: כיוון טקסט, יישור צד ימין, ניהול ספרות בעברית, התנהגות של ציטוטים באנגלית בתוך טקסט עברי.
4. עיין ב-`../../references/R4-siblings-templates.md` כדי לראות תבניות PPT מוכנות שאפשר להשתמש בהן כאנקור.
5. עבור על כל slide ב-`ast.slides`:
   - קרא את כל השדות (title, key_message, content, bullets_allowed, visual_placeholder, speaker_notes).
   - החלט על `grid`:
     - אם visual_placeholder=none ו-bullets_allowed=false -> `title-content` (PPT) / `1col` (HTML).
     - אם visual_placeholder=none ו-bullets_allowed=true -> `title-content` (PPT) / `1col` (HTML).
     - אם visual_placeholder!=none ו-content קצר -> `title-image` (PPT) / `split-50-50` או `split-60-40` (HTML, תלוי בעומס הטקסט).
     - אם visual_placeholder!=none ו-content ארוך -> `two-content` (PPT) / `split-60-40` עם טקסט בצד הרחב (HTML).
     - אם זו שקופית אופנינג / סיום (slide 1 או slide N עם key_message כ-statement) -> `section-header` (PPT) / `hero` (HTML).
   - החלט על `hierarchy`: סדר את title -> key_message -> content -> visual לפי חשיבות אופטית.
   - החלט על `image_placement` לפי grid ו-target. אם visual_placeholder=none -> "none".
   - החלט על `motion`: ברירת מחדל "none" לסגנונות מינימליים, "fade-in" לסגנונות עשירים. אם bullets_allowed=true ויש 3+ bullets -> שקול "build-by-bullet". אסור motion מסובך לטלפרומפטר.
   - מלא `rtl_notes` רק אם language=`he` או `mixed`:
     - אם השקופית מכילה מספרים אנגליים בתוך טקסט עברי -> note: `המספרים נשארים LTR בתוך השורה העברית; אל תתרגם.`
     - אם השקופית מכילה ציטוט באנגלית -> note: `הציטוט שמור בתיבה נפרדת LTR עם יישור שמאל; הטקסט סביבו עברי RTL.`
     - אחרת -> note כללי: `כל הטקסט מיושר ימינה, הספרות LTR.`
     - אם language=en -> השאר null.
6. עבור target=`powerpoint`, ודא ש-grid הוא אחד מ-7 ה-slots הסטנדרטיים של PowerPoint. אל תמציא slots חדשים, Claude-in-PowerPoint add-in מצפה ל-vocabulary המוגדר.
7. עבור target=`html` או target=`slides`, ודא ש-grid הוא vocabulary CSS Grid או Flexbox מוכר. השתמש בשמות תיאוריים סמנטיים. עבור html הם מגיעים ל-`generate-html-prompt`, ועבור slides ל-`generate-slides-prompt`, ובשני המקרים אוצר המילים זהה.
8. שמור עקביות בין שקופיות. אם כל הסגנון הוא minimal ו-style_record מציין `motion: none`, אל תוסיף fade-in לשקופיות בודדות.
9. החזר את ה-list של layout records.

## Edge cases

- שקופית עם key_message ארוך (קרוב ל-200 תווים) -> שקול לטפל ב-hierarchy: הקטן את title, הגדל את key_message.
- שקופית 4 ב-fixture ColorTune עם speaker_notes=off -> זה לא משפיע על layout. notes הם תוכן, לא מבנה.
- meta.language=`mixed` עם רוב עברית -> rtl_notes מציין `RTL ברירת מחדל, איים LTR לפי הצורך`.
- target=`powerpoint` עם output_type=`teleprompter` -> grid לרוב `title-only` עם פונט 60pt+. הקפד על read distance.
- שקופית comparison (לדוגמה: before/after של פלטה) -> grid=`comparison` (PPT) / `split-50-50` (HTML), עם שתי image_placement (left-half + right-half).
- visual_placeholder ארוך מאוד (קרוב ל-280 תווים) -> ה-text של ה-placeholder לא נכנס ללייאוט; הוא הולך ל-generate-visual-prompts. כאן רק image_placement מציין את המיקום.

## Failure modes

- target לא ידוע (לא html, powerpoint, או slides) -> זה לא אמור לקרות אחרי detect-target. החזר שגיאה.
- style_record חסר locked.spacing -> השלם משדות ברירת מחדל של 8px base unit, סמן warning.
- slide בלי visual_placeholder field (parse error) -> זה היה אמור להיחסם ב-validator. אם הגעת לכאן, ברירת מחדל ל-`none`.

## Test fixtures

See `tests/` for a 6-slide fixture and the expected layout records.
