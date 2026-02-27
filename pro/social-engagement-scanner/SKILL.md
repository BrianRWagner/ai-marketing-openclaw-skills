> 🛒 **Available on Claw Mart:** [Buy on shopclawmart.com](https://www.shopclawmart.com/listings/social-engagement-scanner-4ed09919) — $19
> *Full premium version with autonomy triggers, memory architecture, and multi-agent handoffs.*

# Social Engagement Scanner

**Version:** 1.0.0  
**Price:** $19  
**Category:** Marketing  

---

## What It Does

Scans X (Twitter) 3x/day for high-reach posts matching your niche. Scores each post by follower count and freshness. Drafts contextual replies aligned to your voice profile. Sends drafts to Telegram for your approval — **nothing posts without your explicit "post" command.**

**The flow:**

```
[Cron 10am/2pm/6pm ET] → Scan X for niche keywords
→ Score posts (3K+ followers OR 2+ comments, <6hrs old)
→ Draft reply aligned to your voice
→ Send to Telegram: "Reply drafted. Type 'post' to send."
→ [YOU] → Review draft → type "post" → bird CLI posts it
```

Zero auto-posting. Ever.

---

## Setup

### 1. bird CLI Config

Install and configure the bird CLI:

```bash
# Set credentials in ~/.openclaw/credentials/bird.env
BIRD_AUTH_TOKEN=your_x_auth_token
BIRD_CT0=your_ct0_cookie

# Test it
source ~/.openclaw/credentials/bird.env
bird search "AI marketing" --auth-token "$BIRD_AUTH_TOKEN" --ct0 "$BIRD_CT0" --limit 20
```

### 2. Voice Profile

Create or update `bambf/brand/VOICE-PROFILE-MASTER.md` with:
- Your writing style
- Topics you engage with
- Phrases/tones to avoid
- Your typical reply length

### 3. Niche Keywords File

Create `.openclaw/scanner/keywords.txt`:

```
AI marketing
founder systems
content ops
AI agents
autonomous workflows
marketing automation
```

### 4. Telegram Bot Config

Set your Telegram chat ID in `.openclaw/scanner/config.json`:

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
# 10am ET (15:00 UTC)
0 15 * * * openclaw run triton "Run social engagement scan. Read config. Scan keywords. Score posts. Draft replies. Send to Telegram." >> ~/.openclaw/logs/scanner.log 2>&1

# 2pm ET (19:00 UTC)  
0 19 * * * openclaw run triton "Run social engagement scan." >> ~/.openclaw/logs/scanner.log 2>&1

# 6pm ET (23:00 UTC)
0 23 * * * openclaw run triton "Run social engagement scan." >> ~/.openclaw/logs/scanner.log 2>&1
```

---

## Scoring Logic

Every post found in the scan gets scored before drafting a reply.

**Pass criteria (must meet at least one):**
- Author has **3,000+ followers**, OR
- Post has **2+ comments/replies**

**Freshness filter:**
- Post must be **less than 6 hours old**
- Posts older than 6 hours = skip (engagement window has closed)

**Auto-skip:**
- Low follower accounts (<3K) with 0-1 comments
- Posts >6 hours old
- Posts already replied to by your account
- Retweets (no engagement value)
- Spam patterns (excessive hashtags, link dumps)

**Scoring breakdown:**

```
Follower weight: 0-40pts  (3K=20, 10K=30, 100K=40)
Freshness:       0-30pts  (<1hr=30, 1-3hr=20, 3-6hr=10)
Engagement:      0-30pts  (2+comments=15, 5+comments=25, 10+=30)

Score 60+ = draft reply
Score <60  = skip
```

---

## Approve-Before-Post Workflow

**⚠️ NOTHING POSTS WITHOUT YOUR EXPLICIT "POST" APPROVAL. THIS IS NON-NEGOTIABLE.**

### Step 1: Triton drafts a reply

Based on the scored post + your voice profile, Triton writes a contextual reply. It saves the draft to `.openclaw/scanner/drafts/[timestamp]-[username].json`:

```json
{
  "id": "draft-001",
  "status": "pending_approval",
  "original_post_id": "1234567890",
  "original_author": "@marketingfounder",
  "original_text": "AI agents that work overnight are the new competitive advantage",
  "reply_draft": "The overnight ops shift is real. We run Scribe at 2am, Proof at 3am — wake up to approved content every morning. The teams who figure out async AI workflows are going to be untouchable.",
  "score": 78,
  "drafted_at": "2026-03-01T15:04:00Z"
}
```

### Step 2: Telegram approval message

Triton sends to your Telegram:

```
📡 Engagement opportunity found

@marketingfounder (45K followers, 2hrs ago)
"AI agents that work overnight are the new competitive advantage"

Draft reply:
"The overnight ops shift is real. We run Scribe at 2am, Proof at 3am — wake up to approved content every morning. The teams who figure out async AI workflows are going to be untouchable."

Score: 78/100 ✅

Reply "post" to send. Reply "skip" to pass. Reply "edit [new text]" to revise.
```

### Step 3: Your response

- **"post"** → bird CLI posts the reply immediately
- **"skip"** → draft archived, no action
- **"edit [new text]"** → replaces draft, re-sends for approval

### Step 4: Confirmation

After posting:

```
✅ Posted to @marketingfounder
Tweet ID: 9876543210
View: https://x.com/YourHandle/status/9876543210
```

---

## Voice Alignment

Drafts are generated with your voice profile loaded. The scanner reads `VOICE-PROFILE-MASTER.md` before every reply draft.

**Voice rules applied to every draft:**
- Never starts with "I"
- No AI tells (delve, unleash, leverage, game-changing)
- Specific > vague (real numbers when possible)
- Adds perspective, doesn't just agree
- Ends with a statement, not a question

**The scanner does NOT:**
- Post generic "Great point!" replies
- Agree with everything
- Write replies that could've been written by anyone

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
  - .openclaw/scanner/drafts/[timestamp].json  # New drafts
  - .openclaw/scanner/scan-log.md              # Activity log
  - memory/YYYY-MM-DD.md                       # Session log
```

---

## Example Output

### Sample Scan Result

```
Scan run: 2026-03-01 15:00 ET
Keywords searched: AI marketing, founder systems, content ops
Posts found: 47
Posts scored 60+: 3
Posts already replied: 1
Drafts created: 2
Sent to Telegram: 2
```

### Sample Draft Reply

**Original post:** @founderbuilder (28K followers, 45 mins ago)  
"Spent 6 hours on content this week. Feels like the wrong leverage."

**Draft reply:**
> 6 hours/week on content is about 5.5 hours too many once you have agents running it. We've got Scribe drafting at 2am and Proof editing at 3am. The only human touch is hitting "post." Not theoretical — running this now.

**Score:** 82/100

---

## Requirements

- OpenClaw v2026.1+
- bird CLI installed + X cookies configured
- Voice profile in vault
- Telegram bot configured
- System crontab access

---

*Built from a real social engagement workflow. Never set-and-forget — always approve before post.*
