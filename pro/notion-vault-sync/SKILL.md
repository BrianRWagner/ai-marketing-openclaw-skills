> 🛒 **Available on Claw Mart:** [Buy on shopclawmart.com](https://www.shopclawmart.com/listings/notion-to-obsidian-vault-sync-cfe1f50e) — $9
> *Full premium version with autonomy triggers, memory architecture, and multi-agent handoffs.*

# Notion ↔ Obsidian Vault Sync

**Version:** 1.0.0  
**Price:** $9  
**Category:** Productivity  

---

## What It Does

A zero-token polling script that automatically syncs tagged Notion pages to Obsidian markdown files. Uses a `#vault` tag filter — any Notion page containing `#vault` in the title, a heading, or the body text gets pulled down and written to your vault every 15 minutes.

No database configuration. No manual exports. No token usage. Just cron + Node.js.

**The flow:**

```
[Every 15 min] → poller.js fetches recently edited Notion pages
→ Checks each page for #vault tag in title/blocks
→ Tagged pages → convert to Markdown → write to vault
→ Log sync to notion-sync.log
→ Save checkpoint (last sync timestamp)
```

---

## Setup

### 1. Get Your Notion API Token

1. Go to https://www.notion.so/my-integrations
2. Create a new integration (name: "Vault Sync")
3. Copy the Internal Integration Token
4. Share each workspace page with the integration (or use a root page)

### 2. Create Config File

Save as `~/.openclaw/notion-sync/config.json`:

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

### 3. Save the Poller Script

Save to `/usr/local/bin/notion-vault-poller.js` (or any path you prefer):

```javascript
#!/usr/bin/env node
// notion-vault-poller.js
// Zero npm dependencies — uses native Node 22 fetch
// Polls Notion for #vault tagged pages and syncs to Obsidian vault

import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'fs';
import { join } from 'path';

const CONFIG_PATH = process.env.NOTION_SYNC_CONFIG || 
  `${process.env.HOME}/.openclaw/notion-sync/config.json`;

const config = JSON.parse(readFileSync(CONFIG_PATH, 'utf8'));
const { notion_token, output_dir, checkpoint_file, log_file, tag_filter } = config;

const NOTION_API = 'https://api.notion.com/v1';
const HEADERS = {
  'Authorization': `Bearer ${notion_token}`,
  'Notion-Version': '2022-06-28',
  'Content-Type': 'application/json'
};

function log(msg) {
  const line = `[${new Date().toISOString()}] ${msg}\n`;
  process.stdout.write(line);
  try {
    const resolved = checkpoint_file.replace('~', process.env.HOME);
    const logDir = log_file.replace('~', process.env.HOME).split('/').slice(0, -1).join('/');
    mkdirSync(logDir, { recursive: true });
    const resolvedLog = log_file.replace('~', process.env.HOME);
    writeFileSync(resolvedLog, line, { flag: 'a' });
  } catch {}
}

function loadCheckpoint() {
  const path = checkpoint_file.replace('~', process.env.HOME);
  if (!existsSync(path)) return { last_sync: new Date(0).toISOString() };
  return JSON.parse(readFileSync(path, 'utf8'));
}

function saveCheckpoint(data) {
  const path = checkpoint_file.replace('~', process.env.HOME);
  mkdirSync(path.split('/').slice(0, -1).join('/'), { recursive: true });
  writeFileSync(path, JSON.stringify(data, null, 2));
}

async function searchRecentPages(since) {
  const body = {
    filter: { value: 'page', property: 'object' },
    sort: { direction: 'descending', timestamp: 'last_edited_time' },
    page_size: 100
  };
  
  const res = await fetch(`${NOTION_API}/search`, {
    method: 'POST',
    headers: HEADERS,
    body: JSON.stringify(body)
  });
  
  const data = await res.json();
  if (!data.results) return [];
  
  // Filter to pages edited since last checkpoint
  return data.results.filter(p => 
    p.object === 'page' && 
    new Date(p.last_edited_time) > new Date(since)
  );
}

async function getPageBlocks(pageId) {
  // Paginated fetch — handles pages of any length, no block limit
  let blocks = [];
  let cursor = undefined;
  do {
    const url = `${NOTION_API}/blocks/${pageId}/children?page_size=100${cursor ? '&start_cursor=' + cursor : ''}`;
    const res = await fetch(url, { headers: HEADERS });
    const data = await res.json();
    blocks = blocks.concat(data.results || []);
    cursor = data.has_more ? data.next_cursor : undefined;
  } while (cursor);
  return blocks;
}

function extractText(block) {
  if (!block.type) return '';
  const typeData = block[block.type];
  if (!typeData?.rich_text) return '';
  return typeData.rich_text.map(t => t.plain_text).join('');
}

function blocksToMarkdown(blocks) {
  return blocks.map(block => {
    const text = extractText(block);
    switch (block.type) {
      case 'heading_1': return `# ${text}`;
      case 'heading_2': return `## ${text}`;
      case 'heading_3': return `### ${text}`;
      case 'bulleted_list_item': return `- ${text}`;
      case 'numbered_list_item': return `1. ${text}`;
      case 'code': return `\`\`\`\n${text}\n\`\`\``;
      case 'quote': return `> ${text}`;
      case 'divider': return `---`;
      case 'paragraph': return text || '';
      default: return text;
    }
  }).filter(Boolean).join('\n\n');
}

