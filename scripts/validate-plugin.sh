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

echo "OK"
