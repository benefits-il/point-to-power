# פרק 8 - Warnings, limitations, contradictions
> Snapshot: May 2026

הפרק הזה מרכז את כל מה שלא עובד, לא נתמך, לא מאומת או לא ידוע ב-KB. הוא משרת את POWER כ-pre-flight check לפני שהוא ממליץ למשתמש על מסלול, ואת היחידה כ-honesty layer שמונע ללמד דברים שיתפוצצו בכיתה. ארבעה חתכים: מגבלות זמינות, פערים טכניים, פערי ידע ב-KB עצמו (טבלת סתירות), ו-single-source claims שצריכים אימות חיצוני.

## (א) מגבלות זמינות

| מגבלה | פירוט | מקור | Last verified |
|---|---|---|---|
| GCC / GCC High / DoD / sovereign cloud | Claude for PowerPoint add-in ו-M365 Copilot עם Claude אינם נתמכים ב-government clouds. אין FedRAMP authorization ל-Anthropic נכון למאי 2026. | שלושת המקורות מסכימים | 2026-05 |
| Mobile (iOS / Android) | התוסף לא רץ ב-PowerPoint Mobile. אין ציר זמן להוספת תמיכה. | שלושת המקורות מסכימים | 2026-05 |
| EU / EFTA / UK - M365 Copilot Anthropic | Off by default ב-tenants ישנים; ב-tenants חדשים אחרי 2026-03-25 ההגדרה On לפי Word/Excel/PowerPoint, אך EU Data Boundary לא חל על עיבוד Anthropic - דרוש opt-in מפורש של Global Administrator. | Claude DR + Perplexity DR + Microsoft Learn | 2026-04-03 |
| Free plan | התוסף לא זמין ב-Free. file creation בתוך chat כן זמין ב-Free עם Sonnet 4.5, אך בלי PPTX Skill מלא. | Stage 1 חלק 1 שורה 1 | 2026-05 |
| Windows / Mac build minima | התוסף דורש Windows build 16.0.13127.20296+ ו-Mac 16.46+. גרסאות ישנות יותר לא ייטענו. | Gemini DR | 2026-05 |

## (ב) פערים טכניים

| פער | פירוט | מקור | Last verified |
|---|---|---|---|
| SmartArt בלי API ב-python-pptx | python-pptx לא תומך ביצירה / עריכה של SmartArt. ה-add-in הרשמי כן יוצר SmartArt דרך Office.js, אבל קוד שיוצר deck דרך Skill / python-pptx ישירות לא יכול. ppt-mcp (ykuwai) כן תומך SmartArt דרך COM. | Perplexity DR (LinkedIn leonfurze) + פרק 5 | 2026-03 |
| Image generation בתוך התוסף | אין יצירת תמונות פנימית בתוסף Claude for PowerPoint. למסלול תמונות צריך לעבור ל-MCP server עם image gen (powerpoint-mcp של Ichigo3766 עם SD, supercurses עם FLUX) או למקור חיצוני. | Claude DR + Gemini DR | 2026-05 |
| Audit logs / Compliance API ל-Team / Enterprise | שלושת המקורות מציינים שחסר, אך אין ציר זמן ל-rollout. ארגונים שדורשים audit log על שימוש בתוסף לא מקבלים פתרון מובנה. | שלושת המקורות (Stage 1 Tier C) | 2026-05 |
| OOXML duplication patterns | python-pptx לא תומך בשכפול שקפים native; הפתרון המומלץ הוא עבודה ב-OOXML XML ישירות. לא חלק מה-Skill הרשמי, דורש כתיבת helper. | Perplexity DR (LinkedIn leonfurze) - single source | 2026-03 |
| PPTX↔Markdown round-trip מאבד charts / SmartArt / animations | ערוץ 3 ב-פרק 4 (chat רגיל) ממיר PPTX ל-Markdown לניתוח, ובחזרה מאבד את כל ה-grafic info. text-only fidelity. | brightideasagency + Perplexity | 2026-02-18 |
| Cowork PowerPoint Connector - macOS only | Connector ייעודי ל-PPT ב-Cowork קיים רק ב-macOS, ושם הוא חוטף את באג AppleScript (ראו חלק ד). Windows ללא Connector. | Claude DR | 2026-05 |
| 30MB limit על קובץ ב-sandbox | מצגות עתירות media עלולות להיכשל ב-file creation. | Gemini DR | 2026-02 |

