---
name: point-recommend-and-prompt-notebooklm
description: Activate after structure-content-to-slides has produced a slide list , emit 0..N NotebookLM recommendations with feature name, ready Hebrew prompt, warning tokens, and serves_slides.
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Recommend and Prompt NotebookLM

## Purpose

מציע ללומד 0 עד N תוספי NotebookLM שמעצימים את המצגת, לכל אחד שם פיצ'ר, פרומפט עברי מוכן להדבקה, אסימוני warning, וטווח שקופיות שהפיצ'ר משרת. הסקיל לא מבנה תוכן ולא בוחר סגנון.

## Inputs

- **intake_record.meta** (להחלטות שמבוססות על language, audience, genre).
- **slides** (לזיהוי שקופיות שמתחננות לתוסף מסוים, דמו, נתון, מפת מושגים, סיכום).

## Outputs

- **notebooklm_recommendations** (ordered list, 0..N). כל recommendation:
  - `feature` (טקסט חופשי באנגלית או עברית, מהקטלוג של R2, לדוגמה: `Audio Overview - Brief`, `Mind Map`, `Video Overview`, `Briefing Doc`, `Study Guide`, `Timeline`, `FAQ`, `Discover Sources`).
  - `prompt` (טקסט עברי רב-שורתי, מוכן להדבקה ב-NotebookLM).
  - `warnings` (רשימה של אסימונים מופרדת בפסיקים, או "none").
  - `serves_slides` (רשימת מספרי שקופיות מופרדת בפסיקים, או "all").

## Process

1. קרא את `../../references/handoff-contract.md` Section 4 כדי לוודא את המבנה המדויק של recommendation block.
2. קרא את `../../references/R2-ch12-recommendation-patterns.md` ואת `../../references/R2-addon-b-patterns-cheatsheet.md` כדי להבין איזה פיצ'ר מתאים לאיזה תרחיש (לדוגמה: Audio Overview ל-warm intros, Mind Map לסקירת תפיסות, Video Overview לסיפורי product, Briefing Doc לעדכוני exec, Study Guide ל-workshops).
3. עבור על השקופיות וזהה מועמדים. שאלות מנחות:
   - האם יש שקופית שמייצרת overview שאפשר לעטוף לאודיו של 3 דקות לחימום הקהל? -> Audio Overview - Brief, serves_slides 1, 2.
   - האם יש 3+ מושגים מקושרים שאפשר למפות? -> Mind Map, serves_slides ספציפיות לחלק התיאורטי.
   - האם יש דמו או סיפור product שעובד טוב כווידאו של 2 דקות לקהל שלא הגיע? -> Video Overview.
   - האם יש מצגת לטכניים / academic שצריכים סיכום לקריאה? -> Briefing Doc.
   - האם זה workshop/lecture עם תוכן עומק? -> Study Guide.
   - האם יש סדרת אירועים / היסטוריה? -> Timeline.
4. אל תמליץ ברירת מחדל. אם אין סיבה אמיתית לפיצ'ר מסוים, אל תכלול אותו. 0 recommendations זה תקף לחלוטין (החוזה מאפשר 0..N).
5. עבור כל recommendation, כתוב את הפרומפט בעברית. כללים לפרומפט:
   - פתח עם פעולה ("הפק תקציר אודיו", "בנה Mind Map", "צור Briefing Doc").
   - ציין שפה ("בעברית").
   - ציין אורך / היקף ("3 דקות", "3 ענפים, עד 4 צמתים בכל ענף").
   - ציין מה לכלול ומה לא לכלול (אל תחשוף ספוילרים של שקופית wow).
   - שמור פרומפט מתחת ל-300 תווים.
6. קבע warnings:
   - אם meta.language הוא `he` או `mixed`, ואם הפיצ'ר הוא Audio Overview או Video Overview -> הוסף `rtl-audio-weak` אוטומטית. זה כלל קבוע מ-R2 ch11.
   - אם השקופיות מכילות מספרים / נתונים שעלולים להתיישן (traction, מחירים, מטריקות) -> הוסף `stale-watch`. בדוק עם `../../references/R2-addon-c-stale-watch.md`.
   - אם השפה היא `he` והפיצ'ר מייצר טקסט ארוך (Briefing Doc, Study Guide, Discover Sources) -> שקול `hebrew-quality-tier-c` לפי R2 ch11.
   - אם הפיצ'ר דורש NotebookLM Pro -> הוסף `pro-tier-required`.
   - אם אין warnings -> כתוב את המחרוזת המילולית `none`.
7. קבע serves_slides:
   - אם ההמלצה משרתת את כל הדק -> השתמש במחרוזת `all`. *חשוב:* אל תברור all מעצלות. ודא שההמלצה באמת רלוונטית לכל שקופית. אם רוב השקופיות לא נוגעות לפיצ'ר, צמצם לרשימת מספרים ספציפית.
   - אחרת -> כתוב מספרי שקופיות מופרדים בפסיקים, בסדר עולה (לדוגמה: `1, 2, 4`).
8. אסימוני warnings לא ידועים: מותר להמציא אסימון חדש אם יש מקרה אמיתי שלא נכלל (R2 ch11 מאפשר זאת). POWER יעביר את האסימון ללומד כפי שהוא.
9. סדר ההמלצות לפי חשיבות, לא לפי alphabetical. ההמלצה הראשונה היא זו שתכי משפיעה על איכות המצגת.
10. החזר את ה-list. אם אין המלצות, החזר list ריק (לא null, לא חסר).

## Edge cases

- `genre: pitch` קצר (5-10 דקות) -> בדרך כלל 1-2 המלצות, לא יותר. Audio Overview ל-warm intro של משקיעים זה הקלאסי.
- `genre: workshop` ארוך (45-90 דקות) -> 2-4 המלצות. Study Guide + Mind Map + Briefing Doc זה צירוף תקף.
- `output_type: teleprompter` -> בדרך כלל אין recommendations. הטלפרומפטר הוא לדובר, לא לקהל.
- `output_type: slidedoc` -> שקול Briefing Doc כי הקהל יקרא, לא יראה.
- `language: en` בלבד -> בדרך כלל אין warnings של עברית, אבל בדוק stale-watch ו-pro-tier-required.
- מספר השקופיות נמוך (1-3) -> serves_slides לרוב all או רשימה קצרה.
- שקופית עם דמו חי -> אל תמליץ על Video Overview של הדמו (זה מבטל את הדמו החי). אבל כן אפשר Video Overview של הפתיחה לקהל שלא הגיע.

## Failure modes

- אסימון warning לא ידוע -> מותר. אל תעצור. סמן בלוג פנימי.
- ספירת serves_slides לא תואמת את מספר השקופיות בדק -> בדוק חישוב; אם slide 7 ב-serves_slides אבל יש רק 6 שקופיות, הסר את 7.
- פרומפט מעל 300 תווים -> קצר.
- חוסר feature name -> לא מותר. R2 מספק קטלוג; בחר מתוכו או הצע שם חדש שעובר עיון אנושי.
- אם אתה לא בטוח אם פיצ'ר רלוונטי -> אל תכלול אותו. עדיף 0 המלצות מוצקות מאשר 3 רפויות.

## Test fixtures

See `tests/` for a pitch deck fixture and expected recommendations.
