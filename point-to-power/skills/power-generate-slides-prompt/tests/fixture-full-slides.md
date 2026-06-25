# Fixture: full input for generate-slides-prompt

Same inputs as the HTML branch, with `target` switched to `slides`. Because Gemini reads
natural-language layout, the slides branch reuses the HTML semantic-grid vocabulary (no
PowerPoint slot names).

Inputs:

- `ast`: the AST from `../parse-point-handoff/tests/expected-output.md` with `meta.target` overridden to `slides`.
- `style_record`: Editorial Light (Inter + Rubik Hebrew pair, single accent `#2563EB`, 8px base).
- `layouts`: 6 records using CSS Grid / semantic names (`hero`, `split-60-40`, `full-bleed`, `split-50-50`) , identical vocabulary to the HTML branch.
- `image_prompts`: the 5-entry image_prompts list from `../generate-visual-prompts/tests/expected-output.md`.