## (ג) פערי ידע ב-KB - סיכום הסתירות

| # | נושא | פרק שמכיל | סטטוס |
|---|---|---|---|
| 1 | slide-design-pro identity (תוסף / SlideLizard / מתודולוגיית workflow) | פרק 3 | Unresolved (default: not found) |
| 2 | תאריך השקת Claude in PowerPoint research preview (5.2.2026 vs 20.2.2026) | פרק 1 | Resolved-default (5.2.2026 יחד עם Opus 4.6) |
| 3 | באילו plans זמין Claude for PowerPoint (AppSource preview vs GA לכל paid plans) | פרק 1 | Resolved-default (GA לכל paid plans, listing מאחר באזורים) |
| 4 | סטטוס Office-PowerPoint-MCP-Server (GongRzhe) - active vs archive 3.3.2026 | פרק 5 | Needs-verification (single-source Gemini, default: unverified-possibly-archived) |
| 5 | Cowork ועריכת deck פתוח - באג AppleScript ב-macOS | פרק 4 | Needs-verification (single-source Claude DR, default: known-issue, 3 ערוצים נפרדים) |
| 6 | Claude default ב-Copilot ל-PPT לפי MC1269241 | פרק 2 | Resolved-default ("Anthropic enabled by default" ולא "Claude default" עד אימות Message Center) |

## (ד) Single-source claims לסימון

| Claim | מקור יחיד | תאריך מקור | מה צריך כדי לאמת |
|---|---|---|---|
| באג AppleScript ב-Cowork macOS (קריאת deck פתוח קורסת) | Claude DR בלבד (ryanandmattdatascience.com) | Early 2026 | רישום ב-support.claude.com/articles או issue ב-github.com/anthropics/claude-code + reproduction על Mac עם PowerPoint פתוח |
| MC1269241 ("Claude default in Copilot Excel/PPT" 4.5.2026) | cloudswitched.com בלבד | 2026-05-04 | אימות ישיר ב-Microsoft Message Center של tenant פעיל; ניסוח רשמי של ההודעה |
| GongRzhe Office-PowerPoint-MCP-Server - archive read-only מ-3.3.2026 | Gemini DR בלבד | 2026-03-03 | בדיקת github.com/GongRzhe/Office-PowerPoint-MCP-Server - האם ה-repo מסומן "Archived" ב-GitHub UI ומה תאריך commit אחרון |
| Microsoft Build 2026 anticipated PPT announcements (Azure HorizonDB / Foundry IQ pre-announcement) | Perplexity DR בלבד (Claude DR deferred) | 2026-05 (pre-event) | סיקור Build 2026 ב-2-3 ביוני 2026 בערוצים רשמיים (Microsoft blog, techcommunity) |
| PPT Master harness (hugohe3) עם image gen requirement | Claude DR בלבד | 2026-05 | בדיקת github.com/hugohe3/ppt-master README ודרישות runtime |
| OOXML duplication patterns דרך XML ישיר | Perplexity DR בלבד (LinkedIn leonfurze) | 2026-03 | פוסט המקור + repro על deck פעיל |

## מה לוודא שוב ב-Q3 2026

- כל ארבעת ה-single-source claims בטבלה (ד): AppleScript bug, MC1269241, GongRzhe archive, Build 2026 announcements. כל אחד צריך מקור שני או רשמי.
- האם נוספה תמיכה ב-mobile Office (iOS / Android), GCC / GCC High / DoD, ו-Free plan.
- האם EU / EFTA / UK עברו ל-On by default ב-Copilot Anthropic, או שהמצב הדיפרנציאלי נשמר.
- האם audit logs / Compliance API ל-Team ו-Enterprise קיבלו ציר זמן רשמי.

## הפניות צולבות

- פרק 1 (Status snapshot) - לאישור מצב הפיצ'רים ולסתירות 2 ו-3.
- פרק 4 (Claude-native paths) - לפירוט המלא של באג AppleScript, ה-workaround, ושלושת הערוצים.
- פרק 5 (MCP servers) - לסטטוס GongRzhe ולחלופות (ppt-mcp, PPT-MCP, macos-office365-mcp-server).
