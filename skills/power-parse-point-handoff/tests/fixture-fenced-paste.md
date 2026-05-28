# Fixture: pasted handoff wrapped in an outer code fence

Input: source=paste, payload is the canonical example-handoff.md wrapped in a single outer ` ```markdown ` fence:

```
```markdown
# PointToPower Handoff v1.0

## Meta

- **target:** html
- **audience:** משקיעי seed ומנהלי מוצר במיט-אפ דיזיין-טק בתל אביב, כ-30 איש, מחציתם טכניים ומחציתם משקיעים פעילים
- **genre:** pitch
- **duration_minutes:** 12
... (rest of example-handoff.md)
```
```

Expected behavior: parse-point-handoff strips the outer ` ```markdown ... ``` ` fence and proceeds as if the input were the bare content. The resulting AST is byte-identical to the AST produced from fixture-clean-handoff.
