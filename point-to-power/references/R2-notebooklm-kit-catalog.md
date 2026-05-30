# R2 - NotebookLM Kit Catalog

**Snapshot:** May 2026
**Purpose:** המקור הסמכותי שממנו `point-emit-notebooklm-kit` מרכיב את ערכת ה-NotebookLM שנדחפת למשתמש מיד אחרי ה-intake. הקובץ עונה על שלוש שאלות: מה כל artifact מפיק ומתי, איך כותבים פרומפט טוב, ואיזו ערכה להרכיב לכל סוג מצגת. R2 הקיים (ch11/ch12/addons) נשאר תקף ומשלים את הקובץ הזה; כאן מרוכז מה ש-Point צריך כדי לפלוט ערכה שלמה בפעימה אחת.

> **עיקרון מנחה:** NotebookLM הוא מנוע מחקר והעמקה, לא מדפסת לתוצר סופי. הערכה גורמת לתוכן האמיתי לזרום חזרה אל Point (competitor comparison, המדע, הקשר שוק) במקום להישאר ניחושים. כל פרומפט בערכה מוכן-להעתקה ומתויג במטרתו.

---

## חלק 1 - קטלוג Studio artifacts

לכל artifact: מה מפיק, מתי הכי מתאים, ומגבלה מהותית. דרגות tier ומגבלות מבוססות פרק 11 (limitations-flags). פריטים שסומנו Tier B = מקור יחיד/לא מאומת, חובה להוסיף הסתייגות בפרומפט.

| Artifact | מפיק | מתי להשתמש | מגבלה מהותית |
|---|---|---|---|
| **Audio Overview - Brief** | אודיו פודקאסט קצר (~3-5 דק), MP3 + תמליל | חימום קהל, אוריינטציה מהירה למסמך ארוך | עברית: איכות TTS לא נבדקה ב-2026 (`rtl-audio-weak`, `hebrew-quality-tier-c`) |
| **Audio Overview - Deep Dive** | אודיו ~20-30 דק, 2 מנחים | העמקה אחרי שהבנת מסגרת; למידה תוך כדי נסיעה | אין תקרת אורך מובטחת; עברית כנ"ל |
| **Video Overview - Standard** | MP4 5-10 דק עם watermark, 8 סגנונות חזותיים | הפצה לסושיאל/יוטיוב, קהל לא-מומחה | watermark נשאר (אלא Ultra); 80 שפות כולל עברית |
| **Video Overview - Cinematic** | MP4 4-5 דק באיכות פרודקשן (Veo 3) | תוכן בתשלום, מיצוב פרימיום | **EN בלבד** (28/05/2026); דורש Pro+ (`pro-tier-required`) |
| **Mind Map** | דיאגרמה היררכית אינטראקטיבית, ענפים לחיצים | סקירת 3+ מושגים מקושרים, מבט-על על notebook גדול | אין שליטה ישירה במבנה דרך פרומפט; view-only באפליקציה |
| **Infographic** | PNG יחיד, 10 סגנונות (Professional/Scientific/Bento/Timeline...) | תמונה אחת שמסכמת, פוסט סושיאל | PNG בלבד (אין וקטור); Anime ב-18+ |
| **Slide Deck** | ייצוא PPTX/PDF, נערך אחרי הייצוא | בסיס למצגת רשמית, דוח בורד | Slide revisions פר-שקופית קיים, אבל **אי אפשר להוסיף/למחוק שקופיות**; watermark (אלא Ultra) |
| **Briefing Doc** | מסמך טקסט (Reports family) | תקציר מנהלים, decision memo, עדכון exec | לא נערך ישירות; עברית ארוכה → `hebrew-quality-tier-c` |
| **FAQ** | שאלות-תשובות מתוך המקורות | onboarding, anticipating audience questions | אין tile נפרד מאז 02/2026; דרך Custom Report או chat |
| **Study Guide** | מדריך למידה מובנה + glossary | workshop/הרצאה עם עומק, הכנה למבחן | טקסט, לא נערך ישירות |
| **Timeline** | רצף אירועים כרונולוגי (תת-סוג Report) | סיפורי היסטוריה, roadmap, התפתחות | תת-סוג של Report, לא tile עצמאי |
| **Quiz** | שאלות רב-ברירה + הסבר + ציטוט מקור | self-assessment, checkpoint ידע | רב-ברירה בלבד, אין קוד/חיבור |
| **Flashcards** | כרטיסיות spaced-repetition | חזרה פעילה, מינוח | טקסט בלבד; ייצוא CSV תלוי-tier (Tier B) |
| **Custom Report** | סינתזה מותאמת לפי פרומפט חופשי | literature review, מיפוי סתירות, deep-dive נושאי | חופש מלא דרך הפרומפט; ברירת מחדל ללא תקרה |

