# PointToPower (v2.1.0)

Two-agent chain for content-first presentation building, as a Claude Code / Cowork plugin:

- *Point* structures the message and prepares a clean package.
- *POWER* builds the deck prompt.

## What it does

**Point** runs a content loop in a fixed, six-step order (it never skips a step):

1. Intake , collects the raw material and the essence of the content.
2. NotebookLM (mandatory) , Point builds an organized folder: what to upload, and clean copy-ready prompts that produce BRIEF documents (content) plus visual inspiration in the brand's design style (infographics, sample decks, a video). No audio, no mind-map.
3. The learner runs the kit in NotebookLM and returns the artifacts, marking what they liked.
4. Co-edit , Point builds the slide content from the returned research, shows the slide sequence and emphases, and asks the remaining questions.
5. Approval , the learner approves the structure.
6. Package , Point assembles a clean package for POWER and writes a presenter handbook (what to say on each slide). **Point never builds the presentation itself.**

**POWER** reads the package, interviews the learner briefly on design, picks a style from a catalog of 15+ options, writes per-slide layout, and produces a final, design-system-rich prompt for the chosen target (Claude-in-PowerPoint, regular Claude.ai for an effects-rich HTML deck, or Gemini for Google Slides), plus self-contained image prompts in the chat. **POWER never renders the deck and never generates images itself , it emits prompts the learner runs in the target tool.**

## Install (two ways, same plugin)

### A. Marketplace (recommended)

```
/plugin marketplace add benefits-il/point-to-power
/plugin install point-to-power@benefits-plugins
```

Then restart / reload, and verify `/point` and `/power` are registered.

### B. Download the plugin zip

1. Download `point-to-power-plugin.zip` from the landing page (`benefits-il.dev/point-to-power`).
2. Extract it. You get a `point-to-power/` folder.
3. Drop that folder into your Cowork / Claude Code plugins folder and reload.
4. Verify `/point` and `/power` are registered.

Both paths install the same plugin and work in Claude Code and Cowork.

## Use

1. Activate Point: `/point` (or natural language: "אני רוצה לבנות מצגת על X").
2. Answer Point's intake questions in Hebrew.
3. Point builds the NotebookLM folder under `build\<slug>\`:
   - `01-upload-to-notebooklm\` , upload what `_manifest.md` marks `[signal]`.
   - `02-notebooklm-prompts\` , run these in NotebookLM (briefs + visuals).
   - Save what comes back to `03-returns\` and mark what you liked in `_liked.md`.
4. Return to Point. It co-edits the returned research into slides and asks for approval.
5. After you approve, Point writes:
   - `04-package-for-power\` , the clean package for POWER (handoff + selected assets).
   - `presenter-handbook.md` , what to say on each slide (for you, the presenter).
6. Activate POWER: `/power`. POWER reads `04-package-for-power\`, confirms the target, interviews you briefly on design, and offers style options (primary + alternative + wildcard).
7. POWER produces the final prompt for your chosen target plus self-contained image prompts. You run them in the target tool / image tool.
8. Iterate with POWER: "add a visual", "switch to dark mode", etc. POWER preserves state and re-runs only the affected steps.

## Known requirements

- For the PowerPoint target: Copilot Pro or Teams license (Claude-in-PowerPoint add-in).
- For the HTML target: regular Claude.ai builds the single-file deck from POWER's prompt.
- For the Google Slides target: Gemini (Canvas / Gemini-in-Slides) builds the deck; the output is a draft that needs polish after export.
- For Hebrew content + NotebookLM Video Overview: an RTL audio-quality warning auto-attaches.

## Layout

```
point-to-power/                 (repo root = plugin marketplace + landing page)
  .claude-plugin/marketplace.json
  point-to-power/               (the plugin , installed as point-to-power@benefits-plugins)
    .claude-plugin/plugin.json
    agents/        point.md, power.md
    commands/      point.md, power.md
    skills/        point-* (5, incl. point-compile-speaker-handbook) + power-* (9)
    references/    R1, R2, R3, R4, R5 knowledge base + handoff-contract + example-handoff
    shared/        validation-rules.md, filesystem-conventions.md
  assets/          landing page assets
  index.html       GitHub Pages landing
  download/        point-to-power-plugin.zip  (built by scripts/package-plugin.ps1)
  scripts/         package-plugin.ps1
  _archive/        legacy Claude.ai-Project export (superseded by the plugin)
  README.md
```

## Packaging

To rebuild the downloadable plugin zip after changing the plugin:

```
pwsh ./scripts/package-plugin.ps1
```

It zips the `point-to-power/` plugin folder into `download/point-to-power-plugin.zip` and verifies the manifest is at the expected path.

## License + Author

Built by Benefits by Ben Akiva.
