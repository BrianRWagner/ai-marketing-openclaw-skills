# Vault Cleanup Auditor

**Version:** 1.0.0  
**Price:** Free  
**Category:** Productivity  

---

## What It Does

Scans your Obsidian vault and produces a prioritized cleanup report. Finds stale drafts, empty folders, duplicate filenames, and incomplete markdown files — then saves a dated audit file you can work through at your own pace.

Run it monthly (or when the vault starts feeling messy). Takes under 30 seconds.

---

## What It Checks

| Check | What It Finds | Priority |
|-------|---------------|----------|
| **Stale drafts** | Files in `ready-to-post/` not modified in 30+ days | 🔴 High |
| **Incomplete files** | Markdown files with no headings | 🟡 Medium |
| **Duplicate filenames** | Same filename in different directories | 🟡 Medium |
| **Empty folders** | Directories with no files inside | 🟢 Low |

---

## Shell Commands

### Check 1: Stale drafts in ready-to-post/

```bash
VAULT="/root/obsidian-vault"

echo "=== STALE DRAFTS (30+ days, not posted) ==="
find "$VAULT/content/ready-to-post" -name "*.md" -mtime +30 | while read f; do
  if grep -q '\*\*Posted:\*\* ❌' "$f" 2>/dev/null; then
    days=$(( ($(date +%s) - $(stat -c %Y "$f")) / 86400 ))
    echo "  [${days}d] ${f##$VAULT/}"
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

## Full Audit Script (All 4 Checks + Save Report)

Save as `/usr/local/bin/vault-audit.sh`:

```bash
#!/bin/bash

VAULT="${1:-/root/obsidian-vault}"
DATE=$(date +%Y-%m-%d)
REPORT="$VAULT/vault-audit-$DATE.md"

echo "# Vault Cleanup Audit — $DATE" > "$REPORT"
echo "" >> "$REPORT"
echo "Generated: $(date '+%Y-%m-%d %H:%M')" >> "$REPORT"
echo "" >> "$REPORT"

# ---- STALE DRAFTS ----
echo "## 🔴 Stale Drafts (30+ days, unposted)" >> "$REPORT"
echo "" >> "$REPORT"
stale_found=false
find "$VAULT/content/ready-to-post" -name "*.md" -mtime +30 2>/dev/null | while read f; do
  if grep -q '\*\*Posted:\*\* ❌' "$f" 2>/dev/null; then
    days=$(( ($(date +%s) - $(stat -c %Y "$f")) / 86400 ))
    echo "- [${days}d old] ${f##$VAULT/}" >> "$REPORT"
    stale_found=true
  fi
done
echo "" >> "$REPORT"

# ---- INCOMPLETE FILES ----
echo "## 🟡 Incomplete Files (no headings, 5+ lines)" >> "$REPORT"
echo "" >> "$REPORT"
find "$VAULT" -name "*.md" \
  -not -path "*/.git/*" \
  -not -path "*/.obsidian/*" \
  -not -path "*/.openclaw/*" | while read f; do
  if ! grep -qE '^#{1,6} ' "$f" 2>/dev/null; then
    lines=$(wc -l < "$f")
    if [ "$lines" -gt 5 ]; then
      echo "- ${f##$VAULT/} ($lines lines)" >> "$REPORT"
    fi
  fi
done
echo "" >> "$REPORT"

# ---- DUPLICATES ----
echo "## 🟡 Duplicate Filenames" >> "$REPORT"
echo "" >> "$REPORT"
find "$VAULT" -name "*.md" \
  -not -path "*/.git/*" \
  -not -path "*/.obsidian/*" \
  -not -path "*/.openclaw/*" \
  -printf "%f\n" | sort | uniq -d | while read name; do
  echo "- **$name**" >> "$REPORT"
  find "$VAULT" -name "$name" \
    -not -path "*/.git/*" \
    -not -path "*/.obsidian/*" | while read f; do
    echo "  - ${f##$VAULT/}" >> "$REPORT"
  done
done
echo "" >> "$REPORT"

# ---- EMPTY FOLDERS ----
echo "## 🟢 Empty Folders" >> "$REPORT"
echo "" >> "$REPORT"
find "$VAULT" -type d -empty \
  -not -path "*/.git/*" \
  -not -path "*/.obsidian/*" \
  -not -path "*/.openclaw/*" | while read d; do
  echo "- ${d##$VAULT/}/" >> "$REPORT"
done

echo ""
echo "✅ Audit saved to: $REPORT"
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
  action: Run audit, save report, send top findings to Telegram
```

**Monthly cron (1st of month, 8am ET = 13:00 UTC):**

```bash
0 13 1 * * /usr/local/bin/vault-audit.sh /root/obsidian-vault && openclaw run triton "Read vault-audit-$(date +%Y-%m-%d).md in the vault root. Summarize top issues and send to Telegram." >> ~/.openclaw/logs/vault-audit.log 2>&1
```

---

## Example Output

```markdown
# Vault Cleanup Audit — 2026-03-01

Generated: 2026-03-01 08:00

## 🔴 Stale Drafts (30+ days, unposted)

- [47d old] content/ready-to-post/linkedin/2026-01-12-ai-systems-post.md
- [38d old] content/ready-to-post/twitter/2026-01-21-founder-ops.md
- [31d old] content/ready-to-post/newsletter/2026-01-28-tools-roundup.md

## 🟡 Incomplete Files (no headings, 5+ lines)

- bambf/research/untitled-notes.md (23 lines)
- thinking/random-thoughts.md (11 lines)

## 🟡 Duplicate Filenames

- **README.md**
  - bambf/brand/README.md
  - bambf/tracking/README.md
  - content/README.md

## 🟢 Empty Folders

- content/queue/rejected/
- bambf/clients/archived/
```

**What to do with the report:**
- 🔴 Stale drafts: post them, delete them, or archive to `content/posted/`
- 🟡 Incomplete files: finish or trash
- 🟡 Duplicates: merge or rename the less important one
- 🟢 Empty folders: safe to delete (or keep if you're about to use them)

---

## Requirements

- Bash + standard Unix tools (`find`, `grep`, `wc`, `stat`, `date`)
- Read access to vault directory
- Write access to vault root (for saving the report)
- No APIs, no paid services, no dependencies

---

*Your vault gets messy over time. This keeps it honest.*
