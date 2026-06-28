# פרק 6 - Recommended workflow (end-to-end)
> Snapshot: May 2026

POWER - הזרימה הדומיננטית למאי 2026 היא **MD/outline ב-Cowork → Add-in לעיצוב → Polish ידני**. שלוש סיבות: (א) Cowork מצטיין בייצור outline ארוך, מבוסס מקורות (Skills, Connectors, file inputs) מבלי לפגוע ב-Slide Master של הלקוח; (ב) ה-add-in הרשמי של Anthropic הוא היחיד שמכבד את ה-Slide Master, ה-layouts, ה-fonts וה-color scheme של ה-deck הקיים בלי לרסק אותם ל-PNG; (ג) ה-polish הידני בסוף הוא תמיד 5 עד 10 דקות, לא 90, כי 95% מהעבודה מבנית כבר נעשתה. ארבע וריאציות נוספות מטפלות במקרים שבהם הזרימה הראשית לא מתאימה: יציאה מהירה ל-PPTX (Gamma), עבודה תכנותית מ-CLI (2Slides MCP), עריכה מנותחת לשקף בודד (ppt-mcp), ו-tenant ארגוני שמשלם פעמיים על Claude (Copilot + Claude default).

## Dominant flow

```
                  +----------------------+
   [MD outline]   |   1. Cowork chat     |   structure + content
   [PDF / Excel]  |   (Win or Mac)       |   ----------------------> [generic .pptx download]
   [brief prose]  |   Sonnet 4.6/Opus    |
                  +----------------------+
                                                   |
                                                   v
                  +----------------------+
   [client deck]  |   2. Claude for PPT  |   Slide Master + brand
   [.pptx with    |   add-in (sidebar)   |   ----------------------> [branded .pptx]
   Slide Master]  |   Opus 4.7           |
                  +----------------------+
                                                   |
                                                   v
                  +----------------------+
                  |   3. Manual polish   |   typos, anim, embed
                  |   (PowerPoint app)   |   ----------------------> [final .pptx]
                  +----------------------+
```

קריטריונים לבחירת המסלול הראשי: יש Slide Master ארגוני, נדרשים native PowerPoint objects (charts, diagrams editable), נמצא ב-paid plan, לא חייב להישאר ב-CLI. אם אחד מהארבעה לא מתקיים - פנה לוריאציה הרלוונטית.

## וריאציה א - Gamma Connector

מתאים כש-POWER חייב deck יפה ועיצובי תוך 90 שניות, ללא Slide Master ייחודי, ועם נכונות לוותר על native PowerPoint objects (Gamma מייצא PNG-based slides עם פריסה).

```
                  +----------------------+
   [topic prompt] |   Claude chat        |   call Gamma Connector
                  |   /connectors/gamma  |   ----------------------> [Gamma URL]
                  +----------------------+
                                                   |
                                                   v
                  +----------------------+
                  |   Gamma editor (web) |   manual tweaks (אופציונלי)
                  |   gamma.app          |   ----------------------> [PPTX export]
                  +----------------------+
```

טרייד-אוף: מהירות מקסימלית, fidelity נמוך לעיצוב הארגוני, נדרש מנוי Gamma פעיל. שימוש חוזר ל-Skills או Connectors אחרים בתוך ה-deck לא אפשרי - היציאה היא PPTX סטטי.

## וריאציה ב - 2Slides MCP מ-Claude Code

מתאים כש-POWER עובד ב-Claude Code (CLI), צריך לייצר deck מתוך data structured (CSV, JSON, DB query), ורוצה שה-deck יישמר אוטומטית למסלול בפרויקט.

```
                  +----------------------+
   [data file]    |   Claude Code        |   call 2Slides MCP tool
   [.csv .json]   |   .mcp.json registers|   ----------------------> [downloadUrl]
                  |   2Slides server     |
                  +----------------------+
                                                   |
                                                   v
                  +----------------------+
                  |   curl / wget        |   save .pptx locally
                  |                      |   ----------------------> [data-deck.pptx]
                  +----------------------+
```

