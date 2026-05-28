# פרק 4 - Claude-native paths (Desktop / Cowork)
> Snapshot: May 2026

POWER - יש שלושה ערוצים נפרדים שבהם Claude נוגע ב-PPTX מחוץ ל-add-in הרשמי, ואסור לערבב ביניהם. הראשון הוא Cowork על מחשב מקומי (PowerPoint Connector ב-macOS בלבד). השני הוא file creation בתוך chat - sandbox מבודד שמריץ Python ו-Node ומחזיר קובץ להורדה. השלישי הוא chat רגיל שממיר PPTX ל-Markdown כדי לנתח deck קיים. כל ערוץ עם platform, יכולות ומגבלות שונות. ניווט שגוי בין הערוצים הוא הסיבה השכיחה ל-"זה לא עובד אצלי".

## PPTX Skill ו-file creation

- **PPTX Skill הרשמי של Anthropic:** משתמש ב-python-pptx ו-PptxGenJS בתוך code-execution environment. מסלול אלטרנטיבי HTML→PPTX דרך LibreOffice. SKILL.md ב-`github.com/anthropics/skills/blob/main/skills/pptx/SKILL.md`.
- **File creation GA:** 2025-10-21 (preview ספטמבר 2025). דורש הפעלת `Code execution and file creation` ב-Settings → Feature preview.
- **Sandbox:** Python + Node.js מבודדים. אין גישה לפילסיסטם של המשתמש. הקובץ מוחזר כ-download link בתוך השיחה.
- **מגבלת 30MB** לקובץ בודד (קלט ופלט). מצגות עתירות media עלולות להיכשל.
- **API call:** Messages API עם `betas=["code-execution-2025-08-25","skills-2025-10-02"]` ו-`container={"skills":[{"type":"anthropic","skill_id":"pptx","version":"latest"}]}`, מודל `claude-opus-4-7`.
- **PowerPoint Connector ב-Cowork:** זמין בכל ה-paid plans, **macOS only** נכון למאי 2026. Windows עדיין ללא Connector ייעודי ל-PowerPoint דרך Cowork.
- **Cowork timeline:** השקה ב-Mac ינואר 2026, ב-Windows פברואר 2026. רכישת Vercept ב-2026-02-25 חיזקה את computer-use מאחורי Cowork.

## שלושת הערוצים

| ערוץ | פלטפורמה | יכולות | מגבלות | Last verified |
|---|---|---|---|---|
| **(1) Cowork desktop + PowerPoint Connector** | macOS בלבד (Mac+Win Cowork קיים, Connector רק Mac) | יצירת `.pptx` native; הפעלת PPTX Skill אוטומטית; אורקסטרציה מול PowerPoint app פתוח; PDF/Excel input | macOS only; באג AppleScript בקריאת deck פתוח; 30MB limit; דורש paid plan | 2026-05 (support.claude.com, beginnersinai.org) |
| **(2) File creation בתוך chat (sandbox)** | Web + Desktop (Win/Mac/Linux); Free עם Sonnet 4.5, Paid עם Opus | יצירת `.pptx` מאפס דרך python-pptx / PptxGenJS; PDF→deck; brief→deck; Skills loadable; דורש toggle ב-Settings | Sandbox מבודד (אין filesystem access); 30MB limit; אין connection ל-PPT app פתוח; output generic ללא template | 2026-05 (anthropic.com/news/create-files; support.claude.com) |
| **(3) Chat רגיל - PPTX↔Markdown** | Web + Desktop, כל פלטפורמה | ניתוח deck קיים (העלאה→המרה ל-MD); סיכום, תרגום, refactor; **לא** יוצר `.pptx` החוצה ללא ערוץ 2 | אובדן grafic info בהמרה (charts/SmartArt/animations נופלים); text-only fidelity; דורש "round-trip" ידני | 2026-02-18 (brightideasagency); 2026-05 verified by 3-source crossref |

## באג AppleScript ו-workaround

- **התסמין:** Cowork ב-macOS נכשל בקריאת תוכן של deck פתוח דרך AppleScript עם syntax error. כשמבקשים מ-Cowork "תקרא את ה-deck הפתוח ב-PowerPoint", הוא יורד ל-AppleScript bridge וקורס.
- **Single-source:** מקור יחיד - Claude DR ציטוט מ-ryanandmattdatascience.com (Early 2026). לא אומת ב-secondary, לא מופיע ב-support.claude.com.
- **Workaround עיקרי (Anthropic-recommended):** לא לבקש מ-Cowork לקרוא deck פתוח. במקום זה, להוריד את ה-`.pptx`, לסגור את PowerPoint, ולתת ל-Cowork לעבוד על הקובץ כקלט.
- **Workaround נוסף (פרוצדורלי):** ייצוא PPTX דרך chat (ערוץ 3) → המרה ל-Markdown → תיקון בתוך השיחה → ייצוא חזרה דרך file creation (ערוץ 2). מסלול הזה עוקף את AppleScript לחלוטין אבל מאבד fidelity של charts ו-SmartArt.
- **Workaround למשתמשי Windows:** לא רלוונטי - הבאג ספציפי ל-AppleScript bridge ב-macOS. Windows נשען על channel אחר (אבל ה-Connector עצמו לא קיים שם).

**Contested:** Cowork יודע לערוך/לקרוא deck פתוח ב-macOS (Claude DR טוען לא, באג AppleScript) vs. Gemini ו-Perplexity לא מתייחסים לבאג כלל. **Default position:** הצג את שלושת הערוצים כנפרדים; סמן את AppleScript bug כ-`unverified, treat as known-issue` כיוון שזה single-source מ-Claude DR. **Re-verify:** לבדוק ב-support.claude.com/articles ו-github.com/anthropics/claude-code issues ב-Q3 2026 אם הבאג עדיין מתועד או נסגר.

## מה לוודא שוב ב-Q3 2026

- סטטוס AppleScript bug ב-Cowork macOS: האם דווח רשמית, האם תוקן, האם workaround השתנה.
- האם PowerPoint Connector ב-Cowork מתרחב ל-Windows (נכון למאי 2026 - macOS only).
- האם file creation toggle עדיין דורש opt-in ב-Settings, או נכנס כברירת מחדל ב-paid plans.
- האם מגבלת 30MB השתנתה (הוכרזה לראשונה פברואר 2026 ולא עודכנה מאז).

## הפניות צולבות

- פרק 2 (Official integrations) - להפרדה בין add-in רשמי (sidebar ב-PowerPoint) לבין ערוץ 1 כאן (Cowork desktop).
- פרק 5 (MCP servers for PowerPoint) - לחלופות לערוץ 1 ב-Windows (ppt-mcp דרך COM) ולמסלולים שמקיפים את באג AppleScript.
- פרק 8 (Warnings, limitations, contradictions) - לטיפול כולל בסתירות single-source כולל AppleScript bug ו-MC1269241.
