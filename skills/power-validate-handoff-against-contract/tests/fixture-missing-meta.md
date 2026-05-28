# Fixture: AST with missing meta fields and invalid enums

A handoff where:

- Header is valid: `# PointToPower Handoff v1.0`.
- `## Meta` exists, but `genre` is missing and `target` carries the value `HTML` (capital) which is not in the allowed enum.
- `duration_minutes` is `"12.5"` (not a positive integer).
- 6 slides numbered 1..6, all fields present, valid.
- Tail exists with Visual Queue and 0 recommendations.
- No emojis, no em-dashes.

Synthetic AST:

```yaml
header_version: v1.0

meta:
  target: HTML
  audience: משקיעים
  duration_minutes: "12.5"
  output_type: presentation
  speaker_notes: on
  language: he
  # genre is missing

slides: [ ... 6 valid slides ... ]

tail:
  notebooklm_recommendations: []
  visual_queue: [ ... matching queue ... ]
  notes_to_power: null

parse_errors: []
```
