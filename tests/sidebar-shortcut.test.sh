#!/usr/bin/env bash
set -euo pipefail

if ! rg -q "e\\.key\\.toLowerCase\\(\\) === 'b'" app.js; then
  echo "FAIL: keyboard shortcut should listen for B key"
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

echo "PASS: Cmd/Ctrl+B toggles sidebar collapse/expand"
