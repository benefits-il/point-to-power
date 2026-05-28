# Fixture: full input for generate-ppt-prompt

Same inputs as the HTML branch, with `target` switched to `powerpoint` and layouts re-emitted in PowerPoint slot vocabulary.

Inputs:

- `ast`: the AST from `../parse-point-handoff/tests/expected-output.md` with `meta.target` overridden to `powerpoint`.
- `style_record`: Editorial Light (Inter + Rubik Hebrew pair, single accent `#2563EB`, 8px base).
- `layouts`: 6 records using PowerPoint slot names (`title-content`, `section-header`, `title-image`, `two-content`) instead of CSS Grid names.
- `image_prompts`: the 5-entry image_prompts list from `../generate-visual-prompts/tests/expected-output.md`.
