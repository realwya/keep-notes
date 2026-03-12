#!/usr/bin/env bash
set -euo pipefail

if ! rg -Fq '<link rel="icon" type="image/svg+xml" href="assets/mindkeep-logo.svg">' index.html; then
  echo "FAIL: favicon should point to the Mindkeep SVG asset"
  exit 1
fi

if ! rg -Fq '<img src="assets/mindkeep-logo.svg" class="brand-logo" alt="Mindkeep logo">' index.html; then
  echo "FAIL: sidebar branding should render the Mindkeep logo image"
  exit 1
fi

if rg -q 'data-lucide="book-open"' index.html; then
  echo "FAIL: sidebar branding should not use the temporary Lucide book-open icon"
  exit 1
fi

echo "PASS: Mindkeep logo branding is wired into the sidebar and favicon"
