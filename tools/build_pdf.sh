#!/usr/bin/env bash
# Usage: tools/build_pdf.sh week02
# Builds weekNN/weekNN_report.pdf from weekNN/README.md (pandoc + headless Chrome).
set -e
WEEK="$1"; ROOT="$(cd "$(dirname "$0")/.." && pwd)"; DIR="$ROOT/$WEEK"
CHROME="/c/Program Files/Google/Chrome/Application/chrome.exe"
TMP_MD="$DIR/_tmp.md"; TMP_HTML="$DIR/_tmp.html"
# Expand <details> blocks so screenshots and tables show up in the PDF
sed -E '/^<\/?details>|^<summary>/d' "$DIR/README.md" > "$TMP_MD"
pandoc "$TMP_MD" -f gfm -t html5 -s --metadata pagetitle="$WEEK report" \
  --css "file:///$(cygpath -m "$ROOT/tools/pdf.css")" -o "$TMP_HTML"
"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$(cygpath -w "$DIR/${WEEK}_report.pdf")" "file:///$(cygpath -m "$TMP_HTML")" 2>/dev/null
rm -f "$TMP_MD" "$TMP_HTML"
echo "built $WEEK/${WEEK}_report.pdf"
