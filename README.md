# Superhuman Agent — Codex plugin

**Superhuman Agent** connects Codex to the **Superhuman Operations** MCP (tasks, projects,
workload, documents) and brings a roster of **senior specialist agents** to work those tasks —
all in one install. `start-task` reads a task, picks the right specialist, and runs the work.

> **Operational surface only.** This connects to the Operations MCP — tasks, projects,
> workload, documents. It exposes **no finance, sales, or people data / money** (the token is
> audience-scoped to Operations). The MCP endpoint requires a valid token; without one it
> returns nothing.

## The agents

| Agent | Persona | Specialises in | Status |
|---|---|---|---|
| **Product Agent** | Senior Product Manager | the what & why — problem framing, PRDs/specs, user stories & acceptance criteria, prioritisation, roadmap, success metrics, scope | **live** (7 skills) |
| **Design Agent** | Senior Principal UX Designer | how it works & feels — IA, sitemaps, flows, wireframes, visual design, design systems, prototyping, design QA | **live** (18 skills) |
| **Graphic Agent** | Senior Brand & Graphic Designer | brand & graphic — strategy, moodboard, logo, identity system, marketing assets, brand book, handoff, critique | **live** (8 skills) |
| **Dev Agent** | Senior Software Engineer | shipping code — implementation, review, refactors, tests, debugging | **live** (7 skills) |
| **Research Agent** | Senior UX & Market Researcher | evidence — user/market research, synthesis, usability, opportunity framing | **live** (7 skills) |

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

**Product Agent skills (live):**
- **Frame & discover** — `product-brief` · `pr-faq` · `product-discovery`
- **Define & plan** — `prd` · `prioritization` · `roadmap`
- **QA** — `product-critique`

**Dev Agent skills (live):**
- **Design & plan** — `tech-spec` · `implementation-plan`
- **Build** — `implement` · `test-plan`
- **Review & maintain** — `code-review` · `refactor` · `debug`

**Research Agent skills (live):**
- **Plan** — `research-plan` · `market-analysis`
- **Fieldwork** — `user-interview` · `survey` · `usability-eval`
- **Synthesise** — `synthesis` · `insights-report`

## Install

You need a **Superhuman MCP token** — ask the founder (minted at `/account/mcp`).

### From the Codex app
1. **Plugins → Add marketplace.**
   - Source: `panggihcallour/superhuman-codex-plugin`
   - Git ref: `main`
   - Sparse paths: `.agents/plugins`
2. Find **Superhuman Agent** in the plugin list → **Add**.
3. Set your token (below).
4. **Restart Codex.**

### From the CLI
```
codex plugin marketplace add panggihcallour/superhuman-codex-plugin
codex plugin add superhuman-agent@callour
```
Then set your token and restart Codex.

## Set your token

**First, get a token — ask the founder.** Callour Studio mints it at `/account/mcp` (the token
page is founder-only). The plugin reads it from `SUPERHUMAN_MCP_TOKEN`, which Codex loads from
`~/.codex/.env`. Open that file in a text editor:

```
touch ~/.codex/.env && open -e ~/.codex/.env
```

TextEdit opens — add this line (replace `shmcp_xxxx` with your token), then save (`Cmd+S`):

```
SUPERHUMAN_MCP_TOKEN=shmcp_xxxx
```

If a `SUPERHUMAN_MCP_TOKEN` line already exists, replace it (don't duplicate). Then **restart Codex**.

## Update

```
codex plugin marketplace upgrade callour
```

## Use

In a Codex chat:
- `/start-task` — paste a task link; it reads the task, moves it to in-progress, and kicks off, then either hands you the wheel or runs the full process.
- `/create-report` — when done, it reports the **process + outcome** (what it explored, the decisions, then the deliverable) and posts it to the task (after you approve).

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
