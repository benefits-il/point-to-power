#!/usr/bin/env bash
# Build Claude.ai Project knowledge-files folders from the plugin's references/ and shared/.
# Run from anywhere; uses script-relative paths.
#
# Output (gitignored):
#   claude-ai-project/point/knowledge-files/   (21 files)
#   claude-ai-project/power/knowledge-files/   (18 files)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PLUGIN_ROOT="$REPO_ROOT/point-to-power"

REFS="$PLUGIN_ROOT/references"
SHARED="$PLUGIN_ROOT/shared"
POINT_OUT="$REPO_ROOT/claude-ai-project/point/knowledge-files"
POWER_OUT="$REPO_ROOT/claude-ai-project/power/knowledge-files"

rm -rf "$POINT_OUT" "$POWER_OUT"
mkdir -p "$POINT_OUT" "$POWER_OUT"

# Point gets R1 (all 11), R2 (5 + kit catalog), handoff-contract, example-handoff, plus 2 shared.
POINT_FILES=(
  R1-00-foundations.md
  R1-01-typography.md
  R1-02-density.md
  R1-03-data-viz.md
  R1-04-bullets.md
  R1-05-visuals.md
  R1-06-speaker-notes.md
  R1-07-story-structure.md
  R1-08-decision-tree.md
  R1-addon-A-decision-sheet.md
  R1-addon-B-watch-fors.md
  R2-ch11-limitations-flags.md
  R2-ch12-recommendation-patterns.md
  R2-addon-a-quick-reference.md
  R2-addon-b-patterns-cheatsheet.md
  R2-addon-c-stale-watch.md
  R2-notebooklm-kit-catalog.md
  handoff-contract.md
  example-handoff.md
)

# POWER gets R3, R4 (all 8), R5, 4 R1 overlap, handoff-contract, example-handoff, plus 2 shared.
POWER_FILES=(
  R1-01-typography.md
  R1-02-density.md
  R1-03-data-viz.md
  R1-05-visuals.md
  R3-stage-3-output.md
  R4-SA1-ch1-2.md
  R4-SA2-ch3.md
  R4-SA3-ch4.md
  R4-SA4-ch5.md
  R4-SA5-ch6-7.md
  R4-SA6-ch8.md
  R4-siblings-stale-watch.md
  R4-siblings-templates.md
  R5-gemini-slides.md
  handoff-contract.md
  example-handoff.md
)

SHARED_FILES=(
  validation-rules.md
  filesystem-conventions.md
)

echo "Building Point knowledge-files..."
for f in "${POINT_FILES[@]}"; do
  cp "$REFS/$f" "$POINT_OUT/"
done
for f in "${SHARED_FILES[@]}"; do
  cp "$SHARED/$f" "$POINT_OUT/"
done

echo "Building POWER knowledge-files..."
for f in "${POWER_FILES[@]}"; do
  cp "$REFS/$f" "$POWER_OUT/"
done
for f in "${SHARED_FILES[@]}"; do
  cp "$SHARED/$f" "$POWER_OUT/"
done

POINT_COUNT=$(ls "$POINT_OUT" | wc -l)
POWER_COUNT=$(ls "$POWER_OUT" | wc -l)

echo
echo "Done."
echo "  Point: $POINT_COUNT files (expected 21)"
echo "  POWER: $POWER_COUNT files (expected 18)"
echo
echo "Next: upload these folders to your Claude.ai Projects."
echo "After uploading, you may delete them - they regenerate any time you run this script."
