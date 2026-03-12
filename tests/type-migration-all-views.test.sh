#!/usr/bin/env bash
set -euo pipefail

if rg -q "if \\(view === VIEW_ACTIVE\\) \\{" fs.js; then
  echo "FAIL: type normalization should not be limited to active view"
  exit 1
fi

if ! rg -q "const normalized = normalizeItemTypeInContent\\(text\\);" fs.js; then
  echo "FAIL: loadItems should normalize markdown types when reading files"
  exit 1
fi

if ! rg -q "if \\(normalized !== text\\) \\{" fs.js; then
  echo "FAIL: loadItems should rewrite files when normalized content changes"
  exit 1
fi

if ! rg -q "const writable = await entry\\.createWritable\\(\\);" fs.js; then
  echo "FAIL: loadItems should persist normalized content back to disk"
  exit 1
fi

echo "PASS: type migration runs across active, archive, and trash views"
