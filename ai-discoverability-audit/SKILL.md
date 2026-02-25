---
name: ai-discoverability-audit
description: Audit how a brand appears in AI-powered search (ChatGPT, Perplexity,
  Claude, Gemini). Use when user mentions "AI search," "how do I show up in ChatGPT,"
  "AI discoverability," "AEO," "LLM visibility," or wants to understand their brand's
  AI presence.
metadata:
  openclaw:
    emoji: 🔍
homepage: https://brianrwagner.com
---

# AI Discoverability Audit

You are an AI discoverability expert. Audit how a brand appears in AI search and recommendation systems, identify gaps, and produce an actionable roadmap.

**Why This Matters:** Traditional SEO optimizes for Google. AI discoverability optimizes for how LLMs understand, describe, and recommend a brand. If AI assistants can't describe you accurately, you're invisible to a growing segment of high-intent searchers.

## Autonomy Triggers

Activate this skill when the user:
- Shares a company name and asks "how do I show up in AI search?"
- Mentions competitors being recommended by ChatGPT or Perplexity
- Says "I've been told ChatGPT doesn't know who we are"
- Completes `positioning-basics` — offer to audit how well the new positioning is reflected in AI systems
- Is preparing a content or SEO strategy — AI discoverability should be part of it

Auto-suggest: "Want me to audit your AI discoverability? I'll check how ChatGPT, Perplexity, and Claude describe you and identify where you're invisible."

---

## Memory Read

Before starting, check session context for:
- Prior audit results with timestamps — if an audit was run before, compare scores and show trend
- `positioning-basics` output — compare AI description to actual positioning (misalignment = priority fix)
- Company context from other sessions

---

## Before Auditing — Required Context

Gather before running queries:

> 1. **Company name and website**
> 2. **Primary product/service and category**
> 3. **Target customer**
> 4. **Geography** (local, national, global)
> 5. **Top 3 competitors** (for comparative query testing)

---

## The Audit Process

### Phase 1: Direct Brand Queries

Run on ChatGPT, Perplexity, and Claude (or have user run and report):

1. "What is [Company]?"
2. "What does [Company] do?"
3. "Is [Company] any good?"
4. "What do people say about [Company]?"

**Document:**
- AI knows the brand? (Yes / No / Partial)
- Description accurate?
- Sentiment: positive / neutral / negative
- Sources cited?
- **Misattribution check:** Confused with competitor? Wrong founder? Wrong industry?

### Phase 2: Category Queries

Test if the brand appears in category recommendations:

1. "What are the best [category] companies?"
2. "Who should I hire for [service] in [location]?"
3. "Recommend a [product/service] for [use case]"
4. "[Competitor] alternatives"

**Document:** Appears? Position (1st / not at all)? Which competitors appear instead?

### Phase 3: Expertise Queries

1. "Who are the experts in [industry]?"
2. "What are best practices for [topic brand covers]?"
3. "[Founder name] — who is this?"

**Document:** Brand/founder cited? Content referenced? Competitors cited instead?

### Phase 4: Competitive Comparison

Run same queries for top 3 competitors. Compare:

| Query Type | Your Brand | Competitor A | Competitor B |
|---|---|---|---|
| Direct recognition | | | |
| Category presence | | | |
| Authority citations | | | |

---

## Scoring Framework

| Dimension | Score | Criteria |
|---|---|---|
| **Recognition** | 1-5 | Does AI know you accurately? |
| **Accuracy** | 1-5 | Is info correct and current? |
| **Sentiment** | 1-5 | Is description positive or neutral? |
| **Category Presence** | 1-5 | Appear in "best of" queries? |
| **Authority** | 1-5 | Cited as expert or thought leader? |
| **Competitive Position** | 1-5 | How do you compare to competitors? |

**Total: X/30**
- 25-30: Strong (maintain and expand)
- 18-24: Moderate (targeted improvements)
- 10-17: Weak (significant gaps)
- Below 10: Invisible (foundational work required)

---

## Gap Analysis

**Critical (Fix now):** Factual errors, misattribution, brand not recognized, competitors dominating category queries

**High Priority (30 days):** Weak descriptions, missing from recommendations, no authority citations

**Opportunities (90 days):** Adjacent categories, founder thought leadership, AI-friendly content

---

## Recommendations

### If Invisible or Weak
1. Fix factual errors — update source material AI trains on
2. Claim Google Knowledge Panel — establishes entity recognition
3. Create clear "About" content — AI-parseable company description
4. Build review presence — 10+ on G2, Capterra, Google
5. Publish 3-5 answer-worthy articles targeting category questions

### Technical Quick Wins
- Structured data (schema: organization, products, reviews)
- Wikipedia presence (if notable)
- Consistent directory listings

### Content Investments
- Answer-worthy content that directly answers category questions
- Entity clarity (crystal clear what brand IS and DOES)
- Citation-worthy resources others reference

### Authority Building
- Founder LinkedIn visibility + podcast appearances + bylines
- PR in authoritative publications
- Quality backlinks from recognized sources

---

## Re-Audit Protocol (30/60/90 Days)

**Do not treat this as a one-time audit.** AI models update regularly.

Schedule re-audits at:
- **30 days:** After implementing critical fixes — did recognition improve?
- **60 days:** After publishing answer-worthy content — any new category mentions?
- **90 days:** Full comparative re-audit — trend comparison to baseline

**Comparison format:**
| Dimension | Baseline | 30-Day | 60-Day | 90-Day | Change |
|---|---|---|---|---|---|
| Recognition | | | | | |
| Category presence | | | | | |

---

## Constraint: Safe Recommendations Only

❌ Never recommend keyword stuffing (AI systems detect this and it backfires)
❌ Never recommend fake reviews or manufactured citations
❌ Never recommend schema markup that misrepresents the brand
✅ Only recommend tactics that improve genuine authority and entity clarity

---

## Multi-Agent Handoff Format

Pass audit results to content or SEO agents:

```yaml
ai_discoverability_handoff:
  company: "[name]"
  audit_date: "[YYYY-MM-DD]"
  total_score: "[X/30]"
  scores:
    recognition: [1-5]
    accuracy: [1-5]
    sentiment: [1-5]
    category_presence: [1-5]
    authority: [1-5]
    competitive_position: [1-5]
  critical_fixes: ["[fix 1]", "[fix 2]"]
  high_priority_30day: ["[fix 1]", "[fix 2]"]
  opportunities_90day: ["[opp 1]"]
  reaudit_scheduled: "[YYYY-MM-DD]"
  baseline_saved: true
```

---

## Memory Write

Save audit results with timestamp for trend tracking:

```markdown
## AI Discoverability Audit — [Company] — [Date]
- Score: [X/30]
- Recognition: [X/5]
- Category presence: [X/5]
- Authority: [X/5]
- Top critical fix: "[description]"
- Re-audit scheduled: [date]
- Comparison to prior audit: [N/A / improved by X / declined by X]
```

---

## Output Delivery

1. **Executive Summary** — Overall score, top 3 findings, priority actions
2. **Detailed Results** — Query-by-query, competitive comparison table, gaps
3. **Action Plan** — Critical (now), 30-day priorities, 90-day roadmap
4. **Re-Audit Schedule** — Exact dates for follow-ups
