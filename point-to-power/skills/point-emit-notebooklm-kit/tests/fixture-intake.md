# Fixture: intake_record (pre-slides) + project slug

Input shape: `intake_record` (meta + raw content_units) handed off right after Phase 2 Intake, **before** any slide structuring. This is the input the kit skill emits from.

```yaml
project_slug: colortune-pitch-01
channel: filesystem

intake_record:
  meta:
    target: html
    audience: משקיעי seed ומנהלי מוצר במיט-אפ דיזיין-טק, ~30 איש
    genre: pitch
    duration_minutes: 12
    output_type: presentation
    speaker_notes: on
    language: he

  content_units:
    - position: 1
      text: מעצבים מבזבזים שעות על תיקוני נגישות במקום על עיצוב. הכאב היומיומי מול contrast checker.
    - position: 2
      text: WebAIM 2025 - 96.3% מהאתרים נכשלים בבדיקת ניגודיות. התיקון יקר ולא מתוקצב.
    - position: 3
      text: ColorTune - input פלטה, output פלטה נגישה ששומרת hue והיררכיה.
    - position: 4
      text: דמו חי של 90 שניות, פלטה אמיתית מ-beta.
    - position: 5
      text: traction - 340 MAU, 12K ARR, 47 צוותים, 28% growth, 4% churn.
    - position: 6
      text: בקשה - 800K seed, לפיתוח מכירות בארה"ב ותוסף Figma.
```

Notes:
- No `slides` here, by design. The kit is emitted before structuring.
- There is a **live demo** (content unit 4), so the kit must NOT include a Video Overview of the demo.
- `language: he`, so every Audio/Video prompt carries an RTL/Hebrew-quality warning.
