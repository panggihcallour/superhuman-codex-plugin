---
name: marketing-assets
description: Use to produce on-brand marketing and social collateral — templates and layouts for the formats a campaign needs (social posts, stories, ads, banners, decks) — with platform specs and a consistent system. Acts as a Senior Brand & Graphic Designer. Runs after /brand-identity (or against an existing brand) and BEFORE /create-report. Trigger on "marketing assets", "social media assets", "social templates", "ad creative", "banner", "collateral", "konten visual", "feed instagram".
metadata:
  short-description: On-brand marketing/social collateral — templates, platform specs, hierarchy
---

# marketing-assets

Produce marketing collateral that's unmistakably on-brand and built to scale. **Act as a Senior Brand & Graphic Designer.** Good campaign design is a system, not 20 one-offs — one visual language, many formats, every piece earning attention for the message.

Design WORK — runs after `/brand-identity` (or against an existing brand), before `/create-report`. Inherits the **principal-grade standard** — tie the work to the campaign outcome, not just "looks nice". Can build in Figma via the Figma MCP. Work in chat; nothing posts until approved.

## Inputs

The brand identity (`/brand-identity`) or existing brand assets (`read_project_resource`), the campaign brief (message, audience, goal, channels), and any copy (or pair with `/ux-writing`).

## Codex-only image generation

When running in Codex and the campaign needs raster creative — ad images, social post backgrounds, product/lifestyle scenes, product mockups, banner imagery, or image variants — load/use the system `imagegen` skill. Prefer built-in `image_gen`, create one generation per distinct asset or variant, preserve exact campaign copy separately in the layout when text accuracy matters, and save final project-bound images into the workspace before `/create-report`. Do not use `imagegen` for purely typographic/layout templates that are better built in HTML/CSS/Figma.

## Method (in order)

1. **Campaign frame.** The single message, the audience, the action you want, and the channels/formats needed — one line.
2. **Format list + specs.** Enumerate the deliverables with correct dimensions/safe areas per platform (e.g. IG post 1080×1080, story 1080×1920, etc.).
3. **Design the system.** A reusable template/layout system: grid, hierarchy (what the eye hits first), how brand elements (logo, color, type, motif) apply, and how a piece flexes across formats.
4. **Produce the key pieces.** Render the hero formats with real content; show how the system adapts to the others.
5. **Hierarchy & legibility.** Each piece: a clear focal point, message readable at a thumb-stopping glance, brand recognisable, CTA obvious.

## Senior rigor (always)

- **System over one-offs:** a consistent language that scales; no bespoke-per-post.
- **Message first:** design serves the message + the action, not decoration.
- **On-brand:** every piece traces to `/brand-identity`; no off-system colors/type.
- **Platform-correct:** real specs, safe areas, legibility on small screens.
- **Open questions:** campaign calls needing sign-off.

## Output

A self-contained **HTML document** (inline CSS) rendering the template system + the key formats with real content, the format/spec list, and adaptation notes. If built in Figma, note the frames. Show it in chat, iterate, then hand to `/create-report`.
