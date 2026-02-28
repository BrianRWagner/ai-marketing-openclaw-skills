---
name: vault-cleanup-auditor
description: Audit an Obsidian vault for stale drafts, empty folders, duplicate filenames, and incomplete files. Saves a dated report. Use when user says "clean up vault," "audit vault," "vault is messy," or "find orphan files."
---
# Vault Cleanup Auditor

**Version:** 2.0.0  
**Price:** Free  
**Category:** Productivity  

---

## What It Does

Scans your Obsidian vault and produces a prioritized cleanup report. Finds stale drafts, empty folders, duplicate filenames, and incomplete markdown files — then saves a dated audit file you can work through at your own pace.

Compares against your previous audit to flag repeat offenders. Caps each section at 15 items to keep the report actionable.

Run it monthly (or when the vault starts feeling messy). Takes under 30 seconds.

---

## What It Checks

| Check | What It Finds | Priority |
|-------|---------------|----------|
| **Stale drafts** | Files in `ready-to-post/` not modified in 30+ days | 🔴 High |
| **Incomplete files** | Markdown files with no headings | 🟡 Medium |
| **Duplicate filenames** | Same filename in different directories | 🟡 Medium |
| **Empty folders** | Directories with no files inside | 🟢 Low |

Items marked `↩ REPEAT` appeared in your previous audit too — highest priority to resolve.

---

## Shell Commands

### Check 1: Stale drafts in ready-to-post/

```bash
VAULT="/root/obsidian-vault"
MAX_ITEMS=15

echo "=== STALE DRAFTS (30+ days, not posted) ==="
COUNT=0
find "$VAULT/content/ready-to-post" -name "*.md" -mtime +30 | while read f; do
  if grep -q '\*\*Posted:\*\* ❌' "$f" 2>/dev/null; then
    days=$(( ($(date +%s) - $(stat -c %Y "$f")) / 86400 ))
    COUNT=$((COUNT+1))
    if [ "$COUNT" -le "$MAX_ITEMS" ]; then
      echo "  [${days}d] ${f##$VAULT/}"
    fi
  fi
done
```

### Check 2: Markdown files with no headings

```bash
echo ""
echo "=== NO HEADINGS (likely incomplete) ==="
find "$VAULT" -name "*.md" \
  -not -path "*/.git/*" \
  -not -path "*/.obsidian/*" \
  -not -path "*/.openclaw/*" | while read f; do
  if ! grep -qE '^#{1,6} ' "$f" 2>/dev/null; then
    lines=$(wc -l < "$f")
    if [ "$lines" -gt 5 ]; then
      echo "  ${f##$VAULT/} ($lines lines)"
    fi
  fi
done
```

### Check 3: Duplicate filenames

```bash
echo ""
echo "=== DUPLICATE FILENAMES ==="
find "$VAULT" -name "*.md" \
  -not -path "*/.git/*" \
  -not -path "*/.obsidian/*" \
  -not -path "*/.openclaw/*" \
  -printf "%f\n" | sort | uniq -d | while read name; do
  echo "  $name:"
  find "$VAULT" -name "$name" \
    -not -path "*/.git/*" \
    -not -path "*/.obsidian/*" | while read f; do
    echo "    ${f##$VAULT/}"
  done
done
```

### Check 4: Empty folders

```bash
echo ""
echo "=== EMPTY FOLDERS ==="
find "$VAULT" -type d -empty \
  -not -path "*/.git/*" \
  -not -path "*/.obsidian/*" \
  -not -path "*/.openclaw/*" | while read d; do
  echo "  ${d##$VAULT/}"
done
```

---

## Full Audit Script (All 4 Checks + Delta Comparison + Save Report)

Save as `/usr/local/bin/vault-audit.sh`:

