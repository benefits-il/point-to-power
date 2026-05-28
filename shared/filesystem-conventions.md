# Filesystem Conventions , Shared Helper

> Single source of truth for handoff filesystem paths. Mirrors Section 7 of `handoff-contract.md`.
> Read by `produce-handoff-md` (Point, write side) and `parse-point-handoff` (POWER, read side). Both skills must agree on slug rules and timestamp format.

---

## Canonical path

```
build\handoff-runtime\<YYYYMMDD-HHMM>-<slug>.md
```

The path is relative to the active project root. On Windows use backslashes; on POSIX shells use forward slashes. The skill writing the file is responsible for normalizing for the host OS.

This path applies when Point runs inside the Claude Code plugin or the Cowork plugin. It does NOT apply to the Claude.ai paste channel (contract §8) , there is no filesystem there.

---

## Timestamp format

- **Pattern:** `YYYYMMDD-HHMM`
- **Time zone:** local time of the machine running Point. No conversion.
- **Examples:** `20260604-2214`, `20260101-0900`.
- **Precision:** minutes. Two writes in the same minute collide; the second write must append a single-letter suffix (`-a`, `-b`, ...) before the file extension. Example: `20260604-2214-colortune-pitch-01.md`, then `20260604-2214-colortune-pitch-01-a.md`.

Use `datetime.now().strftime("%Y%m%d-%H%M")` semantics; do NOT use ISO 8601 with colons (colons are invalid in Windows filenames).

---

## Slug rules

Source priority order. Walk top-down and take the first non-empty source:

1. **Point's session id** when known (e.g., `colortune-pitch-01`). This is the same value that, if present, appears in `meta.session_id`.
2. **A learner-supplied label** captured during elicitation (e.g., `q3-board-deck`). Point's elicit skill asks for this when no session id exists.
3. **The literal `untitled`** when neither is available.

### Slug shape

- Charset: lowercase ASCII letters, digits, hyphens. Nothing else.
- Length: maximum 40 characters. Truncate at the nearest hyphen boundary if possible; otherwise hard-truncate.
- Hebrew slugs: NOT permitted in the filename. If the learner's label is Hebrew, transliterate to ASCII or fall back to `untitled` and store the original Hebrew label inside `meta.session_id` instead.
- Whitespace: replace runs of whitespace with a single hyphen.
- Disallowed characters: any non-`[a-z0-9-]` character is stripped, not replaced.
- Leading and trailing hyphens are stripped.

### Slug examples

| Source | Slug |
|---|---|
| session_id `colortune-pitch-01` | `colortune-pitch-01` |
| learner label `Q3 Board Deck!` | `q3-board-deck` |
| learner label `מצגת לבורד Q3` | `untitled` (transliteration not attempted; Hebrew preserved in `meta.session_id`) |
| neither available | `untitled` |

---

## Directory creation

Point's emit skill (`produce-handoff-md`) creates `build\handoff-runtime\` if it does not exist. POWER's intake skill (`parse-point-handoff`) reads existing files and does not create directories.

If the directory cannot be created (permission error, read-only mount), Point falls back to the paste-channel output: it returns the handoff Markdown as a chat message and tells the learner to copy-paste it into POWER.

---

## Read priority (POWER side)

When a POWER session is opened in Claude Code / Cowork without an explicit filename argument, `parse-point-handoff` reads:

1. The most-recently-modified `*.md` file under `build\handoff-runtime\`, by file mtime.
2. If multiple files share the same mtime to the second, the lexicographically-last filename wins (timestamp prefix makes this deterministic in practice).
3. If the directory is empty or missing, POWER asks the learner to paste the handoff into chat.

When the learner passes an explicit filename, that file is read instead. If the explicit filename is not found under `build\handoff-runtime\`, POWER returns an error and lists the three most recent files in the directory as suggestions.

---

## Retention

The plugin does not delete old handoff files. The directory grows monotonically over a learner's project lifetime. Cleanup is the learner's responsibility. Future versions may add a `prune` skill; out of scope for v1.0.
