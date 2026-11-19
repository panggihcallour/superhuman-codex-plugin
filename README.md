# Superhuman Agent — Codex plugin

**Superhuman Agent** connects Codex to the **Superhuman Operations** MCP (tasks, projects,
workload, documents) and brings a focused roster of **senior specialist agents** to work those
tasks — all in one install. `start-task` reads a task, picks the right specialist, and runs the
work.

> **Operational surface only.** This connects to the Operations MCP — tasks, projects,
> workload, documents. It exposes **no finance, sales, or people data / money**. You sign in with
> your own Ops account (OAuth) and get the tools your role has in the app; without signing in it
> returns nothing.

## The agents

| Agent | Persona | Specialises in | Status |
|---|---|---|---|
| **Design Agent** | Senior Principal UX Designer | how it works & feels — IA, sitemaps, flows, wireframes, visual design, design systems, prototyping, design QA | **live** (18 skills) |
| **Graphic Agent** | Senior Brand & Graphic Designer | brand & graphic — strategy, moodboard, logo, identity system, marketing assets, brand book, handoff, critique | **live** (8 skills) |
| **Dev Agent** | Senior Software Engineer | shipping code — implementation, review, refactors, tests, debugging | **live** (7 skills) |

Shared by every agent: **`start-task`** (the conductor — understand a task, then do it yourself or
run the full pipeline) and **`create-report`** (report the **process + outcome** back on the task — what was explored, the decisions, then the deliverable). Each agent
works at a senior, principal level in its craft.

**Design Agent skills (live):**
- **Strategy & discovery** — `design-strategy` · `competitive-audit` · `explore-solutions`
- **Structure** — `information-architecture` · `sitemap`
- **Content** — `ux-writing`
- **Produce** — `wireframe` · `design-tokens` · `component-spec` · `visual-design` · `prototype` · `figma-build`
- **Document** — `design-spec`
- **QA** — `design-critique` · `wcag-check` · `edge-cases` · `figma-audit` · `design-parity`

**Graphic Agent skills (live):**
- **Strategy & direction** — `brand-strategy` · `moodboard`
- **Identity** — `logo-design` · `brand-identity`
- **Application** — `marketing-assets`
- **Document & handoff** — `brand-guidelines` · `asset-handoff`
- **QA** — `graphic-critique`

**Dev Agent skills (live):**
- **Design & plan** — `tech-spec` · `implementation-plan`
- **Build** — `implement` · `test-plan`
- **Review & maintain** — `code-review` · `refactor` · `debug`

## Install

You need an active Ops account (founder, PM, designer or developer). No token: you sign in.

### From the Codex app
1. **Plugins → Add marketplace.**
   - Source: `panggihcallour/superhuman-codex-plugin`
   - Git ref: `main`
   - Sparse paths: `.agents/plugins`
2. Find **Superhuman Agent** in the plugin list → **Add**.
3. Sign in (below).
4. **Restart Codex.**

### From the CLI
```
codex plugin marketplace add panggihcallour/superhuman-codex-plugin
codex plugin add superhuman-agent@callour
```
Then sign in (below) and restart Codex.

## Sign in

```
codex mcp login superhuman_operations
```

The browser opens: sign in to Ops if asked, then **Allow**. Codex keeps the sign-in and refreshes it
itself. Then **restart Codex**.

> **Upgrading from 0.11 or older?** Old `shmcp_` tokens no longer work. Remove the
> `SUPERHUMAN_MCP_TOKEN` line from `~/.codex/.env`, then sign in as above.

## Update

```
codex plugin marketplace upgrade callour
```

## Validate before release

Run the lightweight plugin check before tagging/publishing a new version:

```
scripts/validate-plugin.sh
```

It validates the plugin JSON files and fails if stale instructions leak back in, including old
`post-comment` wording, old Figma MCP tool names, or platform-specific runner/provenance text.

## Use

In a Codex chat:
- `/start-task` — paste a task link; it reads the task, moves it to in-progress, and kicks off, then either hands you the wheel or runs the full process.
- `/create-report` — when done, it reports the **process + outcome** (what it explored, the decisions, then the deliverable), posts it to the task under your name, then adds a progress update that tags the PM (after you approve).

Verify it's connected: paste a task link and ask Codex to `get_task <link>` — it should return
the task's title and status.

## Notes & troubleshooting

- **Listing shows `superhuman-agent`, not "Superhuman Agent", before install.** Normal for a
  GitHub-hosted (cross-repo) plugin — Codex shows the raw id + "install to view more". The display
  name **"Superhuman Agent" appears once installed.**
- **Icon shows a generic puzzle.** Codex's custom-plugin-icon support is limited; the manifest's
  `composerIcon` may not override it. Not fixable from the plugin side.
- **Marketplace source is `git-subdir`.** A `local` source fails to load
  (`path does not exist or is not a directory`) via the GitHub flow — don't switch it.
- **Updates are NOT automatic.** After a new release, run `codex plugin marketplace upgrade callour`.
- **Sparse paths:** `.agents/plugins` is enough.
- **"MCP not available in this thread"?** Codex loads MCP at startup — fully quit + reopen Codex,
  then start a new chat. Use an interactive chat (not an Automation, which is sandboxed/no network).
