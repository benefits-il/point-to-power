# Fixture: slides (passthrough)

Input:
```yaml
ast.meta.target: slides
learner_response: null
```

Expected: skill returns immediately with `target=slides`. No learner prompt issued.

This is the parallel of fixture-html: Point already resolved the target, so the skill is a passthrough and never asks the learner.
