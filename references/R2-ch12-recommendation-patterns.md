# פרק 12 - Point Recommendation Patterns

**Snapshot:** May 2026

## Section 1 - איך לקרוא את הפרק

זה הפרק התפעולי של Point. כל פעם שמשתמש מגיע עם בעיה, Point מבצע ארבעה צעדים בסדר קבוע. ראשית מזהה trigger במה שהמשתמש אמר או הראה (סוג קלט, מטרה, אילוץ). אחר כך מתאים לדפוס מתוך 10 הדפוסים בסעיף 2 (לפעמים שילוב של שניים). אז מציע פיצ'ר NotebookLM אחד או רצף קצר, ביחד עם פרומפט מוכן ל-copy-paste, מה מצפים שיחזור (פורמט, אורך, plan minimum) ומה הצעד הבא אחרי שהפלט מוכן. כל דפוס עומד בפני עצמו ולא דורש קריאה רציפה. אם דפוס דורש פיצ'ר Tier B, Point חייב להוסיף הסתייגות מפורשת לפי הניסוח של פרק 11.

## Section 2 - 10 דפוסי המלצה

### Pattern 1 - "יש לי PDF ארוך, אני רוצה להבין מהר"

**Trigger** (מה המשתמש אמר/הראה):
המשתמש העלה PDF של 40 עמודים פלוס, או אמר משפט כמו "אני צריך להבין את המסמך הזה בעשר דקות".

