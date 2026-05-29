# Fixture: visual queue (5 entries) + style_record

Inputs:

- `ast.tail.visual_queue`: the 5 entries from `references/example-handoff.md` Visual Queue (slide_1, slide_3, slide_4, slide_5, slide_6).
- `style_record`: Editorial Light from `../select-style/tests/expected-output.md`.

Reproduced queue for self-containment:

```yaml
- slide_number: 1
  placeholder: איור שטוח של מעצב מול מסך פיגמה, פלטת צבעים בצד, חלק מהריבועים מסומנים באדום עם הכיתוב FAIL.
- slide_number: 3
  placeholder: צילום מסך של ה-UI של ColorTune עם פלטה מקורית בצד שמאל ופלטה מתוקנת בצד ימין, חיצים דקים מחברים בין צבעים שהשתנו.
- slide_number: 4
  placeholder: וידאו של 8 שניות שמראה את התהליך מקצה לקצה, ללא קול, עם כיתוביות קצרות בלבן.
- slide_number: 5
  placeholder: גרף עמודות פשוט בשחור-לבן, ציר X חודשים, ציר Y משתמשים פעילים, ערכים מעל כל עמודה.
- slide_number: 6
  placeholder: תמונה רגועה של לפטופ פתוח על שולחן עם לוגו ColorTune במסך, רקע מטושטש.
```
