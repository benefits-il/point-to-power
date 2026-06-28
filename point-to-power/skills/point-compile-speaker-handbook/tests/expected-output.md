# Expected output , compile-speaker-handbook for `fixture-approved-slides`

The skill writes the file at:

```
build\colortune-pitch-01\presenter-handbook.md
```

Expected `handbook_markdown` content:

```markdown
# חוברת מנחה , ColorTune

קהל: משקיעים בתחילת דרכם וצוות מוצר במיט-אפ של 30 איש. משך: 12 דקות. שתי שקופיות.

מפת השקופיות:
1. למה אנחנו חיים בעולם נגיש פחות , מעצבים מבזבזים שעות על תיקוני נגישות במקום על עיצוב.
2. ColorTune , ColorTune מקבל פלטה ראשונית ומחזיר פלטה נגישה בלי לשבור את ההיררכיה.

## שקופית 1: למה אנחנו חיים בעולם נגיש פחות

**המסר:** מעצבים מבזבזים שעות על תיקוני נגישות במקום על עיצוב.

**מה אומרים:** פותחים בשאלה לקהל , מתי בפעם האחרונה פתחתם contrast checker וגיליתם שחצי מהפלטה נכשלת. נותנים לזה לשקוע. מתארים את הרגע המוכר: פותחים את ה-Figma, מריצים בדיקת ניגודיות, וחצי מהצבעים לא עוברים. התיקון לוקח שעות שלא תוקצבו.

**דגשים:** השתהות של שתי שניות אחרי השאלה הפותחת. קצב איטי לאורך כל השקופית.

## שקופית 2: ColorTune

**המסר:** ColorTune מקבל פלטה ראשונית ומחזיר פלטה נגישה בלי לשבור את ההיררכיה.

**מה אומרים:** עוברים לאנרגיה גבוהה , זה רגע הפתרון. המעצב מזין את הצבעים שבחר, ColorTune מתקן רק את מה שצריך, ושומר על תחושת המותג.

**דגשים:** מצביעים על המסך באמירה "בלי לשבור את ההיררכיה".
```

Return value structure:

```yaml
handbook_markdown: |
  # חוברת מנחה , ColorTune
  ...
filesystem_path: build\colortune-pitch-01\presenter-handbook.md
```

Notes for human reviewer:

- The handbook is for the human presenter, not for POWER. POWER never reads `presenter-handbook.md`.
- Page 1 is the overview map (one line per slide with its key_message); pages 2+ are per-slide scripts.
- "מה אומרים" is compiled from each slide's speaker_notes plus the BRIEF context; it invents no new facts.
- No emojis, no em-dashes; emphasis via asterisks. Brand/proper names (ColorTune) are not translated.
- If meta.speaker_notes were `off`, the handbook would still be produced from key_message + content, with a note at the top that there are no dedicated notes.