**שתי הערות חוצות-artifact:**
- **עברית באודיו/וידאו:** היכולת נתמכת, האיכות לא אומתה ב-2026. תמיד צרף `rtl-audio-weak` ל-Audio/Video כש-`language` הוא `he` או `mixed`, ובקש מהמשתמש להאזין לדגימה לפני הפצה.
- **אין עריכה ישירה** (חוץ מ-Slide revisions): פלט חלש מתוקן ב-regenerate עם פרומפט מדויק יותר, או export ועריכה חיצונית. 30 שניות בפרומפט חוסכות 10 דקות עריכה.

---

## חלק 2 - איך כותבים פרומפט טוב ל-NotebookLM

חמישה כללים, מבוססי ראיות מהמחקר (claude.md §6, blog.google, godofprompt.ai):

1. **פעולה קודם, לא תיאור.** פתח בפועל: "צור Briefing Doc שמנתח...", "הפק תקציר אודיו...", "בנה Mind Map ש...". לא "ספר לי על X".
2. **ציין קהל.** "לקהל לא-מומחה", "למשקיע seed", "לסטודנט שנה א'". NotebookLM מכייל טון ועומק לפי הקהל.
3. **קבע היקף מספרי.** "10 שקופיות מקסימום", "3 ענפים, עד 4 צמתים בכל אחד", "באורך 5 דקות", "2000 מילה מקסימום". מספר מדויק מעגן את המודל.
4. **אמור מה לכלול ומה להשמיט.** "התמקד ב-X בלבד", "התעלם מאנקדוטות צדדיות", "אל תחשוף את הדמו של שקופית 4". include + exclude ביחד.
5. **קבע קול ומבנה כשרלוונטי.** "בסגנון McKinsey: כל כותרת היא משפט פעולה, מקס 3 בולטים"; "בנימה ישירה, בלי 'אולי' או 'ייתכן'"; "כל סתירה בין מקורות עם ציטוט לכל צד".

**מה נכשל (אל תבקש):** שאילתות web בזמן אמת מתוך chat (Deep Research מוסיף מקורות, לא שואל live); עריכת שורה ספציפית בפלט קיים; חישוב אריתמטי; יצירת תמונות inline ב-chat; איחוד נתונים מ-2+ notebooks (צריך לאחד מקורות מראש).

**אורך פרומפט:** עד ~300 תווים לפרומפט בערכה. תמציתי וצפוף עדיף על מלל.

---

## חלק 3 - Source ingestion + Deep Research / Discover Sources

### פורמטי מקור נתמכים (עד 500k מילה / מקור)
PDF, Google Docs/Slides/Sheets, DOCX, PPTX, CSV, TXT/MD, EPUB, Web URL (טקסט בלבד), YouTube (תמליל, דורש כתוביות), קבצי אודיו (תמלול אוטומטי), טקסט מודבק (~900k תווים), תמונות (OCR), Gemini chats (2-way sync).
**לא נתמך:** קובץ MP4 מקומי (המר ל-YouTube URL או תמלל ל-TXT).

### מסמך המקור שהמשתמש מעלה
Point מרכיב מהתוכן הגולמי **מסמך מקור נקי אחד** (`prompts/01-source-document.md`) שהמשתמש מעלה ל-NotebookLM כ-source. זה הזרע: כל ה-artifacts וה-chat ימשכו ממנו. המסמך כולל את כוונת המצגת, הקהל, ונקודות התוכן הגולמיות בצורה מסודרת.

### Discover Sources / Deep Research (איסוף מקורות חיצוניים)
ב-Sources panel → טאב Discover. **Fast Research** ~30 שניות, ~10 מקורות. **Deep Research** ~5 דקות, ~40 מקורות (web בלבד). מכסות: Free 10/חודש, Pro 75/חודש.

תבניות מוכנות-להדבקה (התאם את הסוגריים לנושא):

- **הרחבת ידע:** "Run Deep Research for '2024-2026 advances in [נושא]'. Import research papers and industry reports. Exclude opinion pieces."
- **ניתוח תחרותי:** "Deep Research on 'competitors to [מוצר] as of 2026'. Return pricing, feature comparisons, and market positioning."
- **אימות טענות:** "Run Deep Research on [טענה מהמסמך]. Return sources that corroborate or refute it, ranked by recency and author credibility."

---

## חלק 4 - תבניות פרומפט פר-artifact (מוכנות-להעתקה)

כל תבנית עצמאית. עברית כברירת מחדל; אם `language: en`, תרגם והשמט "בעברית". החלף `[סוגריים]` בערכים מה-intake.

**Audio Overview - Brief:**
```
הפק תקציר אודיו קצר באורך 3 דקות מהמקורות, בעברית, בנימה רגועה ומדויקת.
התמקד ב-[הטענה המרכזית] ובשלוש הנקודות החשובות. סיים בשורה אחת שמחברת הכל.
```

