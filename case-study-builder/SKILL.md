---
name: case-study-builder
description: Turn client wins into formatted case studies for proposals, social proof,
  and sales conversations. Use when someone needs to document results, build credibility,
  or create reusable proof assets. Trigger when user completes a project, mentions
  a "win," or says "I need a case study."
metadata:
  openclaw:
    emoji: 📊
homepage: https://brianrwagner.com
---

# Case Study Builder

## Autonomy Triggers

Activate this skill when the user:
- Says "we just finished a project" or "client just got results"
- Mentions a specific outcome (revenue, leads, time saved, growth)
- Is building a proposal and needs proof points
- Says "I need something for my website" about past work
- `testimonial-collector` just ran and collected a strong quote — offer to expand it into a case study

Auto-suggest: "That sounds like a strong result — want me to build a case study from it while the details are fresh?"

---

## Memory Read

Before starting, check session context for:
- `testimonial-collector` outputs — use collected quotes as source material
- `positioning-basics` outputs — ensure case study reinforces the stated positioning
- Existing case study library — identify coverage gaps (which industries or outcomes are missing?)

---

## ⚠️ Structured Intake Form (8 Fields — Complete Before Drafting)

Do not begin writing until all 8 fields are answered:

> **Field 1 — Client industry and company size:**
> (e.g., "Series B SaaS, 30 employees" or "Solo consultant, legal industry")
>
> **Field 2 — Before metric or situation:**
> (What was broken, slow, or painful before you showed up? Numbers preferred.)
>
> **Field 3 — What you actually did:**
> (Scope, timeline, your specific role and actions)
>
> **Field 4 — Outcome metric:**
> (The result — MUST include at least one number. See Outcome Extraction Protocol.)
>
> **Field 5 — Timeline:**
> (How long did this take to achieve?)
>
> **Field 6 — Client quote (if available):**
> (Direct quote or paraphrase — will be polished in draft)
>
> **Field 7 — Can we name the client, or do we anonymize?**
> (Named = stronger; anonymous = still usable with industry/size context)
>
> **Field 8 — Primary use case for this case study:**
> (Proposals? Website? Sales conversations? LinkedIn?)

---

## Outcome Extraction Protocol

If Field 4 is vague (e.g., "results were really good"), do NOT proceed. Ask:

> "I need at least one specific number to make this case study credible. Can you give me one of these?
> - Revenue change (e.g., 'closed 3 new clients worth $X')
> - Time saved (e.g., 'reduced from 10 hours to 2 hours per week')
> - Lead volume (e.g., 'went from 0 to 5 inbound leads/month')
> - Cost reduction (e.g., 'saved $2K/month on [thing]')
> - A rough estimate is fine — it doesn't have to be exact."

Do not draft until at least one number is named.

---

## The Hero Principle

**The client is the hero. You are the guide.**

Before/After Example:
- ❌ Wrong: "I built a content system that generated leads."
- ✅ Right: "Sarah went from scrambling to fill her pipeline to getting 3 inbound inquiries per week — all from a content system we built together in 6 weeks."

Every case study should be written from the client's perspective. What did THEY experience? What was THEIR situation? What changed for THEM?

---

## The Three Formats

### Format 1: The Two-Liner (Proposals & Bios)

**Formula:** `[What was done] + [scale/scope] + [for who] + [result or timeframe]`

**Template:**
> "[Action verb] [what you delivered] for [client descriptor]. [Result in X timeframe]."

**Example:**
> "Built a full content system for a Series B SaaS founder — 0 to 3 inbound leads/week in 6 weeks."

---

### Format 2: The Story Version (LinkedIn & Sales Calls)

**Structure:**
1. **Set the scene** — What was their situation when you showed up?
2. **Show the complexity** — What made this hard?
3. **What you did** — Actions, not features
4. **What changed** — The outcome with the number

**Target length:** 4 paragraphs, 150-250 words

---

### Format 3: The Full Case Study (Website & Portfolio)

```markdown
# Case Study: [Client Name or Descriptor]

## The Challenge
[2-3 paragraphs on the situation before]

## The Approach
[What was done, broken into phases or steps]

## The Results
[Metrics, outcomes, before/after comparison]

## Key Details
- Client: [Named or "A [descriptor] company"]
- Industry: [Sector]
- Timeline: [Duration]
- Scope: [What was delivered]

## What Made This Different
[Unique angle, unexpected obstacle, or pivotal insight]

## Client Quote
> "[Testimonial]"
> — [Name], [Title]
```

---

## Self-Critique Pass (REQUIRED After Drafting)

After generating all three formats, check:

| Check | Two-liner | Story | Full |
|---|---|---|---|
| Does it include at least one metric? | ✅/❌ | ✅/❌ | ✅/❌ |
| Is the client the hero (not you)? | ✅/❌ | ✅/❌ | ✅/❌ |
| Does the story have real tension? | N/A | ✅/❌ | ✅/❌ |
| Is it specific enough to be credible? | ✅/❌ | ✅/❌ | ✅/❌ |

Flag any ❌: "The story version lacks tension — there's no mention of what made this hard. Add one obstacle or unexpected challenge."

---

## Distribution Plan

Always include where to use each format:

| Format | Use Here | When |
|---|---|---|
| Two-liner | Proposals, email bios, LinkedIn About | Immediately |
| Story | LinkedIn post, sales call talking points | Weekly content |
| Full case study | Website portfolio, PDF downloads | Reference asset |

---

## Multi-Agent Handoff Format

Pass to `testimonial-collector`, Scribe, or content agents:

```yaml
case_study_handoff:
  client: "[Name or descriptor]"
  industry: "[sector]"
  before_metric: "[situation/number]"
  after_metric: "[result/number]"
  timeline: "[duration]"
  formats:
    two_liner: "[text]"
    story: "[text]"
    full_case_study_path: "case-studies/[slug].md"
  quote: "[client quote if available]"
  use_cases: ["proposals", "website", "linkedin"]
  date_created: "[YYYY-MM-DD]"
```

**Cross-reference:** If a client quote is available and not yet in `testimonial-collector`, offer to add it: "Want me to save this quote to your testimonial library?"

---

## Memory Write

After completing this session, save to case study library:

```markdown
## Case Study: [Client Descriptor] — [Date]
- Industry: [sector]
- Before: [situation]
- After: [metric]
- Two-liner: "[text]"
- Formats: [two-liner / story / full]
- Location: case-studies/[slug].md
```
