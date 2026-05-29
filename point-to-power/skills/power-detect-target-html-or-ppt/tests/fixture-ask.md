# Fixture: ask + learner reply

Turn 1 , input:
```yaml
ast.meta.target: ask
learner_response: null
```

Skill issues the Hebrew prompt:

```
איך תרצה לקבל את הפלט?

1) אתר HTML יחיד שאפשר לפתוח בדפדפן ולשלוח כקובץ אחד.
   מתאים אם רוצים שיתוף מהיר, צפייה במובייל, או אם אין PowerPoint.

2) קובץ PowerPoint שאפשר לערוך ב-Microsoft PowerPoint.
   מתאים אם תרצה להמשיך לערוך, להדפיס, או להציג מתוך PowerPoint עצמו.

ענה 1 או 2, או כתוב html / powerpoint.
```

Turn 2 , learner reply: `2`

Expected: skill returns `target=powerpoint`.
