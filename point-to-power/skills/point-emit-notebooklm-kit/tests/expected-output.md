# Expected output - emitted kit for `fixture-intake`

The skill builds two folders under `build/colortune-pitch-01/` and returns `kit_summary` to Point. The kit is VISUAL plus BRIEFS only , no Audio, no Mind Map (G6). Video is omitted here because content unit 4 is a live demo (a recorded video would compete with it, catalog part 5 precision rule).

## `01-upload-to-notebooklm/`

### `00-source-document.md`
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

### `_manifest.md`
```markdown
# מה להעלות ל-NotebookLM

- [signal] 00-source-document.md , העלה כ-source. זה הזרע לכל התוצרים.

(בפיקסצ'ר הזה אין קבצי-מקור גולמיים נוספים. אם המשתמש היה מספק קבצים, הם היו מופיעים כאן עם [signal] להעלאה או [noise] לדילוג.)
```

## `02-notebooklm-prompts/` (כל קובץ = רק הפרומפט)

### `00-INDEX.md`
```markdown
# ערכת NotebookLM - colortune-pitch-01

העלה קודם את מה שמסומן [signal] ב-01-upload-to-notebooklm/_manifest.md. אחר כך הרץ את הפרומפטים בסדר הזה. שמור כל תוצר שחוזר ל-build/colortune-pitch-01/03-returns/, וסמן ב-_liked.md מה אהבת, ואז חזור אליי (Point).

1. **01-deep-research.md** , הרץ ב-Sources > Discover לאיסוף תחרות ונתוני נגישות.
2. **02-brief-exec.md** , מסמך BRIEF: תקציר-מנהלים. הורד אותו, זה תוכן לעבוד איתו.
3. **02-brief-key-points.md** , מסמך BRIEF: נקודות-מפתח עם נתונים.
4. **03-visual-infographic-a.md** , אינפוגרפיק (זווית הכאב והשוק).
5. **03-visual-infographic-b.md** , אינפוגרפיק (זווית ה-traction).
6. **03-visual-sample-deck.md** , מצגת-דוגמה להשראת-סגנון.
```

### `01-deep-research.md`
```markdown
Deep Research on 'competitors to ColorTune (accessible color palette tools) as of 2026'.
Return pricing, feature comparisons, and market positioning. Also gather '2024-2026
WebAIM accessibility statistics and contrast-failure data'. Exclude opinion pieces;
prefer industry reports and primary data.
```

### `02-brief-exec.md`
```markdown
צור Briefing Doc מהמקורות: תקציר מנהלים ל-ColorTune. כלול את הכאב (תיקוני נגישות יקרים),
גודל השוק, מה המוצר עושה, ו-3 נקודות traction. דלג על רקע מבואי. עד 600 מילה.
```

### `02-brief-key-points.md`
```markdown
צור Briefing Doc מהמקורות: נקודות-המפתח של ColorTune עם הנתונים המספריים המדויקים
(96.3% כשל ניגודיות, 340 MAU, 12K ARR, 28% growth, 4% churn). כל נקודה עם מקור. עד 500 מילה.
```

### `03-visual-infographic-a.md`
```markdown
צור Infographic בסגנון Professional. תוכן מדויק: כותרת מובילה "נגישות עולה לנו שעות",
שלוש נקודות תמיכה: 96.3% מהאתרים נכשלים, התיקון לא מתוקצב, ColorTune מתקן בלי לשבור היררכיה,
וקריאה-לפעולה: "פלטה נגישה בלחיצה". היררכיה ויזואלית לפי חשיבות.

design system (ברירת-מחדל נקייה לפי ההעדפה "נקי ובוטח, פחות צבעוני"):
- פלטה: #0F766E ראשי, #115E59 משני, #FFFFFF רקע, #0F172A טקסט.
- טיפוגרפיה: Rubik לכותרות, Assistant לגוף.
- 30% white space מינימום, בלי קישוט שלא נושא מידע, בלי טקסט שלא צוין.
```

### `03-visual-infographic-b.md`
```markdown
צור Infographic בסגנון Bento Grid. תוכן מדויק: כותרת "Traction", ושש לבנות:
340 MAU, 12K ARR, 47 צוותים, 28% growth חודשי, 4% churn, תוסף Figma בדרך.

design system (זהה לעיל):
- פלטה: #0F766E ראשי, #115E59 משני, #FFFFFF רקע, #0F172A טקסט.
- טיפוגרפיה: Rubik לכותרות, Assistant לגוף.
- בלי קישוט שלא נושא מידע, בלי טקסט שלא צוין.
```

### `03-visual-sample-deck.md`
```markdown
צור מצגת-דוגמה מהמקורות, 6 שקופיות מקסימום, בעברית. זו דוגמת-השראה לסגנון, לא המצגת הסופית.
כל כותרת משפט-פעולה, עד 3 בולטים לשקופית עם נתון או דוגמה. שקופית אחרונה: המלצה אחת חדה.
תוכן: בנה סביב הכאב, הפתרון (ColorTune), וה-traction.

design system (זהה לעיל): פלטה #0F766E/#115E59/#FFFFFF/#0F172A, Rubik לכותרות, Assistant לגוף, סגנון נקי.
ייצא PPTX.
```

## `kit_summary` returned to Point
```yaml
kit_summary:
  upload_to: build/colortune-pitch-01/01-upload-to-notebooklm/
  prompts_in: build/colortune-pitch-01/02-notebooklm-prompts/
  upload_files:
    - { name: 00-source-document.md, mark: signal }
  prompt_files:
    - { name: 00-INDEX.md,                  purpose: מפת הערכה וסדר הרצה }
    - { name: 01-deep-research.md,          purpose: איסוף תחרות + נתוני נגישות }
    - { name: 02-brief-exec.md,             purpose: BRIEF תקציר-מנהלים (תוכן) }
    - { name: 02-brief-key-points.md,       purpose: BRIEF נקודות-מפתח עם נתונים }
    - { name: 03-visual-infographic-a.md,   purpose: אינפוגרפיק , כאב ושוק }
    - { name: 03-visual-infographic-b.md,   purpose: אינפוגרפיק , traction }
    - { name: 03-visual-sample-deck.md,     purpose: מצגת-דוגמה להשראת-סגנון }
  next_instruction: >
    העלה את מה שמסומן signal, הרץ את הפרומפטים לפי 00-INDEX, שמור כל תוצר שחוזר ל-
    build/colortune-pitch-01/03-returns/ וסמן ב-_liked.md מה אהבת, ואז חזור אליי.
```

Notes for human reviewer:
- **No Audio, no Mind Map** (G6): the kit is visual artifacts plus BRIEF documents only.
- **No Video here**: content unit 4 is a live demo; a recorded video would compete with it (catalog part 5 precision rule). For a deck without a live demo, the kit would also include one `03-visual-video.md`.
- **Every visual prompt is self-contained** (G7): each carries a full design-system block (exact hex, fonts) plus the actual content, never "add your content here".
- The intake had no brand design system, so Point proposed a clean default consistent with the learner's `style_preference` ("נקי ובוטח, פחות צבעוני") before emitting the visual prompts.
- The kit is built **before** any slides exist; it references topic and intent, not slide numbers.
- The skill stops here. Slide structuring happens in Phase 4, after the content returns to `03-returns/`.
