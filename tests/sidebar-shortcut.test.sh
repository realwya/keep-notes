#!/usr/bin/env bash
set -euo pipefail

if ! rg -q "e\\.key === '\\\\\\\\'" app.js; then
  echo "FAIL: keyboard shortcut should listen for backslash key"
  exit 1
fi

if ! rg -q "\\(e\\.metaKey \\|\\| e\\.ctrlKey\\)" app.js; then
  echo "FAIL: keyboard shortcut should support Cmd/Ctrl modifier"
  exit 1
fi

if ! rg -q "toggleSidebarCollapse\\(\\)" app.js; then
  echo "FAIL: keyboard shortcut should toggle sidebar collapse"
  exit 1
fi

echo "PASS: Cmd/Ctrl+\\\\ toggles sidebar collapse/expand"
