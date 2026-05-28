# Expected output , AST for fixture-clean-handoff (and identical for fixture-fenced-paste)

```yaml
header_version: v1.0

meta:
  target: html
  audience: משקיעי seed ומנהלי מוצר במיט-אפ דיזיין-טק בתל אביב, כ-30 איש, מחציתם טכניים ומחציתם משקיעים פעילים
  genre: pitch
  duration_minutes: "12"      # נשמר כמחרוזת. ההמרה ל-int היא תפקיד ה-validator (rule 6).
  output_type: presentation
  speaker_notes: on
  language: he
  style_preference: "משהו נקי, סווייצ'רי, פחות צבעוני, עם הרבה לבן"
  generated_at: 2026-06-04T22:14:00
  session_id: colortune-pitch-01

slides:
  - number: 1
    title: עיצוב נגיש לוקח שעות שלא תוקצבו
    fields:
      key_message: מעצבים מבזבזים שעות שלמות בכל פרויקט על תיקוני נגישות שאף אחד לא תכנן עליהם.
      content: |
        בכל פרויקט יש את הרגע הזה. המעצב מסיים את הפלטה, פותח Contrast Checker,
        ומגלה שחצי מהקומבינציות נכשלות. החלפת צבע אחד שוברת את ההיררכיה של כל המסך.
        התיקון לוקח לפעמים יום שלם, ולא מופיע באף אומדן זמן בתחילת הפרויקט.
      bullets_allowed: "false"
      visual_placeholder: איור שטוח של מעצב מול מסך פיגמה, פלטת צבעים בצד, חלק מהריבועים מסומנים באדום עם הכיתוב FAIL.
      speaker_notes: |
        התחילי בלשאול את הקהל מתי בפעם האחרונה הם פתחו Contrast Checker.
        השתהי שתי שניות אחרי השאלה. אל תענה. תני לאי-נוחות לעבוד.
        שמרי על קצב איטי בשקופית הזו, היא בונה את הבעיה.

  # slides 2..6 follow the same structure; see references/example-handoff.md
  # for the literal source. The AST preserves each value verbatim including
  # multi-line content with two-space indent preserved as line breaks.

tail:
  notebooklm_recommendations:
    - index: 1
      fields:
        feature: Audio Overview - Brief
        prompt: |
          הפק תקציר אודיו קצר באורך שלוש דקות מהמסמכים המצורפים, בעברית, בנימה רגועה ומדויקת.
          הדגש את שלושת הכאבים המרכזיים שמופיעים בשקופיות 1 ו-2.
          הסבר במשפט אחד את הפתרון של ColorTune, בלי לחשוף את הדמו של שקופית 4.
          סיים בקריאה לפעולה כללית בלי לציין סכומים.
        warnings: "rtl-audio-weak, hebrew-quality-tier-c"
        serves_slides: "1, 2"
    - index: 2
      fields:
        feature: Mind Map
        prompt: |
          בנה Mind Map בעברית שמתחיל בשורש "ColorTune"
          ומסתעף לשלושה ענפים ראשיים: כאב, פתרון, traction.
          כל ענף עד ארבעה צמתים. שמור על תמצות, בלי משפטים מלאים בצמתים.
        warnings: none
        serves_slides: all

  visual_queue:
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

  notes_to_power: |
    הקהל מעורב, חצי טכני וחצי משקיעים. שמור על קצב מהיר בשקופיות 1 ו-2, ותן זמן נשימה בשקופית 4 שזו ה-wow.
    אם הסגנון שיוצא נראה צבעוני מדי, חזור ל-Style Decision Tree עם משקל גבוה יותר על "פחות צבעוני, הרבה לבן" מתוך ה-style_preference.
    הדמו בשקופית 4 הוא רגע ה-wow של ההרצאה. אל תפזר את תשומת הלב למרכיבי עיצוב אחרים בשקופית הזו.

parse_errors: []
```

Notes for human reviewer:

- Slide 4's `speaker_notes` field is the literal one-line value `off` , the AST stores it as `speaker_notes: "off"` (string), not as the absence of the field. This is critical for the `validate-handoff-against-contract` skill to apply the precedence chain.
- `bullets_allowed` and `duration_minutes` are stored as strings; type coercion happens in the validator.
- The fenced-paste fixture produces a parse_errors=[] result if and only if the outer fence is exactly ` ```markdown `, ` ```md `, or ` ``` `. Any other tag (e.g., ` ```yaml `) would add a `header-malformed` parse_error.
