#!/usr/bin/env bash
set -euo pipefail

if ! rg -q "const linkType = getLinkTypeFromUrl\\(url\\);" app.js; then
  echo "FAIL: addLinkItem should classify URL type before requesting metadata"
  exit 1
fi

if ! awk '
  /async function addLinkItem\(url, tags = \[\]\) \{/ { in_fn=1 }
  in_fn && /if \(linkType === '\''links'\''\) \{/ { in_link_branch=1 }
  in_link_branch && /await fetchLinkMetadata\(url\)/ { found=1 }
  in_link_branch && /^\s*\}/ { in_link_branch=0 }
  in_fn && /^\}/ { exit(found ? 0 : 1) }
  END { if (!found) exit 1 }
' app.js; then
  echo "FAIL: addLinkItem should only request Microlink metadata for links"
  exit 1
fi

if ! rg -q "image: linkType === 'images' \\? url : ''" app.js; then
  echo "FAIL: image URLs should use the original URL as saved image metadata"
  exit 1
fi

if ! rg -q "console.warn\\('Fetch link metadata failed:'" app.js; then
  echo "FAIL: Microlink failures should be downgraded to a non-blocking warning"
  exit 1
fi

if ! awk '
  /async function addLinkItem\(url, tags = \[\]\) \{/ { in_fn=1 }
  in_fn && /const markdownContent = createMarkdownWithFrontMatter\(frontMatterData\);/ { created=1 }
  in_fn && /await saveFile\(filename, markdownContent\);/ { saved=1 }
  in_fn && /^\}/ { exit(created && saved ? 0 : 1) }
  END { if (!(created && saved)) exit 1 }
' app.js; then
  echo "FAIL: addLinkItem should still save markdown content after fallback metadata handling"
  exit 1
fi

echo "PASS: link metadata fallback flow checks"
