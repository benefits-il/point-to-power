# Expected outputs

## For `fixture-valid-ast`

```yaml
status: ok
rejections: []
warnings: []
```

POWER continues to `detect-target-html-or-ppt`.

## For `fixture-missing-meta`

```yaml
status: rejected
rejections:
  - code: meta-field-missing
    hebrew_message: "שדה חובה חסר במקטע Meta: genre. הוסף שורה: - **genre:** <ערך>"
    location: meta.genre
  - code: meta-enum-invalid
    hebrew_message: "ערך לא חוקי לשדה target: 'HTML'. הערכים המותרים: html, powerpoint, slides, ask."
    location: meta.target
  - code: duration-invalid
    hebrew_message: "שדה duration_minutes חייב להיות מספר שלם בין 1 ל-240. נמצא: '12.5'."
    location: meta.duration_minutes
warnings: []
```

POWER stops, surfaces the three Hebrew rejection messages to the learner, and does not run downstream skills. The learner fixes the source, re-emits, and pastes again.

Notes for human reviewer:

- The three rejections are emitted in a single pass , not iteratively, one at a time. The learner sees all three at once to fix in one round-trip.
- `genre` missing triggers rule 4. The substitution shows `genre` (the missing field key).
- `target: HTML` triggers rule 5. Substitutions: `{field}=target`, `{value}=HTML`, `{allowed}=html, powerpoint, slides, ask`.
- `duration_minutes: 12.5` triggers rule 6. Substitution: `{value}=12.5` (raw string as it appeared).
- No warnings because no emojis or em-dashes in any field value.
