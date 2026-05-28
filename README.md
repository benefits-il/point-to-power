# PointToPower (v1.0.0)

Two-agent chain for content-first presentation building:

- *Point* structures the message.
- *POWER* builds the deck.

## What it does

Point asks elicitation questions, applies proven content discipline (typography, density, bullets, story structure), and outputs a structured Markdown handoff.
POWER reads the handoff, picks a style from a catalog of 15+ options, writes per-slide layout details, and produces a final prompt for either Claude-in-PowerPoint or regular Claude (HTML deck).

## Install

This single plugin works for both Claude Code and Cowork. Pick the section that matches your environment.

### Claude Code

1. Copy this entire directory into your Claude Code plugins folder (or install via marketplace).
2. Restart Claude Code.
3. Verify both subagents are loaded by listing agents.
4. Verify both slash commands are registered: `/point` and `/power`.

### Cowork

1. Install via Cowork marketplace, or drop this directory into the Cowork local plugin path.
2. Reload Cowork plugins.
3. Verify both subagents are loaded by listing agents.
4. Verify both slash commands are registered: `/point` and `/power`.

The manifest at `.claude-plugin/plugin.json` is shared between the two environments, so both loaders auto-discover the plugin without extra configuration.

## Use

1. Activate Point: `/point` (or natural language: "אני רוצה לבנות מצגת על X").
2. Answer Point's elicitation questions in Hebrew.
3. Point produces a handoff under `build\handoff-runtime\`.
4. Activate POWER: `/power`.
5. POWER reads the latest handoff and offers style options (primary + alternative + wildcard).
6. POWER produces the final prompt for your chosen target (Claude-in-PowerPoint or regular Claude.ai for HTML).
7. Iterate with POWER: "add a visual", "switch to dark mode", etc. POWER preserves state across iterations and only re-runs the affected steps.

## Known requirements

- For PowerPoint target: Copilot Pro or Teams license (Claude-in-PowerPoint add-in).
- For HTML target: regular Claude.ai (NOT Claude Code at the learner stage).
- For Hebrew content + NotebookLM Audio/Video Overview: warnings auto-attach for RTL audio quality.

## Layout

```
point-to-power/
  .claude-plugin/plugin.json
  agents/
    point.md
    power.md
  skills/
    point-elicit-content-from-user/
    point-structure-content-to-slides/
    point-recommend-and-prompt-notebooklm/
    point-produce-handoff-md/
    power-parse-point-handoff/
    power-validate-handoff-against-contract/
    power-detect-target-html-or-ppt/
    power-select-style/
    power-write-per-slide-layout/
    power-generate-visual-prompts/
    power-generate-ppt-prompt/
    power-generate-html-prompt/
  commands/
    point.md
    power.md
  references/         (R1, R2, R3, R4 knowledge base + handoff-contract + example-handoff)
  shared/             (validation-rules.md, filesystem-conventions.md)
  assets/             (landing page assets)
  landing.html
  README.md
```

## License + Author

Built by Benefits by Ben Akiva.
