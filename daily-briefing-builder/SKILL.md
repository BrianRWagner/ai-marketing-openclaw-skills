# Daily Briefing Builder

**Version:** 2.0.0  
**Price:** Free  
**Category:** Productivity  

---

## What It Does

Pulls together your daily priorities, content backlog, and local weather into a clean morning brief — no APIs, no paid services, no configuration overhead. Pure vault + shell operations.

Runs automatically on your morning heartbeat or cron. You wake up, open Telegram (or your terminal), and your day is already organized.

Includes dedup guard, delivery log, and state tracking so the same content never appears two days in a row.

---

## What the Brief Includes

1. **Today's 3 Actions** — pulled from your daily actions file (`bambf/tracking/daily-actions/YYYY-MM-DD.md`)
2. **Ready to Post** — up to 5 content files in `content/ready-to-post/` where `**Posted:** ❌` (most recently modified first)
3. **Weather** — current conditions via wttr.in (no API key required)

---

## Setup

### 1. Daily Actions File Structure

The skill reads today's actions from:

```
/root/obsidian-vault/bambf/tracking/daily-actions/YYYY-MM-DD.md
```

Your daily actions file should contain a section like this:

```markdown
# Daily Actions — 2026-03-01

## Today's 3 Actions
1. Finish Q1 content calendar
2. Send invoice to BAMBF client
3. Publish LinkedIn post on AI ops
```

The skill grabs everything under `## Today's 3 Actions` (or the first numbered list it finds if that heading doesn't exist).

### 2. Content Scan

The skill scans `content/ready-to-post/` recursively for any markdown file containing the line:

```
**Posted:** ❌
```

It lists each file by platform (based on subdirectory) and extracts the first non-blank line as a title preview. Capped at **5 items** (most recently modified). If more exist, overflow count is shown.

### 3. Weather

Uses `wttr.in` — no account, no API key, no setup:

```bash
curl -s "wttr.in/Ann+Arbor?format=3"
# Output: Ann Arbor: ☀️  +42°F
```

Set your city once in the config block below.

---

## Configuration

At the top of your heartbeat prompt or agent SOUL.md, set:

```yaml
briefing_config:
  vault_root: /root/obsidian-vault
  city: Ann+Arbor          # wttr.in format (spaces → +)
  daily_actions_dir: bambf/tracking/daily-actions
  ready_to_post_dir: content/ready-to-post
  state_dir: ~/.openclaw/state
  log_dir: memory
```

---

## Shell Commands

### Pull today's 3 actions
```bash
TODAY=$(date +%Y-%m-%d)
ACTIONS_FILE="/root/obsidian-vault/bambf/tracking/daily-actions/${TODAY}.md"

if [ -f "$ACTIONS_FILE" ]; then
  echo "=== TODAY'S 3 ACTIONS ==="
  awk '/## Today.s 3 Actions/{found=1; next} found && /^[0-9]/{print} found && /^##/{exit}' "$ACTIONS_FILE"
else
  echo "No actions file for today — add priorities at bambf/tracking/daily-actions/${TODAY}.md"
fi
```

### Scan ready-to-post content (capped at 5)
```bash
echo ""
echo "=== READY TO POST ==="

VAULT="/root/obsidian-vault"
MAX=5
COUNT=0

TOTAL=$(find "$VAULT/content/ready-to-post" -name "*.md" -exec grep -l '\*\*Posted:\*\* ❌' {} \; 2>/dev/null | wc -l)

if [ "$TOTAL" -eq 0 ]; then
  echo "No content ready — pipeline empty"
else
  find "$VAULT/content/ready-to-post" -name "*.md" -printf "%T@ %p\n" 2>/dev/null | sort -rn | awk '{print $2}' | while read f; do
    if grep -q '\*\*Posted:\*\* ❌' "$f" 2>/dev/null; then
      platform=$(echo "$f" | sed 's|.*/ready-to-post/||' | cut -d'/' -f1)
      title=$(grep -m1 '^[^#\-\*>|` ]' "$f" | head -c 80)
      echo "[$platform] $title"
      COUNT=$((COUNT + 1))
      if [ "$COUNT" -ge "$MAX" ]; then
        OVERFLOW=$(( TOTAL - MAX ))
        [ "$OVERFLOW" -gt 0 ] && echo "...and $OVERFLOW more in the pipeline"
        break
      fi
    fi
  done
