#!/usr/bin/env bash
set -euo pipefail

if ! rg -q 'rel="preconnect" href="https://platform.twitter.com"' index.html; then
  echo "FAIL: index should preconnect to platform.twitter.com"
  exit 1
fi

if ! rg -q 'rel="preconnect" href="https://cdn.syndication.twimg.com"' index.html; then
  echo "FAIL: index should preconnect to cdn.syndication.twimg.com"
  exit 1
fi

if ! rg -q 'warmupXPostEmbedding\(\)' app.js; then
  echo "FAIL: app init should warm up X post embedding"
  exit 1
fi

if ! rg -q 'function warmupXPostEmbedding\(' utils.js; then
  echo "FAIL: utils should expose X post warmup helper"
  exit 1
fi

if ! rg -q 'xPostEmbedCache\.get\(xPostId\)' utils.js; then
  echo "FAIL: renderXPostEmbed should use cache lookup"
  exit 1
fi

if ! rg -q 'xPostEmbedCache\.set\(xPostId, tweetEl\)' utils.js; then
  echo "FAIL: renderXPostEmbed should cache rendered tweet element"
  exit 1
fi

echo "PASS: X post loading performance checks"
