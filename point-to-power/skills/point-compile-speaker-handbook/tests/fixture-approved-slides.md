# Fixture , approved slides for compile-speaker-handbook

A minimal post-approval input (`content_approved=true`). Two slides from the canonical ColorTune pitch, with speaker_notes present (meta.speaker_notes=on).

```yaml
content_approved: true
project_slug: colortune-pitch-01
channel: filesystem

meta:
  genre: pitch
  audience: משקיעים בתחילת דרכם וצוות מוצר במיט-אפ של 30 איש
  language: he
  duration_minutes: 12
  output_type: presentation
  speaker_notes: on

slides:
  - number: 1
    title: למה אנחנו חיים בעולם נגיש פחות
    key_message: מעצבים מבזבזים שעות על תיקוני נגישות במקום על עיצוב.
    content: |
      בכל פרויקט יש שלב שבו המעצב פותח את ה-Figma, מריץ בדיקת ניגודיות,
      ומגלה שחצי מהפלטה לא עוברת. התיקון לוקח שעות שלא תוקצבו.
    speaker_notes: |
      התחל בלהזכיר לקהל מתי בפעם האחרונה הם פתחו contrast checker.
      השתהה שתי שניות. שמור על קצב איטי בשקופית הזו.
  - number: 2
    title: ColorTune
    key_message: ColorTune מקבל פלטה ראשונית ומחזיר פלטה נגישה בלי לשבור את ההיררכיה.
    content: |
      המעצב מזין את הצבעים שבחר, ColorTune מתקן רק את מה שצריך,
      ושומר על תחושת המותג.
    speaker_notes: |
      כאן עוברים לאנרגיה גבוהה. זה הרגע של הפתרון.
      הצבע על המסך כשאתה אומר "בלי לשבור את ההיררכיה".

briefs:
  - 03-returns/brief-exec.md
```
