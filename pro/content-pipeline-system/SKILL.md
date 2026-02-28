---
name: content-pipeline-system
description: Autonomous async content operations — Scribe writes, Proof QAs, files land in ready-to-post/ with status tracking. Use to set up or run a hands-off content pipeline where agents handle drafting and review without manual handoffs.
---

# Content Pipeline System

**Version:** 1.1.0  
**Price:** $19  
**Category:** Content  

---

## What It Does

A fully autonomous, async content operations system that runs while you sleep. Scribe writes, Proof QAs, and vault files land in `ready-to-post/` with Posted status tracking — zero manual handoffs required.

```
[Cron 2am] → Scribe reads brief + voice rules → writes draft → saves to content/queue/
[Cron 3am] → Proof reads draft → scores 1-10 → routes:
  ├── Score <7 → returns to queue with fix instructions
  └── Score 7+ → moves to ready-to-post/ with ✅ approval notes
[You] → Pick up from ready-to-post/ → post → flip Posted status to ✅
```

No babysitting. No manual QA. Just approved content waiting every morning.

---

## Setup

### 1. Install Voice + Brief Files

```
bambf/brand/VOICE-PROFILE-MASTER.md   ← Your voice rules
bambf/content/scribe-brief.md         ← Standing content instructions
bambf/research/content-angles.md      ← Topics / angles bank
```

### 2. Agent SOUL.md Configs

See `references/agent-configs.md` for complete Scribe and Proof SOUL.md configs and multi-agent handoff YAML.

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

**pending.json task schema:**
```json
{
  "id": "post-001",
  "status": "pending",
  "platform": "linkedin",
  "angle": "AI systems for founders",
  "pillar": "systems",
  "target_date": "2026-03-01",
  "notes": "Focus on async agent architecture"
}
```

### 4. Cron Schedule

```bash
0 2 * * * openclaw run scribe "Read SOUL.md. Check pending.json. Write all pending drafts." >> ~/.openclaw/logs/scribe.log 2>&1
0 3 * * * openclaw run proof "Read SOUL.md. Score all drafts in queue/drafts/. Route approved/rejected." >> ~/.openclaw/logs/proof.log 2>&1
```

---

## Quality Gate

Proof scores every draft 1–10 across 4 dimensions: voice match (30%), hook strength (25%), substance (25%), closer (20%). Score ≥ 7 = approved. Score < 7 = rejected with specific fix instructions.

Full voice rules checklist, scoring rubric, and approval/rejection templates: `references/quality-gate.md`

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

---

## Requirements

- OpenClaw v2026.1+
- Scribe + Proof agent configs (see `references/agent-configs.md`)
- Voice profile in vault
- System crontab access

---

*Built from real content ops — 100+ hours of pipeline refinement.*