fi
```

### Pull weather
```bash
echo ""
echo "=== WEATHER ==="
curl -s --max-time 5 "wttr.in/Ann+Arbor?format=3" || echo "Weather unavailable (offline)"
```

---

## Full Brief Script (with dedup guard + delivery log)

Save as `/usr/local/bin/daily-brief.sh`:

```bash
#!/bin/bash

VAULT="${1:-/root/obsidian-vault}"
CITY="${2:-Ann+Arbor}"
TODAY=$(date +%Y-%m-%d)
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# ---- DEDUP GUARD ----
# Prevents double-firing within 2 hours
STATE_DIR="$HOME/.openclaw/state"
mkdir -p "$STATE_DIR"
STAMP_FILE="$STATE_DIR/briefing-last-run.txt"

if [ -f "$STAMP_FILE" ]; then
  LAST_RUN=$(cat "$STAMP_FILE")
  LAST_EPOCH=$(date -d "$LAST_RUN" +%s 2>/dev/null || echo 0)
  NOW_EPOCH=$(date +%s)
  DIFF=$(( NOW_EPOCH - LAST_EPOCH ))
  if [ "$DIFF" -lt 7200 ]; then
    echo "Brief already ran within 2 hours (last: $LAST_RUN). Skipping."
    exit 0
  fi
fi

# Record this run timestamp
date -u +%Y-%m-%dT%H:%M:%SZ > "$STAMP_FILE"

# ---- HEADER ----
DAY_LABEL=$(date '+%A, %B %-d')
echo "☀️ Morning Brief — $DAY_LABEL"
echo ""

# ---- TODAY'S ACTIONS ----
ACTIONS_FILE="$VAULT/bambf/tracking/daily-actions/${TODAY}.md"
echo "TODAY'S 3 ACTIONS"
if [ -f "$ACTIONS_FILE" ]; then
  awk '/## Today.s 3 Actions/{found=1; next} found && /^[0-9]/{print} found && /^##/{exit}' "$ACTIONS_FILE"
else
  echo "No actions file for today — add priorities at bambf/tracking/daily-actions/${TODAY}.md"
fi
echo ""

# ---- READY TO POST (capped at 5, suppress items shown yesterday) ----
echo "READY TO POST"

SHOWN_FILE="$STATE_DIR/briefing-last-shown.txt"
SHOWN_YESTERDAY=""
[ -f "$SHOWN_FILE" ] && SHOWN_YESTERDAY=$(cat "$SHOWN_FILE")

TOTAL=$(find "$VAULT/content/ready-to-post" -name "*.md" -exec grep -l '\*\*Posted:\*\* ❌' {} \; 2>/dev/null | wc -l)
MAX_ITEMS=5
COUNT=0
NEW_SHOWN_LIST=""

if [ "$TOTAL" -eq 0 ]; then
  echo "No content ready — pipeline empty"
else
  while IFS= read -r f; do
    [ -z "$f" ] && continue
    if grep -q '\*\*Posted:\*\* ❌' "$f" 2>/dev/null; then
      rel="${f##$VAULT/}"
      # Skip if shown yesterday (unless it's the only item)
      if echo "$SHOWN_YESTERDAY" | grep -qF "$rel" && [ "$TOTAL" -gt 1 ]; then
        continue
      fi
      platform=$(echo "$f" | sed 's|.*/ready-to-post/||' | cut -d'/' -f1)
      title=$(grep -m1 '^[^#\-\*>|` ]' "$f" | head -c 80)
      echo "[$platform] $title"
      NEW_SHOWN_LIST="${NEW_SHOWN_LIST}${rel}\n"
      COUNT=$((COUNT + 1))
      if [ "$COUNT" -ge "$MAX_ITEMS" ]; then
        break
      fi
    fi
  done < <(find "$VAULT/content/ready-to-post" -name "*.md" -printf "%T@ %p\n" 2>/dev/null | sort -rn | awk '{print $2}')

  if [ "$COUNT" -eq 0 ]; then
    echo "No new content to surface — all items shown recently"
  fi

  OVERFLOW=$(( TOTAL - COUNT ))
  if [ "$OVERFLOW" -gt 0 ] && [ "$COUNT" -ge "$MAX_ITEMS" ]; then
    echo "...and $OVERFLOW more in the pipeline"
  fi
fi

# Save what was shown for tomorrow's dedup
printf "%b" "$NEW_SHOWN_LIST" > "$SHOWN_FILE"
echo ""

