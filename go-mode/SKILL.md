---
name: go-mode
description: Autonomous goal execution mode. Use when someone says "take the wheel," "go mode," "execute this," "run this task," "build this," or gives a clear goal they want planned and executed end-to-end with checkpoints.
homepage: https://brianrwagner.com
metadata:
  openclaw:
    emoji: 🚀
---

# 🎯 Go Mode — Autonomous Goal Execution

Give me a goal. I'll plan it, confirm with you, execute it, and report back. You steer — I drive.

## How It Works

```
GOAL → PLAN → CONFIRM → EXECUTE → REPORT
```

### Phase 1: PLAN
When given a goal, break it down:

1. **Parse the goal** — What's the desired outcome? What does "done" look like?
2. **Break into steps** — Ordered task list, each step concrete and actionable
3. **Identify tools** — Which skills, APIs, agents, or CLI tools are needed?
4. **Estimate effort** — Time per step, total duration, API costs if applicable
5. **Flag risks** — What could go wrong? What needs human approval?

Output a structured plan:

```
## 🎯 Goal: [restated goal]

### Definition of Done
[What success looks like]

### Plan
| # | Step | Tool/Skill | Est. Time | Cost | Risk |
|---|------|-----------|-----------|------|------|
| 1 | ... | ... | ... | ... | ... |

### Total Estimate
- **Time:** X minutes
- **API Cost:** ~$X.XX
- **Human Checkpoints:** [list]

### Guardrails Triggered
- [ ] External communication (needs approval)
- [ ] Financial spend > $1
- [ ] Irreversible action
```

### Phase 2: CONFIRM
Present the plan and wait for approval:

- **"Go"** → Execute all steps
- **"Go with changes"** → Adjust plan, then execute
- **"Just steps 1-3"** → Partial execution
- **"Cancel"** → Abort

**Never skip confirmation.** This is the human's steering wheel.

### Phase 3: EXECUTE
Run each step sequentially:

1. **Announce** the current step: "Step 2/5: Researching competitor pricing..."
2. **Execute** using the identified tool/skill
3. **Checkpoint** after each major step — brief status update
4. **Pause if:** 
   - A guardrail is triggered (external action, spend, irreversible)
   - Something unexpected happens
   - A decision point requires human judgment
5. **Adapt** — If a step fails, try alternatives before escalating

### Phase 4: REPORT
When all steps complete:

```
## ✅ Goal Complete: [goal]

### What Was Done
- Step 1: [result]
- Step 2: [result]
- ...

### Outputs
- [List of files, links, artifacts created]

### What Was Learned
- [Insights discovered during execution]

### Recommended Next Steps
- [What to do with the results]
- [Follow-up opportunities]

### Stats
- Total time: Xm
- API calls: X
- Est. cost: $X.XX
```

## Guardrails

### Always Ask Before:
- ✉️ Sending emails, DMs, or messages to anyone
- 📢 Posting to social media (Twitter, LinkedIn, etc.)
- 💰 Spending money or making API calls > $1 estimated
- 🗑️ Deleting files or data
- 🔒 Changing permissions, credentials, or configs
- 🌐 Making any public-facing change

### Auto-Proceed On:
- ✅ Reading files, searching the web
- ✅ Creating drafts (not publishing)
- ✅ Organizing or summarizing information
- ✅ Running analysis or calculations
- ✅ Creating files in the workspace

### Budget Caps
- **Default per-goal budget:** $5 API spend max
- **Per-step timeout:** 5 minutes (escalate if stuck)
- **Total goal timeout:** 60 minutes (checkpoint and ask to continue)
- Human can override any cap at confirm time

## Usage

Just tell the agent your goal in natural language:

> "Go mode: Research the top 5 AI newsletter tools, compare them, and recommend the best one"

> "Take the wheel: Build a complete email welcome sequence — 5 emails over 2 weeks"

> "Execute: Audit our Twitter presence and create a 30-day content strategy"

The agent will plan, confirm, execute, and report. You stay in control at every checkpoint.

## Principles

1. **Transparency** — Always show the plan before executing
2. **Safety** — Never take external actions without approval
3. **Efficiency** — Use the cheapest/fastest tool for each step
4. **Resilience** — Try alternatives before giving up
5. **Accountability** — Report everything that was done
6. **Respect time** — Estimate honestly, checkpoint if running long
