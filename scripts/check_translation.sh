#!/bin/bash
MISSING=0
./scripts/list_md_files.sh | while read -r file; do
  ext="${file##*.}"
  base="${file%.*}"
  translated="${base}_zh_TW.${ext}"
  if [ ! -f "$translated" ]; then
    echo "Missing translation for: $file"
    MISSING=$((MISSING + 1))
  fi
done
if [ "$MISSING" -eq 0 ]; then
  echo "All files translated!"
  exit 0
else
  echo "Total missing: $MISSING"
  exit 1
fi
