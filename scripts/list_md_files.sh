#!/bin/bash
find . -type f \( -name "*.md" -o -name "*.mdx" \) \
  ! -name "*_zh_TW.md" \
  ! -name "*_zh_TW.mdx" \
  ! -name "PROGRESS.md" \
  ! -path "*/node_modules/*" \
  ! -path "*/.git/*" \
  ! -path "*/build/*"
