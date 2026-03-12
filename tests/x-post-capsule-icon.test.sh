#!/usr/bin/env bash
set -euo pipefail

if ! rg -q '<button class="type-capsule" data-type="x-posts" type="button" aria-label="Filter X posts">' index.html; then
  echo "FAIL: X posts type capsule is missing"
  exit 1
fi

if ! rg -q 'data-lucide="twitter"' index.html; then
  echo "FAIL: X posts type capsule should use the twitter Lucide icon"
  exit 1
fi

if rg -q 'data-type="x-posts"[\\s\\S]*data-lucide="message-circle"' index.html; then
  echo "FAIL: X posts type capsule should no longer use the message-circle icon"
  exit 1
fi

echo "PASS: X posts capsule uses the twitter icon"