**Audio Overview - Deep Dive:**
```
הפק Deep Dive אודיו מהמקורות, בעברית. כסה את [הנושא] לעומק, כולל הנחות יסוד
ושאלות פתוחות. הסבר כל מונח טכני לפני שאתה ממשיך.
```

**Standard Video Overview:**
```
Create a Standard Video Overview for a non-expert audience. Lead with the single
most surprising finding. Cover three main points with concrete examples. Close with
one practical takeaway. Visual style: [Whiteboard/Classic].
```

**Mind Map:**
```
בנה Mind Map בעברית שמתחיל בשורש "[המוצר/הנושא]" ומסתעף ל-[3] ענפים:
[ענף 1], [ענף 2], [ענף 3]. כל ענף עד 4 צמתים. תמצות בלבד, בלי משפטים מלאים.
```

**Infographic:**
```
צור Infographic בסגנון [Professional/Bento Grid]. התמקד ב-5 נקודות הנתונים
החשובות, היררכיה ויזואלית לפי חשיבות. כותרת מובילה אחת, שלוש נקודות תמיכה,
קריאה לפעולה אחת. 30% white space מינימום. בלי קישוט שלא נושא מידע.
```

**Slide Deck (McKinsey discipline):**
```
Design a slide deck from the sources, [10] slides max. Rules: every slide title is
an action statement, not a topic label. Max 3 bullets per slide, each with one
specific data point or named example. Final slide: one bold recommendation. Export PPTX.
```

**Briefing Doc:**
```
צור Briefing Doc מהמקורות: תקציר מנהלים, ממצאי מפתח ב-3 בולטים, המלצות עם נימוק,
וסיכונים פתוחים. התמקד בתובנות מעשיות, דלג על רקע מבואי.
```

**FAQ (דרך Custom Report):**
```
צור Custom Report בפורמט FAQ: 8 השאלות שקהל [הקהל] ישאל על [הנושא],
כל תשובה עד 3 משפטים עם ציטוט מקור. סדר מהשאלה הבסיסית למתקדמת.
```

**Study Guide:**
```
צור Study Guide מהמקורות: מושגי מפתח, הגדרות, ושאלות סבירות. כלול סעיף glossary.
```

**Timeline (דרך Custom Report):**
```
צור Custom Report בפורמט Timeline: רצף האירועים של [הנושא] לפי תאריך,
כל נקודה עם משפט הקשר אחד. סמן את שלוש נקודות המפנה.
```

---

## חלק 5 - לוגיקת הרכבת הערכה

הערכה **תמיד** כוללת שלושה מרכיבי-ליבה, ואז 1-3 artifacts של Studio לפי (genre, audience, language, intent). הסקיל פולט הכל בפעימה אחת, כל קובץ מתויג במטרתו.

**מרכיבי ליבה (תמיד):**
1. `01-source-document.md` - מסמך המקור הנקי להעלאה (חלק 3).
2. `02-deep-research.md` - פרומפט Discover/Deep Research לאיסוף ההקשר החיצוני שהמצגת צריכה (תחרות, מדע, שוק).
3. `00-INDEX.md` - מסביר את הערכה, באיזה סדר להריץ, ולאן לשמור כל תוצר חוזר (`content/`).

**בחירת Studio artifacts לפי genre:**

| genre | ערכה מומלצת (Studio) | סיבה |
|---|---|---|
| `pitch` (קצר) | Audio Overview - Brief + Mind Map | חימום משקיעים + מבט-על מוצר. בלי Video אם יש דמו חי. |
| `keynote` / `ted` | Audio Brief + Infographic | חידוד המסר + ויזואל אחד חזק להפצה. |
| `lecture` / `workshop` | Study Guide + Mind Map + Briefing Doc | עומק, מפת מושגים, חומר קריאה. |
| `sales` | Briefing Doc + Standard Video Overview | מסמך החלטה + סרטון לקהל שלא הגיע. |
| `briefing` | Briefing Doc + Infographic | תקציר exec + סנאפשוט ויזואלי. |
| `demo` | Infographic + Audio Brief | תמונת סיכום + חימום, בלי Video שמתחרה בדמו. |

**כללי דיוק:**
- **אל תכלול artifact בלי סיבה.** עדיף ערכה ממוקדת מ-5 פרומפטים רפויים.
- **התאם warnings בכל artifact:** עברית + Audio/Video → `rtl-audio-weak`; עברית ארוכה → `hebrew-quality-tier-c`; Cinematic/feature שדורש Pro → `pro-tier-required`; נתונים שמתיישנים → `stale-watch`.
- **דמו חי בדק → אל תכלול Video של הדמו** (מבטל את הדמו). Video של הפתיחה לקהל שלא הגיע - בסדר.
- **output_type teleprompter → בדרך כלל ללא Studio artifacts** (התוכן לדובר, לא לקהל); הליבה (מסמך מקור + Deep Research) עדיין רלוונטית למחקר.
