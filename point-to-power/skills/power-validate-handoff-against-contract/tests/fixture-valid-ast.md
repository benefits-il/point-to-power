# Fixture: valid AST

The AST produced by `parse-point-handoff` from the canonical example-handoff.md. See `../parse-point-handoff/tests/expected-output.md` for the full structure.

Key invariants of this AST that should drive a `status: ok` result:

- header_version = "v1.0"
- meta has all 7 required fields with valid enum values; duration_minutes = "12" (parseable to int 12, in range).
- 6 slides, numbered 1..6 contiguously, no duplicates. Each slide has all 4 required fields. Slide 4 carries `speaker_notes: "off"` (valid per precedence chain).
- Tail has `### Visual Queue` with 5 entries matching the 5 non-`none` slide placeholders.
- 2 NotebookLM recommendations, each with all 4 required fields.
- All values are emoji-free and em-dash-free.
- All bullet keys are English snake_case.
