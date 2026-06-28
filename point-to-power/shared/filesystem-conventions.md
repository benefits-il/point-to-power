# Filesystem Conventions , Shared Helper

> Single source of truth for the project folder structure and handoff filesystem paths. Mirrors Section 7 of `handoff-contract.md`.
> Read by `point-emit-notebooklm-kit`, `point-produce-handoff-md`, and `point-compile-speaker-handbook` (Point, write side) and `power-parse-point-handoff` (POWER, read side). All skills must agree on the structure, slug rules, and timestamp format.

---

## Project folder structure (v2 , numbered for a clear, logical order)

Each presentation project lives under its own per-project folder, keyed by `<slug>`. The subfolders are numbered so the learner always knows the order of the flow and exactly what goes where:

```
build\<slug>\
  01-upload-to-notebooklm\   # the actual source files the learner uploads to NotebookLM.
  02-notebooklm-prompts\     # the clean, copy-ready prompts the learner runs in NotebookLM.
  03-returns\                # the artifacts the learner downloads back from NotebookLM.
  04-package-for-power\      # the clean, final package POWER consumes.
  presenter-handbook.md      # the presenter handbook (per-slide speaker script). For the human, not for POWER.
```

### What each folder holds

**`01-upload-to-notebooklm\`** , everything the learner uploads into the NotebookLM notebook, as real files, not a description of files.
- The composed master source document (`00-source-document.md`).
- A copy of every relevant raw source file the learner gave Point (so the learner uploads the files themselves, not a summary).
- `_manifest.md` , a short index that names each file and marks it `[signal]` (upload this) or `[noise]` (do NOT upload, here for reference only). This is how the learner knows exactly what to upload.

**`02-notebooklm-prompts\`** , one prompt per file, each file containing ONLY the prompt, nothing around it, so the learner copies the whole file content in one go.
- `00-INDEX.md` , the run order and what each prompt is for, plus the instruction to save downloads into `03-returns\`.
- `01-deep-research.md` , the Discover Sources / Deep Research prompt.
- `02-brief-<name>.md` ... , one file per BRIEF document the notebook should produce (content the learner downloads and works with).
- `03-visual-<name>.md` ... , one file per visual artifact prompt (video, infographic, sample deck). Every visual prompt is self-contained: it carries the full visual specification anchored to the brand design system AND the exact content that must appear inside. Never a generic visual prompt with a "add your content here" placeholder.

**`03-returns\`** , where the learner saves what comes back from NotebookLM.
- The downloaded artifacts (briefs, infographics, sample decks, video).
- `_liked.md` , a short note where the learner marks which returned artifacts and which ideas they liked. Point reads this when assembling the package.

**`04-package-for-power\`** , the clean package Point assembles for POWER after the slide structure is approved.
- `<YYYYMMDD-HHMM>-<slug>.md` , the handoff file (Sections 1-4 of the contract).
- Copies of (or pointers to) the selected visual assets the learner liked, so POWER can ingest them, not just read a textual description.
- `_assets-index.md` , maps each selected asset to the slide(s) it serves and to its role (palette / sample-deck style / infographic / reference image).

**`presenter-handbook.md`** , the presenter handbook (`חוברת מנחה`). Written by Point at the packaging stage. A per-slide speaker script: what the presenter says on each slide. It is for the human presenter, NOT a POWER input. POWER never reads it.

### Lazy creation and ordering

Each subfolder is created lazily by the skill that first writes into it (the Write tool creates parent directories). The numeric prefixes are part of the folder names and fix the display order. Point writes `01-` and `02-` in the NotebookLM phase, reads `03-` after the learner returns artifacts, and writes `04-` plus `presenter-handbook.md` at the packaging phase (after structure approval). POWER reads only from `04-package-for-power\`.

The path is relative to the active project root. On Windows use backslashes; on POSIX shells use forward slashes. The skill writing the file normalizes for the host OS.

This structure requires a filesystem (the Claude Code plugin or the Cowork plugin). If no filesystem is available, the skill falls back to emitting the same content as labeled chat blocks and tells the learner where each block belongs, but the canonical experience is the real folder tree above.

---

## Canonical handoff path

```
build\<slug>\04-package-for-power\<YYYYMMDD-HHMM>-<slug>.md
```

The handoff file is written under `04-package-for-power\` only after the learner approved the slide structure (Phase 5).

---

## Timestamp format

- **Pattern:** `YYYYMMDD-HHMM`
- **Time zone:** local time of the machine running Point. No conversion.
- **Examples:** `20260604-2214`, `20260101-0900`.
- **Precision:** minutes. Two writes in the same minute collide; the second write appends a single-letter suffix (`-a`, `-b`, ...) before the file extension. Example: `20260604-2214-colortune-pitch-01.md`, then `20260604-2214-colortune-pitch-01-a.md`.

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

Point's skills create the project subfolders lazily as they write:
- `point-emit-notebooklm-kit` creates `build\<slug>\01-upload-to-notebooklm\` and `build\<slug>\02-notebooklm-prompts\` (NotebookLM phase).
- `point-produce-handoff-md` creates `build\<slug>\04-package-for-power\` (packaging, Phase 6).
- `point-compile-speaker-handbook` writes `build\<slug>\presenter-handbook.md` (packaging, Phase 6).
- The learner creates `build\<slug>\03-returns\` content by saving downloads there; Point reads it.

POWER's intake skill (`power-parse-point-handoff`) reads existing files under `04-package-for-power\` and does not create directories.

If a directory cannot be created (permission error, read-only mount), the skill falls back to the chat-block output: it returns the content (kit, handoff, or handbook Markdown) as a chat message and tells the learner where each block belongs.

---

## Read priority (POWER side)

When a POWER session is opened in Claude Code / Cowork without an explicit filename argument, `power-parse-point-handoff` reads:

1. The most-recently-modified `*.md` handoff file under any `build\<slug>\04-package-for-power\` folder, by file mtime (scan all project package folders).
2. If multiple files share the same mtime to the second, the lexicographically-last filename wins (timestamp prefix makes this deterministic in practice).
3. If no handoff file exists, POWER asks the learner to point to the package folder or paste the handoff into chat.

When the learner passes an explicit filename or a project slug, that file (or the latest under `build\<slug>\04-package-for-power\`) is read instead. If the explicit target is not found, POWER returns an error and lists the three most recent handoff files it can see as suggestions. POWER also reads `_assets-index.md` in the same folder, when present, to ingest the selected visual assets.

---

## Retention

The plugin does not delete old project folders, handoff files, or handbooks. They grow monotonically over a learner's project lifetime. Cleanup is the learner's responsibility. Future versions may add a `prune` skill; out of scope now.