טרייד-אוף: סקריפטי מאוד, מצוין ל-batch generation (10 דוחות שבועיים), פחות מתאים ל-narrative deck ידני. דורש 2Slides API key.

## וריאציה ג - ppt-mcp ל-edits מדויקים

מתאים כש-POWER מקבל deck קיים ונדרש שינוי ממוקד בשקף N (החלפת טקסט, swap של chart, עדכון פריסה) בלי לגעת בשאר ה-deck.

```
                  +----------------------+
   [open .pptx    |   Claude Desktop     |   ppt-mcp drives PowerPoint
    in PowerPoint]|   ppt-mcp connected  |   via COM (Windows only)
                  |   154 tools          |   ----------------------> [edited .pptx in-place]
                  +----------------------+
                                                   |
                                                   v
                  +----------------------+
                  |   Save in PowerPoint |
                  |   (Ctrl+S)           |   ----------------------> [final .pptx]
                  +----------------------+
```

טרייד-אוף: דיוק כירורגי, רק Windows (COM), דורש PowerPoint פתוח. הכי טוב לתיקונים אחרי שה-add-in הרשמי "כמעט הצליח" אבל פספס שקף ספציפי.

## וריאציה ד - Copilot + Claude default

מתאים לארגון שכבר משלם על M365 Copilot ($30/user/חודש), שבו tenant הוא commercial cloud (לא EU/EFTA/UK שמצריך opt-in), והמשתמש לא רוצה תוסף נוסף. מאי 2026 - Claude הוא default model ב-PowerPoint Copilot באזורים שבהם Anthropic מופעל.

```
                  +----------------------+
   [user prompt   |   Copilot pane in    |   routes to Claude
    in slide]     |   PowerPoint         |   (no model picker UI)
                  |   Microsoft-owned    |   ----------------------> [in-slide content]
                  +----------------------+
```

טרייד-אוף: zero install ל-end-user, אבל אין Skills/Connectors של Anthropic, אין בחירת מודל, billing דרך Microsoft ולא דרך Claude. הארגון משלם פעמיים אם יש גם מנוי Claude Team/Enterprise פעיל - בדוק לפני rollout.

## מה לוודא שוב ב-Q3 2026

- האם Cowork PowerPoint Connector הורחב מ-macOS ל-Windows (כרגע macOS only).
- האם ppt-mcp הוסיף תמיכה ב-macOS דרך AppleScript bridge או דרך PPTX file-mode.
- האם Gamma Connector הוסיף יציאה native editable (לא PNG) ל-PowerPoint objects.
- האם Microsoft פרסם UI לבחירת מודל ב-Copilot PowerPoint (כרגע אין picker).

## הפניות צולבות

- פרק 4 - Claude-native paths: פירוט הערוצים של Cowork מאחורי הזרימה הראשית.
- פרק 5 - MCP servers: ppt-mcp ו-2Slides MCP כ-tools בוריאציות ב' ו-ג'.
- פרק 7 - POWER instruction templates: פרומפטים מוכנים לכל אחד מהמסלולים כאן.

---

# פרק 7 - POWER instruction templates
> Snapshot: May 2026

POWER - שישה templates מוכנים להעתקה. כל template מתאים לאחד המסלולים מפרק 6. ה-template הקבוע: When to use, Required context, Prompt (ready-to-paste), Expected output, Common failures. הפרומפטים נכתבו באנגלית כי הם פונים ל-Claude כסוכן ביצוע, לא ל-end-user.

## Template 1: Cowork MD outline to first-draft .pptx

**When to use:** יש לך outline ב-Markdown או brief טקסטואלי, ואתה רוצה first-draft `.pptx` תוך פחות מ-3 דקות, בלי Slide Master ארגוני (זה שלב הראשון לפני ה-polish ב-add-in).

