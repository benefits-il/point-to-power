## פרק 3 - Data visualization choices

פרק זה עוסק בהחלטות על גרפים, טבלאות ונתונים בשקופית: מתי גרף, איזה גרף, כמה דיו, וכמה קישוט. ההגדרות של CLT / Mayer / שלוש קטגוריות התוצר מופיעות בפרק 0 ולא חוזרות כאן. החלטות תלויות-קהל (technical vs. non-expert, חיצוני vs. פנימי) מופיעות בפרק 8. כאן עוסקים אך ורק בנתונים וגרפים. הבחירה בין תמונה אינפורמטיבית לדקורטיבית (צילומים, אייקונים, איורים) שייכת לפרק 5.

---

### 3.1 Data-ink ratio (Tufte)

**שם:** Data-ink ratio.
**מקור:** Edward Tufte, *The Visual Display of Quantitative Information* (Graphics Press, 1983/2001), עמ' 91-105.

**מה זה אומר:** "data-ink" הוא חלק הדיו שאינו ניתן להסרה בלי לאבד נתונים. data-ink ratio = data-ink / total ink בגרף. Tufte דורש: *"Above all else show the data"* (עמ' 91), ולמקסם את ה-ratio הזה. בפועל: צמצם קווי רשת כבדים, מסגרות מיותרות, רקעים צבעוניים, צללים, אפקטי 3D שאינם מקודדים נתון, ואלמנטים חוזרים שאינם מוסיפים מידע.

**למה זה עובד:** כל פיקסל לא-נתוני מתחרה על אותו working memory מוגבל (פרק 0, סעיף 0.1). כשהמוח של הקהל מסנן רעש ויזואלי, הוא לא מעבד את הסיגנל. ככל שיחס הדיו-נתונים גבוה יותר, כך ה-extraneous load נמוך יותר וה-essential load (הנתון עצמו) מקבל יותר משאבים.

**מתי רלוונטי:** בכל גרף שמוצג למישהו. במיוחד קריטי ב-presentation מוקרנת (פרק 0, סוג 1) שבה לקהל יש שניות בודדות, פחות קריטי ב-slidedoc (סוג 3) שבה הקורא יכול להתבונן מספר דקות.

**כלל אצבע:** הסר כל אלמנט גרפי שאם תמחק אותו - הנתון לא יאבד.

**מקור:** Tufte (1983/2001), עמ' 91-105.

---

### 3.2 הגדרת chartjunk (Tufte)

**שם:** Chartjunk.
**מקור:** Tufte, *The Visual Display of Quantitative Information* (1983), עמ' 107.

**מה זה אומר:** Tufte verbatim: *"The interior decoration of graphics generates a lot of ink that does not tell the viewer anything new... Regardless of its cause, it is all non-data-ink or redundant data-ink, and it is often chartjunk."* (עמ' 107). שלוש משפחות chartjunk קלאסיות אצל Tufte:
- **moiré vibration** - דפוסי הצללה (פסים, נקודות) שמייצרים רעידה ויזואלית.
- **the grid** - קווי רשת עבים שדומיננטיים יותר מהנתון עצמו.
- **the duck** - גרף שעוצב כאובייקט (למשל עמודה בצורת בקבוק כדי להציג מכירות יין). הצורה מחליפה את הקידוד הכמותי.
דוגמאות נוספות: 3D מיותר על bar chart דו-ממדי, אייקונים תוך-גרפיים שלא מקודדים נתון, gradients צבעוניים שאינם מסמנים סקאלה.

**למה זה עובד:** chartjunk אינו רק "מכוער". הוא פעיל בהסחה: גורם לקהל לקודד את הקישוט במקום את הנתון, ובכל גרף עם 3D מעוות את הפרופורציות הנתפסות (טעות פרספקטיבה).

**מתי רלוונטי:** תמיד באבחנה - האם האלמנט הזה הוא נתון או קישוט. לקבלת ההחלטה אם להשאיר קישוט - ראה הסעיף הבא (Holmes-vs-Bateman).

**כלל אצבע:** אם תוכל להחליף את האלמנט בעקומה / עמודה / מספר ולא תאבד מידע - האלמנט הוא chartjunk.

**מקור:** Tufte (1983), עמ' 107.

---

### 3.3 Lie Factor (Tufte)

**שם:** Lie Factor.
**מקור:** Tufte, *Visual Display* (1983), עמ' 57.

**מה זה אומר:** מדד כמותי לעיוות. נוסחה: Lie Factor = (size of effect shown in graphic) / (size of effect in data). אם שינוי נומרי של פי 2 מוצג כעמודה הגבוהה פי 4 - Lie Factor = 2. Tufte קובע סף: **0.95 ≤ Lie Factor ≤ 1.05** = יושר ויזואלי. מחוץ לטווח = הטעיה ויזואלית, גם אם לא כוונתית.

**למה זה עובד:** המוח קורא גרפים פרה-קוגניטיבית. ההשוואה הויזואלית מתבצעת לפני שהקהל קורא את התוויות. אם הגרף משקר פיזית, הקהל לוקח את השקר אפילו אם הוא קורא את המספרים הנכונים מתחת.

**מתי רלוונטי:** כל פעם שמופיע גרף יחסי - bar chart, area chart, גרף עוגה, אייקונים מוגדלים פרופורציונלית. הגורמים השכיחים ל-Lie Factor גבוה: bar chart שלא מתחיל ב-zero baseline (ראה Knaflic 3.5 למטה), שינוי בקנה מידה משתמע, הגדלת אייקון לפי שטח במקום לפי גובה (טעות "rocket factor").

**כלל אצבע:** עבור על הגרף שלך עם סרגל וודא ששינוי כפול בנתון נראה ככפול בויזואל.

**מקור:** Tufte (1983), עמ' 57.

---

### 3.4 המתח: Tufte/Holmes/Bateman - האם chartjunk מזיק תמיד?

זוהי הסתירה המרכזית של הפרק.

**עמדה A - Tufte (1983):** chartjunk הוא רעש. כל קישוט פוגע בקריאה ובדיוק. data-ink ratio מקסימלי = הגרף האידאלי. הצרכן המקצועי של נתונים מעדיף מינימליזם.

**עמדה B - Nigel Holmes (Time Magazine) ואחריו Bateman et al. (2010):** Holmes עיצב במשך שנים illustrative charts ל-Time עם דמויות, צבעים, איורים. Tufte תקף את הסגנון הזה כ-chartjunk. Holmes השיב בראיון ב-*New York Times* (1992): Tufte *"trapped in 'the world of academia' and insensitive to 'the world of commerce', with its need to grab an audience."* המחקר האמפירי הראשון שבחן את הויכוח: Bateman, S., Mandryk, R.L., Gutwin, C., Genest, A., McDine, D., & Brooks, C. (2010), "Useful junk?: the effects of visual embellishment on comprehension and memorability of charts," *CHI '10*, ACM, pp. 2573-2582, **doi:10.1145/1753326.1753716**. הניסוי השווה גרפים מינימליסטיים מול גרפים עם embellishment בסגנון Holmes. ממצאים מרכזיים: דיוק קריאה לטווח הקצר היה דומה, אך **memorability לטווח הארוך** (שבועיים אחרי) הייתה גבוהה יותר משמעותית בגרפים המקושטים. גם נכונות הקהל לדווח שהגרף "מעניין" הייתה גבוהה יותר.

**עמדת ביניים - Knaflic ו-Few:** Cole Nussbaumer Knaflic נוטה ל-Tufte, אך מודה: *"some embellishment, when properly chosen and designed, [can] represent information redundantly in useful ways."* Stephen Few ב-"The Chartjunk Debate" (Perceptual Edge) מבחין בין embellishment שמשרת קידוד (כותרת חזותית, צבע סמנטי) לבין chartjunk שמסיח (3D, ducks).

**ההחלטה התפעולית ל-Point:**
1. **ברירת מחדל = data-ink ratio גבוה, chartjunk נמוך.** כל גרף עסקי, מדעי, פיננסי או טכני מתחיל מינימלי.
2. **חריגה מותרת רק כאשר מתקיימים *שלושת התנאים* ביחד:**
   - הגרף משרת רעיון רטורי יחיד (לא טבלת lookup, לא השוואה רב-ממדית).
   - הקהל אינו מומחה / קהל רחב (decision על audience type מופנה לפרק 8).
   - האלמנט המקושט הוא **קידוד יתיר של הנתון** (sticker בצורת לב מעל "מכירות יום ולנטיין"), לא קישוט לא-קשור.
3. **גם בחריגה - Lie Factor חייב להישאר בטווח 0.95-1.05.** chartjunk אסור להזיז את הצורה הויזואלית של הנתון.

**מקור:** Tufte (1983/2006); Holmes ב-*NYT* (1992); Bateman et al. (2010), CHI, doi:10.1145/1753326.1753716; Knaflic (2015).

---

### 3.5 בחירת סוג גרף לפי שאלת המשתמש (Knaflic)

**שם:** Choosing an Effective Visual.
**מקור:** Cole Nussbaumer Knaflic, *Storytelling with Data* (Wiley, 2015), פרק 2.

**מה זה אומר:** הבחירה אינה לפי סוג הנתון אלא לפי **השאלה שהקהל אמור לענות עליה**. Knaflic מציגה decision tree פשוט:

- **Simple text / big number** - כשהמסר הוא 1-2 מספרים והשאר רעש. *"if you have just a number or two that you want to communicate: use the numbers directly."*
- **Table** - כשהקהל צריך **לחפש ערך ספציפי** (lookup), או להשוות יחידות מדידה שונות. טבלאות נקראות סדרתית, גרפים נקראים במבט אחד.
- **Heatmap** - טבלה שבה הקהל צריך לזהות **תבנית** ולא להציץ בערך בודד.
- **Line graph** - **סדרת זמן רציפה.** שינוי לאורך זמן, מגמה. הקו עצמו אומר "רציפות".
- **Bar chart** - **השוואת קטגוריות** באותו זמן. כלל מחייב של Knaflic: *"It is important that bar charts always have a zero baseline, otherwise, you get a false visual comparison."* (קישור ישיר ל-Lie Factor, סעיף 3.3).
- **Slopegraph** - השוואת **שתי נקודות בזמן** בלבד עבור מספר ישויות (לפני / אחרי).
- **Scatter plot** - **קשר בין שני משתנים רציפים.** כשהשאלה היא "האם X ו-Y קשורים?" ולא "כמה X?".
- **Pie chart** - Knaflic מסתייגת. Duarte מציבה כלל אצבע: עד 8 פלחים, הפלח הגדול מתחיל בשעה 12, סדר לפי גודל. הסיבה להסתייגות: המוח האנושי קורא זוויות פחות מדויק מאורכים, ולכן bar chart כמעט תמיד עדיף על pie.

**למה זה עובד:** הקידוד הויזואלי חייב להתאים לעיבוד הויזואלי. אורך (bar) נקרא יותר מדויק מזווית (pie). רציפות (line) נקראת כמגמה, אינטרוול (bar) נקרא כקטגוריה.

**מתי רלוונטי:** תמיד לפני שמתחילים לעצב גרף. לפני שאתה בוחר את הצבע, התווית, או הכותרת - בחר את הצורה לפי השאלה.

**כלל אצבע:** קודם השאלה של הקהל, אחר כך סוג הגרף; אם בחרת bar - התחל מאפס; אם בחרת pie - שקול שוב.

**מקור:** Knaflic (2015), פרק 2; Duarte, *Slide:ology* (2008), פרק על data slides; הכלל "different takeaway, different graph" - Storytelling with Data Blog.

---

### 3.6 6 השלבים של Knaflic (storytelling with data framework)

**שם:** Knaflic 6-step framework.
**מקור:** Knaflic, *Storytelling with Data* (Wiley, 2015), פרקים 1-7.

**מה זה אומר:** סדר פעולות מחייב לכל גרף שמופיע במצגת.

1. **Understand the context** - מי הקהל, מה אתה רוצה שהוא ידע, מה אתה רוצה שהוא יעשה. ללא הקשר ברור אין החלטה גרפית נכונה.
2. **Choose an appropriate visual** - לפי decision tree של סעיף 3.5.
3. **Eliminate clutter** - הסר כל אלמנט שאינו חיוני. Gestalt principles (proximity, similarity, enclosure, closure, continuity, connection) משמשים זיהוי אלמנטים שניתן להסיר. *"Every single element you add to that page or screen takes up cognitive load."* (Knaflic 2015, פרק 3).
4. **Focus attention** - השתמש בצבע, גודל ומיקום כדי **להוביל את העין** לנתון החשוב. כל השאר באפור. זה הצעד שמבדיל "גרף" מ-"גרף עם מסר".
5. **Think like a designer** - הוסיף affordances טיפוגרפיים: כותרת-משפט מסבירה (לא "מכירות 2024" אלא "מכירות צמחו 30% ברבעון 4"), יישור, היררכיה.
6. **Tell a story** - הגרף משובץ בקריינות נרטיבית, לא מוצג כעובדה יבשה. המסגרת הסיפורית מוסברת בפרק על Narrative.

**למה זה עובד:** השלבים בנויים מהפשטה כללית (1) לעיצוב פרטני (5) ולאחר מכן לחיבור הסיפורי (6). דילוג על שלב 1 פוגע בכל היתר. במיוחד שלב 4 (Focus attention) הוא הגשר בין data-ink minimalism של Tufte (סעיף 3.1) לבין הצורך הרטורי לזרוק את העין על נקודה אחת.

**מתי רלוונטי:** כל גרף, ללא יוצא מן הכלל. אורך הזמן שמושקע בכל שלב תלוי בקונטקסט: גרף ב-slidedoc יקבל את כל ששת השלבים בקפדנות; גרף ב-presentation זריזה יקבל לפחות 1, 2, 4.

**כלל אצבע:** לפני שיגעת בעיצוב, ענה ב-3 משפטים: למי, מה הוא לוקח, מה אתה רוצה שיעשה.

**מקור:** Knaflic (2015), *Storytelling with Data*, ISBN 978-1119002253.

---

### סיכום הפרק - כלל אצבע אחד-משפט

**גרף הוא תשובה לשאלה אחת של הקהל - בחר את הצורה לפי השאלה, צמצם דיו לא-נתוני, שמור Lie Factor בטווח 0.95-1.05, ואל תוסיף קישוט אלא אם הוא מקודד את הנתון ולא מסיח ממנו.**
