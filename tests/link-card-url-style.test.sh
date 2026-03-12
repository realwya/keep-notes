#!/usr/bin/env bash
set -euo pipefail

if rg -q '<span class="card-url">[\r\n[:space:]]*<i data-lucide="link-2"' index.html; then
  echo "FAIL: link card URL should not render a leading link icon"
  exit 1
fi

url_text_line="$(rg -n '^\.url-text \{' styles.css | cut -d: -f1)"

if [[ -z "${url_text_line}" ]]; then
  echo "FAIL: .url-text styles are missing"
  exit 1
fi

if ! sed -n "${url_text_line},$((url_text_line + 8))p" styles.css | rg -q 'text-decoration: underline;'; then
  echo "FAIL: link card URL text should be underlined"
  exit 1
fi

echo "PASS: link card URL removes leading icon and underlines URL text"
