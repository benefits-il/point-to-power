# PointToPower Handoff Contract v1.0

> Authoritative schema for every Point to POWER handoff file.
> Both agents are built against this document. Skills in Steps 3 through 6 read this contract as their source of truth.

---

## 1. Header

Every handoff file MUST begin with this exact line as its first non-empty line:

```
# PointToPower Handoff v1.0
```

**Why it is required.** The header is the self-anchor. POWER receives handoffs through two channels: a filesystem read (Claude Code / Cowork) and a copy-paste into chat (Claude.ai). In the paste channel there is no filename, no MIME type, no folder context. The header is the only signal that the pasted body is a PointToPower handoff and not arbitrary text. The version token in the header gates which POWER builds can consume the file.

**How POWER validates.**

1. POWER trims leading whitespace and any single outer code fence (one of `` ``` ``, ``` ```markdown ```, ``` ```md ```) before reading the first line.
2. POWER compares the first non-empty line against the literal string `# PointToPower Handoff v1.0`.
3. On match, POWER continues parsing. On mismatch, POWER stops and emits the corresponding header error from Section 5.
4. POWER does not accept variants such as `# PointToPower Handoff` (no version), `# PointToPower Handoff V1.0` (capital V), or `# POINTTOPOWER Handoff v1.0` (case shift). The match is exact and case-sensitive.

**Position rule.** The header MUST be the first non-empty line. Lines above it that are blank are tolerated. Any non-blank line above the header causes rejection.

---

## 2. Meta block

The meta block starts with the H2 heading `## Meta` and ends at the next H2 heading. Inside the block, each field is a markdown bullet of the form `- **<key>:** <value>`. Keys are in English, snake_case. Values follow the per-field rules below. Field order inside the block is fixed and follows the order in this section.

### Field specification

| # | Field | Type | Required | Allowed values | Validation |
|---|---|---|---|---|---|
| 1 | `target` | enum | Required | `html` \| `powerpoint` \| `ask` | Lowercase only. `ask` means Point could not determine the target; POWER will ask the learner before building. |
| 2 | `audience` | free text (he) | Required | Free text, max 240 chars | Pointer guideline: R1 ch08 audience taxonomy. POWER treats this as soft signal for the Style Decision Tree. |
| 3 | `genre` | enum | Required | `pitch` \| `keynote` \| `ted` \| `lecture` \| `sales` \| `briefing` \| `workshop` \| `demo` | Lowercase only. Drives genre-specific rules in both Point's emit logic and POWER's style routing. |
| 4 | `duration_minutes` | integer | Required | 1..240 | Integer only, no decimals, no units suffix. POWER uses this for slide pacing checks. |
| 5 | `output_type` | enum | Required | `presentation` \| `teleprompter` \| `slidedoc` | Duarte taxonomy from R1 ch00. Controls Point's density rules and POWER's layout density. |
| 6 | `speaker_notes` | enum | Required | `on` \| `off` | Global default. Per-slide override is documented in Section 3. |
| 7 | `language` | enum | Required | `he` \| `en` \| `mixed` | Drives R2 RTL warnings, R3 font pairing rules, and R4 localization paths. |
| 8 | `style_preference` | free text (he or en) | Optional | Free text, max 120 chars | If Point captured a style hint from the learner, it goes here. POWER treats it as a soft prior. The Decision Tree still has final say per R3. |
| 9 | `generated_at` | ISO 8601 string | Optional | `YYYY-MM-DDTHH:MM:SS` | When omitted, POWER uses file mtime if available, else now. |
| 10 | `session_id` | free text (en) | Optional | Free text, max 60 chars, ASCII | Echoes the filename slug. Useful for cross-referencing. |

**Total meta fields: 10. Required: 7. Optional: 3.**

### Example meta block

```markdown
## Meta

- **target:** html
- **audience:** משקיעים בתחילת דרכם וצוות מוצר משולב במיט-אפ של 30 איש
- **genre:** pitch
- **duration_minutes:** 12
- **output_type:** presentation
- **speaker_notes:** on
- **language:** he
- **style_preference:** משהו נקי ובוטח, פחות צבעוני
- **generated_at:** 2026-06-04T22:14:00
- **session_id:** colortune-pitch-01
```

### Why bullet list with bold keys

The meta block uses a markdown bullet list of `- **key:** value` lines rather than a YAML fenced block. Bullets survive copy-paste round-trips through chat (YAML fences sometimes lose their fence on paste), and the same bullet pattern is reused inside slide blocks, so Point's emit logic and POWER's parser handle one shape across the whole file.

---

## 3. Slide block

A slide block starts with the H2 heading:

```
## Slide <N>: <title>
```

`<N>` is the 1-based slide number. `<title>` is free Hebrew text. POWER parses `<N>` from the heading via regex and treats everything between this H2 and the next H2 as the slide's body.

Slide blocks MUST be numbered contiguously from 1 to the total slide count. Gaps (missing 3 between 2 and 4) and duplicates (two `## Slide 2`) cause rejection.

### Field specification

| # | Field | Type | Required | Allowed values | Validation |
|---|---|---|---|---|---|
| 1 | `key_message` | free text (he) | Required | Single sentence, max 200 chars | One sentence. Period at end allowed but not required. |
| 2 | `content` | free text (he), multi-line | Required | Multi-line. Indent continuation lines by two spaces. An empty line ends the field. | Density per R1 ch02; Point decides bullets per R1 ch04. |
| 3 | `bullets_allowed` | enum | Required | `true` \| `false` | Lowercase. Point's explicit decision per Doumont conditional. POWER respects this when laying out the slide. |
| 4 | `visual_placeholder` | free text (he or en), single line | Required | Free text, max 280 chars, or the literal `none` | When set to `none`, the slide has no visual and is excluded from the visual queue in the tail. Otherwise describes what the visual must convey. |
| 5 | `speaker_notes` | free text (he), multi-line | Optional override | Same multi-line rule as `content`. When omitted, the meta-level `speaker_notes` value applies. When present and the meta value is `on`, this block is the slide's notes. When present and the value is the literal `off`, the slide has no notes regardless of meta. |

**Total slide fields: 5. Required: 4. Optional override: 1.**

The slide title is carried by the H2 heading and is NOT a separate field inside the block.

### Field order inside the block

Bullets appear in the order: `key_message`, `content`, `bullets_allowed`, `visual_placeholder`, `speaker_notes`. POWER's regex parser uses field-key matching first and falls back to positional matching when a key string is corrupted.

### Multi-line field rule (canonical)

A multi-line field begins on the same line as its key:

```markdown
- **content:** השורה הראשונה של הגוף.
  שורת המשך עם הזחה של שני רווחים.
  שורה נוספת.
- **bullets_allowed:** false
```

The two-space indent on continuation lines is mandatory. An empty line terminates the field, after which the parser expects either the next bullet or the next H2.

### Per-slide override semantics

`speaker_notes` follows a precedence chain:

1. If meta `speaker_notes` is `off` and the slide has no `speaker_notes` field, the slide has no notes.
2. If meta `speaker_notes` is `on` and the slide has no `speaker_notes` field, POWER treats the absence as an error and rejects (Point must emit the notes for every slide when meta is `on`).
3. If meta `speaker_notes` is `on` and the slide carries `speaker_notes: off` (literal one-line value), POWER skips notes for that slide only.
4. If the slide carries multi-line `speaker_notes` content, that content is the notes regardless of meta.

### Example slide block

```markdown
## Slide 1: למה אנחנו חיים בעולם נגיש פחות

- **key_message:** מעצבים מבזבזים שעות על תיקוני נגישות במקום על עיצוב.
- **content:** בכל פרויקט יש שלב שבו המעצב פותח את ה-Figma, מריץ בדיקת ניגודיות,
  ומגלה שחצי מהפלטה לא עוברת. החלפת הצבעים שוברת את ההיררכיה.
  התיקון לוקח שעות שלא תוקצבו.
- **bullets_allowed:** false
- **visual_placeholder:** איור שטוח של מעצב מול מסך עם פלטת צבעים, חלקה אדום מסומן כ-FAIL.
- **speaker_notes:** התחילי בלהזכיר לקהל מתי בפעם האחרונה הם פתחו contrast checker.
  השתהי שתי שניות. שמרי על קצב איטי בשקופית הזו.
```

---

## 4. Tail block

The tail block starts with the H2 heading `## Tail` and ends at the end of file. It contains three optional or required sub-sections, each introduced by an H3 heading. H3 is the deepest heading level allowed in this contract.

### Sub-section specification

| # | Sub-section | H3 heading | Required | Description |
|---|---|---|---|---|
| 1 | `notebooklm_recommendations` | `### NotebookLM Recommendation <i>` | Optional, 0..N | One H3 per recommendation, numbered from 1. Each recommendation is a bullet block with four fields. |
| 2 | `visual_queue` | `### Visual Queue` | Required | Aggregates every per-slide `visual_placeholder` that is not `none`, in slide order. POWER batch-generates image prompts from this queue. |
| 3 | `notes_to_power` | `### Notes To POWER` | Optional | Free Hebrew text. Any context POWER needs that did not fit elsewhere. |

**Total tail sub-sections: 3. Required: 1. Optional: 2.**

### NotebookLM Recommendation structure

Each `### NotebookLM Recommendation <i>` H3 is followed by a bullet block with these exact fields, in this order:

| # | Field | Type | Required | Notes |
|---|---|---|---|---|
| 1 | `feature` | free text (en or he) | Required | Feature name from R2 catalog. Free text so Point can phrase naturally, e.g. `Audio Overview - Brief` or `Mind Map`. |
| 2 | `prompt` | free text (he), multi-line | Required | Ready-to-paste prompt for the learner. Multi-line rule from Section 3 applies. Backticks inside the prompt are written as literal backticks (no escaping needed; the bullet body does not interpret them as fence). |
| 3 | `warnings` | free text (en), single line, comma-separated | Required | One or more warning tokens. Use the literal `none` when there is no warning. Known tokens: `rtl-audio-weak`, `stale-watch`, `hebrew-quality-tier-c`, `pro-tier-required`. Point may introduce new tokens; POWER passes unknown tokens through to the learner. |
| 4 | `serves_slides` | comma-separated integers | Required | Slide numbers the recommendation supports. Use the literal `all` to mean every slide. |

### Visual Queue structure

The Visual Queue contains one bullet per slide that has a non-`none` visual_placeholder, in slide order, formatted exactly as:

```markdown
- **slide_<N>:** <copy of the slide's visual_placeholder value>
```

POWER cross-checks the queue against the slides: every non-`none` placeholder must appear in the queue, and every queue entry must reference a slide whose placeholder matches. Mismatches cause rejection.

### Notes To POWER structure

A single block of free Hebrew text under the H3. No internal structure required. Cap at 400 words.

### Example tail block

```markdown
## Tail

### NotebookLM Recommendation 1

- **feature:** Audio Overview - Brief
- **prompt:** הפק תקציר אודיו קצר באורך 3 דקות מהמסמכים המצורפים, בעברית,
  בנימה רגועה ומדויקת. הדגש את שלושת הכאבים המרכזיים שמופיעים בשקופיות 1 ו-2,
  והסבר במשפט אחד את הפתרון בלי לחשוף את הדמו של שקופית 4.
- **warnings:** rtl-audio-weak, hebrew-quality-tier-c
- **serves_slides:** 1, 2

### NotebookLM Recommendation 2

- **feature:** Mind Map
- **prompt:** בנה Mind Map שמתחיל בשורש "ColorTune"
  ומסתעף ל-3 ענפים: כאב, פתרון, traction. כל ענף עד 4 צמתים.
- **warnings:** none
- **serves_slides:** all

### Visual Queue

- **slide_1:** איור שטוח של מעצב מול מסך עם פלטת צבעים, חלקה אדום מסומן כ-FAIL.
- **slide_3:** צילום מסך של ה-UI של ColorTune עם פלטה שנוצרה אוטומטית.
- **slide_4:** וידאו 8 שניות של תהליך הפקת פלטה חיה.
- **slide_5:** גרף עמודות פשוט: מספר משתמשים פעילים חודשי, 6 חודשים אחרונים.
- **slide_6:** תמונה רגועה של מסך לפטופ פתוח עם הלוגו.

### Notes To POWER

הקהל מעורב, חצי טכני וחצי משקיעים. שמור על קצב מהיר בשקופיות 1 ו-2,
ותן זמן נשימה בשקופית 4 שזו ה-wow.
```

---

## 5. Validation rules

POWER refuses to consume any handoff that violates a rejection rule. Every error message below is the exact Hebrew template POWER emits to the learner. Variables in `{curly}` are substituted at runtime.

### Rejection rules

| # | Code | Trigger | Hebrew error message |
|---|---|---|---|
| 1 | `header-missing` | First non-empty line is not the literal header | `קובץ ההעברה לא מתחיל בשורת כותרת תקנית. הוסף בראש הקובץ את השורה המדויקת: # PointToPower Handoff v1.0` |
| 2 | `header-version-mismatch` | Header found but version is not `v1.0` or compatible `v1.x` | `גרסת חוזה ההעברה אינה תואמת. נמצא: {found}. POWER תומך ב-v1.0 בלבד או בגרסאות מינוריות תואמות. בקש מ-Point להפיק מחדש בגרסת v1.0.` |
| 3 | `meta-block-missing` | No `## Meta` H2 found | `לא נמצא מקטע Meta בקובץ ההעברה. POWER דורש מקטע ## Meta מיד אחרי שורת הכותרת.` |
| 4 | `meta-field-missing` | A required meta field is absent | `שדה חובה חסר במקטע Meta: {field}. הוסף שורה: - **{field}:** <ערך>` |
| 5 | `meta-enum-invalid` | A meta enum field carries a value outside its allowed set | `ערך לא חוקי לשדה {field}: '{value}'. הערכים המותרים: {allowed}.` |
| 6 | `duration-invalid` | `duration_minutes` is not a positive integer in range 1..240 | `שדה duration_minutes חייב להיות מספר שלם בין 1 ל-240. נמצא: '{value}'.` |
| 7 | `no-slides` | Zero slide blocks found | `לא נמצאו שקופיות בהעברה. POWER דורש לפחות שקופית אחת.` |
| 8 | `slide-numbering-broken` | Slide numbers are not 1..N contiguous, or have duplicates | `מספור השקופיות אינו רציף או מכיל כפילויות. נמצא: {sequence}. נדרש: 1, 2, 3, ... N ברצף.` |
| 9 | `slide-field-missing` | A required slide field is absent | `שדה חובה חסר בשקופית {N}: {field}. הוסף שורה: - **{field}:** <ערך>` |
| 10 | `slide-enum-invalid` | A slide enum field carries a value outside its allowed set | `ערך לא חוקי בשקופית {N}, שדה {field}: '{value}'. הערכים המותרים: {allowed}.` |
| 11 | `tail-block-missing` | No `## Tail` H2 found | `לא נמצא מקטע Tail בקובץ ההעברה. POWER דורש מקטע ## Tail בסוף הקובץ.` |
| 12 | `visual-queue-missing` | `### Visual Queue` H3 absent inside the tail | `Visual Queue חסר במקטע Tail. הוסף ### Visual Queue עם רשימת הוויזואלים לפי סדר השקופיות.` |
| 13 | `visual-queue-mismatch` | Queue entries do not match the set of non-`none` slide placeholders | `Visual Queue אינו תואם לשדות visual_placeholder בשקופיות. הפרש: {diff}. בקש מ-Point להפיק מחדש כדי לסנכרן.` |
| 14 | `nb-recommendation-incomplete` | A NotebookLM recommendation block is missing one of its four required sub-fields | `המלצת NotebookLM מספר {i} חסרה שדות חובה: {fields}.` |
| 15 | `key-language-mismatch` | A field key is written in Hebrew instead of English | `מפתח שדה אינו באנגלית: '{key}'. החוזה דורש מפתחות באנגלית snake_case. תרגם את המפתח לאנגלית.` |

### Warning rule

| # | Code | Trigger | Hebrew warning message |
|---|---|---|---|
| 1 | `forbidden-glyph` | Emoji or em-dash found in any field value | `נמצאו תווים אסורים בשדה {location}: {chars}. POWER ימשיך לבנות, אך מומלץ לנקות אותם בקובץ המקור.` |

The warning does not block consumption; it surfaces to the learner alongside the build output so they can clean the source for next time.

**Total validation rules: 16 (15 rejection rules + 1 warning rule).**

---

## 6. Versioning policy

The contract uses semantic versioning of the form `vMAJOR.MINOR`.

### v1.0 to v1.x (non-breaking)

The only allowed change between v1.0 and any v1.x is appending optional fields at the END of the meta block, slide block, or tail block. Existing field semantics, enums, ordering, and required/optional flags do not change.

A POWER build that supports v1.0 MUST accept any v1.x handoff. Unknown fields it does not recognize are silently ignored. The version-mismatch error fires only when the major version differs.

### v2.0 and beyond (breaking)

A bump to v2.0 is reserved for breaking changes: removing fields, changing field types, changing enum values, restructuring blocks, or changing the header line. A POWER build that supports only v1.x MUST refuse v2.x handoffs with the version-mismatch error.

### Migration responsibility

When a schema bump ships, Point and POWER MUST bump in lockstep within the same plugin release. The plugin release notes document the bump, the rationale, and any migration the learner needs to perform on existing handoff files.

---

## 7. Filesystem path (Claude Code and Cowork)

When Point runs in the Claude Code plugin or the Cowork plugin, it writes handoff files to:

```
build\handoff-runtime\<YYYYMMDD-HHMM>-<slug>.md
```

### Components

- `<YYYYMMDD-HHMM>`: timestamp of the moment Point emitted the file. Example: `20260604-2214`.
- `<slug>`: source priority order:
  1. Point's session id when known (e.g., `colortune-pitch-01`).
  2. A learner-supplied label captured during elicitation (e.g., `q3-board-deck`).
  3. The literal `untitled` when neither is available.

The slug is ASCII, lowercase, words separated by hyphens. Maximum 40 chars.

### Directory creation

Point's emit skill creates the `build\handoff-runtime\` directory if it does not exist. POWER's intake skill reads the most recent file by default, or a specific filename passed by the learner.

### Retention

The plugin does not delete old handoff files. Cleanup is the learner's responsibility.

---

## 8. Copy-paste path (Claude.ai)

When the learner uses the Claude.ai Projects packaging, there is no filesystem. The flow is:

1. Point finishes elicitation in its own chat and prints the complete handoff Markdown as its final message.
2. The learner copies from the line `# PointToPower Handoff v1.0` through the last line of the message.
3. The learner opens a fresh POWER chat and pastes the body as their first message.
4. POWER recognizes the paste by the header line and proceeds with intake.

### Partial paste handling

If POWER receives a first message that does not begin with the exact header line, POWER asks the learner:

```
לא זיהיתי כותרת תקנית של PointToPower Handoff בהודעה.
ודא שהעתקת מהשורה: # PointToPower Handoff v1.0
ועד סוף הקובץ. הדבק שוב, ואני אמשיך.
```

If POWER receives the header but is missing the `## Meta` block or the `## Tail` block, it responds with the matching rejection error from Section 5 and waits for a re-paste.

### Code fence tolerance

The learner sometimes wraps the paste in a single outer code fence. POWER strips one outer fence of any of these forms before parsing:

```
```
```markdown
```md
```

A double-nested fence or a fence in a different language token causes rejection with the header error (treated as if the header line was missing).

---

## 9. Anti-patterns

Concrete examples of malformed handoffs and POWER's response to each. Point's emit skill should treat this section as a do-not-do list.

### Anti-pattern 1: Pasting only the slide blocks

The learner pastes the body starting from `## Slide 1: ...` without the header line or the meta block.

POWER response: rejects with `header-missing` (rule 1).

### Anti-pattern 2: Header line typo

The learner edits the file and writes `# PointToPower Handoff V1.0` (capital V) or `# PointToPower Handoff 1.0` (missing v).

POWER response: rejects with `header-missing` (the literal-match comparison fails).

### Anti-pattern 3: Wrong slide heading depth

Point emits slide titles as `# Slide 1: ...` (H1) instead of `## Slide 2: ...` (H2).

POWER response: cannot find slide blocks under `##`, rejects with `no-slides` (rule 7).

### Anti-pattern 4: Slide numbering gap

The file contains `## Slide 1:`, `## Slide 2:`, `## Slide 4:` with slide 3 missing.

POWER response: rejects with `slide-numbering-broken` (rule 8), echoing the broken sequence in the error.

### Anti-pattern 5: Emoji in a field value

Point's elicitation accidentally captured an emoji and embedded it in `audience` or `content`.

POWER response: emits the `forbidden-glyph` warning (warning rule 1) and continues to build. The learner sees the warning in the final output and is expected to clean the source for next time.

### Anti-pattern 6: Empty content with bullets allowed

A slide carries `content:` with an empty value and `bullets_allowed: true`.

POWER response: the missing content fires `slide-field-missing` (rule 9) for `content`. The combination is invalid before the bullets question even matters.

### Anti-pattern 7: Stub visual placeholder

A slide carries `visual_placeholder: image` or `visual_placeholder: tbd`.

POWER response: accepts the value (it is a non-`none` string of valid length), but the Visual Queue inherits the stub. POWER includes the stub in its image-prompt batch and surfaces a soft note in the build output: `שקופית {N} מכילה תיאור ויזואלי קצר מאוד. הוויזואל ייוצר כללי. שקול להעשיר את התיאור.`

### Anti-pattern 8: Hebrew field keys

A learner edits the file and rewrites a key as `- **כותרת:** ...`.

POWER response: the parser does not match a known English key. After failing key-based lookup, POWER reports `key-language-mismatch` (rule 15) with the offending Hebrew key string.

---

## End of contract

Any change to this document is a schema change and follows the versioning policy in Section 6.
