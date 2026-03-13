#!/usr/bin/env bash
set -euo pipefail

if ! rg -q '\.image-link-card \.card-tags \{' styles.css; then
  echo "FAIL: image link cards should explicitly hide card tags"
  exit 1
fi

if ! awk '
  /\.image-link-card \.card-actions \{/ { in_block=1 }
  in_block && /position: absolute;/ { absolute=1 }
  in_block && /bottom: 0;/ { bottom=1 }
  in_block && /pointer-events: none;/ { pointer_none=1 }
  in_block && /^\}/ {
    exit(absolute && bottom && pointer_none ? 0 : 1)
  }
  END { if (!(absolute && bottom && pointer_none)) exit 1 }
' styles.css; then
  echo "FAIL: image link card actions should be an absolute bottom overlay hidden by default"
  exit 1
fi

if ! rg -q '\.image-link-card:hover \.card-actions,' styles.css; then
  echo "FAIL: image link card actions should appear on hover"
  exit 1
fi

if ! rg -q '\.image-link-card:focus-within \.card-actions \{' styles.css; then
  echo "FAIL: image link card actions should remain visible for keyboard focus"
  exit 1
fi

if ! rg -q '@media \(hover: none\), \(pointer: coarse\)' styles.css; then
  echo "FAIL: image link card actions should stay visible on touch devices"
  exit 1
fi

echo "PASS: image link card overlay actions checks"
