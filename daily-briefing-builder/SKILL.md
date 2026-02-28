---
name: daily-briefing-builder
description: Generate a daily founder morning brief from your Obsidian vault. Pulls today's priorities, unposted content, weather, and content queue into one clean briefing. Runs on cron or heartbeat. Use when user says "morning brief," "daily briefing," or "what's on my plate today."
---

# Daily Briefing Builder

**Version:** 2.0.0  
**Price:** Free  
**Category:** Productivity  

---

## What It Does

Generates a morning brief from your Obsidian vault — automatically. Pulls today's 3 priorities, scans your ready-to-post content queue, fetches weather, and formats it into a clean briefing delivered to Telegram.

Run it on heartbeat or cron. Takes under 10 seconds. No manual steps.

---

## Routing

### Use This Skill When:
- User wants a daily briefing or morning overview
- Cron or heartbeat fires at morning check-in time
- User says "morning brief," "daily briefing," "what's on my plate today"

### Do NOT Use When:
- User wants a full calendar review → Use calendar integration
- User wants email inbox → Use Gmail skill
- User wants detailed content audit → Use vault-cleanup-auditor

### Inputs Required:
- Vault path (default: /root/obsidian-vault)
- City for weather (wttr.in format, e.g. Ann+Arbor)
- Today's date (auto-detected)

### Outputs Produced:
- Formatted morning brief with 3 sections: Actions, Content Queue, Weather
- Brief sent to Telegram
- Saved to bambf/briefings/YYYY-MM-DD-morning.md

---

## Steps

### 1. Pull Today's Actions

Read: bambf/tracking/daily-actions/YYYY-MM-DD.md

Extract items under "## Today's 3 Actions". If file missing, note it in the brief.

### 2. Scan Content Queue

Search content/ready-to-post/ for files containing **Posted:** with an X marker.

Cap display at 5 items (newest first). Show total count.

### 3. Fetch Weather

Run: curl -s "wttr.in/CITY?format=3"

Fail gracefully if offline — include "Weather unavailable" in brief.

### 4. Assemble Brief

Format:
  Morning Brief — [Weekday, Month Day]
  TODAY'S 3 ACTIONS: [numbered actions]
  READY TO POST ([shown] of [total]): [platform, title, path]
  WEATHER: [wttr.in output]

### 5. Deliver

- Send to Telegram
- Save to bambf/briefings/YYYY-MM-DD-morning.md

---

## Autonomy Triggers

  - "morning brief" | "daily briefing" | "what's on my plate today"
    Run: Generate and deliver brief immediately

  - heartbeat / cron at 7am ET
    Run: Auto-generate and send without prompt

Cron setup (7am ET = 12:00 UTC):
  0 12 * * * openclaw run triton "Run the daily-briefing-builder skill. Vault: /root/obsidian-vault. City: Ann+Arbor"

---

## Example Output

  Morning Brief — Friday, February 28

  TODAY'S 3 ACTIONS
  1. Finish Q1 content calendar
  2. Send invoice to BAMBF client
  3. Publish LinkedIn post on AI ops

  READY TO POST (5 of 9)
  [linkedin] Nobody talks about what happens when your AI fails — content/ready-to-post/linkedin/ai-ops.md
  [twitter] The overnight ops shift is real — content/ready-to-post/twitter/async-ops.md
  [newsletter] AI marketing systems that actually work — content/ready-to-post/newsletter/systems.md
  ...and 4 more in the pipeline

  WEATHER
  Ann Arbor: Sunny +42F

---

## Requirements

- Read access to vault
- Write access to bambf/briefings/ (auto-created)
- curl for weather (fails gracefully without it)
- Telegram configured for delivery
