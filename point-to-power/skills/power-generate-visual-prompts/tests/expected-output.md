# Expected output , image_prompts for `fixture-5-visuals`

```yaml
image_prompts:
  - slide_number: 1
    image_prompt: |
      Flat editorial illustration of a designer at a laptop, facing a Figma color-palette panel on the right side of the screen.
      Several palette swatches are marked in red with the text "FAIL" overlaid in a thin uppercase sans-serif.
      Mood: quietly frustrated, observational, not dramatic.
      Style: flat vector, generous whitespace, single accent color #2563EB on a near-black (#0F1419) and white palette,
      no gradients, no decorative flourishes, editorial composition with subject left-of-center.
      Aspect ratio: 4:3. Resolution: 1600x1200.
    target_tools:
      - recraft
      - gpt-image
      - gemini
    style_anchors:
      palette: ["#0F1419", "#FFFFFF", "#2563EB"]
      illustration_or_photo: illustration
      motion_language: static
      composition_keywords: [flat, editorial, single-accent, generous-whitespace]

  - slide_number: 3
    image_prompt: |
      UI mock-up of a desktop application called ColorTune, presented as a clean editorial illustration (not a literal screenshot).
      Two color palettes shown side by side: original palette on the left, accessibility-corrected palette on the right.
      Thin connecting lines between matched swatches show which colors changed.
      Style: minimalist UI, near-black text on white background, single accent #2563EB,
      flat vector look, plenty of whitespace, captions in small caps.
      Note for the learner: replace with a real product screenshot when one is available; this mock is the visual stand-in.
      Aspect ratio: 16:9. Resolution: 1920x1080.
    target_tools:
      - recraft
      - gpt-image
      - gemini
    style_anchors:
      palette: ["#0F1419", "#FFFFFF", "#2563EB"]
      illustration_or_photo: illustration
      motion_language: static
      composition_keywords: [flat, ui-mock, editorial, single-accent]

  - slide_number: 4
    image_prompt: |
      Still keyframe (single frame) representing a 8-second silent process video: a designer's hand uploads a PNG palette,
      clicks "Generate", and sees a corrected palette appear on a second monitor.
      Render as the title frame: a clean white background, a small editorial caption in Hebrew "דמו חי" in the corner,
      a subtle play-button overlay in #2563EB.
      Style: photoreal-leaning illustration, near-monochrome with single accent, no motion blur.
      Note for the learner: this is a keyframe; the actual video must be produced separately (e.g., Loom, OBS).
      Aspect ratio: 21:9 (full-bleed). Resolution: 2520x1080.
    target_tools:
      - gemini
      - recraft
      - gpt-image
    style_anchors:
      palette: ["#0F1419", "#FFFFFF", "#2563EB"]
      illustration_or_photo: mixed
      motion_language: static
      composition_keywords: [keyframe, editorial, single-accent, full-bleed]

  - slide_number: 5
    image_prompt: |
      Simple bar chart, black and white, x-axis is the last 6 months (Hebrew month names, written RTL),
      y-axis is monthly active users (integer), value labels above each bar.
      Style: editorial restraint , thin axes, no gridlines, sans-serif labels.
      Note for the learner: prefer a real chart generated from your data in Excel/Datawrapper.
      This image is a visual placeholder to lock the layout.
      Aspect ratio: 16:9. Resolution: 1920x1080.
    target_tools:
      - recraft
      - gemini
      - gpt-image
    style_anchors:
      palette: ["#0F1419", "#FFFFFF", "#2563EB"]
      illustration_or_photo: diagram
      motion_language: static
      composition_keywords: [chart, editorial, monochrome]

  - slide_number: 6
    image_prompt: |
      Soft photograph of an open laptop on a wooden desk, the laptop screen showing the ColorTune logo (a small wordmark
      in the chosen accent color #2563EB on a white background), shallow depth of field, background slightly blurred.
      Mood: calm, conclusive, end-of-pitch.
      Lighting: natural daylight from the left, soft shadows.
      Style: photoreal, editorial, single-accent palette echoing the rest of the deck.
      Aspect ratio: 16:9. Resolution: 1920x1080.
    target_tools:
      - gemini
      - recraft
      - gpt-image
    style_anchors:
      palette: ["#0F1419", "#FFFFFF", "#2563EB"]
      illustration_or_photo: photo
      motion_language: static
      composition_keywords: [photo, editorial, calm, single-accent]
```

Notes for human reviewer:

- All 5 prompts share the same `style_anchors.palette` , that is the cross-slide consistency the batch processing exists for.
- target_tools varies per slide: slides 4 and 6 (photoreal-leaning) lead with gemini; slides 1, 3, 5 (illustration / diagram) lead with recraft.
- Slide 4's prompt explicitly notes that the deliverable is a keyframe, not a video , POWER does not generate video.
- Slide 5's prompt explicitly says to prefer a real chart from the learner's data , image generation is a fallback for visual lock-in, not a substitute for data viz tooling.
