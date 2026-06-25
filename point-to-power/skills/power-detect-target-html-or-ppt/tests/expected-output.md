# Expected outputs

## fixture-html
```yaml
target: html
```

## fixture-slides
```yaml
target: slides
```

## fixture-ask (after learner replied "2")
```yaml
target: powerpoint
```

Notes for human reviewer:

- For `ask`, the Hebrew prompt must be byte-exact to the 3-option template in the skill body. POWER agents downstream of this skill do not need to know that an ask round happened , the output is uniformly `html`, `powerpoint`, or `slides`.
- A reply of `3` / `slides` / `gemini` resolves to `target=slides`.
- If the learner had replied with `כולם` or a bare `מצגת` (ambiguous now that both PowerPoint and Google Slides are "מצגת"), the skill would have issued the short re-prompt `בבקשה ענה 1, 2 או 3.` and waited again.
