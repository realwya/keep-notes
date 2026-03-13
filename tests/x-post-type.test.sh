#!/usr/bin/env bash
set -euo pipefail

if ! rg -q "return extractXPostId\\(url\\) \\? 'x-posts' : extractDirectImageUrl\\(url\\) \\? 'images' : 'links';" utils.js; then
  echo "FAIL: X/Twitter status URLs should be classified as x-posts before images/links fallback"
  exit 1
fi

if ! rg -q "return type === 'links' \\|\\| type === 'images' \\|\\| type === 'x-posts';" utils.js; then
  echo "FAIL: x-posts should be treated as a link-like item type"
  exit 1
fi

if ! rg -q "const TYPE_FILTER_ORDER = \\['notes', 'links', 'x-posts', 'images'\\];" sidebar.js; then
  echo "FAIL: sidebar type filter order should include x-posts after links"
  exit 1
fi

if ! rg -q 'data-type="x-posts"' index.html; then
  echo "FAIL: type capsules should include an X posts button with plural type value"
  exit 1
fi

if ! rg -q "type: getLinkTypeFromUrl\\(rawUrl\\)," editor.js; then
  echo "FAIL: edited links should keep using URL-based type detection"
  exit 1
fi

if ! rg -q "const linkType = getLinkTypeFromUrl\\(url\\);" app.js || ! rg -q "type: linkType," app.js; then
  echo "FAIL: new links should keep using URL-based type detection"
  exit 1
fi

if ! rg -q "const frontMatterData = \\{ type: 'notes' \\};" app.js; then
  echo "FAIL: new notes should persist with the plural notes type"
  exit 1
fi

if ! rg -q "const frontMatterData = \\{ \\.\\.\\.originalData, type: 'notes' \\};" editor.js; then
  echo "FAIL: edited notes should persist with the plural notes type"
  exit 1
fi

if ! rg -q "if \\(nextData\\.url\\) \\{" utils.js || ! rg -q "nextData\\.type = getLinkTypeFromUrl\\(nextData\\.url\\);" utils.js; then
  echo "FAIL: active-view normalization should migrate existing X post links to x-posts"
  exit 1
fi

if ! rg -q "nextData\\.type = 'notes';" utils.js; then
  echo "FAIL: active-view normalization should migrate existing note types to notes"
  exit 1
fi

echo "PASS: plural type classification and UI wiring checks"
