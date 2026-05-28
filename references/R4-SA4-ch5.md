# פרק 5 - MCP servers for PowerPoint
> Snapshot: May 2026

שדה ה-MCP servers ל-PowerPoint רווי: עשרה שרתים פעילים נכון למאי 2026, רובם פונים ל-Claude Desktop / Claude Code, חצי מהם תלויי Windows COM. ה-default ל-POWER: ppt-mcp של ykuwai (154 tools, real-time COM, Windows-only). הסעיף שלהלן מציג טבלה, snippets מוכנים להעתקה לקובצי config, וההמלצה הסופית.

## טבלת השוואה

| שם השרת | בעלים | מס' tools | טכנולוגיה | פלטפורמות | סטטוס | Last verified |
|---|---|---|---|---|---|---|
| ppt-mcp | ykuwai | 154 | COM automation (pywin32) | Windows בלבד | Active (recommended) | 2026-05-28 |
| Office-PowerPoint-MCP-Server | GongRzhe | 34 | python-pptx | Windows / macOS / Linux | Unverified (possibly archived) | 2026-03-03 (Gemini single-source) |
| mcp-server-ppt | trsdn | רב-שלבי (19 shape ops) | COM API | Windows בלבד | Active | 2026-05 |
| PPT_MCP_Server | socamalo | בסיסי | COM / python | Windows בלבד | Stale | 2025-04-27 |
| macos-office365-mcp-server | vAirpower | PoC | AppleScript bridge | macOS בלבד | Active (PoC) | 2026-05 |
| OfficeMCP | קהילה | אוניברסלי (Word/Excel/PPT/Visio/Access/WPS) + RunPython() | COM | Windows בלבד | Active (risky: RunPython) | 2026-05 |
| powerpoint-mcp | Ichigo3766 (fork מ-supercurses) | יצירת decks + image gen | python-pptx + Stable Diffusion WebUI | Windows / macOS / Linux | Active | 2026-05 |
| PPT-MCP | LobeHub | יצירה / ניתוח מהיר | Node.js + PptxGenJS | חוצה-פלטפורמות | Active | 2026-05 |
| powerpoint | supercurses | בסיסי + image gen | python-pptx + FLUX via TogetherAI | חוצה-פלטפורמות | Active (דורש API key) | 2026-05 |
| mcp-ms-office-documents | ForLegalAI | PPTX / DOCX / XLSX / EML | Docker + YAML templates | חוצה-פלטפורמות | Active | 2026-05 |

הערה: ppt-mcp הוא היחיד שמציע שליטה חיה ב-PowerPoint פתוח (real-time COM) ולא רק עריכת קובץ. הוא תומך ב-dialog auto-dismiss, theme colors, SmartArt creation, animations, freeform paths ו-2,500+ אייקוני Google Material Symbols דרך typography check tool.

## חיבור ppt-mcp ל-Claude Desktop / Code

חיבור ל-Claude Desktop. ערוך את `claude_desktop_config.json` (Windows: `%APPDATA%\Claude\claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "ppt-mcp": {
      "command": "uvx",
      "args": ["ppt-mcp"],
      "env": {
        "PPT_AUTO_DISMISS_DIALOG": "true"
      }
    }
  }
}
```

הפעל מחדש את Claude Desktop, פתח PowerPoint, וודא שהשרת מופיע ברשימת ה-tools ב-sidebar.

חיבור ל-Claude Code. שתי דרכים. הראשונה: קובץ `.mcp.json` בשורש הפרויקט:

```json
{
  "mcpServers": {
    "ppt-mcp": {
      "command": "uvx",
      "args": ["ppt-mcp"],
      "env": {
        "PPT_AUTO_DISMISS_DIALOG": "true"
      }
    }
  }
}
```

השנייה: פקודת CLI אחת:

```bash
claude mcp add ppt-mcp -- uvx ppt-mcp
```

הוסף `--env PPT_AUTO_DISMISS_DIALOG=true` כדי למנוע חסימת RPC_E_CALL_REJECTED כש-PowerPoint פותח dialog modal.

## ההמלצה

אם POWER צריך לבחור אחד: **ppt-mcp (ykuwai)**. הסיבות: הכי הרבה tools (154 לעומת 34 אצל GongRzhe), real-time COM נותן feedback ויזואלי מיידי במקום round-trip על קובץ, dialog auto-dismiss מובנה, ותמיכה native ב-SmartArt ו-animations שחסרות ב-add-in הרשמי. החיסרון היחיד: Windows-only. עבור משתמשי macOS, הנפילה לאחור היא macos-office365-mcp-server (vAirpower) דרך AppleScript bridge, או PPT-MCP של LobeHub עבור עבודה חוצת-פלטפורמות שאינה דורשת PowerPoint פתוח.

**Contested:** GongRzhe Office-PowerPoint-MCP-Server - Gemini DR טוען archive read-only מ-2026-03-03 (single source), Claude DR טוען active עם PyPI release 1.0.0 ללא תאריך מדויק, Perplexity לא מתייחס לסטטוס. **Default position:** Unverified (possibly archived). אל תמליץ עליו ל-POWER עד אימות, ובחר ב-ppt-mcp או PPT-MCP. **Re-verify:** בדוק את `github.com/GongRzhe/Office-PowerPoint-MCP-Server` ישירות - האם ה-repo מסומן "Archived" ב-GitHub UI, ומה תאריך ה-commit האחרון.

## מה לוודא שוב ב-Q3 2026

- סטטוס GongRzhe Office-PowerPoint-MCP-Server - האם ה-repo עדיין marked archive, ואם כן האם קם fork מתוחזק.
- האם ppt-mcp הוסיף תמיכה ב-macOS (כרגע Windows COM exclusive).
- האם 2Slides MCP נכלל ב-Claude for PowerPoint Connectors הרשמיים (מצוין כ-MCP server ב-Stage 1, אך לא נכלל בפרק זה כי הוא third-party tool ולא MCP מקומי).
- האם PPT_MCP_Server (socamalo) חזר לחיים אחרי Apr 2025 או נמחק לחלוטין.

## הפניות צולבות

- פרק 4 - Claude-native paths: מסלול PPTX Skill המובנה ב-Cowork לעומת MCP servers (מתי לבחור מה).
- פרק 6 - Recommended workflow: שילוב ppt-mcp ב-pipeline `Cowork outline -> ppt-mcp targeted edits -> Add-in polish`.
- פרק 8 - Warnings: מגבלות MCP-based workflows (RPC_E_CALL_REJECTED, Windows lock, prompt injection דרך custom connectors).
