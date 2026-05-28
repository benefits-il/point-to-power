# Claude.ai Project setup for PointToPower

> זה לא פורמט אריזה נפרד. זו הוראת בנייה ידנית של הסוכנים בתוך Claude.ai Projects, על בסיס אותם קבצי ידע שמשמשים את הפלאגין הראשי. הכל יחסי ל-root של הריפו.

## למה זה קיים

Claude.ai Projects לא תומך בפורמט הפלאגין של Claude Code/Cowork. לכל Project יש system prompt משלו וקבצים מצורפים. PointToPower בפורמט הזה הוא **שני Projects נפרדים** (Point ו-POWER) שמתקשרים ב-copy-paste של ה-handoff. ה-skills שבפלאגין הפכו ל-instructions inline בתוך ה-system prompt של כל סוכן.

## הקבצים בתיקייה הזו

```
claude-ai-project/
  SETUP.md                    <- הקובץ הזה
  point/
    system-prompt.md          <- להעתיק ל-Project של Point ב-Claude.ai
  power/
    system-prompt.md          <- להעתיק ל-Project של POWER ב-Claude.ai
  (point/knowledge-files/ ו-power/knowledge-files/ נוצרים ע"י הסקריפט, לא ב-git)
```

## הכנת קבצי הידע

קבצי הידע (R1, R2, R3, R4, handoff-contract, example-handoff, validation-rules, filesystem-conventions) חיים פעם אחת בלבד תחת `references/` ו-`shared/` ב-root של הריפו. הם **לא** משוכפלים כאן. בכל פעם שצריך להתקין את Claude.ai Project, מריצים מ-root של הריפו:

```
bash scripts/build-claude-ai-project.sh
```

הסקריפט מעתיק את הקבצים הנחוצים לתוך `claude-ai-project/point/knowledge-files/` (20 קבצים) ו-`claude-ai-project/power/knowledge-files/` (17 קבצים). אחרי ההתקנה, אפשר למחוק את התיקיות האלה - הן לא נשמרות ב-git.

## התקנת Point

1. גשו ל-https://claude.ai וצרו Project חדש בשם `Point`.
2. Project settings -> Instructions: הדביקו את כל התוכן של `point/system-prompt.md`.
3. Project -> Files: העלו את כל 20 הקבצים מ-`point/knowledge-files/` (אחרי הרצת הסקריפט).
4. Smoke test: פתחו צ'אט חדש. Point אמור להציג את עצמו בעברית. נסו: *"אני רוצה לבנות מצגת על X"*. הוא אמור להתחיל אליציטציה.

## התקנת POWER

1. צרו Project חדש בשם `POWER`.
2. Project settings -> Instructions: הדביקו את כל התוכן של `power/system-prompt.md`.
3. Project -> Files: העלו את כל 17 הקבצים מ-`power/knowledge-files/`.
4. Smoke test: פתחו צ'אט חדש. הדביקו example handoff מ-`power/knowledge-files/example-handoff.md`. POWER אמור לעשות parse, validate, ולהציע tuple של סגנונות.

## הזרימה בין שני ה-Projects

- Point מסיים -> מציג ללומד את ה-Markdown של ה-handoff.
- הלומד מעתיק החל מ-`# PointToPower Handoff v1.0` עד הסוף.
- הלומד פותח צ'אט חדש ב-Project של POWER ומדביק כהודעה הראשונה.
- POWER ממשיך משם.

אין אוטומציה - Claude.ai Projects לא מאפשר Project אחד להפעיל Project אחר. ההעברה ידנית בכוונה.

## הבדלים מהפלאגין הראשי

- בפלאגין: skills בקבצים נפרדים, handoff בפילסיסטם.
- ב-Claude.ai Project: skills כ-instructions inline בתוך system prompt, handoff בערוץ paste.
- בפלאגין: Claude Code/Cowork מפעילים `/point` ו-`/power`.
- ב-Claude.ai Project: כל Project הוא הצ'אט שלו, אין slash commands.

## מגבלות

- חלון ההקשר של Claude.ai מתחלק בין system prompt + knowledge files (RAG) + היסטוריית הצ'אט. ב-handoff ארוך מ-30 שקופיות יכול להיות לחץ טוקנים בעת iteration.
- אין filesystem - ה-handoff תמיד paste. המסקנה: אין שמירה אוטומטית של גרסאות.
- Point לא יכול להפעיל את POWER. המשתמש הוא הגשר.
