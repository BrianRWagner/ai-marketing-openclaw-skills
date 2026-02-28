# Scoring Logic + Approval Workflow

## Pass Criteria

Must meet at least one:
- Author has **3,000+ followers**, OR
- Post has **2+ comments/replies**

**Freshness filter:** Post must be **< 6 hours old**

## Auto-Skip Rules

- Low follower accounts (<3K) with 0-1 comments
- Posts >6 hours old (engagement window closed)
- Posts already replied to by your account
- Retweets
- Spam patterns (excessive hashtags, link dumps)

## Scoring Breakdown

```
Follower weight: 0-40pts  (3K=20, 10K=30, 100K=40)
Freshness:       0-30pts  (<1hr=30, 1-3hr=20, 3-6hr=10)
Engagement:      0-30pts  (2+comments=15, 5+comments=25, 10+=30)

Score 60+ = draft reply
Score <60  = skip
```

## Draft JSON Schema

Saved to `.openclaw/scanner/drafts/[timestamp]-[username].json`:

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

## Telegram Approval Message Format

```
📡 Engagement opportunity found

@marketingfounder (45K followers, 2hrs ago)
"AI agents that work overnight are the new competitive advantage"

Draft reply:
"The overnight ops shift is real. We run Scribe at 2am, Proof at 3am — wake up to approved content every morning. The teams who figure out async AI workflows are going to be untouchable."

Score: 78/100 ✅

Reply "post" to send. Reply "skip" to pass. Reply "edit [new text]" to revise.
```

## Post Confirmation

```
✅ Posted to @marketingfounder
Tweet ID: 9876543210
View: https://x.com/YourHandle/status/9876543210
```

## Voice Rules Applied to Every Draft

- Never starts with "I"
- No AI tells (delve, unleash, leverage, game-changing)
- Specific > vague (real numbers when possible)
- Adds perspective, doesn't just agree
- Ends with a statement, not a question

The scanner does NOT generate generic "Great point!" replies.
