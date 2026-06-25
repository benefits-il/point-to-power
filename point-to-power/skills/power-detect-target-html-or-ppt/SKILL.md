---
name: power-detect-target-html-or-ppt
description: Activate after validate-handoff-against-contract returns status=ok , resolve the build target; when meta.target is html, powerpoint, or slides pass through, when target=ask prompt the learner with all three options.
version: 1.0.0
user-invocable: false
disable-model-invocation: false
allowed-tools:
  - Read
---

# Detect Target (HTML / PowerPoint / Slides)

## Purpose

מחליט מה הפלט הסופי יהיה: אתר HTML יחיד, מצגת PowerPoint, או מצגת Google Slides (שנבנית דרך Gemini). אם Point כבר קבע (`target: html`, `target: powerpoint`, או `target: slides`), זו פעולת מעבר. אם Point לא היה בטוח וקבע `target: ask`, הסקיל שואל את הלומד בעברית, מציע את שלוש האפשרויות, ומפרש את תשובתו.

## Inputs

- **ast.meta.target** (string, אחד מ-`html`, `powerpoint`, `slides`, `ask`).
- **learner_response** (אופציונלי), תשובת הלומד אם נדרשה שאלה.

## Outputs

- **target** (enum: `html` | `powerpoint` | `slides`). אף פעם לא `ask` בפלט.

## Process

1. קרא את ast.meta.target.
2. אם הערך הוא `html` -> החזר `target=html`. סיים.
3. אם הערך הוא `powerpoint` -> החזר `target=powerpoint`. סיים.
4. אם הערך הוא `slides` -> החזר `target=slides`. סיים.
5. אם הערך הוא `ask` -> שאל את הלומד בעברית בדיוק את הניסוח הבא:

```
איך תרצה לקבל את הפלט?

1) אתר HTML יחיד שאפשר לפתוח בדפדפן ולשלוח כקובץ אחד.
   מתאים אם רוצים שיתוף מהיר, צפייה במובייל, או אם אין PowerPoint.

2) קובץ PowerPoint שאפשר לערוך ב-Microsoft PowerPoint.
   מתאים אם תרצה להמשיך לערוך, להדפיס, או להציג מתוך PowerPoint עצמו.

3) מצגת Google Slides שנבנית דרך Gemini.
   מתאים אם אין לך PowerPoint, או אם תרצה שיתוף בענן ועבודה משותפת על המצגת.

ענה 1, 2 או 3, או כתוב html / powerpoint / slides.
```

6. פרסר את התשובה:
   - `1`, `html`, `אתר`, `דפדפן` -> `target=html`.
   - `2`, `powerpoint`, `ppt`, `pptx`, `מיקרוסופט` -> `target=powerpoint`.
   - `3`, `slides`, `google slides`, `גוגל סלייד`, `סליידס`, `gemini`, `ג'מיני` -> `target=slides`.
   - `מצגת` בלי הקשר נוסף עמום עכשיו (גם PowerPoint וגם Google Slides הן "מצגת") -> אל תנחש, שאל שוב את שאלת ההבהרה.
   - תשובה מעורפלת (לדוגמה: `כולם`, `לא יודע`, או טקסט שלא תואם) -> שאל שוב בקיצור: `בבקשה ענה 1, 2 או 3.`
7. אחרי שני סבבי שאלה ללא תשובה ברורה -> ברירת מחדל ל-`html` והודע ללומד: `אבחר HTML כברירת מחדל. אפשר לבקש לשנות בסיום.`

## Edge cases

- ast.meta.target עם capitalization שונה (לדוגמה `HTML`, `PowerPoint`, `Slides`) -> זה כבר היה אמור להיחסם ב-`validate-handoff-against-contract` עם rule 5. אם הגעת לכאן עם capitalization כזה, זו תקלה בולמת בוולידטור; דחה למטה case-insensitive לצורך עמידות, אבל סמן באג.
- learner_response בעברית עם רווחים מסביב -> trim ואז התאם.
- learner_response באנגלית בקיצור (`p`, `h`, `s`, `g`) -> p -> powerpoint, h -> html, s -> slides, g -> slides (Gemini).
- ast.meta.target חסר לחלוטין -> זה היה אמור להיחסם ב-rule 4. אם הגעת לכאן, ברירת מחדל ל-`ask` והפעל את הזרימה.

## Failure modes

- ערך לא ידוע ב-target (לדוגמה `pdf`) -> זה חורג מהאניום. הוולידטור היה אמור לתפוס ב-rule 5. אם הגעת לכאן, ברירת מחדל ל-`html` עם הודעה ללומד שערך לא תקף הוסר.
- אין learner_response זמין ו-target=ask בערוץ שלא מאפשר אינטראקציה (לדוגמה: batch run) -> ברירת מחדל ל-`html` עם warning שיש להחזיר את ה-handoff ולעדכן את ה-target ב-Meta.

## Test fixtures

See `tests/` for html, powerpoint, and ask fixtures.
