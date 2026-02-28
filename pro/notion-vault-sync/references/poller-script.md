# Notion Vault Poller — Full Script

Save as `/usr/local/bin/notion-vault-poller.js` then `chmod +x`.

See the poller.js embedded in the setup section of SKILL.md for the complete implementation.

**Key implementation details:**
- Zero npm dependencies — uses native Node 22 `fetch`
- Paginated block fetching (handles pages of any length, no 100-block limit)
- 350ms delay between pages (stays under Notion's 3 req/sec rate limit)
- Checkpoint system: only downloads pages edited since last run
- Per-page error handling: one bad page doesn't kill the run

**File naming:** `YYYY-MM-DD-page-title-slug.md`

**Cron setup:**
```bash
*/15 * * * * /usr/bin/node /usr/local/bin/notion-vault-poller.js >> /root/.openclaw/notion-sync/cron.log 2>&1
```

**Troubleshooting:**
```bash
# Test manually
/usr/bin/node /usr/local/bin/notion-vault-poller.js

# Check sync health
tail -50 ~/.openclaw/notion-sync/notion-sync.log

# Validate Notion token
curl -H "Authorization: Bearer YOUR_TOKEN" https://api.notion.com/v1/users/me

# Check checkpoint isn't future-dated
cat ~/.openclaw/notion-sync/checkpoint.json
```

**Common failures:**
- No pages syncing: check integration has access to pages in Notion settings
- 429 errors: wait one cycle, 350ms delay handles normal usage
- Wrong output dir: edit `~/.openclaw/notion-sync/config.json` → `output_dir`
- Manual vault edits lost: synced files overwrite on every sync — treat as read-only
