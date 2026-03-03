#!/usr/bin/env bash
set -euo pipefail

if ! rg -q 'const cardRenderCache = new Map\(\)' config.js; then
  echo "FAIL: config should define card render cache"
  exit 1
fi

if ! rg -q 'function getCardCacheKey\(item\)' cards.js; then
  echo "FAIL: cards should expose cache key helper"
  exit 1
fi

if ! rg -q '\$\{currentView\}:\$\{item\.id\}' cards.js; then
  echo "FAIL: card cache key should include current view"
  exit 1
fi

if ! rg -q 'cardRenderCache\.get\(cacheKey\)' cards.js; then
  echo "FAIL: cards should read from render cache"
  exit 1
fi

if ! rg -q 'cardRenderCache\.set\(cacheKey' cards.js; then
  echo "FAIL: cards should write into render cache"
  exit 1
fi

echo "PASS: card render cache checks"
