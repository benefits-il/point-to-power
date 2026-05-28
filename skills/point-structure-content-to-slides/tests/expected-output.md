# Expected output , slides for `fixture-intake`

Six slides emerge from six content_units (1:1 here is acceptable because the pitch structure happens to match the units; this is not a forced mapping). The story shape is Problem -> Solution -> Proof -> Ask, which matches R1 ch07 pitch pattern.

```yaml
slides:
  - number: 1
    title: עיצוב נגיש לוקח שעות שלא תוקצבו
    key_message: מעצבים מבזבזים שעות שלמות בכל פרויקט על תיקוני נגישות שאף אחד לא תכנן עליהם.
    content: |
      בכל פרויקט יש את הרגע הזה. המעצב מסיים את הפלטה, פותח Contrast Checker,
      ומגלה שחצי מהקומבינציות נכשלות. החלפת צבע אחד שוברת את ההיררכיה של כל המסך.
      התיקון לוקח לפעמים יום שלם, ולא מופיע באף אומדן זמן בתחילת הפרויקט.
    bullets_allowed: false
    bullets_justification: סיפור נרטיבי, לא רשימה. R1 ch04 Doumont conditional נכשל.
    visual_placeholder: איור שטוח של מעצב מול מסך פיגמה, פלטת צבעים בצד, חלק מהריבועים מסומנים באדום עם הכיתוב FAIL.
    speaker_notes: |
      התחילי בלשאול את הקהל מתי בפעם האחרונה הם פתחו Contrast Checker.
      השתהי שתי שניות אחרי השאלה. אל תענה. תני לאי-נוחות לעבוד.
      שמרי על קצב איטי בשקופית הזו, היא בונה את הבעיה.

  - number: 2
    title: הבעיה במספרים
    key_message: מחקר WebAIM 2025 מצא שש מתוך עשר אתרים מובילים נכשלים בבדיקת ניגודיות ברמת AA.
    content: |
      הנתון הזה לא מספר את הסיפור המלא. ב-WebAIM Million 2025, 96.3% מדפי הבית
      של מיליון האתרים המובילים בעולם הכילו לפחות תקלת WCAG אחת.
      הסיבה הראשונה במעלה: ניגודיות צבע. הסיבה שזה לא מתוקן: התיקון יקר במונחי זמן עיצוב.
    bullets_allowed: false
    bullets_justification: הנתון העיקרי הוא משפט אחד גדול. R1 ch02 Glance Test מועדף על מספר גדול בודד.
    visual_placeholder: none
    speaker_notes: |
      המספר 96.3 כתוב גדול על הסליידר אבל אל תקריאי אותו, תני לקהל לקרוא לבד.
      אחרי שתיקה של שלוש שניות, אמרי רק את שלוש המילים: "התיקון יקר. תמיד."

  - number: 3
    title: ColorTune
    key_message: ColorTune מקבל פלטה ראשונית ומחזיר גרסה נגישה ששומרת על הזהות הוויזואלית.
    content: |
      המעצב מעלה את הפלטה הראשונית או מחבר את ה-Figma שלו ישירות.
      ColorTune מריץ אנליזה של יחסי הניגודיות בכל הצירופים שבאמת קיימים ב-UI,
      לא בכל הקומבינציות התיאורטיות. החזרה היא פלטה מתוקנת ששומרת על ה-hue
      ועל ההיררכיה, ומסבירה למה כל שינוי נעשה.
    bullets_allowed: false
    bullets_justification: הסבר תהליך, לא רשימה. סיפור אישי של המעצב יעיל יותר.
    visual_placeholder: צילום מסך של ה-UI של ColorTune עם פלטה מקורית בצד שמאל ופלטה מתוקנת בצד ימין, חיצים דקים מחברים בין צבעים שהשתנו.
    speaker_notes: |
      הצג את שני הצדדים של הצילום במקביל ואל תקפצי בין הצדדים בדיבור.
      השתמשי במונח "ColorTune" פעם אחת בלבד בשקופית הזו, אחרת זה נשמע פרסומי.
      עברי לשקופית 4 ברגע שאת רואה ראשים מהנהנים.

  - number: 4
    title: ColorTune בפעולה
    key_message: דמו חי, 90 שניות, פלטה אמיתית שנשלחה אלינו השבוע על ידי משתמשת בטא.
    content: |
      הדמו רץ באמת ולא בווידאו. המעצב מעלה את ה-PNG של פלטת המוצר,
      לוחץ Generate, ורואה את הפלטה המתוקנת תוך פחות מעשר שניות.
      המסך השני מציג את ההסבר: מה השתנה, ולמה, ואיך זה משפיע על ההיררכיה.
    bullets_allowed: false
    bullets_justification: זה רגע wow של דמו, לא רשימה.
    visual_placeholder: וידאו של 8 שניות שמראה את התהליך מקצה לקצה, ללא קול, עם כיתוביות קצרות בלבן.
    speaker_notes: "off"

  - number: 5
    title: יש כבר משתמשים שמשלמים
    key_message: במאי 2026 הגענו ל-340 משתמשים פעילים חודשי ול-12,000 דולר ARR מ-47 צוותים משלמים.
    content: |
      הגדילה הצטברה ב-6 חודשים מהשקה שקטה, בלי תקציב שיווק.
      קצב הגידול החודשי בשלושת החודשים האחרונים: 28%. שיעור הנטישה: 4%.
      שלוש סטודיות עיצוב גדולות בארץ נכנסו לתקופת פיילוט בחודש האחרון.
    bullets_allowed: true
    bullets_justification: רשימת מטריקות, עיניים סורקות אותן. R1 ch04 Doumont conditional מתקיים.
    visual_placeholder: גרף עמודות פשוט בשחור-לבן, ציר X חודשים, ציר Y משתמשים פעילים, ערכים מעל כל עמודה.
    speaker_notes: |
      אל תקריאי את המספרים, הם על המסך. במקום זה, הזכירי שמות של שלוש הסטודיות
      שנכנסו לפיילוט, אבל רק אם הקהל מכיר אותן. אחרת דלגי וקפצי לבקשה.

  - number: 6
    title: מה אנחנו מבקשים
    key_message: מגייסים סבב seed של 800 אלף דולר, להאצת המכירות לסטודיות בארה"ב ולהשלמת חיבור ל-Figma.
    content: |
      הכסף מחולק שני שליש לצוות מכירות בארה"ב ושליש להשלמת תוסף ה-Figma המקורי.
      אנחנו פוגשים משקיעים במשך החודש הקרוב. תהליך הסגירה הצפוי: שישה שבועות.
      אם זה רלוונטי לכם או למישהו שאתם מכירים, אשמח להמשך שיחה אחרי המיט-אפ.
    bullets_allowed: false
    bullets_justification: הבקשה היא משפט אנושי, לא רשימה.
    visual_placeholder: תמונה רגועה של לפטופ פתוח על שולחן עם לוגו ColorTune במסך, רקע מטושטש.
    speaker_notes: |
      סיימי בשלושה משפטים בלבד. אל תוסיפי "תודה". במקום זה, חכי שלוש שניות
      ואז אמרי: "אם זה רלוונטי, אשמח לדבר אחר כך". לא יותר.
```

Notes for human reviewer:

- Six slides for 12 minutes = 2 minutes per slide. Within the pitch pacing band (1-2 min for pitch). OK.
- Slide 4 carries explicit `speaker_notes: "off"` , the demo slide should not have notes per learner's intuition (intake didn't request this; structure-skill judged that the demo runs on its own).
- Slide 5 is the only slide with `bullets_allowed: true`. The metric list passes Doumont conditional.
- Slide 2 has `visual_placeholder: none` because the headline number IS the visual (R1 ch05 PSE).
