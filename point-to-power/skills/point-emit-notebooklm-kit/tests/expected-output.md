# Expected output - emitted kit for `fixture-intake`

The skill writes five files to `build/colortune-pitch-01/prompts/` and returns `kit_summary` to Point. Three core files plus two Studio artifacts (Audio Brief + Mind Map), per the `pitch` row of the catalog assembly table. No Video Overview, because content unit 4 is a live demo.

## Files written to `build/colortune-pitch-01/prompts/`

### `00-INDEX.md`
```markdown
# ערכת NotebookLM - colortune-pitch-01

הרץ את הקבצים בסדר הזה. שמור כל תוצר שחוזר מ-NotebookLM ל-`build/colortune-pitch-01/content/`, ואז חזור אליי (Point) ונערוך אותו יחד לתוכן השקופיות.

1. **01-source-document.md** - העלה כ-source ב-NotebookLM. זה הזרע לכל השאר.
2. **02-deep-research.md** - הרץ ב-Sources > Discover לאיסוף הקשר השוק והתחרות. שמור את המקורות והסיכום ל-content/.
3. **03-studio-audio-brief.md** - תקציר אודיו לחימום משקיעים. שמור את התמליל ל-content/.
4. **03-studio-mind-map.md** - מפת מושגים של המוצר. שמור צילום/תמצית ל-content/.
```

### `01-source-document.md`
```markdown
> העלה קובץ זה ל-NotebookLM כ-source (Add source > Upload).

# ColorTune - מסמך מקור למצגת

**קהל:** משקיעי seed ומנהלי מוצר במיט-אפ דיזיין-טק, ~30 איש.
**כוונה:** pitch של 12 דקות שמוביל מהכאב לבקשת ההשקעה.

## נקודות תוכן
1. מעצבים מבזבזים שעות על תיקוני נגישות במקום על עיצוב. הכאב היומיומי מול contrast checker.
2. WebAIM 2025 - 96.3% מהאתרים נכשלים בבדיקת ניגודיות. התיקון יקר ולא מתוקצב.
3. ColorTune - input פלטה, output פלטה נגישה ששומרת hue והיררכיה.
4. דמו חי של 90 שניות, פלטה אמיתית מ-beta.
5. traction - 340 MAU, 12K ARR, 47 צוותים, 28% growth, 4% churn.
6. בקשה - 800K seed, לפיתוח מכירות בארה"ב ותוסף Figma.
```

### `02-deep-research.md`
```markdown
> הרץ ב-Sources > Discover. שמור את המקורות שנבחרו, ואת הסיכום, ל-content/.

Deep Research on 'competitors to ColorTune (accessible color palette tools) as of 2026'.
Return pricing, feature comparisons, and market positioning. Also gather '2024-2026
WebAIM accessibility statistics and contrast-failure data'. Exclude opinion pieces;
prefer industry reports and primary data.
```

### `03-studio-audio-brief.md`
```markdown
> Studio > Audio Overview (Brief). מטרה: חימום אודיו של 3 דקות למשקיעים שלא הגיעו. שמור את התמליל ל-content/.

הפק תקציר אודיו קצר באורך 3 דקות מהמקורות, בעברית, בנימה רגועה ומדויקת.
התמקד בכאב של עיצוב נגיש ובגודל השוק. הסבר במשפט אחד מה ColorTune עושה,
בלי לחשוף את הדמו. סיים בקריאה כללית בלי לציין סכומים.

אזהרה: איכות ה-TTS בעברית לא נבדקה רשמית ב-2026 (rtl-audio-weak, hebrew-quality-tier-c).
האזן לדגימה לפני שיתוף.
```

### `03-studio-mind-map.md`
```markdown
> Studio > Mind Map. מטרה: מבט-על על המוצר לחיבור כל הדק. שמור צילום/תמצית ל-content/.

בנה Mind Map בעברית שמתחיל בשורש "ColorTune" ומסתעף לשלושה ענפים:
כאב, פתרון, traction. כל ענף עד 4 צמתים. תמצות בלבד, בלי משפטים מלאים בצמתים.
```

## `kit_summary` returned to Point
```yaml
kit_summary:
  written_to: build/colortune-pitch-01/prompts/
  files:
    - { name: 00-INDEX.md,             purpose: מפת הערכה וסדר הרצה }
    - { name: 01-source-document.md,   purpose: מסמך מקור להעלאה }
    - { name: 02-deep-research.md,     purpose: איסוף תחרות + נתוני נגישות }
    - { name: 03-studio-audio-brief.md, purpose: חימום אודיו למשקיעים }
    - { name: 03-studio-mind-map.md,   purpose: מבט-על מוצר }
  next_instruction: >
    הרץ את הערכה לפי 00-INDEX, שמור כל תוצר שחוזר ל-build/colortune-pitch-01/content/,
    ואז חזור אליי. נקרא את מה שחזר ונערוך יחד לתוכן השקופיות.
```

Notes for human reviewer:
- **No Video Overview**: content unit 4 is a live demo; a recorded video would compete with it (catalog part 5 precision rule).
- **No Briefing Doc**: the audience is in the room and will not read a doc after a 12-minute pitch.
- Every Audio prompt carries the RTL/Hebrew-quality warning inline because `language: he`.
- The kit is emitted **before** any slides exist; it references topic and intent, not slide numbers. `serves_slides` is gone.
- The skill stops here. Slide structuring happens in Phase 4, after the content returns to `content/`.
