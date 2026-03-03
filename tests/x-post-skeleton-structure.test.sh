#!/usr/bin/env bash
set -euo pipefail

if ! rg -q "x-post-skeleton-header" utils.js; then
  echo "FAIL: X post skeleton should include header section"
  exit 1
fi

if ! rg -q "x-post-skeleton-avatar" utils.js; then
  echo "FAIL: X post skeleton should include avatar placeholder"
  exit 1
fi

if ! rg -q "x-post-skeleton-media" utils.js; then
  echo "FAIL: X post skeleton should include media placeholder"
  exit 1
fi

if ! rg -q "x-post-skeleton-actions" utils.js; then
  echo "FAIL: X post skeleton should include action row"
  exit 1
fi

if ! rg -q "\.x-post-skeleton-header" styles.css; then
  echo "FAIL: styles should define X post skeleton header"
  exit 1
fi

if ! rg -q "\.x-post-skeleton-avatar" styles.css; then
  echo "FAIL: styles should define X post skeleton avatar"
  exit 1
fi

if ! rg -q "\.x-post-skeleton-actions" styles.css; then
  echo "FAIL: styles should define X post skeleton actions"
  exit 1
fi

echo "PASS: X post skeleton structure and styles"
