# פרק 1 - Status snapshot Q2 2026
> Snapshot: May 2026

תמונת מצב נכון למאי 2026: Anthropic סגרה בתוך פחות מארבעה חודשים את כל המסלול מ-research preview ועד General Availability של Claude for PowerPoint. הציר נראה כך: ב-5 בפברואר 2026 שוחרר התוסף כ-research preview ל-Max, Team ו-Enterprise במקביל להכרזת Opus 4.6; בסוף פברואר 2026 נפתח גם ל-Pro ($20 לחודש); ב-7 במאי 2026 הוכרז GA לחבילה המלאה Claude for Excel, PowerPoint ו-Word על כל ה-paid plans, יחד עם Outlook ב-public beta. במקביל, Microsoft הצהירה במאי 2026 על Claude כברירת מחדל ב-Copilot ל-Excel ול-PowerPoint לפי הודעת MC1269241 ב-Message Center, באזורים שבהם Anthropic מופעל.

הפלטפורמות הנתמכות כוללות את שלושת ערוצי PowerPoint העיקריים: Windows (build 16.0.13127.20296 ואילך), macOS (16.46 ואילך) ו-PowerPoint on the web. mobile (iOS, Android) ו-government clouds (GCC, GCC High, DoD, sovereign) אינם נתמכים. בתוך התוסף ניתן להחליף בין Sonnet 4.5, Sonnet 4.6, Opus 4.6 ו-Opus 4.7, כאשר Opus 4.7 הוכרז ב-Microsoft 365 Copilot ב-16 באפריל 2026 (Cowork Frontier, Studio early release, Copilot in Excel).

| פיצ'ר | סטטוס נכון למאי 2026 | Plans | Last verified |
|---|---|---|---|
| Claude for PowerPoint add-in | GA | כל paid plans | 2026-05-07 |
| Sonnet 4.5/4.6, Opus 4.6/4.7 בתוסף | זמין, מתחלף | כל paid plans | 2026-05 |
| M365 Copilot עם Claude default | Live (commercial cloud) | E3/E5/E7 עם Copilot | 2026-05-04 |
| Windows / Mac / Web | נתמך | - | 2026-05 |
| Mobile / GCC / DoD | לא נתמך | - | 2026-05 |

**Contested:** Claude DR ו-Perplexity מציינים 5.2.2026 כתאריך השקת ה-research preview vs Gemini שמציין 20.2.2026. **Default position:** 5.2.2026 כתאריך השקה (יחד עם Opus 4.6), 20.2 הוא ככל הנראה תאריך build רחב יותר או הרחבת זמינות. **Re-verify:** Anthropic press release מ-5.2.2026 + Medium ו-gHacks coverage.

**Contested:** GA לכל paid plans נכון למאי 2026 vs AppSource listing באזורים מסוימים שעדיין מציג preview-only ל-Max/Team/Enterprise. **Default position:** GA לכל paid plans נכון למאי 2026, אך listing באזורים מסוימים עדיין מציג preview-only. **Re-verify:** AppSource listing פר-region ו-Anthropic Help Center.

## מה לוודא שוב ב-Q3 2026
- האם תוספת תמיכה ב-mobile Office (iOS, Android).
- האם Skills בתוך התוסף יצא מ-preview ופורסמה רשימת Skills רשמיים.
- האם הסטטוס של GCC/GCC High/DoD משתנה לאחר FedRAMP authorization.
- האם Microsoft Build 2026 (2-3 ביוני) הוסיף הכרזות PowerPoint-ספציפיות.

## הפניות צולבות
- פרק 2 - Official integrations: פירוט שני המסלולים הרשמיים.
- פרק 4 - Claude-native paths: ערוץ Cowork ו-PPTX Skill.
- פרק 8 - Warnings: מגבלות זמינות וגיאוגרפיה.

---

# פרק 2 - Official integrations
> Snapshot: May 2026

קיימים שני מסלולים רשמיים נפרדים לשימוש ב-Claude בתוך PowerPoint, ויש להבחין ביניהם בבירור. הראשון הוא Claude for PowerPoint add-in של Anthropic, תוסף עצמאי שיושב כסרגל צד בתוך PowerPoint ומתחבר ישירות לחשבון Claude של המשתמש. השני הוא M365 Copilot של Microsoft, שמ-4 במאי 2026 מנתב משימות במודלי Anthropic כברירת מחדל באזורים מסוימים. שני המסלולים מתקיימים במקביל באותו tenant, ולעיתים על אותו קובץ - אבל הם שני מוצרים שונים מבחינת בעלות, billing, UI ו-data flow.

### מסלול א: Claude for PowerPoint add-in (Anthropic)

התוסף מותקן דרך Microsoft AppSource או דרך Microsoft 365 Admin Center (Integrated apps, Add-ins) או manifest XML. הוא יושב כסרגל צד בתוך PowerPoint ל-Windows, Mac ו-Web, ומתחבר לחשבון Claude של המשתמש (Pro, Max, Team, Enterprise) או דרך LLM gateway ארגוני - Amazon Bedrock, Google Cloud Vertex AI או Microsoft Foundry. ה-billing הוא דרך מנוי Claude (החל מ-$20 לחודש ב-Pro), ללא תוספת מ-Microsoft.

