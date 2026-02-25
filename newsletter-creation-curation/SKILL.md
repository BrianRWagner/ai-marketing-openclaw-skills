---
name: newsletter-creation-curation
description: Industry-adaptive B2B newsletter creation with stage, role, and geography-aware
  workflows. Use when someone needs to create, improve, or systematize a B2B newsletter.
metadata:
  openclaw:
    emoji: ✉️
homepage: https://brianrwagner.com
---

# Newsletter Creation & Curation Skill

Use this skill to create B2B newsletters that match business context, not generic content templates.

Deep strategic guidance is in `PLAYBOOK.md`.
Use this file as the executable operating manual.

## Autonomy Triggers

Activate this skill when the user:
- Asks "what should I write in my newsletter this week?"
- Says "help me create a newsletter" or "I need to write my next issue"
- Completes `content-idea-generator` — offer to turn ideas into a newsletter
- Has a content strategy from `linkedin-authority-builder` — offer to cross-publish to newsletter
- Mentions subscriber list, email marketing, or "my audience"

Auto-suggest: "Want me to build this week's newsletter issue? Give me your context (industry, stage, goal) and I'll produce a publish-ready draft."

---

## Memory Read

Before starting, check session context for:
- Subscriber personas from prior newsletter sessions
- Content themes and editorial calendar
- Industry template selected previously (don't re-ask if already established)
- `positioning-basics` output — ICP should match newsletter audience
- `content-idea-generator` outputs — ideas to pull from

---

## Quick Decision Tree (5 Dimensions)

Answer these in order before writing anything:

### 1) Goal
- `Lead Generation`: newsletter should drive pipeline and SQLs.
- `Thought Leadership`: build trust and category authority.
- `Personal Brand`: establish individual POV and visibility.
- `Category Ownership`: define market narrative at scale.

### 2) Industry
- `Sales Tech`: tactical, data-heavy, ROI-forward.
- `HR Tech`: research-led, professional, trust-first.
- `Fintech`: compliance-aware, conservative claims.
- `Operations Tech`: domain-specific, practical playbooks.

### 3) Company Stage
- `Series A`: founder-led, lean, weekly or bi-weekly.
- `Series B`: team-led, stronger editorial process, analytics discipline.
- `Series C+`: media-grade quality, original research, category narrative.

### 4) Role
- `Founder`: highest autonomy, fastest execution.
- `VP/Director`: medium autonomy, stakeholder review expected.
- `PMM/Content`: structured approvals, brand constraints.
- `Enterprise employee`: PR/legal gatekeeping likely required.

### 5) Geography
- `India-first`: IST timing, local examples/channels.
- `US-first`: EST/PST timing, US benchmarks/channels.

---

## Execution Workflow

### Step 1: Assess Context
Output one-line strategy statement:
> `For [ICP], we publish [cadence] to achieve [goal] with [format].`

### Step 2: Draft Issue

Required structure — every issue, every time:
- **Subject line options (3)** — test A/B
- **Hook** (problem + stakes — first 2 sentences must earn the read)
- **Core insight** (data, framework, or pattern — the reason you sent this)
- **Actionable playbook** (steps/checklist — what to do with the insight)
- **CTA** (ONE measurable action: reply, share, demo, resource)

Generation rules:
- Specific numbers and named examples > generic claims
- Remove all generic filler phrases
- One primary takeaway per issue
- CTA is singular and measurable

### Step 3: Refine

Run checklist:
- `Clarity`: Can a busy reader extract value in 60 seconds?
- `Specificity`: Does each section have concrete guidance?
- `Relevance`: Tone matches industry and role?
- `Compliance`: For fintech/employee-led, does legal/manager review step exist?
- `Consistency`: Voice aligns with prior issues?

### Step 4: Finalize
- Choose one subject line
- Add send time
- Add amplification plan (LinkedIn post + one secondary channel)

---

## Execution Output Template (Fill This In Every Issue)

```markdown
## Issue: [Newsletter Name] — [Issue #] — [Date]
**Goal:** [Lead Gen / Thought Leadership / Personal Brand / Category]
**Strategy:** For [ICP], we publish [cadence] to achieve [goal].

---

### Subject Line Options
A) [Option 1 — curiosity/open loop]
B) [Option 2 — specific + benefit]
C) [Option 3 — contrarian/bold]
**Recommended:** [A/B/C — why]

---

### Hook
[Problem + stakes — 2-3 sentences]

---

### Core Insight
[Data, framework, or pattern — the reason you sent this]

---

### Actionable Playbook
1. [Step 1]
2. [Step 2]
3. [Step 3]

---

### CTA
[ONE action — specific and measurable]

---

### Send Details
- **Send time:** [Day, Time, Timezone]
- **Amplification:** [LinkedIn post angle] + [secondary channel]
- **KPI targets:** [Specific metrics for this issue's goal]
```

---

## Multi-Agent Handoff Format

Pass newsletter content to downstream agents (Scribe, social scheduler):

```yaml
newsletter_handoff:
  issue_number: [number]
  date: "[YYYY-MM-DD]"
  goal: "lead_gen | thought_leadership | personal_brand | category"
  industry: "sales_tech | hr_tech | fintech | ops_tech"
  stage: "series_a | series_b | series_c_plus"
  subject_line_chosen: "[text]"
  hook: "[text]"
  core_insight_summary: "[1 sentence]"
  cta: "[text]"
  send_time: "[Day Time Timezone]"
  amplification:
    linkedin_angle: "[post hook]"
    secondary_channel: "[platform + angle]"
  kpi_targets:
    open_rate: "[target%]"
    ctr: "[target%]"
    primary_metric: "[SQLs / subscribers / replies]"
  subscriber_persona_used: "[description]"
```

---

## Memory Write

After each issue, save to session context:

```markdown
## Newsletter Issue — [Date]
- Issue #: [number]
- Goal: [type]
- Subject chosen: "[text]"
- Core insight: "[1 sentence]"
- CTA: "[text]"
- Send time: [time]
- KPI targets: [metrics]
- Content themes for next issue: [notes]
- Subscriber persona: [description]
```

---

## Role-Based Approval Workflow

- **Founder-led:** No formal approval required. Optional peer review.
- **VP/Director-led:** Manager or leadership review required.
- **PMM/Content-led:** Brand + stakeholder review required.
- **Enterprise employee:** PR/legal review required before distribution.

When in doubt, default to stricter review.

---

## KPI Defaults by Goal

| Goal | Primary Metrics |
|---|---|
| Lead Generation | Open rate, CTR, demo requests, SQL tags |
| Thought Leadership | Open rate trend, replies, shares, speaking invites |
| Personal Brand | Subscriber growth, profile visits, inbound opps |
| Category Ownership | Share of voice, citations, partnerships |

---

## Fictional Case Study

**SignalPilot** (Sales Tech, Series A, US, Lead Gen goal):
- Selected `sales-tech-template.md`
- Weekly, Tuesday 9 AM EST
- 50% data-backed observations / 30% tactical playbooks / 20% contrarian POV
- Outcome in 6 months: 1,350 subscribers, 42% open rate, 14 monthly SQLs newsletter-attributed
