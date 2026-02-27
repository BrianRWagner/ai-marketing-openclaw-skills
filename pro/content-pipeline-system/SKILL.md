> 🛒 **Available on Claw Mart:** [Buy on shopclawmart.com](https://www.shopclawmart.com/listings/content-pipeline-system-93c7ed4e) — $19
> *Full premium version with autonomy triggers, memory architecture, and multi-agent handoffs.*

# Content Pipeline System

**Version:** 1.0.0  
**Price:** $19  
**Category:** Content  

---

## What It Does

A fully autonomous, async content operations system that runs while you sleep. Scribe writes, Proof QAs, and vault files land in `ready-to-post/` with Posted status tracking — zero manual handoffs required.

**The pipeline:**

```
[Cron 2am] → Scribe agent reads brief + voice rules → writes draft → saves to content/queue/
[Cron 3am] → Proof agent reads draft → scores 1-10 → routes:
  ├── Score <7 → returns to queue with fix instructions
  └── Score 7+ → moves to ready-to-post/ with ✅ approval notes
[You] → Pick up from ready-to-post/ → post → flip Posted status to ✅
[Calendar] → Auto-updated with wikilinks to every approved file
```

No babysitting. No manual QA. Just approved content waiting every morning.

---

## Setup

### 1. Install Voice + Brief Files

Create these files in your vault:

```
bambf/brand/VOICE-PROFILE-MASTER.md   ← Your voice rules
bambf/content/scribe-brief.md         ← Standing content instructions
bambf/research/content-angles.md      ← Topics / angles bank
```

### 2. Agent SOUL.md Configs

**Scribe agent** — save as `.openclaw/agents/scribe/SOUL.md`:

```yaml
name: Scribe
role: Content Writer
persona: |
  You write high-signal content for founders and builders.
  Voice is direct, earned, and specific. No fluff.
  Every post passes the Corey Test before submission.
on_start:
  - read: bambf/brand/VOICE-PROFILE-MASTER.md
  - read: bambf/content/scribe-brief.md
  - read: bambf/research/content-angles.md
  - read: content/queue/pending.json
output_dir: content/queue/drafts/
status_file: content/queue/pending.json
```

**Proof agent** — save as `.openclaw/agents/proof/SOUL.md`:

```yaml
name: Proof
role: QA Editor
persona: |
  You are a ruthless but fair editor. Score each draft 1-10.
  If below 7, return specific fix instructions.
  If 7+, approve with inline notes.
  You enforce voice rules strictly — no exceptions.
on_start:
  - read: bambf/brand/VOICE-PROFILE-MASTER.md
  - read: content/queue/drafts/
input_dir: content/queue/drafts/
output_dir: content/ready-to-post/
score_threshold: 7
```

### 3. Queue File Structure

```
content/
├── queue/
│   ├── pending.json          ← Tasks for Scribe
│   ├── drafts/               ← Scribe output, awaiting Proof
│   └── rejected/             ← Failed QA, with fix notes
├── ready-to-post/
│   ├── linkedin/
│   ├── twitter/
│   └── newsletter/
└── posted/                   ← Archive of live content
```

**pending.json schema:**

```json
[
  {
    "id": "post-001",
    "status": "pending",
    "platform": "linkedin",
    "angle": "AI systems for founders",
    "pillar": "systems",
    "target_date": "2026-03-01",
    "notes": "Focus on async agent architecture"
  }
]
```

### 4. Cron Schedule

```bash
# Scribe runs at 2am — writes drafts
0 2 * * * openclaw run scribe "Read SOUL.md. Check pending.json. Write all pending drafts." >> ~/.openclaw/logs/scribe.log 2>&1

# Proof runs at 3am — QAs drafts
0 3 * * * openclaw run proof "Read SOUL.md. Score all drafts in queue/drafts/. Route approved/rejected." >> ~/.openclaw/logs/proof.log 2>&1
```

---

## Voice Rules Checklist

| Rule | What It Means |
|------|---------------|
| **Never start with "I"** | Lead with observation, hook, or insight |
| **Emotion first** | First line makes someone feel before they think |
| **Real numbers** | Specific data beats vague claims |
| **No AI tells** | Never: "delve into", "unleash", "unlock", "game-changing" |
| **No generic closers** | Don't end with "What do you think?" — end with a punch |
| **Corey Test** | Read it out loud. If a normal human cringes, rewrite it. |

**The Corey Test:** Imagine reading the post to a skeptical friend named Corey. Would he roll his eyes? Feel fake or salesy? If yes — rewrite until it sounds like something you'd say at dinner.

---

## Quality Gate Logic

Proof scores every draft **1–10** across 4 dimensions:

| Dimension | Weight | What's Measured |
|-----------|--------|-----------------|
| Voice match | 30% | Does it sound like the configured voice? |
| Hook strength | 25% | Does line 1 make you stop scrolling? |
| Substance | 25% | Real insight, not just opinions? |
| Closer | 20% | Does it end with punch, not a question? |

**Score < 7 — Rejected with fix instructions:**

```markdown
---
PROOF REVIEW — REJECTED
Score: 5/10

Fix instructions:
1. Hook is too generic. Rewrite with a specific story or data point.
2. "leverage the power of" is an AI tell. Cut it.
3. Closer is a question — ends weakly. Replace with declarative statement.

Resubmit after fixes.
---
```

**Score ≥ 7 — Approved with notes:**

```markdown
---
PROOF REVIEW — APPROVED
Score: 8/10

Notes:
- Strong hook, punchy opener ✅
- Real numbers in paragraph 2 ✅
- Closer could be sharper but acceptable

**Posted:** ❌
---
```

---

## Posted Status Tracking

Every file in `ready-to-post/` includes a status block:

```markdown
---
Platform: LinkedIn
Scheduled: 2026-03-01
**Posted:** ❌
---

[post content here]
```

When a post goes live, flip to:

```markdown
**Posted:** ✅ 2026-03-01
```

---

## Calendar Integration (Obsidian Wikilinks)

Content calendar at `bambf/content/4-week-calendar.md` uses wikilinks:

```markdown
| Date | Platform | Angle | Status | File |
|------|----------|-------|--------|------|
| Mar 1 | LinkedIn | AI Systems | ✅ Ready | [[content/ready-to-post/linkedin/2026-03-01-ai-systems\|2026-03-01-ai-systems]] |
| Mar 3 | Twitter | Founder takes | ⏳ Queue | — |
```

Proof appends wikilinks to the calendar automatically when approving drafts.

---

## Autonomy Triggers

```yaml
- "run content pipeline" → Check pending.json → spawn Scribe → spawn Proof → report
- "what's ready to post" → List ready-to-post/ with Posted: ❌
- "mark [slug] as posted" → Flip status → archive → update calendar
- "add [topic] to queue" → Append to pending.json
```

## Memory Patterns

```yaml
memory_read:
  - bambf/brand/VOICE-PROFILE-MASTER.md
  - bambf/content/scribe-brief.md
  - content/queue/pending.json

memory_write:
  - content/queue/pending.json
  - bambf/content/4-week-calendar.md
  - memory/YYYY-MM-DD.md
```

## Multi-Agent Handoff YAML

```yaml
pipeline:
  - agent: Scribe
    reads: [pending.json, VOICE-PROFILE-MASTER.md, scribe-brief.md]
    writes: [queue/drafts/YYYY-MM-DD-slug.md]
    updates: [pending.json → status: in_progress]

  - agent: Proof
    reads: [queue/drafts/*.md, VOICE-PROFILE-MASTER.md]
    writes:
      approved: [ready-to-post/[platform]/YYYY-MM-DD-slug.md]
      rejected: [queue/rejected/YYYY-MM-DD-slug.md]
    updates: [pending.json → status: done|rejected, 4-week-calendar.md]
```

---

## Example Output

### Sample Scribe Draft

```
Platform: LinkedIn
Angle: Why AI agents fail at 3am
Created: 2026-03-01
Posted: ❌

Nobody talks about what happens when your AI system fails at 3am.

Not the failure itself — the aftermath. The logs you read at 7am.
The context you lost because nobody wrote it down.

We built a write-ahead log into every agent we run. Before any action,
the agent writes what it's about to do. After, it logs what happened.

Result: zero mystery failures in 90 days.

The difference between graceful failure and silent data corruption
is 8 lines of JSON. Here's what that logging pattern looks like ↓
```

### Sample Proof Approval

```
PROOF REVIEW — APPROVED
Score: 8/10

- Specific scenario opener, not generic ✅
- Real specifics: 90 days, 8 lines of JSON ✅  
- No AI tells detected ✅
- Closer sets up the thread — punchy and directive ✅
- Minor: "graceful failure" is slightly jargon-y. Optional rewrite suggested.
```

---

## Requirements

- OpenClaw v2026.1+
- Two agent configs (Scribe + Proof)
- Voice profile in vault
- System crontab access

---

*Built from real content ops — 100+ hours of pipeline refinement.*