**Required context:** Cowork פעיל (Mac או Windows), paid plan, file creation toggle פעיל ב-Settings, MD content מצורף או paste בתוך הצ'אט.

**Prompt:**
```
Generate a first-draft .pptx from the outline below.

Requirements:
- 1 slide per H2 heading in the MD
- Title slide from the first H1
- Bullets become native PowerPoint bullet text (not images)
- Charts: if the bullet starts with "Chart:" interpret the next list as data and generate a native editable chart (column unless specified)
- Speaker notes: one short paragraph per slide, derived from the bullet context
- Output: a single .pptx file under 30MB, downloadable

Do not add design themes. Use the default Office theme. I will run a brand polish pass after.

Outline:
[PASTE MD HERE]
```

**Expected output:** קובץ `.pptx` בודד, ~1MB, generic Office theme, bullets editable, charts editable, speaker notes per slide. ניתן לפתוח ב-PowerPoint Win/Mac/Web.

**Common failures:** (1) הקובץ עובר 30MB אם המשתמש הכניס תמונות PDF embedded - Claude יחזיר שגיאה. פתרון: הסר תמונות מה-MD. (2) Charts מ-"Chart:" מתפרשים לא נכון אם הנתונים לא בטבלת MD תקנית - הוסף `| header | header |` שורה ראשונה. (3) Cowork ב-macOS עלול ליפול ל-AppleScript bridge אם PowerPoint פתוח ברקע - סגור את PowerPoint לפני הריצה.

## Template 2: Add-in brand polish pass

**When to use:** יש לך first-draft `.pptx` (מ-Template 1 או מקור אחר) ו-deck ארגוני קיים עם Slide Master, ואתה רוצה שה-add-in הרשמי יחיל את ה-brand על ה-draft.

**Required context:** Claude for PowerPoint add-in מותקן (AppSource), המשתמש מחובר לחשבון Claude paid, ה-`.pptx` של ה-draft פתוח, ויש לך גישה ל-template ארגוני (קובץ `.potx` או `.pptx` עם Slide Master מוגדר).

**Prompt (הקלד בסרגל הצד של ה-add-in):**
```
Polish this deck using my brand.

Brand source: [attach company-template.potx OR paste link to brand guide]

Apply on every slide:
- Slide Master from the attached template (use Layout 1 for title, Layout 2 for content, Layout 5 for charts)
- Replace default Office fonts with the brand fonts defined in the master
- Map color references: primary -> brand primary, accent -> brand accent
- Keep all native PowerPoint objects editable (do not rasterize charts or diagrams)
- Keep all speaker notes intact
- Do not change the wording. Do not add or remove slides.

Report at the end: list of slides where the Slide Master could not be applied cleanly and why.
```

**Expected output:** אותו deck, אותם תכנים, אבל עם Slide Master ארגוני, fonts ו-colors מהמותג, charts editable. בסוף - דיווח של שקפים שבהם נפלה החלת ה-master.

**Common failures:** (1) שקפים עם custom layout שלא קיים ב-master מתקבלים בלי שינוי. פתרון: מפה אותם ל-layout קיים בידיים. (2) Fonts לא מוחלפים אם ה-Slide Master משתמש ב-"Theme Font" מתקדם - הגדר ידנית. (3) ה-add-in לא מבצע batch על יותר מ-50 שקפים בריצה אחת - חלק לשתי ריצות.

## Template 3: ppt-mcp targeted slide edit

**When to use:** PowerPoint פתוח ב-Windows, יש שינוי ספציפי לשקף N (החלפת טקסט, החלפת chart data, swap של תמונה) שאתה רוצה שיתבצע בדיוק ובלי לגעת ביתר השקפים.

**Required context:** Claude Desktop ב-Windows, ppt-mcp רשום ב-`claude_desktop_config.json` (ראו פרק 5), PowerPoint פתוח עם ה-deck המבוקש, PPT_AUTO_DISMISS_DIALOG=true.