```bash
#!/bin/bash

VAULT="${1:-/root/obsidian-vault}"
DATE=$(date +%Y-%m-%d)
AUDIT_DIR="$VAULT/vault-audit"
REPORT="$AUDIT_DIR/$DATE-audit.md"
MAX_ITEMS=15

mkdir -p "$AUDIT_DIR"

# ---- DELTA: find previous audit ----
LAST_REPORT=$(ls "$AUDIT_DIR"/*.md 2>/dev/null | grep -v "$DATE" | sort | tail -1)
LAST_DATE=""
LAST_ISSUE_COUNT=0
LAST_RESOLVED=0
if [ -n "$LAST_REPORT" ]; then
  LAST_DATE=$(basename "$LAST_REPORT" | sed 's/-audit\.md//')
  LAST_ISSUE_COUNT=$(grep -c '^- \[' "$LAST_REPORT" 2>/dev/null || echo 0)
fi

# ---- HEADER ----
{
  echo "# Vault Cleanup Audit — $DATE"
  echo ""
  echo "Generated: $(date '+%Y-%m-%d %H:%M')"
  echo ""
  if [ -n "$LAST_DATE" ]; then
    echo "> **Last audit:** $LAST_DATE | $LAST_ISSUE_COUNT issues found"
    echo "> Items marked \`↩ REPEAT\` appeared in the previous audit — resolve these first."
  else
    echo "> No previous audit found. First run."
  fi
  echo ""
} > "$REPORT"

# ---- HELPER: check if item appeared in last report ----
is_repeat() {
  local item="$1"
  if [ -n "$LAST_REPORT" ] && grep -qF "$item" "$LAST_REPORT" 2>/dev/null; then
    echo " ↩ REPEAT"
  else
    echo ""
  fi
}

# Counters for summary
STALE_COUNT=0
INCOMPLETE_COUNT=0
DUPE_COUNT=0
EMPTY_COUNT=0

# ---- STALE DRAFTS ----
{
  echo "## 🔴 Stale Drafts (30+ days, unposted)"
  echo ""
} >> "$REPORT"

STALE_ALL=()
while IFS= read -r f; do
  if grep -q '\*\*Posted:\*\* ❌' "$f" 2>/dev/null; then
    STALE_ALL+=("$f")
  fi
done < <(find "$VAULT/content/ready-to-post" -name "*.md" -mtime +30 2>/dev/null)

STALE_COUNT=${#STALE_ALL[@]}
SHOWN=0
for f in "${STALE_ALL[@]}"; do
  days=$(( ($(date +%s) - $(stat -c %Y "$f")) / 86400 ))
  rel="${f##$VAULT/}"
  repeat=$(is_repeat "$rel")
  echo "- [${days}d old]${repeat} $rel" >> "$REPORT"
  SHOWN=$((SHOWN+1))
  if [ "$SHOWN" -ge "$MAX_ITEMS" ]; then
    OVERFLOW=$(( STALE_COUNT - MAX_ITEMS ))
    [ "$OVERFLOW" -gt 0 ] && echo "- ...and $OVERFLOW more" >> "$REPORT"
    break
  fi
done
echo "" >> "$REPORT"

# ---- INCOMPLETE FILES ----
{
  echo "## 🟡 Incomplete Files (no headings, 5+ lines)"
  echo ""
} >> "$REPORT"

INCOMPLETE_ALL=()
while IFS= read -r f; do
  if ! grep -qE '^#{1,6} ' "$f" 2>/dev/null; then
    lines=$(wc -l < "$f")
    [ "$lines" -gt 5 ] && INCOMPLETE_ALL+=("$f|$lines")
  fi
done < <(find "$VAULT" -name "*.md" \
  -not -path "*/.git/*" \
  -not -path "*/.obsidian/*" \
  -not -path "*/.openclaw/*")

INCOMPLETE_COUNT=${#INCOMPLETE_ALL[@]}
SHOWN=0
for entry in "${INCOMPLETE_ALL[@]}"; do
  f="${entry%|*}"
  lines="${entry##*|}"
  rel="${f##$VAULT/}"
  repeat=$(is_repeat "$rel")
  echo "- ${rel}${repeat} ($lines lines)" >> "$REPORT"
  SHOWN=$((SHOWN+1))
  if [ "$SHOWN" -ge "$MAX_ITEMS" ]; then
    OVERFLOW=$(( INCOMPLETE_COUNT - MAX_ITEMS ))
    [ "$OVERFLOW" -gt 0 ] && echo "- ...and $OVERFLOW more" >> "$REPORT"
    break
  fi
done
echo "" >> "$REPORT"

# ---- DUPLICATES ----
{
  echo "## 🟡 Duplicate Filenames"
  echo ""
} >> "$REPORT"

DUPE_NAMES=()
while IFS= read -r name; do
  DUPE_NAMES+=("$name")
done < <(find "$VAULT" -name "*.md" \
  -not -path "*/.git/*" \
  -not -path "*/.obsidian/*" \
  -not -path "*/.openclaw/*" \
  -printf "%f\n" | sort | uniq -d)

DUPE_COUNT=${#DUPE_NAMES[@]}
SHOWN=0
for name in "${DUPE_NAMES[@]}"; do
  echo "- **$name**" >> "$REPORT"
  find "$VAULT" -name "$name" \
    -not -path "*/.git/*" \
    -not -path "*/.obsidian/*" | while read f; do
    echo "  - ${f##$VAULT/}" >> "$REPORT"
  done
  SHOWN=$((SHOWN+1))
  if [ "$SHOWN" -ge "$MAX_ITEMS" ]; then
    OVERFLOW=$(( DUPE_COUNT - MAX_ITEMS ))
    [ "$OVERFLOW" -gt 0 ] && echo "- ...and $OVERFLOW more duplicate names" >> "$REPORT"
    break
  fi
done
echo "" >> "$REPORT"

# ---- EMPTY FOLDERS ----
{
  echo "## 🟢 Empty Folders"
  echo ""
} >> "$REPORT"

EMPTY_ALL=()
while IFS= read -r d; do
  EMPTY_ALL+=("$d")
done < <(find "$VAULT" -type d -empty \
  -not -path "*/.git/*" \
  -not -path "*/.obsidian/*" \
  -not -path "*/.openclaw/*")

EMPTY_COUNT=${#EMPTY_ALL[@]}
SHOWN=0
for d in "${EMPTY_ALL[@]}"; do
  echo "- ${d##$VAULT/}/" >> "$REPORT"
  SHOWN=$((SHOWN+1))
  if [ "$SHOWN" -ge "$MAX_ITEMS" ]; then
    OVERFLOW=$(( EMPTY_COUNT - MAX_ITEMS ))
    [ "$OVERFLOW" -gt 0 ] && echo "- ...and $OVERFLOW more" >> "$REPORT"
    break
  fi
done
echo "" >> "$REPORT"

# ---- SUMMARY (prepend after counts are known) ----
SUMMARY_LINE="**Summary:** 🔴 $STALE_COUNT stale | 🟡 $INCOMPLETE_COUNT incomplete | 🟡 $DUPE_COUNT dupes | 🟢 $EMPTY_COUNT empty"
# Insert summary after header block
sed -i "s/^> No previous audit.*/${SUMMARY_LINE}\n\n&/" "$REPORT" 2>/dev/null || true
sed -i "s/^> Items marked.*/${SUMMARY_LINE}\n\n&/" "$REPORT" 2>/dev/null || true

# Append summary at end for easy Telegram delivery
{
  echo "---"
  echo ""
  echo "$SUMMARY_LINE"
  echo ""
  echo "**What to do:**"
  echo "- 🔴 Stale drafts: post them, delete them, or archive to \`content/posted/\`"
  echo "- 🟡 Incomplete files: finish or trash"
  echo "- 🟡 Duplicates: merge or rename the less important one"
  echo "- 🟢 Empty folders: safe to delete (or keep if you're about to use them)"
} >> "$REPORT"

echo ""
echo "✅ Audit saved to: $REPORT"
echo "$SUMMARY_LINE"
```