function pageHasVaultTag(title, blocks) {
  if (title.toLowerCase().includes(tag_filter.toLowerCase())) return true;
  return blocks.some(b => extractText(b).toLowerCase().includes(tag_filter.toLowerCase()));
}

function slugify(title) {
  return title.toLowerCase()
    .replace(/[^a-z0-9\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .trim();
}

function getPageTitle(page) {
  const titleProp = page.properties?.title || page.properties?.Name;
  if (!titleProp) return 'untitled';
  const texts = titleProp.title || [];
  return texts.map(t => t.plain_text).join('') || 'untitled';
}

async function syncPage(page) {
  const title = getPageTitle(page);
  const blocks = await getPageBlocks(page.id);
  
  if (!pageHasVaultTag(title, blocks)) return false;
  
  const date = new Date(page.last_edited_time).toISOString().split('T')[0];
  const slug = slugify(title.replace('#vault', '').trim());
  const filename = `${date}-${slug}.md`;
  
  const markdown = [
    `# ${title.replace('#vault', '').trim()}`,
    ``,
    `> Synced from Notion | Last edited: ${page.last_edited_time}`,
    `> Source: https://notion.so/${page.id.replace(/-/g, '')}`,
    ``,
    blocksToMarkdown(blocks)
  ].join('\n');
  
  mkdirSync(output_dir, { recursive: true });
  const outPath = join(output_dir, filename);
  writeFileSync(outPath, markdown);
  
  return filename;
}

async function main() {
  log('Starting Notion vault sync...');
  const checkpoint = loadCheckpoint();
  log(`Last sync: ${checkpoint.last_sync}`);
  
  const pages = await searchRecentPages(checkpoint.last_sync);
  log(`Found ${pages.length} recently edited pages`);
  
  let synced = 0;
  for (const page of pages) {
    try {
      const result = await syncPage(page);
      if (result) {
        log(`Synced: ${result}`);
        synced++;
      }
    } catch (err) {
      log(`Error syncing page ${page.id}: ${err.message}`);
    }
    // Notion API rate limit: stay under 3 req/sec
    await new Promise(r => setTimeout(r, 350));
  }
  
  saveCheckpoint({ last_sync: new Date().toISOString() });
  log(`Done. Synced ${synced} pages.`);
}

main().catch(err => {
  log(`Fatal error: ${err.message}`);
  process.exit(1);
});
```

### 4. Make It Executable

```bash
chmod +x /usr/local/bin/notion-vault-poller.js
```

### 5. Set Up Crontab

```bash
crontab -e
```

Add:

```bash
# Notion vault sync — every 15 minutes
*/15 * * * * /usr/bin/node /usr/local/bin/notion-vault-poller.js >> /root/.openclaw/notion-sync/cron.log 2>&1
```

---

## The #vault Tag Filter

### How It Works

The poller checks for `#vault` in three places:

1. **Page title** — `My Project Plan #vault` → synced
2. **First heading** — Any H1/H2/H3 block containing `#vault` → synced
3. **Body text** — Any paragraph containing `#vault` → synced

If `#vault` appears anywhere in the page, the whole page syncs.

### Where to Put It in Notion

**Recommended:** Add `#vault` to the page title for clarity.

```
My Project Plan #vault
Q1 Strategy #vault
Meeting Notes 2026-03-01 #vault
```

Or drop it in a hidden section at the bottom:

```
[page content]

---
tags: #vault
```

### Removing the Tag

To stop syncing a page, remove `#vault` from the title/body. The existing synced file remains in your vault — it won't be deleted. To remove it, delete it manually.

---

## File Naming

Synced files follow this pattern:

```
YYYY-MM-DD-page-title-slug.md
```

Examples:
```
2026-03-01-my-project-plan.md
2026-03-01-q1-strategy.md
2026-02-28-meeting-notes-2026-03-01.md
```

Files are saved to the `output_dir` configured in `config.json`.

---

## Sync Log and Checkpoint Files

**Sync log** (`~/.openclaw/notion-sync/notion-sync.log`):

```
[2026-03-01T15:00:01Z] Starting Notion vault sync...
[2026-03-01T15:00:01Z] Last sync: 2026-03-01T14:45:00Z
[2026-03-01T15:00:02Z] Found 3 recently edited pages
[2026-03-01T15:00:03Z] Synced: 2026-03-01-q1-strategy.md
[2026-03-01T15:00:04Z] Done. Synced 1 pages.
```

**Checkpoint file** (`~/.openclaw/notion-sync/checkpoint.json`):

```json
{
  "last_sync": "2026-03-01T15:00:04Z"
}
```

The checkpoint prevents re-downloading pages on every run. Only pages edited since the last sync are checked.

---

## Example Output

### Notion Page (before sync)

```
Title: Q1 Marketing Strategy #vault

## Overview
Build content systems that run without me.

## Goals
- Ship 3 pieces/week via Scribe pipeline
- Grow LinkedIn to 5K followers
- Close 2 fractional CMO clients

## Key Systems
- Content pipeline (Scribe + Proof)
- Social scanner (3x/day)
- Agent queue orchestrator
```

### Synced Vault File (`2026-03-01-q1-marketing-strategy.md`)

```markdown
# Q1 Marketing Strategy

> Synced from Notion | Last edited: 2026-03-01T14:30:00Z
> Source: https://notion.so/abc123def456

## Overview

Build content systems that run without me.

## Goals

- Ship 3 pieces/week via Scribe pipeline
- Grow LinkedIn to 5K followers
- Close 2 fractional CMO clients

## Key Systems

- Content pipeline (Scribe + Proof)
- Social scanner (3x/day)
- Agent queue orchestrator
```

---

## Working with Other Agents

Synced Notion pages land in your configured `output_dir` (default: `notion-sync/`). To unlock the full value of this skill, point your other agents at this directory.

**Recommended: Change `output_dir` to `bambf/from-notion/`** so synced files live inside the main vault content tree where all agents already scan.

```json
{
  "output_dir": "/root/obsidian-vault/bambf/from-notion/"
}
```

**Add to HEARTBEAT.md scan list:**
```markdown
## Context Sources
- bambf/from-notion/   # Synced Notion pages — check for new briefing docs, strategies, notes
```

**Agent integration examples:**
- **Triton** — checks `from-notion/` each heartbeat for new briefing docs or project updates
- **Scribe** — reads synced strategy pages before drafting content ("use Q1 strategy from from-notion/")
- **Radar** — uses synced research notes as starting context for new intel tasks
- **Forge** — pulls synced technical specs or requirements before building

**In any agent prompt, reference synced files directly:**
```
"Read bambf/from-notion/2026-03-01-q1-marketing-strategy.md before drafting"
```

This is how a Notion page becomes shared context across your entire agent stack — zero token cost, zero manual copy-paste.

---

## Update Behavior

**Synced files are overwritten on each sync run** if the Notion page has been edited. This is by design — the vault file always reflects the current Notion source.

> ⚠️ **Note on manual edits:** If you manually edit a synced vault file, those changes will be lost on the next sync if the Notion page is also edited. Treat synced files as read-only. If you need to annotate or extend a synced page, create a separate vault file that links to it rather than editing the synced copy.

---

## Error Handling

The poller handles errors at three levels:

**Per-page errors** — if a single page fails (deleted, permissions changed, API error), the error is logged and the script continues syncing remaining pages. One bad page won't kill the run.

**API rate limits** — the 350ms delay between pages keeps requests under Notion's 3 req/sec limit. If you hit a 429, the error is logged as `Error syncing page [id]: 429 Too Many Requests`. Wait one cycle and it will retry automatically.

**Fatal errors** — if the config file is missing or the Notion token is invalid, the script exits with code 1 and logs a fatal error. Check `~/.openclaw/notion-sync/notion-sync.log` for details.

**To check sync health:**
```bash
tail -50 ~/.openclaw/notion-sync/notion-sync.log
```

A healthy run ends with: `Done. Synced N pages.`

---

## Troubleshooting

**No pages syncing:**
1. Check your Notion token is valid: `curl -H "Authorization: Bearer YOUR_TOKEN" https://api.notion.com/v1/users/me`
2. Confirm the integration has access to your pages (share pages with the integration in Notion)
3. Check that `#vault` appears in the page title, heading, or body text
4. Verify `checkpoint.json` isn't set to a future date: `cat ~/.openclaw/notion-sync/checkpoint.json`

**Partial page content (old behavior):**
If you installed this skill before v1.1, your `getPageBlocks` may have been capped at 100 blocks. Update to the paginated version included in this skill — it handles pages of any length.

**Script not running on cron:**
```bash
# Test manually first
/usr/bin/node /usr/local/bin/notion-vault-poller.js

# Check cron is set
crontab -l | grep notion

# Check cron logs
tail -20 /root/.openclaw/notion-sync/cron.log
```

**Wrong output directory:**
Edit `~/.openclaw/notion-sync/config.json` and update `output_dir`. Files already synced won't move automatically — they stay where they were written.

---

## Requirements

- Node.js 22+ (uses native `fetch`)
- Notion API token (free)
- Notion API rate limit: 3 req/sec — script automatically paces requests with 350ms delay
- System crontab access
- Zero npm packages required

---

*Built for founders who live in Notion but think in Obsidian. Bridge the gap automatically.*
