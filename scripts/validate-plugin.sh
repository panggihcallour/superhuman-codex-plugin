#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN_DIR="$ROOT_DIR/plugins/design-agent"

if ! command -v rg >/dev/null 2>&1; then
  echo "error: rg is required for plugin validation" >&2
  exit 1
fi

echo "Validating Superhuman Agent plugin..."

TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

rg -n \
  'post-comment|Graphic, Dev, Research coming|WebSearch|WebFetch|Claude Code|Agent tool|runner: "claude"|figma_(get|take|search|execute|lint|audit|export|browse|setup|create|batch|scan|check|instantiate|analyze)_' \
  "$PLUGIN_DIR" >"$TMP_FILE" || true

if [[ -s "$TMP_FILE" ]]; then
  echo "error: found stale plugin instructions:" >&2
  cat "$TMP_FILE" >&2
  exit 1
fi

python3 -m json.tool "$PLUGIN_DIR/.codex-plugin/plugin.json" >/dev/null
python3 -m json.tool "$PLUGIN_DIR/.mcp.json" >/dev/null

GRAPHIC_SKILLS=(
  brand-strategy
  moodboard
  logo-design
  brand-identity
  marketing-assets
  brand-guidelines
  asset-handoff
  graphic-critique
)

REMOVED_SKILLS=(
  product-brief
  pr-faq
  product-discovery
  prd
  prioritization
  roadmap
  product-critique
  research-plan
  market-analysis
  user-interview
  survey
  usability-eval
  synthesis
  insights-report
)

for skill in "${GRAPHIC_SKILLS[@]}"; do
  skill_file="$PLUGIN_DIR/skills/$skill/SKILL.md"
  if ! rg -q '^## Codex-only image generation$' "$skill_file"; then
    echo "error: missing Codex-only image generation section in $skill_file" >&2
    exit 1
  fi
done

for skill in "${REMOVED_SKILLS[@]}"; do
  if [[ -e "$PLUGIN_DIR/skills/$skill" ]]; then
    echo "error: removed Product/Research skill still exists: $PLUGIN_DIR/skills/$skill" >&2
    exit 1
  fi
done

if rg -n 'Product Agent|Research Agent|product-brief|pr-faq|product-discovery|/prd|`prd`|prioritization|roadmap|product-critique|research-plan|market-analysis|user-interview|/survey|`survey`|usability-eval|/synthesis|`synthesis`|insights-report' "$PLUGIN_DIR" "$ROOT_DIR/README.md" >"$TMP_FILE"; then
  echo "error: found stale Product/Research agent instructions:" >&2
  cat "$TMP_FILE" >&2
  exit 1
fi

echo "OK"
