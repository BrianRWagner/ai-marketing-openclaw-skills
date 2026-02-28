---
name: notion-vault-sync
description: Auto-sync Notion pages tagged vault to Obsidian markdown files every 15 minutes via cron. Use when setting up Notion-to-Obsidian sync, stopping manual exports, or automatically pulling ideas from Notion into the vault.
---

# Notion ↔ Obsidian Vault Sync

**Version:** 1.1.0  
**Price:** $9  
**Category:** Productivity  

---

## What It Does

A zero-token polling script that automatically syncs tagged Notion pages to Obsidian markdown files every 15 minutes. Any page with `#vault` in the title, a heading, or the body text gets pulled down and written to your vault automatically.

**The flow:**
```
[Every 15 min] → poller.js fetches recently edited Notion pages
→ Checks each page for #vault tag
→ Tagged pages → convert to Markdown → write to vault
→ Log sync to notion-sync.log → save checkpoint
```

No database configuration. No manual exports. No token usage. Just cron + Node.js.

---

## Setup

### 1. Get Your Notion API Token

1. Go to https://www.notion.so/my-integrations
2. Create new integration (name: "Vault Sync")
3. Copy the Internal Integration Token
4. Share workspace pages with the integration

### 2. Create Config File

Save as `~/.openclaw/notion-sync/config.json`:

```json
{
  "notion_token": "secret_xxxxxxxxxxxxxxxxxxxx",
  "output_dir": "/root/obsidian-vault/bambf/from-notion/",
  "checkpoint_file": "~/.openclaw/notion-sync/checkpoint.json",
  "log_file": "~/.openclaw/notion-sync/notion-sync.log",
  "tag_filter": "#vault",
  "poll_interval_minutes": 15
}
```

See `references/config-examples.md` for alternate configs and agent integration patterns.

### 3. Install Poller Script

Get the full script from `references/poller-script.md`.

```bash
# After saving the script:
chmod +x /usr/local/bin/notion-vault-poller.js
```

### 4. Set Up Crontab

```bash
crontab -e
# Add:
*/15 * * * * /usr/bin/node /usr/local/bin/notion-vault-poller.js >> /root/.openclaw/notion-sync/cron.log 2>&1
```

---

## The #vault Tag Filter

The poller checks for `#vault` in three places:
1. **Page title** — `My Project Plan #vault`
2. **Any heading block** — H1/H2/H3 containing `#vault`
3. **Body text** — any paragraph containing `#vault`

---

## Working with Other Agents

Synced files land in `bambf/from-notion/`. Reference them from any agent context:
```
"Read bambf/from-notion/2026-03-01-q1-marketing-strategy.md before drafting"
```

This is how a Notion page becomes shared context across your entire agent stack — zero token cost.

---

## Requirements

- Node.js 22+ (uses native `fetch`, zero npm packages)
- Notion API token (free)
- System crontab access

---

*Built for founders who live in Notion but think in Obsidian.*
