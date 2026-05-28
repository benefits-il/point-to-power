# Expected outputs

## fixture-html
```yaml
target: html
```

## fixture-ask (after learner replied "2")
```yaml
target: powerpoint
```

Notes for human reviewer:

- For `ask`, the Hebrew prompt must be byte-exact to the template in the skill body. POWER agents downstream of this skill do not need to know that an ask round happened , the output is uniformly `html` or `powerpoint`.
- If the learner had replied with `שניהם`, the skill would have issued the short re-prompt `בבקשה ענה רק 1 או 2.` and waited again.
