# Design Agent — Codex plugin

A **Design Agent** plugin for [Callour Studio](https://callourstudio.com). It connects Codex to
the **Superhuman Operations** MCP (tasks, projects, workload, documents) and adds skills to run a
task and produce senior UX design deliverables — acting as a **Senior Principal UX Designer**.

It bundles the `superhuman_operations` MCP server (auto-registered on install) and a **19-skill,
end-to-end design process** you invoke as slash commands:

- **Start / document** — `start-task` (read a task, flip it to in-progress, frame the brief, kick off) · `post-comment` (summarise + post the deliverable back to the task)
- **Discover & define** — `competitive-audit` (web-research teardown) · `explore-solutions` (diverge into distinct directions + alternative flows)
- **Structure** — `information-architecture` · `sitemap`
- **Content** — `ux-writing`
- **Produce** — `wireframe` · `design-tokens` · `component-spec` · `visual-design` · `prototype` · `figma-build` (build it in Figma via the Figma MCP)
- **Document** — `design-spec` (convert a design into a `design.md` handoff)
- **QA gates** — `design-critique` · `wcag-check` · `edge-cases` · `figma-audit` · `design-parity`

Every design skill acts as a **Senior Principal UX Designer**.

> **Operational surface only.** This connects to the Operations MCP — tasks, projects,
> workload, documents. It exposes **no finance, sales, or people data / money** (the token is
> audience-scoped to Operations). The MCP endpoint requires a valid token; without one it
> returns nothing.

## Install

You need a **Superhuman MCP token** — ask the founder (minted at `/account/mcp`).

### From the Codex app
1. **Plugins → Add marketplace.**
   - Source: `panggihcallour/superhuman-codex-plugin`
   - Git ref: `main`
   - Sparse paths: `.agents/plugins`
2. Find **Design Agent** in the plugin list → **Add**.
3. Set your token (below).
4. **Restart Codex.**

### From the CLI
```
codex plugin marketplace add panggihcallour/superhuman-codex-plugin
codex plugin add design-agent@callour
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
- `/start-task` — paste a task link; Codex reads it, moves it to in-progress, and kicks off.
- `/post-comment` — when done, it summarises the work and posts it to the task (after you approve).

Verify it's connected: paste a task link and ask Codex to `get_task <link>` — it should return
the task's title and status.

## Notes & troubleshooting

- **Listing shows `design-agent`, not "Design Agent", before install.** Normal for a GitHub-hosted
  (cross-repo) plugin — Codex shows the raw id + "install to view more". The display name
  **"Design Agent" appears once installed.**
- **Icon shows a generic puzzle.** Codex's custom-plugin-icon support is limited; the manifest's
  `composerIcon` may not override it. Not fixable from the plugin side.
- **Marketplace source is `git-subdir`.** A `local` source fails to load
  (`path does not exist or is not a directory`) via the GitHub flow — don't switch it.
- **Updates are NOT automatic.** After a new release, run `codex plugin marketplace upgrade callour`.
  (Maintainer bumps `version` in plugin.json each release.)
- **Sparse paths:** `.agents/plugins` is enough.
- **"MCP not available in this thread"?** Codex loads MCP at startup — fully quit + reopen Codex,
  then start a new chat. Use an interactive chat (not an Automation, which is sandboxed/no network).
