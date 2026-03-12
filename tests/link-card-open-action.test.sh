#!/usr/bin/env bash
set -euo pipefail

if rg -q 'open-link-button' index.html; then
  echo "FAIL: link card actions should not include an open link button"
  exit 1
fi

if ! rg -F -q "const cardUrl = e.target.closest('.card-url');" app.js; then
  echo "FAIL: handleCardClick should keep card URL click handling"
  exit 1
fi

if ! rg -q "const href = item \\? withHttpProtocol\\(getItemParsed\\(item\\)\\.data\\.url\\) : '';" app.js; then
  echo "FAIL: card URL click should derive the URL directly from the item data"
  exit 1
fi

if ! rg -q "window\\.open\\(href, '_blank', 'noopener,noreferrer'\\)" app.js; then
  echo "FAIL: card URL click should still open the derived URL in a new tab"
  exit 1
fi

if rg -F -q "card?.querySelector('.open-link-button')?.href" app.js; then
  echo "FAIL: card URL click should not depend on open link button href"
  exit 1
fi

echo "PASS: link card removes open action button and keeps URL click opening"
