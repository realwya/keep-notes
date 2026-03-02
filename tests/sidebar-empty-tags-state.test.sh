#!/usr/bin/env bash
set -euo pipefail

if ! rg -q 'id="tagsEmptyState"' index.html; then
  echo "FAIL: tags section should include tagsEmptyState element"
  exit 1
fi

if ! rg -q 'No tags found' index.html; then
  echo "FAIL: tags empty state copy should be 'No tags found'"
  exit 1
fi

if ! rg -q "tagsEmptyState: document\\.getElementById\\('tagsEmptyState'\\)" config.js; then
  echo "FAIL: config elements should register tagsEmptyState"
  exit 1
fi

if rg -q "tagsSection\\.classList\\.toggle\\('hidden', allTags\\.length === 0\\)" sidebar.js; then
  echo "FAIL: tags section should not be hidden when tags are empty"
  exit 1
fi

if ! rg -q "tagsEmptyState\\.classList\\.toggle\\('hidden', hasTags\\)" sidebar.js; then
  echo "FAIL: sidebar should toggle tagsEmptyState by hasTags"
  exit 1
fi

echo "PASS: sidebar tags empty state checks"
