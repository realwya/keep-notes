#!/usr/bin/env bash
set -euo pipefail

show_line="$(rg -n "editModal\\.modal\\.classList\\.remove\\('hidden'\\)" editor.js | head -n1 | cut -d: -f1)"
ensure_line="$(rg -n 'await ensureNoteEditor\(\)' editor.js | head -n1 | cut -d: -f1)"

if [[ -z "${show_line}" || -z "${ensure_line}" ]] || ! (( ensure_line < show_line )); then
  echo "FAIL: note edit modal should wait for editor readiness before showing"
  exit 1
fi

if ! rg -q 'function scheduleNoteEditorWarmup\(\)' editor.js; then
  echo "FAIL: note editor should provide a warmup scheduler"
  exit 1
fi

if ! rg -q 'scheduleNoteEditorWarmup\(\)' app.js; then
  echo "FAIL: app init should schedule note editor warmup"
  exit 1
fi

echo "PASS: editor modal stability checks"
