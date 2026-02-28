# HEARTBEAT.md Decision Engine Template

Save as `.openclaw/HEARTBEAT.md` in your OpenClaw workspace.

```markdown
# HEARTBEAT — Queue Check

## Queue Priority Order

Tie-breaking rule: when multiple queues have pending tasks at the same priority level, process in this order. High priority always beats normal regardless of queue.

1. review.json  → Proof (Sonnet)    — unreviewed work blocks everything downstream
2. build.json   → Forge (Codex)     — builds unlock content pipeline
3. content.json → Scribe (Sonnet)   — content depends on builds being ready
4. intel.json   → Radar (Gemini)    — intel is lowest urgency; informs but doesn't block

## On Each Heartbeat
1. Read each queue file
2. Find tasks with status: "pending"
3. Apply priority tier (high > normal), then queue order for ties
4. Spawn the winning agent
5. Update task status to "in_progress"
6. Log to queue-log.md
7. Run watchdog check (scan for in_progress tasks >2hrs old)

## Routing Rules
- Tasks in review.json  → Proof (Sonnet)
- Tasks in build.json   → Forge (Codex)
- Tasks in content.json → Scribe (Sonnet)
- Tasks in intel.json   → Radar (Gemini)

## Watchdog — Stuck Task Detection
On each heartbeat, scan for tasks where status == "in_progress" AND updated_at > 2 hours ago.
Set those to "blocked", add blocker_notes, send Telegram alert.

## If no pending tasks: HEARTBEAT_OK
```

## Cron Schedule

```bash
# Heartbeat check every 30 minutes
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

## Example Routing Decision Log

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
Spawning Radar for intel-005...
Spawning Forge for build-002...
```
