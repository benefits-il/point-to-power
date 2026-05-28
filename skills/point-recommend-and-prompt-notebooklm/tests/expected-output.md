# Expected output , notebooklm_recommendations for `fixture-pitch-deck`

Two recommendations. Audio Overview for warm intro to investors who couldn't attend; Mind Map for cross-cutting product summary.

```yaml
notebooklm_recommendations:
  - feature: Audio Overview - Brief
    prompt: |
      הפק תקציר אודיו קצר באורך שלוש דקות מהמסמכים המצורפים, בעברית, בנימה רגועה ומדויקת.
      הדגש את שלושת הכאבים המרכזיים שמופיעים בשקופיות 1 ו-2.
      הסבר במשפט אחד את הפתרון של ColorTune, בלי לחשוף את הדמו של שקופית 4.
      סיים בקריאה לפעולה כללית בלי לציין סכומים.
    warnings: rtl-audio-weak, hebrew-quality-tier-c
    serves_slides: 1, 2

  - feature: Mind Map
    prompt: |
      בנה Mind Map בעברית שמתחיל בשורש "ColorTune"
      ומסתעף לשלושה ענפים ראשיים: כאב, פתרון, traction.
      כל ענף עד ארבעה צמתים. שמור על תמצות, בלי משפטים מלאים בצמתים.
    warnings: none
    serves_slides: all
```

Notes for human reviewer:

- `rtl-audio-weak` was auto-attached on the Audio Overview because `meta.language` is `he`. This is mandatory per the rule in the skill body.
- `hebrew-quality-tier-c` was added because Hebrew TTS in NotebookLM is uneven (R2 ch11). Hand the learner the warning so they listen before sharing.
- The Mind Map serves all slides because the product summary connects the entire deck. `all` was chosen deliberately, not as a default.
- No `Video Overview` because the demo on slide 4 is live; a recorded video would compete with it.
- No `Briefing Doc` because the audience is in the room and will not read a doc after.
- `serves_slides` for Audio Overview is `1, 2` , the intro / problem slides , because that is what a 3-minute warm-up should preview.
