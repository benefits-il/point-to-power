# Validation Rules , Shared Helper

> Single source of truth for handoff validation. Mirrors Section 5 of `handoff-contract.md`.
> Read by `produce-handoff-md` (Point, internal pre-emit gate) and `validate-handoff-against-contract` (POWER, post-parse gate). Hebrew error templates must not drift between the two skills , both load this file.

---

## How to use

For each rule below:

- `code` , stable error identifier; never localized; used in logs and structured returns.
- `trigger` , the condition that fires the rule.
- `predicate` , one-line Python-style pseudocode that evaluates the trigger against an AST node. Treat as specification, not literal code.
- `hebrew_message` , the exact Hebrew string POWER (or Point's internal gate) emits to the learner. `{curly}` tokens are runtime substitutions; substitute from AST fields, not from English defaults.

Rejection rules block consumption. The warning rule does not block , it surfaces alongside the build output.

---

## Rejection rules (15)

### 1. `header-missing`

- **trigger:** First non-empty line (after stripping one outer code fence and leading whitespace) is not the literal `# PointToPower Handoff v1.0`.
- **predicate:** `first_nonempty_line(text_after_fence_strip) != "# PointToPower Handoff v1.0"`
- **hebrew_message:** `קובץ ההעברה לא מתחיל בשורת כותרת תקנית. הוסף בראש הקובץ את השורה המדויקת: # PointToPower Handoff v1.0`

### 2. `header-version-mismatch`

- **trigger:** Header found with literal `# PointToPower Handoff v<X.Y>` but `X != 1`.
- **predicate:** `header_match and parse_major(header_version) != 1`
- **hebrew_message:** `גרסת חוזה ההעברה אינה תואמת. נמצא: {found}. POWER תומך ב-v1.0 בלבד או בגרסאות מינוריות תואמות. בקש מ-Point להפיק מחדש בגרסת v1.0.`
- **substitutions:** `{found}` = exact version string from header (e.g., `v2.1`).

### 3. `meta-block-missing`

- **trigger:** No `## Meta` H2 heading found.
- **predicate:** `not any(h2.text == "Meta" for h2 in ast.h2_headings)`
- **hebrew_message:** `לא נמצא מקטע Meta בקובץ ההעברה. POWER דורש מקטע ## Meta מיד אחרי שורת הכותרת.`

### 4. `meta-field-missing`

- **trigger:** A required meta field (one of `target`, `audience`, `genre`, `duration_minutes`, `output_type`, `speaker_notes`, `language`) is absent from the meta bullet list.
- **predicate:** `field in REQUIRED_META and field not in ast.meta`
- **hebrew_message:** `שדה חובה חסר במקטע Meta: {field}. הוסף שורה: - **{field}:** <ערך>`
- **substitutions:** `{field}` = the missing field key.
- **note:** Fire one error per missing field. Do not collapse into a single message.

### 5. `meta-enum-invalid`

- **trigger:** A meta enum field carries a value outside its allowed set.
- **predicate:** `field in META_ENUMS and ast.meta[field] not in META_ENUMS[field]`
- **hebrew_message:** `ערך לא חוקי לשדה {field}: '{value}'. הערכים המותרים: {allowed}.`
- **substitutions:** `{field}`, `{value}` (raw, lowercased if applicable), `{allowed}` (comma-separated list).
- **enum_table:**
  - `target` -> `html, powerpoint, ask`
  - `genre` -> `pitch, keynote, ted, lecture, sales, briefing, workshop, demo`
  - `output_type` -> `presentation, teleprompter, slidedoc`
  - `speaker_notes` -> `on, off`
  - `language` -> `he, en, mixed`

### 6. `duration-invalid`

- **trigger:** `duration_minutes` is not a positive integer in range 1..240.
- **predicate:** `not (is_integer(ast.meta.duration_minutes) and 1 <= int(ast.meta.duration_minutes) <= 240)`
- **hebrew_message:** `שדה duration_minutes חייב להיות מספר שלם בין 1 ל-240. נמצא: '{value}'.`
- **substitutions:** `{value}` = the raw string POWER saw (so the learner can see "12 דקות" or "12.5" or "0").

### 7. `no-slides`

- **trigger:** Zero `## Slide <N>:` H2 headings found.
- **predicate:** `len(ast.slides) == 0`
- **hebrew_message:** `לא נמצאו שקופיות בהעברה. POWER דורש לפחות שקופית אחת.`

### 8. `slide-numbering-broken`

- **trigger:** Slide numbers are not `1..N` contiguous, or contain duplicates.
- **predicate:** `sorted([s.number for s in ast.slides]) != list(range(1, len(ast.slides) + 1))`
- **hebrew_message:** `מספור השקופיות אינו רציף או מכיל כפילויות. נמצא: {sequence}. נדרש: 1, 2, 3, ... N ברצף.`
- **substitutions:** `{sequence}` = comma-separated numbers in the order they appeared in the file.

### 9. `slide-field-missing`

- **trigger:** A required slide field (one of `key_message`, `content`, `bullets_allowed`, `visual_placeholder`) is absent from a slide block.
- **predicate:** `field in REQUIRED_SLIDE and field not in slide.fields`
- **hebrew_message:** `שדה חובה חסר בשקופית {N}: {field}. הוסף שורה: - **{field}:** <ערך>`
- **substitutions:** `{N}` = slide number, `{field}` = missing field key.
- **note:** Also fires when meta `speaker_notes=on` and a slide has no `speaker_notes` field. The `{field}` substitution in that case is `speaker_notes` per contract §3 precedence chain rule 2.

### 10. `slide-enum-invalid`

- **trigger:** A slide enum field carries a value outside its allowed set.
- **predicate:** `field in SLIDE_ENUMS and slide.fields[field] not in SLIDE_ENUMS[field]`
- **hebrew_message:** `ערך לא חוקי בשקופית {N}, שדה {field}: '{value}'. הערכים המותרים: {allowed}.`
- **substitutions:** `{N}`, `{field}`, `{value}`, `{allowed}`.
- **enum_table:**
  - `bullets_allowed` -> `true, false`

### 11. `tail-block-missing`

- **trigger:** No `## Tail` H2 heading found.
- **predicate:** `not any(h2.text == "Tail" for h2 in ast.h2_headings)`
- **hebrew_message:** `לא נמצא מקטע Tail בקובץ ההעברה. POWER דורש מקטע ## Tail בסוף הקובץ.`

### 12. `visual-queue-missing`

- **trigger:** `### Visual Queue` H3 absent inside the tail block.
- **predicate:** `not any(h3.text == "Visual Queue" for h3 in ast.tail.h3_headings)`
- **hebrew_message:** `Visual Queue חסר במקטע Tail. הוסף ### Visual Queue עם רשימת הוויזואלים לפי סדר השקופיות.`

### 13. `visual-queue-mismatch`

- **trigger:** Queue entries do not match the set of non-`none` slide placeholders.
- **predicate:** `set(queue.slide_numbers) != {s.number for s in ast.slides if s.fields.visual_placeholder != "none"}`
- **hebrew_message:** `Visual Queue אינו תואם לשדות visual_placeholder בשקופיות. הפרש: {diff}. בקש מ-Point להפיק מחדש כדי לסנכרן.`
- **substitutions:** `{diff}` = human-readable description of the diff, e.g. `חסר slide_3 בתור, יש slide_4 בתור אך השקופית מסומנת none`.

### 14. `nb-recommendation-incomplete`

- **trigger:** A NotebookLM recommendation block under `### NotebookLM Recommendation <i>` is missing one of the four required sub-fields (`feature`, `prompt`, `warnings`, `serves_slides`).
- **predicate:** `for i, rec in enumerate(ast.tail.notebooklm_recommendations, 1): missing = REQUIRED_NB_FIELDS - rec.fields.keys()`
- **hebrew_message:** `המלצת NotebookLM מספר {i} חסרה שדות חובה: {fields}.`
- **substitutions:** `{i}` = 1-based recommendation index, `{fields}` = comma-separated missing field keys.

### 15. `key-language-mismatch`

- **trigger:** A bullet-list field key (inside Meta, a Slide, or a NotebookLM Recommendation) is written in Hebrew instead of English snake_case.
- **predicate:** `any(contains_hebrew_char(key) for key in collect_all_bullet_keys(ast))`
- **hebrew_message:** `מפתח שדה אינו באנגלית: '{key}'. החוזה דורש מפתחות באנגלית snake_case. תרגם את המפתח לאנגלית.`
- **substitutions:** `{key}` = the offending Hebrew key string.

---

## Warning rules (1)

### W1. `forbidden-glyph`

- **trigger:** Emoji or em-dash (`,`, U+2014) found in any field value (meta value, slide field value, recommendation field value, notes-to-power text).
- **predicate:** `any(is_emoji(c) or c == "," for c in collect_all_field_values(ast))`
- **hebrew_message:** `נמצאו תווים אסורים בשדה {location}: {chars}. POWER ימשיך לבנות, אך מומלץ לנקות אותם בקובץ המקור.`
- **substitutions:** `{location}` = canonical path like `meta.audience` or `slide_3.content`, `{chars}` = the offending characters as a comma-separated list (literal display).
- **behavior:** Does NOT block consumption. Surfaces alongside the build output.

---

## Required-field constants (single source)

```
REQUIRED_META       = {target, audience, genre, duration_minutes, output_type, speaker_notes, language}
OPTIONAL_META       = {style_preference, generated_at, session_id}
REQUIRED_SLIDE      = {key_message, content, bullets_allowed, visual_placeholder}
OPTIONAL_SLIDE      = {speaker_notes}   # conditional per meta.speaker_notes
REQUIRED_NB_FIELDS  = {feature, prompt, warnings, serves_slides}
```

Any future v1.x append-only fields are NOT added to the REQUIRED sets , they go into the OPTIONAL sets per contract §6 versioning policy.

---

## Rule evaluation order (recommended)

Apply rules in this order. Stop at the first rejection in the same group; collect across groups.

1. Header group: rule 1, then 2.
2. Meta group: rule 3, then 4, 5, 6 (collect all failures, do not stop on first).
3. Slide group: rule 7, then 8, then 9, 10 per slide (collect across slides).
4. Tail group: rule 11, then 12, then 13.
5. Recommendations group: rule 14 (collect across recommendations).
6. Cross-cutting: rule 15.
7. Warnings pass: warning rule 1.

This order makes the most actionable error surface first: the learner cannot fix slide enums if the header is missing.
