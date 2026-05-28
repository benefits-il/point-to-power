# Expected output , intake_record for `fixture-rich-input`

After 1-2 short clarifying turns (Point asks the learner about `target` and `speaker_notes`, learner answers `html` and `on`), Point produces:

```yaml
meta:
  target: html
  audience: משקיעי seed ומנהלי מוצר במיט-אפ דיזיין-טק בתל אביב, כ-30 איש, מחציתם טכניים
  genre: pitch
  duration_minutes: 12
  output_type: presentation
  speaker_notes: on
  language: he
  style_preference: משהו נקי, פחות צבעוני, עם הרבה לבן
  session_id: colortune-pitch-01

content_units:
  - tentative_position: 1
    raw_text: "הבעיה: מעצבים מבזבזים שעות על תיקוני נגישות. כל פרויקט יש את הרגע שפותחים contrast checker ומגלים שחצי מהפלטה נכשלת."
  - tentative_position: 2
    raw_text: "הבעיה במספרים: WebAIM 2025 - 96.3% מדפי הבית של מיליון האתרים המובילים נכשלים. רוב התקלות זה ניגודיות."
  - tentative_position: 3
    raw_text: "ColorTune: מקבל פלטה, מחזיר גרסה נגישה ששומרת על ה-hue וההיררכיה, ומסביר כל שינוי."
  - tentative_position: 4
    raw_text: "דמו חי - 90 שניות, פלטה אמיתית מ-beta."
  - tentative_position: 5
    raw_text: "Traction: 340 משתמשים פעילים חודשי, 12K ARR, 47 צוותים משלמים, 28% growth, 4% churn."
  - tentative_position: 6
    raw_text: "הבקשה: 800K seed לצוות מכירות בארה\"ב + השלמת תוסף Figma."
```

Notes for human reviewer:

- `target: html` was supplied by the learner in a clarifying turn (not from the original message).
- `output_type` defaulted to `presentation` because the learner used the word "מצגת/pitch/ההצגה" and not "טלפרומפטר" or "slidedoc".
- `style_preference` was preserved verbatim from the rich input.
- `session_id` was extracted from the explicit "session id: colortune-pitch-01" line.
- `generated_at` is not required and was omitted; produce-handoff-md will fill it at emit time.
