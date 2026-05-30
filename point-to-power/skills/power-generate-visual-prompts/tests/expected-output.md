# Expected output , image_prompts for `fixture-5-visuals`

Each prompt is a self-contained, copy-paste-ready block with full specs (subject, material/render, lighting, background, exact hex, composition, aspect ratio, and an `Avoid:` negatives line). No hands, no impossible asks, no vague mood-words.

```yaml
image_prompts:
  - slide_number: 1
    image_prompt: |
      Flat editorial vector illustration of a designer seated at a laptop, facing a Figma color-palette panel on the right side of the screen.
      Several palette swatches are marked with a thin uppercase "FAIL" label in red.
      Material/render: flat vector, generous whitespace, no cast shadows.
      Lighting: even, flat, no directional light.
      Background: solid white #FFFFFF.
      Colors: single accent #2563EB on white #FFFFFF and near-black #0F1419 line work, no other hues.
      Composition: subject left-of-center, editorial, plenty of whitespace.
      Mood (observable): matter-of-fact, low contrast, no drama.
      Aspect ratio: 4:3. Resolution: 1600x1200.
      Avoid: no hands or fingers, no text artifacts beyond the FAIL label, no gradients, no decorative clutter, no watermark, no extra limbs.
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
      UI mock-up of a desktop application called ColorTune, rendered as a clean editorial illustration (not a literal screenshot).
      Two color palettes side by side: original palette on the left, accessibility-corrected palette on the right,
      with thin connecting lines between matched swatches showing which colors changed.
      Material/render: minimalist flat-vector UI, captions in small caps.
      Lighting: even, flat.
      Background: solid white #FFFFFF.
      Colors: near-black #0F1419 text, single accent #2563EB, no other hues.
      Composition: two panels centered, generous whitespace.
      Aspect ratio: 16:9. Resolution: 1920x1080.
      Note for the learner: replace with a real product screenshot when one is available; this mock is the visual stand-in.
      Avoid: no hands or fingers, no realistic photo textures, no gradients, no decorative clutter, no watermark.
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
      Still keyframe (single frame) standing in for an 8-second silent process video.
      Show two monitors on a clean desk: the left monitor displays an uploaded PNG palette with a "Generate" button,
      the right monitor displays the corrected palette result. No person and no hands in frame.
      Material/render: photoreal-leaning illustration, near-monochrome with single accent, no motion blur.
      Lighting: soft, even studio light.
      Background: clean white #FFFFFF.
      Colors: single accent #2563EB; a small editorial caption in Hebrew "דמו חי" in the corner; a subtle play-button overlay in #2563EB.
      Composition: both monitors centered, full-bleed framing.
      Aspect ratio: 21:9 (full-bleed). Resolution: 2520x1080.
      Note for the learner: this is a keyframe; the actual video must be produced separately (e.g., Loom, OBS).
      Avoid: no hands or fingers, no people, no motion blur, no text artifacts beyond the stated caption, no watermark, no extra screens.
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
      Simple bar chart, black and white. X-axis: the last 6 months (Hebrew month names, written RTL).
      Y-axis: monthly active users (integers), with value labels above each bar.
      Material/render: flat diagram, thin axes, no gridlines, sans-serif labels.
      Lighting: flat, none.
      Background: solid white #FFFFFF.
      Colors: near-black #0F1419 bars and labels, optional single accent #2563EB on the latest bar only.
      Composition: chart centered, generous margins.
      Aspect ratio: 16:9. Resolution: 1920x1080.
      Note for the learner: prefer a real chart generated from your data in Excel/Datawrapper; this image only locks the layout.
      Avoid: no 3D bars, no gradients, no gridlines, no decorative clutter, no text artifacts, no watermark.
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
      Soft photograph of an open laptop on a wooden desk. The laptop screen shows the ColorTune wordmark
      in the accent color #2563EB on a white screen. Shallow depth of field.
      Material/render: photoreal, editorial.
      Lighting: natural daylight from the left, soft shadows.
      Background: wooden desk, slightly blurred (bokeh).
      Colors: single accent #2563EB echoing the rest of the deck; otherwise neutral wood and white tones.
      Composition: laptop centered, conclusive end-of-pitch framing.
      Mood (observable): calm, warm daylight, low contrast.
      Aspect ratio: 16:9. Resolution: 1920x1080.
      Avoid: no hands or fingers, no people, no text artifacts beyond the wordmark, no harsh shadows, no watermark.
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
- **Problem F fixes applied:** every prompt is self-contained (no preamble to merge); every prompt carries an explicit `Avoid:` negatives line including `no hands`; slide 4 no longer shows a hand uploading a file (it shows the action on-screen instead); lighting and background are always specified; mood is stated in observable terms, never as a value judgment.
- Slide 4's prompt explicitly notes the deliverable is a keyframe, not a video , POWER does not generate video.
- Slide 5's prompt explicitly says to prefer a real chart from the learner's data , image generation is a fallback for visual lock-in, not a substitute for data viz tooling.