**Recommendation** (איזה פיצ'ר NotebookLM להפעיל):
Audio Brief כשלב ראשון לאוריינטציה מהירה (ראה פרק 3), ואחריו Mind Map לראייה מבנית של הנושאים (ראה פרק 6). שני הפיצ'רים נוצרים במקביל ולא דורשים זה את זה.

**Exact prompt** (טקסט copy-paste למשתמש):
ב-Studio בחר Audio Overview, ולחץ Customize. הדבק: "Focus on the main argument, the three most important claims, and the open questions the author leaves unanswered. Brief format, around 5 minutes." במקביל, ב-Studio בחר Mind Map (לא דורש פרומפט).

**Expected output** (מה יחזור):
Audio Brief בערך 5-8 דקות, MP3 להורדה. Mind Map אינטראקטיבי שניתן ללחוץ על ענפים ולהרחיב לתת-נושאים. שניהם זמינים בכל plan כולל Free.

**Next step** (מה Point אומר אחרי שהפלט מוכן):
אם הבנת את המסגרת ורוצה לעמוק, עבור ל-Deep Dive Audio (20-30 דקות) או Study Guide ל-active recall.

### Pattern 2 - "אני רוצה להפיץ את התוכן הזה לקהל"

**Trigger** (מה המשתמש אמר/הראה):
המשתמש אומר "אני מכין משהו ליוטיוב/לסושיאל/לקהל רחב" או מבקש "סרטון תקציר".

**Recommendation** (איזה פיצ'ר NotebookLM להפעיל):
אם הקהל דובר אנגלית והמשתמש על Pro/Ultra - Cinematic Video Overview (ראה פרק 4) בגלל איכות הפרודקשן. אחרת Standard Video Overview, שתומך ב-80 שפות כולל עברית.

**Exact prompt** (טקסט copy-paste למשתמש):
ב-Studio בחר Video Overview, Customize: "Audience is non-experts. Lead with the single most surprising finding. Cover three main points with concrete examples. Close with one practical takeaway." בחר Cinematic אם זמין ואם הקהל אנגלי, אחרת Standard.

**Expected output** (מה יחזור):
Standard Video בערך 5-10 דקות, MP4 עם watermark כברירת מחדל. Cinematic באיכות פרודקשן גבוהה יותר, גם הוא MP4 עם watermark. Cinematic זמין רק מ-Pro 20TB ומעלה עם מכסה של 2/יום, וב-Ultra 30TB מכסה של 20/יום (ראה פרק 10). Cinematic = EN בלבד נכון ל-28/05/2026 (ראה פרק 11 §9). Standard זמין ב-Free.

**Next step** (מה Point אומר אחרי שהפלט מוכן):
ניתן לשתף דרך public link (Free, חשבונות consumer בלבד, ראה פרק 9), או להוריד MP4 ולהעלות לפלטפורמה החיצונית.

### Pattern 3 - "אני לומד למבחן"

**Trigger** (מה המשתמש אמר/הראה):
המשתמש אומר "יש לי מבחן ביום שלישי", "אני צריך לזכור את החומר הזה", או "תכין לי חומר ללמידה".

**Recommendation** (איזה פיצ'ר NotebookLM להפעיל):
רצף קבוע של שלושה פיצ'רים בסדר זה: Study Guide קודם (ראה פרק 5) כמפת ידע, אחר כך Flashcards (ראה פרק 6) לחזרה פעילה, ולסיום Quiz (ראה פרק 6) לאימות. הסדר חשוב כי כל שלב מסתמך על השלב שלפניו.

**Exact prompt** (טקסט copy-paste למשתמש):
שלב 1, Study Guide ב-Studio: "Cover all key concepts, definitions, and likely exam questions. Include a glossary section." שלב 2, Flashcards ב-Studio: "20 cards covering definitions and core concepts." שלב 3, Quiz ב-Studio: "15 questions, mix of multiple choice and short answer, calibrated to exam-level difficulty."

**Expected output** (מה יחזור):
Study Guide כ-Report טקסטואלי. Flashcards אינטראקטיביות עם Got it / Missed it / Shuffle / Delete. Quiz עם תשובות וניקוד. כל השלושה זמינים ב-Free.

**Next step** (מה Point אומר אחרי שהפלט מוכן):
אחרי כל Quiz, חזור ל-Flashcards וסמן Missed it לכל שאלה שהחמצת. עבור עליהן שוב ביום הבא.

### Pattern 4 - "אני צריך להגיש דוח"

**Trigger** (מה המשתמש אמר/הראה):
המשתמש אומר "מנהל ביקש דוח", "צריך להציג ביום חמישי", או "תכין לי תקציר מנהלים".

**Recommendation** (איזה פיצ'ר NotebookLM להפעיל):
Briefing Doc כבסיס הטקסטואלי (ראה פרק 5), ואחריו Slide Deck עם PPTX export (ראה פרק 7) למצגת. אופציונלית Custom Report להעמקה בסעיף ספציפי שצריך פירוט נוסף.

**Exact prompt** (טקסט copy-paste למשתמש):
שלב 1, Briefing Doc: "Executive summary, key findings in three bullets, recommendations with rationale, open risks." שלב 2, Slide Deck: "10 slides max. Slide 1 title, slide 2 executive summary, slides 3-8 key findings one per slide with supporting data, slide 9 recommendations, slide 10 next steps." הורד כ-PPTX.

**Expected output** (מה יחזור):
Briefing Doc כ-Report ארוך. Slide Deck עם 10 שקופיות, ניתן להוריד כ-PPTX ולהמשיך עריכה ב-PowerPoint. הכל זמין ב-Free.

**Next step** (מה Point אומר אחרי שהפלט מוכן):
אם שקופית ספציפית לא מדויקת, השתמש ב-Slide revisions פר-שקופית (חדש מ-20/03/2026) במקום ליצור דק מחדש. כך מתקנים נקודתית בלי לאבד את שאר התוצר.

### Pattern 5 - "יש לי קולקציה של 30 מקורות"

**Trigger** (מה המשתמש אמר/הראה):
המשתמש מתאר notebook עם הרבה מקורות, פרויקט מחקר עם בליל של PDFים ולינקים, או שואל "איך אני מתמצא בכל זה".

**Recommendation** (איזה פיצ'ר NotebookLM להפעיל):
Source Auto-Label לתיוג ראשוני של כל המקורות (ראה פרק 2, **Tier B - מקור יחיד: S5, 24/04/2026**), אחריו Briefing Doc על כל קלאסטר שזוהה, ו-Custom Report פר-נושא שצריך עיון נפרד. אם Auto-Label לא נראה ב-UI - fallback לתיוג ידני לפי קריאת titles.

**Exact prompt** (טקסט copy-paste למשתמש):
שלב 1, חפש ב-Sources panel את הכפתור Auto-Label (ייתכן שזמין החל מ-24/04/2026, לא ראיתי אישור רשמי). שלב 2, Briefing Doc: "Cluster the sources into 3-5 themes. For each theme, summarize the dominant claim and any disagreements between sources." שלב 3, Custom Report פר-נושא: "Deep analysis of [נושא X], including methodology comparison across sources."

**Expected output** (מה יחזור):
תיוג אוטומטי לכל מקור (אם הפיצ'ר חי). Briefing Doc עם מפת קלאסטרים. Custom Report לכל נושא נבחר. Plan minimum Pro (300 sources) לקולקציה בסדר גודל כזה.

**Next step** (מה Point אומר אחרי שהפלט מוכן):
לפני שצוללים לקלאסטר ספציפי, רוץ Mind Map על כל ה-notebook לקבל מבט-על. זה ימנע לעמוק במקום הלא נכון.

### Pattern 6 - "יש לי שיחה ב-Gemini ואני רוצה להמשיך אותה"

**Trigger** (מה המשתמש אמר/הראה):
המשתמש אומר "התחלתי לעבוד על זה ב-Gemini", "יש לי thread טוב ב-Gemini", או "אני רוצה להפוך את השיחה הזאת ל-knowledge base".

**Recommendation** (איזה פיצ'ר NotebookLM להפעיל):
Notebooks in Gemini 2-way sync (ראה פרק 9, חדש מ-08/04/2026 ב-web ומ-30/04/2026 ב-mobile Free). השיחה הופכת ל-notebook עם כל המקורות שנדונו בה, וכל עדכון בצד אחד מתעדכן בצד השני.

**Exact prompt** (טקסט copy-paste למשתמש):
ב-Gemini, פתח את השיחה הרצויה ובחר באפשרות "Open in NotebookLM" (או דומה במונחי UI נוכחיים). לא נדרש פרומפט - המעבר אוטומטי.

**Expected output** (מה יחזור):
notebook חדש שמכיל את היסטוריית השיחה ואת המקורות שצוטטו בה. עדכונים בצד אחד מסונכרנים לצד השני. Plan minimum Free, כולל mobile Free מ-30/04/2026.

**Next step** (מה Point אומר אחרי שהפלט מוכן):
אם השיחה הופכת לבסיס ידע מתמשך, העבר אותה ל-notebook קבוע והוסף sources נוספים שלא היו ב-Gemini. השיחה ב-Gemini עצמה stateless בין sessions (ראה פרק 11 §1).

### Pattern 7 - "אני רוצה אינפוגרפיקה משותפת"

**Trigger** (מה המשתמש אמר/הראה):
המשתמש אומר "תכין לי תמונה לסושיאל", "אני רוצה ויז'ואל אחד שמסכם", או "תמונה שאפשר לשלוח בוואטסאפ".

**Recommendation** (איזה פיצ'ר NotebookLM להפעיל):
Infographic (ראה פרק 7, 10 styles, חדש מ-20/03/2026), הורדה כ-PNG, ושיתוף דרך public link אם רוצים גישה לתוכן המלא (ראה פרק 9, consumer בלבד).

**Exact prompt** (טקסט copy-paste למשתמש):
ב-Studio בחר Infographic. בחר style מתוך 10 האפשרויות (לדוגמה Timeline אם זה רצף, Comparison אם זו השוואה). Customize: "Focus on the 5 most important data points. Visual hierarchy by importance." הורד כ-PNG.

**Expected output** (מה יחזור):
PNG באיכות גבוהה, מבוסס על תוכן ה-notebook. אם style לא מתאים, ניתן לייצר מחדש עם style אחר. Plan minimum Free.

**Next step** (מה Point אומר אחרי שהפלט מוכן):
אם רוצים מצגת מלאה במקום תמונה אחת, עבור ל-Slide Deck עם PPTX export. PNG טוב לפוסט, PPTX טוב להצגה.

### Pattern 8 - "אני רוצה לתת לתלמידים גישה"

**Trigger** (מה המשתמש אמר/הראה):
המשתמש מורה או מרצה, אומר "אני רוצה שהכיתה תוכל לעבוד עם זה", או שואל על שיתוף עם קבוצה.

**Recommendation** (איזה פיצ'ר NotebookLM להפעיל):
Google Classroom integration (ראה פרק 9, חדש מ-27/04/2026) כדרך המרכזית. אופציונלית - הוספת ה-notebook ל-Featured Notebooks אם זה תוכן מומלץ לקהל רחב יותר. אם המוסד משתמש ב-Canvas או Schoology - **Tier B - stale 09/2025** (ראה פרק 11), צריך fallback ידני.

**Exact prompt** (טקסט copy-paste למשתמש):
ב-Google Classroom, צור מטלה חדשה ובחר Attach > NotebookLM. בחר את ה-notebook הרצוי. התלמידים יקבלו גישה אוטומטית עם החשבון הלימודי שלהם. אם Canvas או Schoology - הפיק public link והדבק כקישור במטלה.

**Expected output** (מה יחזור):
התלמידים נכנסים ל-notebook עם הרשאות צפייה, יכולים להריץ chat ולהפיק outputs משלהם. Plan minimum Free.

**Next step** (מה Point אומר אחרי שהפלט מוכן):
תוכל לעקוב אחרי שאלות התלמידים דרך chat history של ה-notebook (Saved & secure chat history, חדש מ-20/03/2026). זה גם דרך טובה לזהות נקודות לא ברורות בחומר.

### Pattern 9 - "המקור שלי הוא MP4"

**Trigger** (מה המשתמש אמר/הראה):
המשתמש אומר "יש לי הקלטה של פגישה", "סרטון של 40 דקות", או מנסה להעלות MP4 ונכשל.

**Recommendation** (איזה פיצ'ר NotebookLM להפעיל):
MP4 ישיר **לא נתמך** ב-NotebookLM (ראה פרק 2). שתי דרכים: אם זה YouTube - הכנס את ה-URL ישירות ב-Add source, ו-NotebookLM ימשוך את התמליל אוטומטית. אם זה קובץ מקומי - תמלל חיצונית (Whisper, Otter, או דומה) והעלה את התמליל כ-TXT.

**Exact prompt** (טקסט copy-paste למשתמש):
מסלול YouTube: ב-Add source, בחר Web URL, הדבק את הקישור. מסלול תמלול חיצוני: רוץ Whisper על הקובץ (פקודה: `whisper input.mp4 --output_format txt`), אחר כך ב-Add source > Upload > בחר את ה-TXT שנוצר.

**Expected output** (מה יחזור):
מסלול YouTube - תמליל מובנה כ-source חדש. מסלול Whisper - TXT עם תמלול שעלול לדרוש ניקוי קל. ב-שני המקרים, ה-source זמין לכל פיצ'רי NotebookLM. Plan minimum לא רלוונטי (תלוי בכלי החיצוני).

**Next step** (מה Point אומר אחרי שהפלט מוכן):
אחרי שהתמליל ב-notebook, רוץ Audio Brief לסיכום מהיר או Mind Map למפת נושאים. אם זו פגישה ארוכה, Briefing Doc עם בקשה ל-"action items per participant" יוציא טבלת מטלות.

### Pattern 10 - "אני רוצה לערוך את הפלט"

**Trigger** (מה המשתמש אמר/הראה):
המשתמש מקבל Audio או Report או Mind Map ואומר "כמעט מושלם, אבל צריך לשנות משפט אחד", או "איפה כפתור העריכה".

**Recommendation** (איזה פיצ'ר NotebookLM להפעיל):
לפי פרק 11 §1, רוב הפלטים של Studio אינם נערכים ישירות. החריג היחיד: Slide revisions פר-שקופית (ראה פרק 7, חדש מ-20/03/2026). לכל שאר הפלטים יש שתי אפשרויות: regenerate עם פרומפט מדויק יותר ב-Customize, או export ועריכה חיצונית.

**Exact prompt** (טקסט copy-paste למשתמש):
מסלול Slides: ב-Slide Deck קיים, בחר את השקופית, בחר Revise, הדבק: "Replace bullet 2 with [טקסט חדש]. Keep all other slides untouched." מסלול regenerate: ב-Studio, מחק את הפלט הקיים וצור מחדש עם פרומפט מפורט יותר. מסלול export: הורד את הפלט (PPTX, PNG, MP3, MP4) וערוך בכלי המקורי.

**Expected output** (מה יחזור):
Slide revisions - שקופית אחת מתעדכנת בלי לפגוע בשאר. Regenerate - פלט חדש לחלוטין. Export - קובץ סטנדרטי לעריכה חיצונית. Plan minimum Free.

**Next step** (מה Point אומר אחרי שהפלט מוכן):
אם זה טקסט שצריך עריכה משמעותית, השקעה בפרומפט מדויק יותר ב-Custom Report עדיפה על עריכה ידנית של פלט חלש. השקעה של 30 שניות בפרומפט חוסכת 10 דקות עריכה.

## Section 3 - 2 צירים לבחירת דפוס

כשמשתמש מתאר בעיה, Point בוחר דפוס בשני סבבי בחירה. הסבב הראשון לפי סוג הקלט, והסבב השני לפי מטרה. אם הקלט עצמו קובע (PDF ארוך, MP4, קולקציה גדולה, שיחה ב-Gemini), עוצרים בציר A. אחרת ממשיכים לציר B שמוכרע לפי מה המשתמש רוצה לעשות עם הפלט.

**ציר A - לפי input:**
- PDF ארוך בודד → Pattern 1.
- קולקציה גדולה של מקורות → Pattern 5.
- שיחה קיימת ב-Gemini → Pattern 6.
- MP4 או הקלטה → Pattern 9.
- כל השאר → המשך לציר B.

**ציר B - לפי goal:**
- ללמוד לבד לקראת מבחן → Pattern 3.
- להגיש דוח רשמי → Pattern 4.
- להפיץ לקהל רחב → Pattern 2 (וידאו) או Pattern 7 (אינפוגרפיקה).
- ללמד תלמידים → Pattern 8.
- לערוך פלט שכבר נוצר → Pattern 10.

הצירים האלה לא ממצים את כל הקומבינציות. אם המשתמש מתאר משהו היברידי (לדוגמה "PDF ארוך שאני רוצה להפיץ"), Point משלב שני דפוסים (כאן: Pattern 1 להבנה אישית קודם, ואחר כך Pattern 2 או 7 להפצה).

## Section 4 - דברים שאף דפוס לא מכסה

ארבעה תרחישים שהמשתמשים שואלים עליהם והדפוסים לא נותנים מענה ישיר. **איכות עברית באודיו** - הדפוסים אומרים "עברית נתמכת" אבל פרק 11 §2 קובע שהאיכות לא נבדקה רשמית ב-2026; ההמלצה היא לבדוק על דוגמה קטנה לפני השקעה במקור גדול. **בחירת voice ל-Audio** - לא קיים פיצ'ר בחירת קולות; הקולות נקבעים אוטומטית לפי שפה. **Aggregation מ-multiple notebooks** - NotebookLM לא תומך ב-cross-notebook queries; כל notebook עצמאי, ולשאלה שדורשת מספר notebookים יש לאחד מקורות ל-notebook אחד מראש. **Automation דרך MCP** - ראה פרק 9 ל-MCP CLI הקיים (jacob-bd/notebooklm-mcp-cli), זה הדרך היחידה לאוטומציה חיצונית נכון להיום.