```bash
chmod +x /usr/local/bin/vault-audit.sh
vault-audit.sh /root/obsidian-vault
```

---

## Autonomy Triggers

```yaml
- trigger: "vault audit" | "clean up vault" | "what's stale in the vault"
  action: Run vault-audit.sh, send summary to Telegram

- trigger: first day of month (cron)
  action: Run audit, save report to vault-audit/YYYY-MM-DD-audit.md, send top findings to Telegram
```

**Monthly cron (1st of month, 8am ET = 13:00 UTC):**

```bash
0 13 1 * * /usr/local/bin/vault-audit.sh /root/obsidian-vault && openclaw run triton "Read the latest file in vault-audit/ in the vault. Summarize top issues (especially any marked REPEAT) and send to Telegram." >> ~/.openclaw/logs/vault-audit.log 2>&1
```

---

## Example Output

```markdown
# Vault Cleanup Audit — 2026-03-01

Generated: 2026-03-01 08:00

> **Last audit:** 2026-02-01 | 8 issues found
> Items marked `↩ REPEAT` appeared in the previous audit — resolve these first.

**Summary:** 🔴 3 stale | 🟡 2 incomplete | 🟡 1 dupe | 🟢 2 empty

## 🔴 Stale Drafts (30+ days, unposted)

- [47d old] ↩ REPEAT content/ready-to-post/linkedin/2026-01-12-ai-systems-post.md
- [38d old] ↩ REPEAT content/ready-to-post/twitter/2026-01-21-founder-ops.md
- [31d old] content/ready-to-post/newsletter/2026-01-28-tools-roundup.md

## 🟡 Incomplete Files (no headings, 5+ lines)

- bambf/research/untitled-notes.md (23 lines)
- thinking/random-thoughts.md (11 lines)

## 🟡 Duplicate Filenames

- **README.md**
  - bambf/brand/README.md
  - bambf/tracking/README.md

## 🟢 Empty Folders

- content/queue/rejected/
- bambf/clients/archived/
```

---

## Report Location

Reports save to: `vault-audit/YYYY-MM-DD-audit.md`

The script reads the most recent previous report for delta comparison. Keep the `vault-audit/` folder intact between runs.

---

## Requirements

- Bash + standard Unix tools (`find`, `grep`, `wc`, `stat`, `date`)
- Read access to vault directory
- Write access to `vault-audit/` (auto-created)
- No APIs, no paid services, no dependencies

---

*Your vault gets messy over time. This keeps it honest — and remembers what you keep ignoring.*