**Prompt:**
```
Use ppt-mcp tools to apply the edit below to the currently open PowerPoint deck.

Slide: 7
Edit type: replace chart data
Current chart: column chart titled "Q1 revenue"
New data:
| Region | Revenue (M USD) |
| North  | 12.4            |
| South  | 8.7             |
| EMEA   | 15.2            |
| APAC   | 9.1             |

Constraints:
- Do not touch slides 1-6 or 8-end
- Keep chart type (column), keep title, keep position and size
- Use brand accent color for North if defined in theme, otherwise default
- After the edit, save the deck and report the change

If a dialog blocks the COM call, auto-dismiss and retry once.
```

**Expected output:** Chart בשקף 7 מתעדכן in-place, יתר השקפים ללא שינוי, deck נשמר. דיווח טקסטואלי על הפעולה והשגיאות (אם היו).

**Common failures:** (1) RPC_E_CALL_REJECTED אם PowerPoint פתח dialog modal (Save As, Find) - הפעל PPT_AUTO_DISMISS_DIALOG. (2) המספור של slide משתנה אם המשתמש מחק שקף בין הריצות - תמיד תוודא slide index לפני edit. (3) ppt-mcp Windows-only - על macOS השתמש ב-macos-office365-mcp-server של vAirpower או עבור לערוץ file-mode.

## Template 4: Gamma Connector structured deck

**When to use:** דרוש deck יפה ומהיר, נושא ידוע, אין צורך ב-Slide Master ארגוני, ו-POWER מוכן לוותר על native editable PowerPoint objects לטובת יציאה PNG-based של Gamma.

**Required context:** Gamma Connector מופעל ב-claude.com/connectors/gamma, מנוי Gamma פעיל (לפחות $10/חודש), Claude chat (לא Cowork ולא add-in).

**Prompt:**
```
Use the Gamma connector to build a 12-slide deck on the topic below, then export to PPTX.

Topic: [TOPIC]
Audience: [exec / technical / sales]
Tone: [formal / energetic / analytical]
Structure required:
1. Title + one-line value prop
2. Problem statement (3 bullets)
3. Market sizing (single big number + source)
4. Solution overview (3-column compare)
5-8. Four deep-dive slides, one per pillar
9. Customer evidence (quote + logo grid)
10. Pricing (3-tier table)
11. Roadmap (timeline)
12. Call to action + contact

Constraints:
- Use Gamma's "Professional" theme
- Embed the brand color [#HEXVALUE] as accent
- Return the Gamma URL first, then trigger PPTX export and return the download link
```

**Expected output:** קישור ל-Gamma deck לעריכה ידנית אופציונלית, ולאחר מכן קישור הורדה ל-`.pptx`. ה-PPTX יכיל את 12 השקפים בסדר המבוקש, theme של Gamma, ויהיה PNG-heavy.

**Common failures:** (1) Gamma Connector לא מחובר - Claude יחזיר "connector unavailable", הפנה את המשתמש ל-connectors page. (2) PPTX export מ-Gamma מאבד אנימציות native של PowerPoint, ה-deck נראה רק PNG. (3) Gamma מגביל decks ארוכים בחבילה החינמית - מעל 10 שקפים דורש paid plan.

## Template 5: 2Slides MCP data to chart slide

**When to use:** יש לך CSV או JSON, אתה עובד ב-Claude Desktop או Claude Code, ואתה צריך שקף בודד (או רצף) שמתרגם את הדאטה ל-chart מעוצב עם כותרת ו-takeaway.

**Required context:** 2Slides MCP רשום ב-config (`.mcp.json` או `claude_desktop_config.json`), 2Slides API key פעיל, הדאטה מצורף או נמצא בקובץ במערכת.

**Prompt:**
```
Use the 2Slides MCP to generate a single-slide PPTX containing a chart from the data below.

Data source: [paste CSV or file path]
Chart type: stacked bar
X axis: Quarter (Q1-Q4)
Y axis: Revenue, in millions USD
Series: Product A, Product B, Product C
Title: "Quarterly revenue by product, 2025"
Subtitle: "Source: internal finance, May 2026"
Takeaway box at bottom: "Product C overtook A in Q4 by 8% margin"

Output:
- Single .pptx (1 slide), 16:9
- Theme: minimal, neutral palette
- Return the downloadUrl
```

