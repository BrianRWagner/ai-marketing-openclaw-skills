---
name: social-engagement-scanner
description: Scans X/Twitter 3x/day for high-reach posts in your niche. Scores by follower count and freshness. Drafts contextual replies in your voice. Sends drafts to Telegram for approval — nothing posts without explicit command.
---

# Social Engagement Scanner

**Version:** 1.1.0  
**Price:** $19  
**Category:** Marketing  

---

## What It Does

Scans X (Twitter) 3x/day for high-reach posts matching your niche. Scores each post by follower count and freshness. Drafts contextual replies aligned to your voice profile. Sends drafts to Telegram for your approval — **nothing posts without your explicit "post" command.**

```
[Cron 10am/2pm/6pm ET] → Scan X for niche keywords
→ Score posts (3K+ followers OR 2+ comments, <6hrs old)
→ Draft reply in your voice
→ Send to Telegram: "Reply drafted. Type 'post' to send."
→ [YOU] → Review → type "post" → bird CLI posts it
```

Zero auto-posting. Ever.

---

## Setup

### 1. bird CLI Config

```bash
# Set credentials in ~/.openclaw/credentials/bird.env
BIRD_AUTH_TOKEN=your_x_auth_token
BIRD_CT0=your_ct0_cookie

# Test
source ~/.openclaw/credentials/bird.env
bird search "AI marketing" --auth-token "$BIRD_AUTH_TOKEN" --ct0 "$BIRD_CT0" --limit 20
```

### 2. Voice Profile

Create/update `bambf/brand/VOICE-PROFILE-MASTER.md` with your writing style, topics, and phrases to avoid.

### 3. Keywords File

Create `.openclaw/scanner/keywords.txt` — one keyword per line:
```
AI marketing
founder systems
content ops
AI agents
```

### 4. Scanner Config

Save as `.openclaw/scanner/config.json`:
```json
{
  "telegram_chat_id": "your_chat_id",
  "scan_keywords": ["AI marketing", "founder systems"],
  "min_followers": 3000,
  "min_comments": 2,
  "max_age_hours": 6,
  "drafts_dir": ".openclaw/scanner/drafts/"
}
```

### 5. Cron Schedule (ET)

```bash
0 15 * * * openclaw run triton "Run social engagement scan. Read config. Scan keywords. Score posts. Draft replies. Send to Telegram." >> ~/.openclaw/logs/scanner.log 2>&1
0 19 * * * openclaw run triton "Run social engagement scan." >> ~/.openclaw/logs/scanner.log 2>&1
0 23 * * * openclaw run triton "Run social engagement scan." >> ~/.openclaw/logs/scanner.log 2>&1
```

---

## Scoring + Approval

Pass criteria, scoring breakdown (follower weight / freshness / engagement), draft JSON schema, and Telegram message format: `references/scoring-logic.md`

**Approval commands:**
- `"post"` → bird CLI posts immediately
- `"skip"` → draft archived, no action
- `"edit [new text]"` → replaces draft, re-sends for approval

---

## Autonomy Triggers

```yaml
- "run scanner now" → Execute immediate scan (ignores cron)
- "show pending approvals" → List all drafts with status: pending_approval
- "post [draft-id]" → Post specific draft by ID
- "skip all" → Archive all pending drafts
- "show scan log" → Last 7 days of scanner activity
```

## Memory Patterns

```yaml
memory_read:
  - bambf/brand/VOICE-PROFILE-MASTER.md
  - .openclaw/scanner/config.json
  - .openclaw/scanner/drafts/

memory_write:
  - .openclaw/scanner/drafts/[timestamp].json
  - .openclaw/scanner/scan-log.md
  - memory/YYYY-MM-DD.md
```

---

## Requirements

- OpenClaw v2026.1+
- bird CLI installed + X cookies configured
- Voice profile in vault
- Telegram bot configured
- System crontab access

---

*Built from a real social engagement workflow. Never set-and-forget — always approve before post.*