יכולות מרכזיות נכון למאי 2026: יצירת deck מלא מתיאור בשפה טבעית; עריכה ממוקדת של slide נבחר תוך שמירה על Slide Master, layouts, fonts וסכמת צבעים; המרת bullets ל-native PowerPoint charts ו-diagrams (אובייקטים editable, לא תמונות); URL-to-deck; PDF/Excel input; full-deck translation; speaker notes generation. שלוש שכבות מתקדמות נוספו במהלך מרץ-מאי 2026 ומגדירות מחדש את התוסף:

- **Skills**: workflows חוזרים בלחיצה אחת (לדוגמה "competitive landscape deck", "quarterly update"). הוכרזו ב-11 במרץ 2026 כחלק מההכרזה על Shared Context.
- **Connectors**: MCP-based, כולל S&P Global, LSEG, Daloopa, PitchBook, Moody's, FactSet, Gamma, 2Slides.
- **Shared Context**: שיחה אחת ממשיכה בין Excel, PowerPoint ו-Word - החל מ-11 במרץ 2026, הורחבה ל-Word ב-11 באפריל 2026.

### מסלול ב: M365 Copilot עם Claude כברירת מחדל

מסלול זה אינו תוסף נפרד - הוא Copilot של Microsoft שמנתב את הקריאה למודל של Anthropic מאחורי הקלעים. ציר זמן הליבה: ב-7 בינואר 2026 Anthropic הוכרזה כ-Microsoft subprocessor, כך שהשימוש בה ב-Copilot נכנס תחת אותם הסכמי אבטחה של M365. ב-3 באפריל 2026 נוספה הגדרה ייעודית במוקד הניהול "Copilot in M365 apps with Anthropic models in EU/EFTA and UK". ב-1 במאי 2026 הושבת ה-IP toggle הישן והכל מנותב דרך subprocessor framework. ב-4 במאי 2026, לפי MC1269241, Claude הפך ל-default model עבור Copilot ב-Excel וב-PowerPoint באזורים שבהם Anthropic מופעל. ה-billing הוא דרך M365 Copilot ($30 למשתמש לחודש מעבר ל-M365), לא דרך Claude.

| ממד | Claude for PowerPoint add-in | M365 Copilot עם Claude default | Last verified |
|---|---|---|---|
| בעלים | Anthropic | Microsoft | 2026-05 |
| UI | סרגל צד עצמאי בתוך PowerPoint | Copilot pane של Microsoft | 2026-05 |
| Billing | מנוי Claude ($20+ לחודש) | M365 Copilot ($30 לחודש מעבר ל-M365) | 2026-05 |
| בחירת מודל | משתמש בוחר מפורשות (Sonnet 4.5/4.6, Opus 4.6/4.7) | אין UI לבחירת מודל, routing אוטומטי | 2026-05 |
| Skills + Connectors | מובנה | חלקי, preview ל-Skills (15.5.2026) | 2026-05-15 |
| Commercial cloud | נתמך | Claude default | 2026-05-04 |
| EU/EFTA/UK | נתמך, opt-in מפורש לעיבוד מחוץ ל-EU Data Boundary | Off by default, admin opt-in נדרש | 2026-04-03 |
| GCC, GCC High, DoD, sovereign | לא נתמך | לא נתמך | 2026-05 |

ההבחנה בין commercial cloud ל-EU/EFTA/UK מרכזית לפריסה ארגונית. ב-commercial cloud האמריקאי והבינלאומי, מ-7 בינואר 2026, Anthropic מופעלת On כברירת מחדל כ-subprocessor. ב-EU/EFTA/UK המצב מורכב יותר: ב-tenants חדשים שנפתחו אחרי 25 במרץ 2026 ההגדרה הספציפית ל-Word, Excel ו-PowerPoint On כברירת מחדל, ב-tenants ישנים נדרשת הפעלה ידנית, ו-EU Data Boundary לא חל על עיבוד Anthropic - דרוש opt-in מפורש מצד Global Administrator.

**Contested:** Claude DR מנסח "Claude default in Copilot Excel/PPT" לפי MC1269241 vs Perplexity שמנסח "Anthropic enabled by default" ולא "Claude default" מפורש. Gemini תומך ב-multi-model framing ללא ברירת מחדל מוצהרת. **Default position:** "Anthropic enabled by default" ולא "Claude default" עד אימות ב-Microsoft Message Center הרשמי - הציטוט של MC1269241 מגיע מ-cloudswitched.com כ-single source. **Re-verify:** Microsoft Message Center בארגון פעיל + Microsoft 365 admin documentation.

## מה לוודא שוב ב-Q3 2026
- אימות הניסוח הרשמי של MC1269241 ישירות מול Microsoft Message Center.
- האם Skills בתוסף יוצאות מ-preview ומה הרשימה הסופית.
- האם EU/EFTA/UK עוברים גם הם ל-On by default.
- האם נוספה תמיכה ב-government clouds דרך FedRAMP authorization.

## הפניות צולבות
- פרק 4 - Claude-native paths: מסלול Cowork מחוץ לתוסף.
- פרק 6 - Workflow: שילוב התוסף עם Cowork ו-MCP.
- פרק 8 - Warnings: מגבלות EU/EFTA/UK ו-government clouds.
