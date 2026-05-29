# Expected output , style record for `fixture-pitch-clean`

```yaml
primary:
  style_name: Editorial Light
  rationale: |
    הלומד ביקש מפורשות "נקי, פחות צבעוני, עם הרבה לבן" וזה ה-cluster של Editorial Light ב-R3.
    קהל investor בגודל 30 איש בחדר עם projector צד ימין מצדיק טיפוגרפיה ברורה ושוליים נדיבים,
    ולא צבעוניות מסיחה.

alternative:
  style_name: Swiss Grid
  rationale: |
    אותו אשכול של מינימליזם, עם דגש מבני יותר. מתאים אם הלומד יחליט שהוא רוצה לוחות נתונים
    גדולים יותר בשקופית 5 (Traction).

wildcard:
  style_name: Notion Doc
  rationale: |
    בחירה נועזת יותר , מצגת שנראית כמו מסמך, לא כמו שקופית. תעבוד טוב כי הקהל הוא מעורב
    טכני-משקיעי, אבל תוותר על האפקט הוויזואלי של pitch קלאסי.

locked:
  fonts:
    heading: "Inter, system-ui, sans-serif"
    body: "Inter, system-ui, sans-serif"
    hebrew_pair: "Rubik, sans-serif"     # נדרש כי language=he
  colors:
    primary: "#0F1419"      # near-black
    accent: "#2563EB"       # one accent only
    background: "#FFFFFF"
    text: "#0F1419"
  spacing:
    base_unit: 8px
    rhythm: "8 / 16 / 24 / 48 / 96"

warnings: []
```

Notes for human reviewer:

- Primary, alternative, and wildcard come from the same cluster (Minimal Editorial) per the Master Style Table; wildcard is the boldest variant in that cluster.
- Hebrew font pair (Rubik) was added automatically because `meta.language=he` and the primary heading font (Inter) does not include a strong Hebrew face. This is a Pairing Rules action.
- Single accent color (`#2563EB`) honors the learner's "פחות צבעוני" preference.
- `warnings` is empty , contrast checks pass and no rtl-hazard fonts were selected.
- A real R3 read might pick slightly different style names; the structure here illustrates the output shape.
