# Stale-Watch List - Claude in PowerPoint KB

> Snapshot: May 2026
> Compiled: 2026-05-28
> Next re-verification: Q3 2026 (יולי-ספטמבר 2026)
> מטרה: רשימה מרוכזת של פריטים שחייבים בדיקה מחודשת בעדכון ה-KB הבא. POWER לא קורא את זה בכל ריצה - זה checklist לעדכון.

---

## אישור מהיר - מה דחוף ביותר

| עדיפות | פריט | בגלל | פרק |
|---|---|---|---|
| גבוהה | אימות MC1269241 ב-Microsoft Message Center | single-source (cloudswitched.com), משפיע על framing של "Claude default" | 2 |
| גבוהה | סטטוס archive של GongRzhe Office-PowerPoint-MCP-Server | single-source (Gemini), משפיע על המלצת MCP | 5 |
| גבוהה | באג AppleScript ב-Cowork macOS | single-source (Claude DR), משפיע על workflow ב-Mac | 4 |
| בינונית | Microsoft Build 2026 (2-3 ביוני) - הכרזות PPT | event צפוי לפני Q3 | 1, 9 |
| בינונית | Skills בתוסף - יציאה מ-preview | משפיע על המלצה פדגוגית | 1, 2, 9 |

---

## פר פרק

### פרק 1 - Status snapshot

- האם תוספת תמיכה ב-mobile Office (iOS, Android).
- האם Skills בתוך התוסף יצא מ-preview ופורסמה רשימת Skills רשמיים.
- האם הסטטוס של GCC/GCC High/DoD משתנה לאחר FedRAMP authorization.
- האם Microsoft Build 2026 (2-3 ביוני) הוסיף הכרזות PowerPoint-ספציפיות.

### פרק 2 - Official integrations

- אימות הניסוח הרשמי של MC1269241 ישירות מול Microsoft Message Center.
- האם Skills בתוסף יוצאות מ-preview ומה הרשימה הסופית.
- האם EU/EFTA/UK עוברים גם הם ל-On by default.
- האם נוספה תמיכה ב-government clouds דרך FedRAMP authorization.

### פרק 3 - Third-party tools landscape

- האם Gamma Connector עדיין פעיל ב-claude.com/connectors/gamma ועדיין מתחזק PPTX export ללא עיוותי פריסה.
- האם 2Slides MCP מחזיק תאימות ל-Claude Desktop בגרסת ה-config העדכנית.
- האם נוסף תוסף חדש בשם slide-design-pro ב-AppSource או ב-GitHub.
- האם Plus AI שמר על Claude כ-provider לאחר GA של ה-add-in הרשמי של Anthropic.

### פרק 4 - Claude-native paths

- סטטוס AppleScript bug ב-Cowork macOS: האם דווח רשמית, האם תוקן, האם workaround השתנה.
- האם PowerPoint Connector ב-Cowork מתרחב ל-Windows (נכון למאי 2026 - macOS only).
- האם file creation toggle עדיין דורש opt-in ב-Settings, או נכנס כברירת מחדל ב-paid plans.
- האם מגבלת 30MB השתנתה.

### פרק 5 - MCP servers for PowerPoint

- סטטוס GongRzhe Office-PowerPoint-MCP-Server - האם ה-repo עדיין marked archive, ואם כן האם קם fork מתוחזק.
- האם ppt-mcp הוסיף תמיכה ב-macOS (כרגע Windows COM exclusive).
- האם 2Slides MCP נכלל ב-Claude for PowerPoint Connectors הרשמיים.
- האם PPT_MCP_Server (socamalo) חזר לחיים אחרי Apr 2025 או נמחק לחלוטין.

### פרק 6 - Recommended workflow

- האם Cowork PowerPoint Connector הורחב מ-macOS ל-Windows.
- האם ppt-mcp הוסיף תמיכה ב-macOS דרך AppleScript bridge או דרך PPTX file-mode.
- האם Gamma Connector הוסיף יציאה native editable (לא PNG) ל-PowerPoint objects.
- האם Microsoft פרסם UI לבחירת מודל ב-Copilot PowerPoint.

### פרק 7 - POWER templates

- האם Anthropic פרסמה official template library ל-add-in (כרגע Skills ב-preview).
- האם Gamma Connector תומך ב-PPTX export עם native editable objects.
- האם 2Slides MCP הוסיף תמיכה ב-streaming של datasets גדולים מעל 1000 שורות.
- האם python-pptx הוסיפו SmartArt API (כרגע פער ידוע, last release 2023).

### פרק 8 - Warnings, limitations, contradictions

- כל ארבעת ה-single-source claims: AppleScript bug, MC1269241, GongRzhe archive, Build 2026 announcements.
- האם נוספה תמיכה ב-mobile Office (iOS / Android), GCC / GCC High / DoD, ו-Free plan.
- האם EU / EFTA / UK עברו ל-On by default ב-Copilot Anthropic.
- האם audit logs / Compliance API ל-Team ו-Enterprise קיבלו ציר זמן רשמי.

### פרק 9 - Unit teaching notes

- האם ה-add-in הרשמי קיבל יכולות חדשות שמשנות את היחס בינו לבין Cowork.
- האם Skills בתוך התוסף יצא מ-preview - אם כן, זה עשוי לשנות את ההמלצה הפדגוגית.
- האם Microsoft Build 2026 הוסיף הכרזות PowerPoint-ספציפיות שדורשות עדכון.
- האם HTML deck workflow ב-Cowork נשאר יציב או שמשהו השתנה (Vercept acquisition aftermath).

---

## איך לרענן את ה-KB ב-Q3 2026

1. **התחל בעדיפות גבוהה.** שלושת ה-single-source claims (MC1269241, GongRzhe, AppleScript bug) הם פערי האמינות הגדולים ביותר. אם הם נסגרים - ה-KB עולה רמה.
2. **בדוק את ה-events הצפויים.** Microsoft Build 2026 (יוני) ו-Anthropic mid-year announcements. אם הוכרז משהו - עדכן פרקים 1, 2, 6.
3. **רענן את המקורות הישנים.** Stage 1 freshness audit סימן python-pptx docs מ-2023 ו-PPT_MCP_Server מ-Apr 2025 כ-stale. בדוק אם יש update.
4. **טפל בסתירות שעדיין פתוחות.** סתירה 1 (slide-design-pro) נשארה לא פתורה - אם בן יכול לבקש מהמשתמש המקורי link מדויק, זה ייסגר.
5. **בדוק את ה-blocks הקשורים בקורס.** Cowork unit, Connectors unit, Plugins unit, Meta-agents unit - אם כתבת בהם דברים על PowerPoint, עדכן מתוך ה-KB.
