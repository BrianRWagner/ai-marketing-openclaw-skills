---
name: queue-orchestrator
description: Multi-agent async work queue routing tasks from 4 JSON queue files (build, content, intel, review) to agents via HEARTBEAT.md. Tracks status pending to done. Use to manage agent workloads, route tasks, or check what is in the queue.
---

# Multi-Agent Queue Orchestrator

**Version:** 1.1.0  
**Price:** $19  
**Category:** Ops  

---

## What It Does

Replaces ad-hoc agent tasking with a persistent async work queue. Four JSON queue files feed into a HEARTBEAT.md decision engine that routes each task to the right agent, tracks status from `pending → in_progress → done`, and picks up automatically on cron.

```
[You or Triton] → Add task to queue (chat or direct JSON edit)
[HEARTBEAT.md] → Checked on cron → routes task to correct agent
[Agent] → Picks up task → executes → updates status to done
[Log] → Every action timestamped in queue-log.md
```

No more "hey Forge, build this." Just add it to the queue and it happens.

---

## Queue Files

All queue files live in `.openclaw/queues/`:

| File | Agent | Model | Specialty |
|------|-------|-------|-----------|
| build.json | Forge | Codex (free) | Scripts, apps, automation |
| content.json | Scribe | Sonnet | Writing, drafts, posts |
| intel.json | Radar | Gemini Flash | Research, market intel |
| review.json | Proof | Sonnet | QA, editing, scoring |

Full task schema, sample queue files, and the watchdog stuck-task detector: `references/queue-schema.md`

---

## Setup

### 1. Create Queue Directory + Files

```bash
mkdir -p ~/.openclaw/queues
echo "[]" > ~/.openclaw/queues/build.json
echo "[]" > ~/.openclaw/queues/content.json
echo "[]" > ~/.openclaw/queues/intel.json
echo "[]" > ~/.openclaw/queues/review.json
```

### 2. Install HEARTBEAT.md

Copy the template from `references/heartbeat-template.md` to `.openclaw/HEARTBEAT.md`.

### 3. Set Up Cron

Full cron schedule in `references/heartbeat-template.md`.

---

## How to Add Tasks

### Via Triton chat (recommended)

```
"Add to build queue: Create a Twitter thread auto-formatter script"
"Queue a content task: Write 3 LinkedIn posts about AI agents"
"Add intel task: Research top 10 AI marketing tools in 2026"
```

Triton generates the task JSON and appends it to the correct queue file.

### Direct JSON edit

Open `.openclaw/queues/build.json` and append a task object. See `references/queue-schema.md` for the full schema.

---

## Autonomy Triggers

```yaml
- "what's in the queue" → Summarize all pending tasks across all queues
- "add [task] to [queue] queue" → Create task JSON, append to correct file
- "run queue now" → Trigger immediate HEARTBEAT check
- "show [queue] queue" → List all tasks in that queue with status
- "mark task-[id] as done" → Update status + prompt for result path
- "clear done tasks" → Archive completed tasks, clean queue files
```

## Memory Patterns

```yaml
memory_read:
  - .openclaw/HEARTBEAT.md
  - .openclaw/queues/*.json

memory_write:
  - .openclaw/queues/*.json        # Task status updates
  - .openclaw/queues/queue-log.md  # Activity logging
  - memory/YYYY-MM-DD.md           # Session log
```

---

## Requirements

- OpenClaw v2026.1+
- Agent configs for Forge, Scribe, Radar, Proof
- System crontab access
- Write access to `.openclaw/queues/`

---

*Built from real multi-agent coordination. Turns chaos into a system.*
