## פרק 8 - Genre and Audience Decision Tree

זהו הפרק התפעולי של ה-KB. כל יתר הפרקים (0-7) מספקים ל-Point את הכלים והעקרונות. פרק 8 הוא המקום שאליו Point ניגש **ראשון**, ברגע שמשתמש מתאר סיטואציה ("אני צריך לבנות פיץ' ל-VC", "יש לי הרצאה מדעית של 40 דקות", "צריך להציג עדכון רבעוני להנהלה"). הפרק לוקח את שני המשתנים החיצוניים העיקריים שמשתמש יכול לתאר במשפט אחד - **ז'אנר** (סוג המצגת) ו-**קהל** - וממפה אותם להמלצה קונקרטית בכל אחד משבעת הצירים שבפרקים 1-7. רק אחרי שהעץ הכריע, Point ניגש לפרק התוכן הספציפי כדי לאסוף את הניסוח המפורט.

הפרק לא מסביר מחדש את התיאוריה. CLT, Mayer ושלוש קטגוריות התוצר של Duarte נמצאים בפרק 0. ההפניה לכל פרק תוכן ניתנת בכל החלטה.

---

### 8.1 למה הפרק קיים - שמונה הסתירות

שמונה סתירות לאורך פרקים 1-7 לא נפתרו שם בכוונה - הן הופנו לפרק הזה. כל סתירה היא לא ויכוח אקדמי אלא הכרעה תפעולית שתלויה במצב. הסיכום:

1. **Tufte vs Reynolds על צפיפות** (פרק 2.5). מוכרע לפי **קטגוריית התוצר** מתוך פרק 0 - presentation מוקרנת מקבלת Reynolds, slidedoc לקריאה אסינכרונית מקבל Tufte. אם המשתמש לא יודע לאיזה תוצר הוא בונה - Point שואל לפני כל החלטה אחרת.
2. **Atkinson zero-bullets vs Doumont conditional** (פרק 4.4). מוכרע לפי **סוג התוכן** של השקופית הספציפית - רשימה לא מסודרת אמיתית עם פעלים מקבילים ועד 5 פריטים מותר ל-Doumont. כל מה שאינו רשימה כזו - sentence headline + ויזואל. ההכרעה הזו אינה תלויה ז'אנר ולכן חוצה את כל התאים בטבלה.
3. **Tufte informative-image vs Reynolds metaphorical-image** (פרק 5.5). מוכרע לפי **קהל** - טכני/מדעי/רגולטורי = אינפורמטיבית; רחב/הנעה לפעולה = מטפורית.
4. **Duarte Sparkline vs Atkinson 3-Act vs Gallo TED** (פרק 7.5). מוכרע לפי **משך ז'אנרי** - פיץ' ≤10 דק = Atkinson; keynote 15-30 דק = Duarte; TED ≤18 דק = Gallo (Atkinson דחוס).
5. **Mayer Redundancy vs Atkinson sentence headline** (פרק 4.5). זו לא סתירה אלא **boundary condition** של Mayer & Pilegard 2014: כותרת קצרה (6-15 מילים) ליד ויזואל לא מפרה; פסקה על המסך שהדובר קורא בקול - כן מפרה. ההכרעה תפעולית קבועה ולא תלוית-קהל - לכן היא כלל אצבע חוצה ולא טור בטבלה.
6. **Pyramid Principle vs Storytelling tension** (פרק 7.5). מוכרע לפי **קהל** - מנהלים/decision-maker = Pyramid (Answer First); קהל שצריך הנעה רגשית = Storytelling. ז'אנר משפיע כסיגנל לקהל אבל הציר הראשי הוא הקהל.
7. **Reynolds minimal-notes vs Atkinson full-notes** (פרק 6.5). מוכרע לפי **ז'אנר ולחץ** - keynote/TED/השראה = Reynolds (key phrases); sales/legal/pitch/leave-behind = Atkinson (~50 מילים פר שקופית).
8. **Kawasaki 30pt vs Doumont 18pt** (פרק 1.3). מוכרע לפי **ז'אנר** - פיץ' עסקי = 30pt; lecture מדעי = 18-24pt; היברידי = ברירת המחדל 24-28pt עם היררכיה כפולה.

