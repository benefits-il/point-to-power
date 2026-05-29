# Expected output , layouts for `fixture-6-slides`

```yaml
layouts:
  - slide_number: 1
    grid: split-60-40
    hierarchy:
      - element: title
        size: text-3xl
        position: grid-area-text-top
      - element: key_message
        size: text-xl
        position: grid-area-text-mid
      - element: content
        size: text-base
        position: grid-area-text-body
      - element: visual
        size: full-cell
        position: grid-area-image-right
    image_placement: right-half
    motion: fade-in
    rtl_notes: "כל הטקסט מיושר ימינה. השם FAIL בתמונה נשאר LTR."

  - slide_number: 2
    grid: hero
    hierarchy:
      - element: title
        size: text-2xl
        position: grid-area-text-top
      - element: key_message
        size: text-6xl
        position: grid-area-text-center
      - element: content
        size: text-base
        position: grid-area-text-body
    image_placement: none
    motion: none
    rtl_notes: "המספר 96.3% נשאר LTR בתוך השורה העברית; אל תתרגם."

  - slide_number: 3
    grid: split-60-40
    hierarchy:
      - element: title
        size: text-3xl
        position: grid-area-text-top
      - element: key_message
        size: text-xl
        position: grid-area-text-mid
      - element: content
        size: text-base
        position: grid-area-text-body
      - element: visual
        size: full-cell
        position: grid-area-image-right
    image_placement: right-half
    motion: fade-in
    rtl_notes: "המילה ColorTune ושמות צבע באנגלית נשארים LTR; היישור הכללי ימינה."

  - slide_number: 4
    grid: hero
    hierarchy:
      - element: title
        size: text-3xl
        position: grid-area-text-top
      - element: key_message
        size: text-xl
        position: grid-area-text-mid
      - element: visual
        size: full-bleed
        position: grid-area-image-fullscreen
    image_placement: full-bleed
    motion: none
    rtl_notes: "הוידאו ללא קול, הכיתוביות בלבן ב-RTL."

  - slide_number: 5
    grid: split-60-40
    hierarchy:
      - element: title
        size: text-3xl
        position: grid-area-text-top
      - element: key_message
        size: text-xl
        position: grid-area-text-mid
      - element: content
        size: text-base
        position: grid-area-text-body
      - element: visual
        size: full-cell
        position: grid-area-image-right
    image_placement: right-half
    motion: build-by-bullet
    rtl_notes: "המספרים והאחוזים נשארים LTR; ציר X (חודשים) בעברית ימין-לשמאל."

  - slide_number: 6
    grid: split-60-40
    hierarchy:
      - element: title
        size: text-3xl
        position: grid-area-text-top
      - element: key_message
        size: text-xl
        position: grid-area-text-mid
      - element: content
        size: text-base
        position: grid-area-text-body
      - element: visual
        size: full-cell
        position: grid-area-image-right
    image_placement: right-half
    motion: fade-in
    rtl_notes: "המילה seed והשם ColorTune נשארים LTR; שאר הטקסט עברי RTL."
```

Notes for human reviewer:

- target=html selected CSS Grid vocabulary (`split-60-40`, `hero`, `full-bleed`). For target=powerpoint, the same slides would have gotten PowerPoint slot names (`title-content`, `section-header`, `title-image`).
- Slide 2 (`hero` grid with `text-6xl` for key_message) reflects the structure decision that the 96.3% number IS the visual.
- Slide 5 chose `build-by-bullet` because that is the only slide with `bullets_allowed: true` and a list of metrics.
- Every `rtl_notes` mentions the specific LTR islands (English brand names, percentages, year numbers) so generate-html-prompt can pass those down to the renderer.