**Expected output:** קובץ `.pptx` חד-שקפי עם stacked bar chart, כותרות, takeaway box, ערכים מספריים מדויקים מה-CSV.

**Common failures:** (1) ה-CSV עם separators לא תקניים (semicolon במקום comma) - 2Slides עלול לפרסר לא נכון, השתמש בפורמט סטנדרטי. (2) downloadUrl יוצא expired אחרי 24 שעות - הורד מיד. (3) אם הדאטה גדול מ-1000 שורות, 2Slides עלול לחתוך - aggregate לפני שליחה.

## Template 6 (bonus): python-pptx in Claude Code

**When to use:** POWER עובד ב-Claude Code, נדרש build תכנותי מלא של deck (לדוגמה: dashboard שבועי, 50 דוחות אישיים, deck שמתעדכן מ-DB query), ויש דרישה ל-version control על ה-script שבונה את ה-deck.

**Required context:** Claude Code פעיל בפרויקט, `python-pptx` מותקן (`pip install python-pptx`), קובץ template `.pptx` אופציונלי, נתונים זמינים כקבצים או דרך MCP.

**Prompt:**
```
Build a Python script using python-pptx that generates the deck described below. Run it and return the resulting .pptx path.

Deck spec:
- Slide 1: Title "Weekly Ops Review" + date in subtitle (today)
- Slide 2: KPIs table (4 metrics, 2 columns: name + value), values pulled from ./data/weekly.json
- Slide 3: Trend chart (line, last 8 weeks) from same JSON
- Slide 4: Top incidents (3 bullets) from ./data/incidents.json, sorted by severity desc
- Slide 5: Action items (numbered list) from ./data/actions.json

Constraints:
- Use template file ./assets/brand-template.pptx if it exists, otherwise default Office theme
- Slide dimensions: 16:9 widescreen
- All text frames must autofit
- Save output to ./out/weekly-YYYY-MM-DD.pptx
- Make the script idempotent (re-running on the same day overwrites)

After running, list the slide titles and a one-line summary per slide to confirm.
```

**Expected output:** קובץ `.py` בפרויקט, ריצה מוצלחת, קובץ `.pptx` ב-`./out/`, ודיווח של 5 שקפים עם summary. ניתן ל-schedule דרך cron או GitHub Action בהמשך.

**Common failures:** (1) `python-pptx` לא תומך ב-SmartArt API - אם נדרש diagram מתקדם, צור אותו ב-add-in הרשמי או ב-ppt-mcp. (2) Template חסר Slide Layout שהסקריפט פונה אליו - הסקריפט יקרוס, הוסף try/except על `slide_layouts[N]`. (3) Charts מורכבים (combo, secondary axis) חלקיים ב-`python-pptx`, הפתרון: השלם ידנית ב-PowerPoint או עבור ל-PptxGenJS דרך PPTX Skill.

## מה לוודא שוב ב-Q3 2026

- האם Anthropic פרסמה official template library ל-add-in (כרגע Skills ב-preview).
- האם Gamma Connector תומך ב-PPTX export עם native editable objects (כרגע PNG-based).
- האם 2Slides MCP הוסיף תמיכה ב-streaming של datasets גדולים מעל 1000 שורות.
- האם python-pptx הוסיפו SmartArt API (כרגע פער ידוע, last release 2023 לפי Perplexity).

## הפניות צולבות

- פרק 6 - Recommended workflow: כל template משויך למסלול שם.
- פרק 4 - Claude-native paths: רקע על Cowork ו-PPTX Skill מאחורי Template 1 ו-6.
- פרק 5 - MCP servers: config מלא ל-ppt-mcp (Template 3) ול-2Slides MCP (Template 5).
