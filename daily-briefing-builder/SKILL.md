# Daily Briefing Builder

**Version:** 1.0.0  
**Price:** Free  
**Category:** Productivity  

---

## What It Does

Pulls together your daily priorities, content backlog, and local weather into a clean morning brief — no APIs, no paid services, no configuration overhead. Pure vault + shell operations.

Runs automatically on your morning heartbeat or cron. You wake up, open Telegram (or your terminal), and your day is already organized.

---

## What the Brief Includes

1. **Today's 3 Actions** — pulled from your daily actions file (`bambf/tracking/daily-actions/YYYY-MM-DD.md`)
2. **Ready to Post** — content files in `content/ready-to-post/` where `**Posted:** ❌`
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

It lists each file by platform (based on subdirectory) and extracts the first non-blank line as a title preview.

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
  echo "No actions file found for $TODAY"
fi
```

### Scan ready-to-post content
```bash
echo ""
echo "=== READY TO POST ==="
find /root/obsidian-vault/content/ready-to-post -name "*.md" | while read f; do
  if grep -q '\*\*Posted:\*\* ❌' "$f"; then
    platform=$(echo "$f" | sed 's|.*/ready-to-post/||' | cut -d'/' -f1)
    title=$(grep -m1 '^[^#\-\*>|` ]' "$f" | head -c 80)
    echo "[$platform] $title"
  fi
done
```

### Pull weather
```bash
echo ""
echo "=== WEATHER ==="
curl -s "wttr.in/Ann+Arbor?format=3"
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
0 12 * * * openclaw run triton "Run the Daily Briefing Builder. Pull today's actions, scan ready-to-post content, get weather for Ann Arbor. Format as morning brief and send to Telegram." >> ~/.openclaw/logs/briefing.log 2>&1
```

---

## Example Output

```
☀️ Morning Brief — Saturday, March 1

TODAY'S 3 ACTIONS
1. Finish Q1 content calendar
2. Send invoice to BAMBF client  
3. Publish LinkedIn post on AI ops

READY TO POST (3 pieces)
[linkedin] Nobody talks about what happens when your AI system fails at 3am...
[twitter] The overnight ops shift is real. We run Scribe at 2am, Proof at 3am...
[newsletter] AI marketing systems that actually work — not theory, not hype...

WEATHER
Ann Arbor: ☀️  +42°F
```

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
- Bash + standard Unix tools (`find`, `grep`, `awk`, `curl`)
- Daily actions file at `bambf/tracking/daily-actions/YYYY-MM-DD.md`
- `content/ready-to-post/` with `**Posted:** ❌` status lines
- Internet access for wttr.in (fails gracefully if offline)

---

*No APIs. No paid services. Just your vault and a curl command.*