# ---- WEATHER ----
echo "WEATHER"
curl -s --max-time 5 "wttr.in/${CITY}?format=3" || echo "Weather unavailable (offline)"
echo ""

# ---- DELIVERY LOG ----
LOG_FILE="$VAULT/memory/briefing-log.md"
mkdir -p "$VAULT/memory"
if [ ! -f "$LOG_FILE" ]; then
  printf "# Briefing Log\n\n" > "$LOG_FILE"
fi
{
  echo "## $NOW"
  echo "- Actions file: $([ -f "$ACTIONS_FILE" ] && echo 'found' || echo 'missing')"
  echo "- Content items surfaced: $COUNT of $TOTAL available"
  echo ""
} >> "$LOG_FILE"

echo "---"
echo "✅ Brief logged to memory/briefing-log.md"
```

```bash
chmod +x /usr/local/bin/daily-brief.sh
daily-brief.sh /root/obsidian-vault Ann+Arbor
```

---

## Autonomy Triggers

Add these to your HEARTBEAT.md or agent SOUL.md:

```yaml
- trigger: morning heartbeat (6–9am ET)
  action: Run Daily Briefing Builder
  output: Telegram message with formatted brief

- trigger: "morning brief" | "daily brief" | "what's my day look like"
  action: Run Daily Briefing Builder on demand
```

**Cron for automatic morning delivery (7am ET = 12:00 UTC):**

```bash
0 12 * * * /usr/local/bin/daily-brief.sh /root/obsidian-vault Ann+Arbor >> ~/.openclaw/logs/briefing.log 2>&1
```

**Handoff spec:**
- After delivery: Brief output is logged to `memory/briefing-log.md` — readable by Queue Orchestrator or any downstream agent
- If content items are surfaced in the brief: downstream agent can pass those file paths directly to the Typefully skill for scheduling
- Brief state (`briefing-last-shown.txt`) is a structured handoff artifact — other agents can read it to know what was surfaced today

---

## Example Output

```
☀️ Morning Brief — Saturday, March 1

TODAY'S 3 ACTIONS
1. Finish Q1 content calendar
2. Send invoice to BAMBF client  
3. Publish LinkedIn post on AI ops

READY TO POST
[linkedin] Nobody talks about what happens when your AI system fails at 3am...
[twitter] The overnight ops shift is real. We run Scribe at 2am, Proof at 3am...
[newsletter] AI marketing systems that actually work — not theory, not hype...
...and 4 more in the pipeline

WEATHER
Ann Arbor: ☀️  +42°F

---
✅ Brief logged to memory/briefing-log.md
```

**Edge case outputs:**

| Situation | Output |
|-----------|--------|
| No actions file | "No actions file for today — add priorities at bambf/tracking/daily-actions/YYYY-MM-DD.md" |
| Empty content queue | "No content ready — pipeline empty" |
| All items shown yesterday | "No new content to surface — all items shown recently" |
| Brief ran < 2 hours ago | "Brief already ran within 2 hours. Skipping." |
| Weather offline | "Weather unavailable (offline)" |

---

## State Files

| File | Purpose |
|------|---------|
| `~/.openclaw/state/briefing-last-run.txt` | Dedup guard — timestamp of last run |
| `~/.openclaw/state/briefing-last-shown.txt` | List of content items shown last brief |
| `memory/briefing-log.md` | Delivery log — timestamped record of every brief |

---

## Expanding the Brief

Once the basics work, easy additions:

**Add queue status** (if using Queue Orchestrator):
```bash
python3 -c "
import json
q = json.load(open('/root/obsidian-vault/.openclaw/queues/content.json'))
pending = [t['title'] for t in q if t['status']=='pending']
print(f'Queue: {len(pending)} pending tasks')
"
```

**Add yesterday's wins:**
```bash
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
grep -A5 "## Completed" "/root/obsidian-vault/bambf/tracking/daily-actions/${YESTERDAY}.md" 2>/dev/null
```

---

## Requirements

- OpenClaw v2026.1+
- Bash + standard Unix tools (`find`, `grep`, `awk`, `curl`, `stat`)
- Daily actions file at `bambf/tracking/daily-actions/YYYY-MM-DD.md`
- `content/ready-to-post/` with `**Posted:** ❌` status lines
- Write access to `~/.openclaw/state/` and `memory/` (auto-created)
- Internet access for wttr.in (fails gracefully if offline)

---

*No APIs. No paid services. Just your vault, a curl command, and a memory that actually works.*
