---
name: figma-build
description: Use to actually BUILD a design in Figma via the Figma MCP — create frames/sections, lay out screens or components with auto layout, apply tokens/styles, and validate by screenshot. Turns the agent from advisor into maker. Acts as a Senior Principal UX Designer. Runs AFTER the design is decided (/visual-design, /component-spec) and BEFORE /create-report. Trigger on "build in figma", "figma build", "bikin di figma", "create the figma", "buatkan figma-nya", "make the design in figma".
metadata:
  short-description: Build screens/components directly in Figma via the Figma MCP (with validation)
---

# figma-build

Build the design in Figma for real, not just describe it. **Act as a Senior Principal UX Designer.** This skill uses the **Figma MCP** to construct frames, screens, and components on the canvas, apply the token/style system, and verify the result visually.

Design WORK — runs **after the design direction is set** (`/visual-design`, `/component-spec`, `/design-tokens`) and before **`/create-report`**. Requires the Figma MCP to be connected; if it isn't, say so and fall back to an HTML build (`/visual-design`).

## Inputs

- The agreed design: screens from `/visual-design`, component specs from `/component-spec`, tokens from `/design-tokens`.
- **Figma MCP.** Start every session by identifying the target file/node and reading current structure with `get_metadata`. Search the design system with `search_design_system`; use `get_design_context` and `get_screenshot` to inspect references. Before writing, load the `figma-use` prerequisite and then use `use_figma`. Node IDs are session-specific and go stale across conversations; never reuse old ones blindly.

## Method (follow the MCP's mandatory build → screenshot → analyse → iterate → verify loop)

1. **Orient.** Resolve the file key/node, inspect with `get_metadata`, and check the target page/section. Before creating, check the page/section doesn't already exist (avoid duplicates).
2. **Container first.** Create or find a **Section/Frame** to hold the work — never leave components floating on blank canvas.
3. **Reuse the system.** Search existing assets with `search_design_system` and import/instantiate existing components in `use_figma` instead of redrawing; apply existing styles/variables/tokens rather than hard-coded values.
4. **Build with auto layout.** Construct screens/components using auto layout; use "fill container" (not "hug") where elements should stretch; keep padding/gap on the spacing scale. Use `use_figma` for construction.
5. **Screenshot & analyse.** Use `get_screenshot` after each meaningful step. Check alignment, spacing, proportion, balance, fill-vs-hug, centring, text/inputs filling width.
6. **Iterate** to fix what the screenshot reveals (max ~3 passes per screen), then **verify** with a final screenshot.
7. **Audit before handing off.** Re-read with `get_metadata`, `get_design_context`, `get_variable_defs`, and screenshots to catch detached-looking one-offs, off-token values, and naming issues you can fix now (or hand to `/figma-audit`).

## Senior rigor (always)

- **Always re-search components** at session start; never trust stale node IDs.
- **System over one-offs:** instantiate + tokenise; raw values are a smell.
- **Validate visually every step** — the screenshot is the source of truth, not your intention.
- **Auto layout + named layers** as you go, not as cleanup.
- **Open questions:** anything the canvas can't decide (real data, missing assets, product calls).

## Output

The built frames/components **in Figma**, plus a short report in chat: what was created (file/page/section), screenshots of the result, components reused, and anything left open. Hand to `/create-report` to document on the task (attach the screenshots / Figma link).
