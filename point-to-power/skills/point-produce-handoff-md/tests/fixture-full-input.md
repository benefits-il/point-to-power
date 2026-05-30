# Fixture: full input

The combined, **approved** output of `elicit-content-from-user` + `structure-content-to-slides` for the ColorTune pitch, plus a short notes_to_power paragraph. The two `notebooklm_recommendations` below are optional in the v2 flow (the kit normally lives in `prompts/`); they are kept here to exercise the contract's Tail rendering.

```yaml
channel: filesystem
content_approved: true
project_slug: colortune-pitch-01

intake_record.meta:
  target: html
  audience: משקיעי seed ומנהלי מוצר במיט-אפ דיזיין-טק בתל אביב, כ-30 איש, מחציתם טכניים ומחציתם משקיעים פעילים
  genre: pitch
  duration_minutes: 12
  output_type: presentation
  speaker_notes: on
  language: he
  style_preference: משהו נקי, סווייצ'רי, פחות צבעוני, עם הרבה לבן
  generated_at: 2026-06-04T22:14:00
  session_id: colortune-pitch-01

slides:
  (the 6 slides from the structure-content-to-slides expected-output.md fixture)

notebooklm_recommendations:
  (optional in v2; two sample recommendations kept to exercise the Tail rendering. In a normal v2 run this is an empty list because the kit was already emitted to prompts/ in Phase 3.)

notes_to_power: |
  הקהל מעורב, חצי טכני וחצי משקיעים. שמור על קצב מהיר בשקופיות 1 ו-2, ותן זמן נשימה בשקופית 4 שזו ה-wow.
  אם הסגנון שיוצא נראה צבעוני מדי, חזור ל-Style Decision Tree עם משקל גבוה יותר על "פחות צבעוני, הרבה לבן" מתוך ה-style_preference.
  הדמו בשקופית 4 הוא רגע ה-wow של ההרצאה. אל תפזר את תשומת הלב למרכיבי עיצוב אחרים בשקופית הזו.
```
