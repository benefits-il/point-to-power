# Filesystem Conventions , Shared Helper

> Single source of truth for the project folder structure and handoff filesystem paths. Mirrors Section 7 of `handoff-contract.md`.
> Read by `point-emit-notebooklm-kit` and `produce-handoff-md` (Point, write side) and `parse-point-handoff` (POWER, read side). All skills must agree on the structure, slug rules, and timestamp format.

---

## Project folder structure

Each presentation project lives under its own per-project folder, keyed by `<slug>`:

```
build\<slug>\
  content\    # what the learner returns from NotebookLM. Point reads here in Phase 4.
  prompts\    # the NotebookLM kit Point emits in Phase 3 (source doc + Deep Research + Studio). NotebookLM prompts only.
  assets\     # images/media (POWER or the learner). Point does NOT write here.
  handoff\    # the final POWER-ready package only, written in Phase 6 after approval.
```

Each subfolder is created lazily by the skill that first writes into it (the Write tool creates parent directories). Point writes to `prompts\` (Phase 3) and `handoff\` (Phase 6), and reads from `content\` (Phase 4). POWER reads from `handoff\` (and may read `content\`/`prompts\` for context). `assets\` is filled by the learner from the external image tools, not by Point or POWER.

The path is relative to the active project root. On Windows use backslashes; on POSIX shells use forward slashes. The skill writing the file is responsible for normalizing for the host OS.

This structure applies when Point runs inside the Claude Code plugin or the Cowork plugin. It does NOT apply to the Claude.ai paste channel (contract §8) , there is no filesystem there; the kit and handoff are exchanged as chat blocks instead.

---

## Canonical handoff path

```
build\<slug>\handoff\<YYYYMMDD-HHMM>-<slug>.md
```

The handoff file is the only thing written under `handoff\`, and only after the learner approved the content (Phase 5).

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

Point's skills create the project subfolders lazily: `point-emit-notebooklm-kit` creates `build\<slug>\prompts\` when it writes the kit (Phase 3); `produce-handoff-md` creates `build\<slug>\handoff\` when it writes the handoff (Phase 6). POWER's intake skill (`parse-point-handoff`) reads existing files and does not create directories.

If a directory cannot be created (permission error, read-only mount), the skill falls back to the paste-channel output: it returns the content (kit or handoff Markdown) as a chat message and tells the learner to copy-paste / save it manually.

---

## Read priority (POWER side)

When a POWER session is opened in Claude Code / Cowork without an explicit filename argument, `parse-point-handoff` reads:

1. The most-recently-modified `*.md` file under any `build\<slug>\handoff\` folder, by file mtime (scan all project handoff folders).
2. If multiple files share the same mtime to the second, the lexicographically-last filename wins (timestamp prefix makes this deterministic in practice).
3. If no handoff file exists, POWER asks the learner to paste the handoff into chat.

When the learner passes an explicit filename or a project slug, that file (or the latest under `build\<slug>\handoff\`) is read instead. If the explicit target is not found, POWER returns an error and lists the three most recent handoff files it can see as suggestions.

---

## Retention

The plugin does not delete old project folders or handoff files. They grow monotonically over a learner's project lifetime. Cleanup is the learner's responsibility. Future versions may add a `prune` skill; out of scope for v1.0.
