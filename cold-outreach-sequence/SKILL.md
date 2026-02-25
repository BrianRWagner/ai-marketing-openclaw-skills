---
name: cold-outreach-sequence
description: Build personalized cold outreach sequences for LinkedIn and email. Use
  when someone needs to reach prospects, warm up cold leads, or build a systematic
  outreach engine. Requires research on each prospect before generating messages.
metadata:
  openclaw:
    emoji: 📧
homepage: https://brianrwagner.com
---

# Cold Outreach Sequence

## Autonomy Triggers

Activate this skill when the user:
- Mentions a specific prospect, company, or person they want to reach
- Says "I need to do outreach" or "how do I get in front of [type of person]"
- Is building a pipeline and needs systematic messaging
- Has completed `positioning-basics` — offer to build outreach sequences anchored to the ICP

Auto-suggest: "Want me to build a personalized outreach sequence for this prospect? Give me their name + company and I'll research before we write."

---

## Memory Read

Before starting, check session context for:
- `positioning-basics` output — use ICP and differentiator to anchor messaging
- Pipeline tracking table from prior sessions — don't create duplicate sequences
- Prior prospect research — if already researched, don't re-run

---

## ⚠️ Research Before Writing (Mandatory)

**Constraint: Never send Tier 1 outreach without a named specific signal from research.**

If no research has been done, run these tool calls first:

```
web_search('[Company] [Founder/Name] news 2026')
web_search('[Company] funding recent')
web_search('[Person name] LinkedIn post')
```

**Personalization Tier Assignment (based on research output):**

| Research Result | Tier | Approach |
|---|---|---|
| Recent news + post activity + named signal | Tier 1 | Fully custom, reference specific signal |
| Company info + general role awareness | Tier 2 | Template + personalized opener |
| No signals found after search | Tier 3 | Volume template only |

**Constraint:** If research yields 0 signals, do NOT write a Tier 1 message. Use Tier 3 and note: "No live signals found — using template approach."

---

## The Full Sequence

### Connection Request (LinkedIn) — 300 chars max

**Formula:** `[Specific observation from research] + [Simple reason to connect]`

**Rules:**
- No pitching. Ever.
- Prove you looked (name the specific signal)
- One sentence, human tone
- No "I'd love to pick your brain"

**Examples by signal type:**
- Recent funding: "Congrats on the Series A — the [specific investor] backing is a smart signal. Would love to connect."
- Recent post: "Your post on [specific topic] resonated — been thinking about the same thing. Happy to connect."
- Product launch: "Saw the [product] launch — the [specific thing] is smart positioning. Would love to connect."

### First Message (After Accept — Wait 24-48 Hours)

**Formula:** `[Thanks] + [Bridge to relevance] + [Light value] + [Soft question]`

**Template:**
```
Thanks for connecting. I work with [ICP description] on [relevant outcome].

Curious — is [relevant function] something you own directly at [Company], or is that still founder-led?

Happy to share what I'm seeing work at similar-stage companies either way.
```

### Follow-Up #1 (Day 7)

**Formula:** `[Light nudge] + [New signal or angle] + [Easy out]`

**Constraint:** Do NOT just say "following up." Add something new — a recent article, a trend, a related signal.

### Follow-Up #2 (Day 14)

Alternative channel (email) or new angle.

Subject line options:
- "[Company]'s [function] as you scale"
- "Saw your [post/news] — quick thought"

### Break-Up Message (Day 21)

**Template:**
```
I'll assume timing isn't right — totally get it. If [relevant pain point] becomes a priority, happy to reconnect. Best of luck with [specific thing they're working on].
```

**After break-up:** Add to 6-month re-engagement list. Note in pipeline tracker: "Resurface [date]."

---

## Pipeline Tracking Table

Always output a tracking table for each batch of prospects:

```markdown
| Prospect | Company | Platform | Tier | Sent Date | Response | Stage | Next Action | Resurface Date |
|---|---|---|---|---|---|---|---|---|
| [Name] | [Co] | LinkedIn | 1 | [date] | — | Connection sent | Wait 24-48h | — |
```

Update after each interaction.

---

## Personalization Tier Details

**Tier 1 — Top 10 prospects (10-15 min research):**
- Full research, fully custom messages
- Reference specific signal in every touchpoint
- Maximum 10 active at once

**Tier 2 — Next 20 prospects (5 min research):**
- Template with personalized opener
- Reference company stage or role context

**Tier 3 — Volume (minimal research):**
- Template with minimal customization
- Only when Tier 1 and 2 are exhausted

**The math:** 10 highly personalized messages often beat 100 spray-and-pray.

---

## Multi-Agent Handoff Format

Pass prospect research and sequences to CRM or follow-up agents:

```yaml
outreach_handoff:
  prospect:
    name: "[full name]"
    company: "[company]"
    role: "[title]"
    research_signals:
      - type: "funding | post | news | launch"
        detail: "[specific finding]"
        source: "[URL or platform]"
  personalization_tier: 1 | 2 | 3
  sequence:
    connection_request: "[text]"
    first_message: "[text]"
    followup_1: "[text]"
    followup_2: "[text]"
    breakup: "[text]"
  pipeline_status: "connection_sent | responded | no_response | break_up"
  resurface_date: "[YYYY-MM-DD or null]"
```

---

## Memory Write

After building sequences, save to session context:

```markdown
## Outreach Pipeline — [Date]
- Prospects built: [number]
- Tier 1: [names]
- Tier 2: [names]
- Tier 3: [names]
- Active sequences: [count]
- Next follow-up batch: [date]
- Re-engagement list: [names + resurface dates]
```

---

## What Kills Outreach

❌ Tier 1 message without a named specific signal
❌ "I'd love to pick your brain"
❌ Pitching in the connection request
❌ Same message to everyone
❌ "Following up" with nothing new
❌ "Hope this finds you well"
