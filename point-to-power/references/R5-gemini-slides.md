# R5 - Google Slides via Gemini
> Snapshot: 2026

המקור הסמכותי של POWER לבניית מצגות Google Slides דרך Gemini. אח ל-R4 (PowerPoint), אבל היעד שונה: הפרומפט מנוסח ל-Gemini, לא ל-Claude, והפלט הוא Google Slides ולא PPTX. הסקיל `power-generate-slides-prompt` קורא את הקובץ הזה במלואו לפני שהוא מרכיב את הפרומפט.

## מה Gemini בונה

יש שני נתיבים, ושניהם מובילים ל-Google Slides:

1. **Gemini Canvas.** מרחב עבודה ב-Gemini שבונה דק שלם מפרומפט אחד או ממסמך מקור. הלומד מדביק את הפרומפט (או מצרף את ה-handoff כמסמך), מבקש "צור מצגת", ומקבל טיוטת דק בתוך Canvas. מתוך Canvas יש כפתור ייצוא ל-Google Slides בקליק.
2. **Gemini בתוך Google Slides.** הלומד פותח Google Slides ומשתמש ב-Gemini המובנה ("Generate") כדי לבנות שקופיות לפי המבנה. כאן אין שלב ייצוא נפרד, המצגת כבר נמצאת ב-Slides.

POWER תומך בשני הנתיבים באותו פרומפט: בלוק Block A מנוסח כך שיתאים גם ל-Canvas וגם ל-Gemini-in-Slides.

## איך לנסח פרומפט ל-Gemini

- **תיאור מבנה בשפה טבעית.** בניגוד ל-Claude-in-PowerPoint, אין כאן design-system skill להפעיל ואין slot vocabulary קבוע. Gemini קורא תיאור layout בשפה טבעית, ולכן משתמשים באוצר המילים הסמנטי של HTML (`hero`, `split-60-40`, `full-bleed`), לא ב-slot names של PowerPoint.
- **הוראות עיצוב מפורשות.** fonts, palette (hex מדויקים), spacing, ו-motion נכתבים כהוראות ישירות ש-Gemini מיישם. כל הפונטים נמשכים מ-Google Fonts, ש-Google Slides תומך בהם ילידית, ולכן זמינות הפונטים זהה ל-HTML.
- **שקופית = רעיון אחד.** אותם כללי צפיפות מ-R1-02: כותרת, key_message, content קצר, ויזואל. לא wall of text.
- **speaker notes לפאנל הנכון.** אם speaker_notes=on, הנחה את Gemini להכניס את ההערות לפאנל ה-Speaker notes של Google Slides, לא לגוף השקופית.

## זרימת הייצוא

- ב-Gemini Canvas: כפתור ייצוא ל-Google Slides. המצגת נפתחת כקובץ Google Slides חדש ב-Drive של הלומד.
- ב-Gemini בתוך Slides: אין ייצוא, המצגת כבר שם.
- וידאו: Google Slides תומך בהטמעת וידאו (Insert > Video). הלומד מטמיע ידנית אחרי הבנייה.
- גרפים: Google Slides מתחבר ל-Google Sheets ישירות, ולכן לגרף אמיתי עדיף Sheets על פני תמונה.

## המגבלה המרכזית - הפלט הוא טיוטה

זו העובדה החשובה ביותר ב-R5, ו-POWER תמיד מציין אותה ללומד. כל פלט של Gemini, בשני הנתיבים, הוא **טיוטה שדורשת ליטוש**. הקצֵה בערך **שליש עד מחצית** מהזמן לעריכה אחרי הבנייה או הייצוא. נקודות ליטוש שכיחות:

- **RTL.** טיוטות Gemini נוטות ליישר טקסט עברי לשמאל. אחרי הייצוא יש לעבור שקופית-שקופית ולוודא יישור-לימין לכל תיבת טקסט עברית.
- **פונטים.** לפעמים Gemini בוחר פונט ברירת מחדל ולא את זה שביקשת. בדוק והחלף.
- **מיקום תמונות וצפיפות.** Gemini ממקם בערך; דייק ידנית.

האסימון ש-POWER פולט ב-notes הוא `slides-draft-polish`, והוא נפלט תמיד.

## RTL ועברית

Google Slides תומך בעברית ובפונטים עבריים מ-Google Fonts (Rubik, Alef, Heebo, ועוד). אין בעיית font availability כמו שלפעמים יש ב-PowerPoint. הבעיה היחידה היא יישור הטיוטה (ראה למעלה), שמתוקן בליטוש. ספרות ושמות לועזיים נשארים LTR בתוך שורה עברית.

## מה לוודא שוב מאוחר יותר

- האם כפתור הייצוא מ-Gemini Canvas ל-Google Slides עדיין קיים ועובד בלי עיוותי פריסה.
- האם Gemini בתוך Google Slides עדיין מציע "Generate" לבניית שקופיות, ובאילו מסלולי רישוי (Google Workspace / Gemini Advanced).
- האם איכות ה-RTL בטיוטות השתפרה (אם כן, אפשר להקטין את אזהרת ה-draft-polish).

## הפניות צולבות

- R3-stage-3-output - קטלוג הסגנונות; ה-pairing של slides זהה ל-HTML.
- R1-01 / R1-02 - טיפוגרפיה וצפיפות, אותו baseline כמו HTML.
- handoff-contract - הגדרת ה-enum של target (`slides` נוסף ל-html / powerpoint / ask).
- R4 (SA1-SA6) - האח של R5 לצד PowerPoint; אותה לוגיקת emitter, יעד אחר.
