> 🛒 **Available on Claw Mart:** [Buy on shopclawmart.com](https://www.shopclawmart.com/listings/multi-agent-queue-orchestrator-a99f2965) — $19
> *Full premium version with autonomy triggers, memory architecture, and multi-agent handoffs.*

# Multi-Agent Queue Orchestrator

**Version:** 1.0.0  
**Price:** $19  
**Category:** Ops  

---

## What It Does

Replaces ad-hoc agent tasking with a persistent async work queue. Four JSON queue files (build, content, intel, review) feed into a HEARTBEAT.md decision engine that routes each task to the right agent, tracks status from pending → in_progress → done, and picks up automatically on cron.

**The system:**

```
[You or Triton] → Add task to queue (chat or direct JSON edit)
[HEARTBEAT.md] → Checked on cron → routes task to correct agent
[Agent] → Picks up task → updates status → executes → marks done
[Log] → Every action timestamped in queue-log.md
```

No more "hey Forge, build this." Just add it to the queue and it happens.

---

## Queue File Structure

All queue files live in `.openclaw/queues/`:

```
.openclaw/
└── queues/
    ├── build.json     ← For Forge (coding, building, scripts)
    ├── content.json   ← For Scribe (writing, drafts, posts)
    ├── intel.json     ← For Radar (research, market intel)
    ├── review.json    ← For Proof (QA, editing, scoring)
    └── queue-log.md   ← Activity log for all queues
```

### Task Schema (all queues share this structure)

```json
{
  "id": "task-001",
  "status": "pending",
  "priority": "high",
  "created_at": "2026-03-01T09:00:00Z",
  "updated_at": "2026-03-01T09:00:00Z",
  "assigned_agent": "Forge",
  "title": "Build Notion sync poller script",
  "description": "Node.js script that polls Notion every 15 mins and syncs #vault tagged pages to Obsidian",
  "inputs": ["notion API token", "output dir config"],
  "outputs": ["poller.js", "README.md"],
  "notes": "Use native Node 22 fetch — zero npm deps",
  "completed_at": null,
  "result_path": null
}
```

### Status Lifecycle

```
pending → in_progress → done
              ↓
           blocked (add blocker note)
              ↓
           failed (add error log)
```

---

## HEARTBEAT.md Decision Engine

The HEARTBEAT.md file is what the cron agent reads on every heartbeat. It contains the routing rules, queue priority order, and watchdog logic.

**`.openclaw/HEARTBEAT.md`:**

```markdown
# HEARTBEAT — Queue Check

## Queue Priority Order

Tie-breaking rule: when multiple queues have pending tasks at the same priority level, process queues in this order. High priority always beats normal priority regardless of queue.

1. review.json  → Proof (Sonnet)    — unreviewed work blocks everything downstream
2. build.json   → Forge (Codex)     — builds unlock content pipeline
3. content.json → Scribe (Sonnet)   — content depends on builds being ready
4. intel.json   → Radar (Gemini)    — intel is lowest urgency; informs but doesn't block

Reasoning: A review sitting in review.json may be blocking a deploy or a content decision. Builds in build.json unblock Scribe's content work. Intel gathering (Radar) is valuable but non-blocking — it can always wait one more cycle.

## On Each Heartbeat
1. Read each queue file
2. Find tasks with status: "pending"
3. Apply priority tier first (high > normal), then queue order above for ties
4. Spawn the winning agent
5. Update task status to "in_progress"
6. Log to queue-log.md
7. Run watchdog check (see below)

## Routing Rules
- Tasks in review.json  → Proof (Sonnet)
- Tasks in build.json   → Forge (Codex)
- Tasks in content.json → Scribe (Sonnet)
- Tasks in intel.json   → Radar (Gemini)

## Watchdog — Stuck Task Detection

On each heartbeat, scan all queues for tasks where:
- `status == "in_progress"` AND
- `updated_at` is more than 2 hours ago

For each stuck task found:
1. Set `status` → `"blocked"`
2. Add `blocker_notes`: `"Agent timeout — task was in_progress for >2 hours. Manual review needed."`
3. Update `updated_at` to now
4. Send Telegram alert: "⚠️ Task [title] ([id]) in [queue] has been in_progress for 2+ hours. May need attention."

This prevents phantom in_progress tasks from clogging the queue when an agent crashes or times out.

**Watchdog implementation (add to your heartbeat script):**

```javascript
const TWO_HOURS_MS = 2 * 60 * 60 * 1000;
const now = new Date();

for (const queueFile of ['review.json', 'build.json', 'content.json', 'intel.json']) {
  const tasks = JSON.parse(readFileSync(`.openclaw/queues/${queueFile}`, 'utf8'));
  let changed = false;
  for (const task of tasks) {
    if (task.status === 'in_progress') {
      const elapsed = now - new Date(task.updated_at);
      if (elapsed > TWO_HOURS_MS) {
        task.status = 'blocked';
        task.blocker_notes = 'Agent timeout — in_progress for >2 hours. Manual review needed.';
        task.updated_at = now.toISOString();
        changed = true;
        // Send Telegram alert via openclaw notify
        console.log(`ALERT: Task "${task.title}" (${task.id}) in ${queueFile} stuck >2hrs`);
      }
    }
  }
  if (changed) writeFileSync(`.openclaw/queues/${queueFile}`, JSON.stringify(tasks, null, 2));
}
```

## If no pending tasks: HEARTBEAT_OK
```

---

## Agent Routing Table

| Queue File | Agent | Model | Specialty |
|-----------|-------|-------|-----------|
| build.json | Forge | Codex (free) | Scripts, apps, automation |
| content.json | Scribe | Sonnet | Writing, drafts, posts |
| intel.json | Radar | Gemini Flash | Research, market intel |
| review.json | Proof | Sonnet | QA, editing, scoring |

**Routing is determined by queue file, not task content.** Put the task in the right queue.

---

## Cron Schedule

```bash
# Heartbeat check every 30 minutes (routes pending tasks)
*/30 * * * * openclaw run triton "Read HEARTBEAT.md. Check all queues. Spawn agents for pending tasks. Log activity." >> ~/.openclaw/logs/heartbeat.log 2>&1

# Forge (builds) — hourly during business hours
0 9-18 * * 1-5 openclaw run forge "Check build.json for pending tasks. Execute highest priority. Update status." >> ~/.openclaw/logs/forge.log 2>&1

# Scribe (content) — 2am daily
0 2 * * * openclaw run scribe "Check content.json for pending tasks. Write drafts. Update status." >> ~/.openclaw/logs/scribe.log 2>&1

# Radar (intel) — 6am daily
0 6 * * * openclaw run radar "Check intel.json for pending tasks. Research and report. Update status." >> ~/.openclaw/logs/radar.log 2>&1

# Proof (review) — 3am daily (after Scribe)
0 3 * * * openclaw run proof "Check review.json for pending tasks. Score and route. Update status." >> ~/.openclaw/logs/proof.log 2>&1
```

---

## How to Add Tasks to Queue

### Via Triton chat (recommended)

```
"Add to build queue: Create a Twitter thread auto-formatter script"
"Queue a content task: Write 3 LinkedIn posts about AI agents"
"Add intel task: Research top 10 AI marketing tools in 2026"
```

Triton generates the JSON task object and appends it to the correct queue file.

### Direct JSON edit

Open `.openclaw/queues/build.json` and append:

```json
{
  "id": "task-007",
  "status": "pending",
  "priority": "normal",
  "created_at": "2026-03-01T14:30:00Z",
  "updated_at": "2026-03-01T14:30:00Z",
  "assigned_agent": "Forge",
  "title": "Auto-formatter for Twitter threads",
  "description": "Script that takes a long text block and formats it into numbered tweet thread",
  "inputs": ["raw text"],
  "outputs": ["formatted thread JSON"],
  "notes": "Max 280 chars per tweet. Number each: 1/N format.",
  "completed_at": null,
  "result_path": null
}
```

---

## Status Lifecycle Detail

```
pending     — Task created, waiting for agent pickup
in_progress — Agent has picked up the task, working
done        — Task completed, result_path populated
blocked     — Agent hit a dependency or needs input (add blocker_notes)
failed      — Agent errored out (add error_log)
```

Agent updates the JSON directly:

```json
{
  "id": "task-001",
  "status": "done",
  "updated_at": "2026-03-01T10:15:00Z",
  "completed_at": "2026-03-01T10:15:00Z",
  "result_path": "bambf/research/ai-tools-2026.md"
}
```

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

## Example: Sample Queue File

**`.openclaw/queues/build.json`:**

```json
[
  {
    "id": "build-001",
    "status": "done",
    "priority": "high",
    "created_at": "2026-02-28T08:00:00Z",
    "updated_at": "2026-02-28T11:30:00Z",
    "assigned_agent": "Forge",
    "title": "Notion sync poller script",
    "description": "Poll Notion every 15 mins, sync #vault pages to Obsidian",
    "completed_at": "2026-02-28T11:30:00Z",
    "result_path": "tools/notion-sync/poller.js"
  },
  {
    "id": "build-002",
    "status": "pending",
    "priority": "normal",
    "created_at": "2026-03-01T09:00:00Z",
    "updated_at": "2026-03-01T09:00:00Z",
    "assigned_agent": "Forge",
    "title": "Content calendar auto-updater",
    "description": "Script that reads ready-to-post/ and updates 4-week-calendar.md with wikilinks",
    "completed_at": null,
    "result_path": null
  }
]
```

## Example: HEARTBEAT Routing Decision

```
HEARTBEAT — 2026-03-01 14:30

Checking queues...
- build.json: 1 pending (build-002, priority: normal)
- content.json: 0 pending
- intel.json: 2 pending (intel-005 high, intel-006 normal)
- review.json: 0 pending

Routing decision:
1. intel-005 (HIGH priority) → spawn Radar
2. build-002 (normal) → spawn Forge after Radar completes

Updating statuses to in_progress...
Logging to queue-log.md...

Spawning Radar for intel-005...
Spawning Forge for build-002...
```

---

## Requirements

- OpenClaw v2026.1+
- Agent configs for Forge, Scribe, Radar, Proof
- System crontab access
- Write access to `.openclaw/queues/`

---

*Built from real multi-agent coordination. Turns chaos into a system.*
