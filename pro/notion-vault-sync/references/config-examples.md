# Config Examples

## config.json (save to `~/.openclaw/notion-sync/config.json`)

```json
{
  "notion_token": "secret_xxxxxxxxxxxxxxxxxxxx",
  "output_dir": "/root/obsidian-vault/notion-sync/",
  "checkpoint_file": "~/.openclaw/notion-sync/checkpoint.json",
  "log_file": "~/.openclaw/notion-sync/notion-sync.log",
  "tag_filter": "#vault",
  "poll_interval_minutes": 15
}
```

**Recommended: use `bambf/from-notion/` as output_dir** so synced files live where all agents scan:
```json
{
  "output_dir": "/root/obsidian-vault/bambf/from-notion/"
}
```

## HEARTBEAT.md Integration

Add to your agent's HEARTBEAT.md:
```markdown
## Context Sources
- bambf/from-notion/   # Synced Notion pages — check for new briefing docs, strategies, notes
```

## Agent Integration Examples

- **Triton** — checks `from-notion/` each heartbeat for new briefing docs or project updates
- **Scribe** — reads synced strategy pages before drafting content
- **Radar** — uses synced research notes as starting context for intel tasks
- **Forge** — pulls synced technical specs before building

## Tagging in Notion

Add `#vault` to any of these locations:

| Location | Example |
|----------|---------|
| Page title | `My Strategy #vault` |
| First heading | `## #vault` at top of page |
| Body text | Add `tags: #vault` at bottom |

To stop syncing a page: remove `#vault`. Existing vault file stays (won't be deleted).

## Update Behavior

Synced files **overwrite** on each run if the Notion page was edited. This is by design — vault file always reflects current Notion source. **Treat synced files as read-only.** For annotations, create a separate linked file.
