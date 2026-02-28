# Queue Schema + Examples

## Directory Structure

```
.openclaw/
└── queues/
    ├── build.json     ← Forge (coding, building, scripts)
    ├── content.json   ← Scribe (writing, drafts, posts)
    ├── intel.json     ← Radar (research, market intel)
    ├── review.json    ← Proof (QA, editing, scoring)
    └── queue-log.md   ← Activity log for all queues
```

## Task Schema (all queues share this structure)

```json
{
  "id": "task-001",
  "status": "pending",
  "priority": "high",
  "created_at": "2026-03-01T09:00:00Z",
  "updated_at": "2026-03-01T09:00:00Z",
  "assigned_agent": "Forge",
  "title": "Build Notion sync poller script",
  "description": "Node.js script that polls Notion every 15 mins and syncs #vault tagged pages",
  "inputs": ["notion API token", "output dir config"],
  "outputs": ["poller.js", "README.md"],
  "notes": "Use native Node 22 fetch — zero npm deps",
  "completed_at": null,
  "result_path": null
}
```

## Status Lifecycle

```
pending → in_progress → done
              ↓
           blocked (add blocker_notes)
              ↓
           failed (add error_log)
```

## Sample build.json

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

## Agent Completion — Update Pattern

Agent updates the task JSON directly when done:
```json
{
  "id": "task-001",
  "status": "done",
  "updated_at": "2026-03-01T10:15:00Z",
  "completed_at": "2026-03-01T10:15:00Z",
  "result_path": "bambf/research/ai-tools-2026.md"
}
```

## Watchdog — Stuck Task Detection (add to heartbeat script)

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
        console.log(`ALERT: Task "${task.title}" (${task.id}) in ${queueFile} stuck >2hrs`);
      }
    }
  }
  if (changed) writeFileSync(`.openclaw/queues/${queueFile}`, JSON.stringify(tasks, null, 2));
}
```
