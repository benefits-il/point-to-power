# Fixture: clean pitch , style_preference signals a minimal aesthetic

Input:

```yaml
ast.meta:
  audience: משקיעי seed ומנהלי מוצר במיט-אפ דיזיין-טק
  genre: pitch
  duration_minutes: 12
  output_type: presentation
  speaker_notes: on
  language: he
  style_preference: "משהו נקי, סווייצ'רי, פחות צבעוני, עם הרבה לבן"

target: html
```

Extracted signals (what `select-style` should infer):

- audience_type: `investor` (with secondary `mixed`)
- tone: `formal` with calm undertone
- industry: `design`
- novelty: `expected` (design AI startup is familiar territory)
- brand_constraint: explicit (`נקי, סווייצ'רי, פחות צבעוני, הרבה לבן`) , strong weight
- format: `html-deck`