ארבע הסתירות התלויות-ז'אנר (#1, #4, #7, #8) הופכות לטור הז'אנר בטבלה. שתי הסתירות התלויות-קהל (#3, #6) הופכות לטור הקהל. סתירה #2 (bullets) וסתירה #5 (Redundancy boundary) הן כללי אצבע גלובליים שחוצים את כל התאים.

---

### 8.2 הגדרת שני הצירים

#### ציר ז'אנר - שישה ז'אנרים תפעוליים

- **Pitch ≤10min:** הצגה עסקית קצרה לקבלת החלטה - VC pitch, pre-seed, החלטת go/no-go פנימית. הסטייקים גבוהים, הזמן קצר, ה-CTA חייב להישמע מוקדם, leave-behind נדרש כי המאזין מתייעץ אחר כך. עומד מתוך פרק 7 על Atkinson 3-Act.
- **Keynote 15-30min:** נאום מרכזי באירוע - השקת מוצר, נאום פתיחה, חזון תרבותי, הזמנה לפעולה רחבה. הזמן מספיק לבניית קשת רגשית. עומד מתוך פרק 7 על Duarte Sparkline.
- **TED ≤18min:** פורמט TED/TEDx - רעיון אחד מזוקק, סיפור אישי, פתיחה תוך 30 שניות. אורך קצוב נוקשה. עומד מתוך פרק 7 על Gallo + הגרסה הדחוסה של Atkinson.
- **Technical lecture:** הרצאה מדעית, סדנת מומחים, מצגת בקונפרנס, תוכן מדעי לקהל בקיא. נוסחאות, גרפים מולטי-משתניים, ז'רגון מקצועי. עומד מתוך פרק 3 (Tufte data-ink) ומתוך פרק 5 (תמונה אינפורמטיבית).
- **Sales deck:** מצגת מכירה מסחרית מול לקוח פוטנציאלי - לרוב 20-45 דקות, שילוב של presentation חיה ו-leave-behind. נדרש משולב Atkinson Notes + Pyramid לתת-החלטות.
- **Internal briefing:** עדכון פנימי - דוח רבעוני, board update, סטטוס פרויקט. מאזין הוא decision-maker עסוק. נמצא בלב Pyramid Principle.

#### ציר קהל - ארבעה טיפוסים

- **Technical:** מהנדסים, חוקרים, אנליסטים, רגולטורים. סובל צפיפות מידע, סולד מפישוטים מטעים, דורש מקור ונתון.
- **Mixed:** קהל מעורב - חלקו טכני, חלקו לא. מאפיין כנסים, השקות מוצר B2B, ימי משקיעים. הצורך החזק ביותר ב-pre-training (Mayer #9) - יישור מונחים לפני התוכן.
- **Broad:** קהל רחב לא-מומחה - לקוחות, ציבור, עיתונאים, סטודנטים מחוץ לתחום. רגיש לעיטור, מגיב לרגש, נשבר על ז'רגון.
- **Executives/Management:** מקבלי החלטה בכירים. **חסרי סבלנות לסיפור**, רוצים תשובה ראשונה ואז ראיות. גם אם הם טכניים ברקע - בכובע הניהולי שלהם הם מתנהגים כקהל החלטה.

---

### 8.3 מטריצת ההחלטה - ליבת הפרק

הטבלה הראשית. שורות = ז'אנר. עמודות = שבעת ציריי התוכן. הקהל נכנס כפרמטר בתאים שבהם הוא מכריע (Visuals, Narrative). כללי האצבע הגלובליים (Bullets ו-Redundancy boundary) חוצים את כל התאים ומופיעים בסעיף 8.5.

| ז'אנר | Typography (פרק 1) | Density (פרק 2) | Data Viz (פרק 3) | Bullets (פרק 4) | Visuals (פרק 5) | Speaker Notes (פרק 6) | Narrative (פרק 7) |
|---|---|---|---|---|---|---|---|
| **Pitch ≤10min** | Kawasaki 30pt+, sans-serif, ניגוד גבוה | מסר אחד, glance test 3s, מינימליסטי | data-ink גבוה, big number / bar chart בלבד, Lie Factor 0.95-1.05 | כלל גלובלי (סעיף 8.5) | Broad/Mixed: מטפורית full-bleed. Executive: אינפורמטיבית ממוקדת. | Atkinson - ~50 מילים פר שקופית, leave-behind מובנה | Atkinson 3-Act, CTA בסוף Act I |
| **Keynote 15-30min** | 24-28pt גוף, sans-serif מודגש לכותרת, contrast 7:1 | מסר אחד, white space דומיננטי | data-ink גבוה, גרף אחד דרמטי לרבעון | כלל גלובלי | Broad/Mixed: מטפורית full-bleed (Reynolds). Technical: אינפורמטיבית במידה. | Reynolds - key phrases ≤10 מילים פר שקופית | Duarte Sparkline + SUCCESs מלא, New Bliss סוגר |
| **TED ≤18min** | 24-28pt גוף, sans-serif, ניגוד מקסימלי | מסר אחד, ויזואל דומיננטי, ≤1 שורה טקסט | אם בכלל - גרף אחד מטמורפוזה ויזואלית | כלל גלובלי | מטפורית full-bleed כברירת מחדל; אינפורמטיבית רק אם הרעיון תלוי בנתון | Reynolds - מינימלי, מופנם | Gallo / Atkinson דחוס, פתיחה ב-30s, רעיון אחד |
| **Technical lecture** | Doumont 18-24pt, sans-serif לגוף, serif מותר ל-slidedoc נלווה | מאוזן - presentation דליל + slidedoc צפוף נפרד | data-ink מקסימלי, גרפים מולטי-משתניים, Knaflic 6-step מלא | Doumont conditional - בולטים מותרים תחת 4 התנאים | אינפורמטיבית (Tufte), מטפורה רק לאינטרו | Atkinson - ~50 מילים בעיקר ב-slidedoc הנלווה | Pyramid אם הקהל יודע למה הוא כאן; SCQA → פירמידה אם נדרש מסגור |
| **Sales deck** | 24-28pt גוף, ניגוד גבוה, two-font ceiling | מצב כפול - presentation דלילה + slidedoc leave-behind | data-ink גבוה, גרף ROI אחד מודגש, Lie Factor קפדני | כלל גלובלי | Broad/Mixed: מטפורית בהקדמה, אינפורמטיבית בנתוני ROI. Executive: רק אינפורמטיבית. | Atkinson - ~50 מילים, ה-Notes Page הוא ה-handout | Atkinson 3-Act + Pyramid ל-Q&A; Executive → Pyramid טהור |
| **Internal briefing** | 24-28pt גוף; slidedoc מקביל בפורמט קריאה | slidedoc-leaning - 100-250 מילים לעמוד אם זה התוצר העיקרי | data-ink מקסימלי, dashboard-style מותר, טבלאות מותרות | Doumont conditional - בולטים מותרים אם רשימת סטטוס אמיתית | אינפורמטיבית בלבד; ללא תמונות סטוק | Atkinson - Notes Page = הדוח עצמו | Pyramid Principle (Answer First) - מסקנה בשקופית 1 |

#### תאים שבהם הקהל מכריע בנפרד מהז'אנר

ארבעה תאים בטבלה לעיל מסמנים את ההכרעה לפי קהל - שני צירים: Visuals ו-Narrative. הנה הפירוט המלא:

**עמודת Visuals (סתירה #3 - פרק 5.5):**

| ז'אנר \ קהל | Technical | Mixed | Broad | Executives |
|---|---|---|---|---|
| Pitch | אינפורמטיבית | מטפורית בהקדמה + אינפורמטיבית בנתון | מטפורית full-bleed | אינפורמטיבית ממוקדת |
| Keynote | מאוזן (אינפ' לנתון, מטפ' למסגור) | מטפורית בעיקר | מטפורית full-bleed | מטפורית קצרה + נתון ברור |
| TED | רק אם תלוי-נתון | מטפורית | מטפורית full-bleed | לא רלוונטי - TED לא ז'אנר ל-execs |
| Technical lecture | אינפורמטיבית בלעדית | אינפורמטיבית עם הסבר תוויות | פישוט נדרש - לא הז'אנר הנכון | אינפורמטיבית עם executive summary |
| Sales | אינפורמטיבית בעיקר | מטפורית + אינפורמטיבית | מטפורית + ROI ויזואלי | אינפורמטיבית טהורה |
| Internal | אינפורמטיבית | אינפורמטיבית | פישוט נדרש | אינפורמטיבית קצרה |

**עמודת Narrative (סתירה #6 - פרק 7.5):**

| ז'אנר \ קהל | Technical | Mixed | Broad | Executives |
|---|---|---|---|---|
| Pitch | Atkinson 3-Act | Atkinson 3-Act + SCQA | Atkinson 3-Act רגשי | Pyramid → Atkinson לפירוט |
| Keynote | Sparkline מתון | Sparkline | Sparkline + SUCCESs מלא | Sparkline קצרה + Pyramid בגוף |
| TED | Gallo | Gallo | Gallo / Sparkline | Gallo עם Pyramid פנימי |
| Technical lecture | Pyramid או הרצאה ליניארית | SCQA → Pyramid | פישוט + Sparkline | Pyramid טהור |
| Sales | Atkinson + Pyramid ב-Q&A | Atkinson 3-Act | Atkinson + Storytelling | Pyramid טהור |
| Internal | Pyramid | Pyramid | SCQA → Pyramid | Pyramid - חובה |

---

### 8.4 פרופילי ששת הז'אנרים - תקציר תפעולי

**Pitch ≤10min.** משך טיפוסי 7-10 דקות, קהל מנהלים/משקיעים בעיקר Executive או Mixed. הסטייקים גבוהים, ה-CTA חייב להישמע גם אם המאזין יוצא בדקה 6. טיפוגרפיה Kawasaki 30pt - הוקסטיקה שעובדת בקהל לא-טכני. צפיפות מינימלית. data-ink גבוה אבל גרף אחד פר רבעון מספיק. Atkinson לכל אורך הקו - sentence headline, Notes Page של ~50 מילים שמשמש leave-behind. נרטיב 3-Act עם CTA בסוף Act I. אם הקהל Executive טהור - Pyramid Principle (Answer First) בשקופית הראשונה ו-Atkinson כמסגרת תומכת.

**Keynote 15-30min.** משך טיפוסי 20-25 דקות, קהל Broad או Mixed. המטרה: לזוז קהל לפעולה רגשית. טיפוגרפיה 24-28pt עם ניגוד גבוה, sans-serif מודגש. צפיפות מינימלית - white space דומיננטי. גרף אחד דרמטי לרבעון של הנאום, לא יותר. תמונות מטפוריות full-bleed (Reynolds) - הז'אנר הקנוני של *Presentation Zen*. Reynolds notes - key phrases בלבד, הדובר הפנים. Duarte Sparkline + SUCCESs מלא + New Bliss מוחשי בסיום. הקללה הקלאסית כאן: דוברים שמכינים keynote כאילו הוא lecture - יותר מדי תוכן, פחות מדי רגש.

**TED ≤18min.** משך מוגבל ל-18 דקות בתקן TED, 12-15 בתקני TEDx. קהל Broad. רעיון אחד מזוקק, סיפור אישי הוא חובה. טיפוגרפיה 24-28pt, ניגוד מקסימלי. כל שקופית = ויזואל יחיד דומיננטי + אולי שורת טקסט. תמונה מטפורית full-bleed כברירת מחדל; אינפורמטיבית רק אם הרעיון תלוי בנתון (מקרה Hans Rosling). Reynolds notes מינימלי - בתרגול TED הדובר משנן עד שאין צורך כלל. נרטיב Gallo (פרק 7) + Atkinson דחוס - פתיחה תוך 30 שניות, רעיון אחד, סיום חי. סכנה: שקופית עם 3 בולטים מפילה TED talk.

**Technical lecture.** משך טיפוסי 30-60 דקות, קהל Technical או Mixed. תוכן עם intrinsic load גבוה - נוסחאות, גרפים, טרמינולוגיה. כאן המקום היחיד שבו Doumont 18-24pt לגיטימי, ולעתים נחוץ כדי שנוסחה תיכנס בלי לפצל שקופית. צפיפות מאוזנת: presentation דליל להקרנה + slidedoc צפוף (100-250 מילים לעמוד) שמופץ אחרי - שני קבצים נפרדים, לא אחד. data-ink מקסימלי לגרפים, Knaflic 6-step מלא, גרפים מולטי-משתניים מותרים. בולטים Doumont conditional מותרים - רשימת שלבים, רשימת תכונות, עומדים בתנאים. תמונות אינפורמטיביות (Tufte) בלעדית; מטאפורה רק לאינטרו. Atkinson notes - ה-slidedoc הוא ה-Notes Page המורחב. נרטיב Pyramid או הרצאה ליניארית; SCQA כפתיח אם הקהל לא מודע לשאלת המחקר.

**Sales deck.** משך משתנה 20-45 דקות, קהל Mixed או Executive. ז'אנר היברידי - חלקו presentation מדוברת, חלקו leave-behind שיקרא לאחר מכן. כפילות-תוצרת נדרשת: presentation דלילה להקרנה + slidedoc/Notes Page מפורט שנשלח אחרי. טיפוגרפיה 24-28pt, two-font ceiling. גרף ROI אחד מודגש, Lie Factor קפדני (אמינות עסקית מתפרקת על Lie Factor חשוד). תמונות מעורבות לפי קהל: Mixed - מטפורית בהקדמה ואינפורמטיבית לנתון; Executive - אינפורמטיבית בלבד. Atkinson notes - ה-Notes Page הוא ה-handout שילך ל-procurement. נרטיב Atkinson 3-Act לפלואו החי + Pyramid ל-Q&A; אם הקהל Executive טהור - Pyramid מההתחלה.

**Internal briefing.** משך טיפוסי 10-20 דקות, קהל Management/Executive. ז'אנר שנוטה ל-slidedoc יותר מ-presentation - לרוב הדוח קיים גם אם המצגת מתקיימת בעל פה. צפיפות גבוהה לגיטימית כאן, **בתנאי** שזה slidedoc ולא presentation מוקרנת. גרפים מולטי-משתניים, dashboard-style, טבלאות - מותרים ואף רצויים. בולטים Doumont conditional מותרים לרשימת סטטוס אמיתית. תמונות סטוק אסורות - רק נתון אינפורמטיבי. Atkinson notes - Notes Page הוא הדוח עצמו, נשלח לפני או אחרי. נרטיב Pyramid Principle חובה - מסקנה בשקופית 1, ראיות בהמשך. SCQA רק אם הקהל לא מודע לבעיה.

---

### 8.5 כללי אצבע חוצי-עץ - סתירות #2 ו-#5

שני כללים שלא הופכים לתאי טבלה כי הם אחידים בכל תא:

**סתירה #2 - Bullets (פרק 4.4):** בכל ז'אנר ובכל קהל, השתמש בבולטים **רק** כשהתוכן הוא רשימה לא מסודרת אמיתית עם פעלים מקבילים, עד 5 פריטים, ללא פיסוק. כל מה שאינו עומד בארבעת התנאים → sentence headline + ויזואל יחיד. הז'אנר משפיע על מידת ההיתר (Technical lecture סלחני יותר מ-TED) אבל הקריטריון התפעולי קבוע.

**סתירה #5 - Redundancy boundary (פרק 4.5):** בכל ז'אנר ובכל קהל, כותרת-משפט קצרה (6-15 מילים) ליד ויזואל לא מפרה את Redundancy Principle - היא Signaling. פסקה על המסך שהדובר קורא בקול - כן מפרה, ובחומרה (d=0.86). זהו ה-threshold שמתיר את שיטת Atkinson קוגניטיבית. תקף גלובלית.

---

### 8.6 פתרון מסודר של שמונה הסתירות

| # | סתירה | הציר המכריע | ההכרעה |
|---|---|---|---|
| 1 | Tufte vs Reynolds (צפיפות) | קטגוריית התוצר (פרק 0) | presentation → Reynolds; slidedoc → Tufte; אם שניהם נדרשים - שני קבצים נפרדים |
| 2 | Atkinson vs Doumont (bullets) | סוג התוכן של השקופית | רשימה לא מסודרת אמיתית עם פעלים מקבילים ≤5 פריטים → Doumont conditional; כל השאר → Atkinson zero-bullets |
| 3 | Tufte vs Reynolds (תמונות) | קהל | Technical → אינפורמטיבית; Broad → מטפורית; Mixed/Executive → מעורב לפי תפקיד התמונה |
| 4 | Duarte vs Atkinson vs Gallo (נרטיב) | משך ז'אנרי | ≤10min pitch → Atkinson; 15-30min keynote → Duarte Sparkline; ≤18min TED → Gallo + Atkinson דחוס |
| 5 | Mayer vs Atkinson (Redundancy) | boundary condition - לא סתירה | כותרת קצרה ליד ויזואל = Signaling, מותר; פסקה + קריאה בקול = Redundancy, פסול |
| 6 | Pyramid vs Storytelling | קהל | Executive/Management → Pyramid (Answer First); הנעה רגשית/Broad → Storytelling; שילוב SCQA→Pyramid נפוץ |
| 7 | Reynolds vs Atkinson (notes) | ז'אנר + לחץ | Keynote/TED/השראה → Reynolds key phrases; Pitch/Sales/Legal/Board → Atkinson ~50 מילים |
| 8 | Kawasaki vs Doumont (טיפוגרפיה) | ז'אנר | Pitch עסקי → Kawasaki 30pt; Technical lecture → Doumont 18-24pt; ברירת מחדל היברידית → 24-28pt עם היררכיה כפולה |

---

### 8.7 כלל אצבע אחד-משפט

**לפני שאתה ניגש לפרק תוכן כלשהו, שאל את המשתמש שני דברים בלבד - איזה ז'אנר ואיזה קהל - ואז קרא את התא הנכון בטבלת 8.3; כל יתר ההחלטות נגזרות משם.**
