# Expected output , produce-handoff-md for `fixture-full-input`

The skill emits the file at:

```
build\colortune-pitch-01\handoff\20260604-2214-colortune-pitch-01.md
```

The file content is byte-equivalent to `references/example-handoff.md`. That fixture is, by design, the canonical PointToPower Handoff v1.0 sample, and the skill's job here is to recreate it from structured inputs.

To verify the expected output, read `../../../../references/example-handoff.md` directly. It is the same file the skill should produce.

Return value structure:

```yaml
handoff_markdown: |
  # PointToPower Handoff v1.0
  ...
  (full content of references/example-handoff.md)

filesystem_path: build\colortune-pitch-01\handoff\20260604-2214-colortune-pitch-01.md

warnings: []
```

Notes for human reviewer:

- `warnings` is an empty list because the input contains no emojis and no em-dashes.
- The header line is byte-exact: `# PointToPower Handoff v1.0`.
- The `## Tail` block includes both NotebookLM Recommendation H3s, the Visual Queue H3 with five entries (slide_2 is excluded because its visual_placeholder is `none`), and the Notes To POWER H3.
- The internal validation gate runs and returns 0 rejections before emission. If it had returned any, the skill would have looped to fix them locally rather than emit a broken file.
