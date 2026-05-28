# פרק 3 - Third-party tools landscape
> Snapshot: May 2026

נכון למאי 2026, סביב Claude קיים אקו-סיסטם של כלי PPT חיצוניים בארבעה דפוסי אינטגרציה: Native Connector ב-Claude (Gamma), MCP server ל-Claude Desktop (2Slides), Office Add-in מתחרה (Plus AI, Deckary, SlideLizard, AI Perfect Assistant), וכלים standalone שמייצאים PPTX (Beautiful.ai, NowSlides, SlideSpeak). הטבלה ממפה את הנוף מהזווית של POWER: מה להריץ, איפה זה רץ, כמה זה עולה, ומי הבעלים.

| שם הכלי | סוג integration | רישוי | Output format | מי בעלים | Last verified |
|---|---|---|---|---|---|
| Plus AI | PowerPoint Add-in + Google Slides Chrome extension | Subscription - Basic $10/חודש, Pro/Team/Enterprise מדורגים | PPTX | Third-party (plusai.com) | 2026-05 |
| Gamma | Native Connector ב-Claude (claude.com/connectors/gamma) | Subscription - מסלול חינמי מוגבל, החל מ-$10/חודש | PPTX + HTML (export מ-Gamma) | Third-party עם Connector רשמי ב-Claude | 2026-04-29 |
| 2Slides | MCP server ל-Claude Desktop + REST API | Subscription - API key + תמחור 2Slides | PPTX (downloadUrl) | Third-party (2slides.com) | 2026-04-16 |
| SlideSpeak | Web tool (SaaS חיצוני) | Subscription | PPTX (upload→template→download) | Third-party (slidespeak.co) | 2026-03 |
| Deckary | PowerPoint Add-in | Subscription - $120-180/year ($10-25/חודש) | PPTX | Third-party (deckary.com) | 2026-02 |
| Beautiful.ai | Web tool standalone | Subscription - החל מ-$12/חודש | PPTX (export בלבד, לא native integration) | Third-party (beautiful.ai) | 2026-05 |
| NowSlides | Python micro-framework (YAML→HTML) | Free / Open source | HTML בלבד - לא PPTX | Third-party (iLLucionist / Maxim Laurijssen) | 2026-05 |
| PPT Master (hugohe3) | Claude Code plugin / harness (npx skills add hugohe3/ppt-master) | Free / Open source | PPTX native editable + animations + TTS | Third-party (hugohe3, GitHub) | 2026-05 |
| AI Perfect Assistant | PowerPoint Add-in (Windows installer) | Subscription נפרד מ-Claude | PPTX (insert into slide) | Third-party (perfectassistant.ai) | 2026-05 |
| SlideLizard Creator Business | PowerPoint Add-in (AppSource) | Enterprise licensing | PPTX (asset management) | Third-party (SlideLizard Software GmbH) | 2026-05 |

מבחינת native vs third-party: רק ה-add-in הרשמי "Claude by Anthropic for PowerPoint" נחשב Anthropic-official. מתוך הצד-שלישי, רק שלושה כלים מחזיקים מסלול אינטגרציה רשמי שמוכרז על ידי Anthropic או הספק: Gamma (Native Connector ב-Claude Connectors), 2Slides (MCP server רשום ל-Claude Desktop), ו-Plus AI (תומך Claude כ-provider בתוסף שלו). שאר הכלים (Beautiful.ai, SlideSpeak, Deckary, SlideLizard, AI Perfect Assistant) פועלים דרך chat/API/copy-paste או כ-add-ins עצמאיים שמתווכים מול Claude API בלי הכרה רשמית של Anthropic. NowSlides לא מייצר PPTX בכלל - HTML בלבד.

**Contested:** slide-design-pro identity. Claude DR אומר שלא קיים tool/repo/package בשם המדויק (חיפוש ב-GitHub, npm, AppSource, mcpmarket); Gemini DR מזהה את SlideLizard Creator Business כ-AppSource equivalent; Perplexity DR טוען שזו מתודולוגיית workflow/קורס בווייטנאמית, לא תוסף. **Default position:** not found, treat as unclear. סמן כ-unverified. לא קיים כלי ציבורי בשם המדויק slide-design-pro; ההתאמה הקרובה ביותר בשם היא powerpoint-presentation-pro-2 ב-mcpmarket.com. **Re-verify:** חיפוש ממוקד ב-AppSource + GitHub ב-Q3 2026; אם המשתמש התכוון לכלי ספציפי - לבקש link מדויק במקום שם.

## מה לוודא שוב ב-Q3 2026
- האם Gamma Connector עדיין פעיל ב-claude.com/connectors/gamma ועדיין מתחזק PPTX export ללא עיוותי פריסה.
- האם 2Slides MCP מחזיק תאימות ל-Claude Desktop בגרסת ה-config העדכנית (claude_desktop_config.json schema).
- האם נוסף תוסף חדש בשם slide-design-pro ב-AppSource או ב-GitHub (כרגע unverified, default: לא קיים).
- האם Plus AI שמר על Claude כ-provider לאחר GA של ה-add-in הרשמי של Anthropic (מאי 2026), או שהמודל העסקי השתנה.

## הפניות צולבות
- פרק 2 (Official integrations) - להבחנה בין ה-add-in הרשמי של Anthropic לתוספי הצד-השלישי המתחרים.
- פרק 5 (MCP servers for PowerPoint) - 2Slides MCP מופיע גם שם בהקשר של MCP ל-Claude Desktop.
- פרק 6 (Recommended workflow) - שילוב Gamma Connector ו-2Slides MCP כווריאציות לזרימה הדומיננטית.
