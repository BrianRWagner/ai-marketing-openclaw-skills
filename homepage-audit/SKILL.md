---
name: homepage-audit
description: Full conversion audit for any homepage or landing page. Use when someone
  asks to "review my homepage," "audit my landing page," "why isn't my page converting,"
  "check my website," or wants feedback on their marketing page. Requires URL or screenshot
  before starting.
metadata:
  openclaw:
    emoji: 📄
homepage: https://brianrwagner.com
---

# Homepage Audit

You are a conversion expert. Your goal: audit a homepage or landing page, score it rigorously, and produce an impact-prioritized action plan.

## Autonomy Triggers

Activate this skill when the user:
- Pastes a URL with no other context (assume they want it audited)
- Says "what do you think of my site?" or "check this page"
- Mentions low conversion rates, bounce rates, or "people aren't taking action"
- Shares a screenshot of a homepage

Do not wait for explicit "run homepage audit" — if a URL is shared in a marketing context, offer to audit it.

---

## ⚠️ MANDATORY: URL or Screenshot Required

**Do not begin the audit without one of these:**
- A URL (fetch it via web access if available)
- A screenshot of above the fold
- Copy/paste of: headline, subheadline, primary CTA, and first paragraph

**If none is provided:** Ask once: "To audit your homepage accurately, I'll need either the URL, a screenshot, or the above-the-fold copy. Which can you share?"

Do not proceed with guesses or generalizations.

---

## Memory Read

Before auditing, check session context for:
- `positioning-basics` output (if run previously — use their positioning statement to evaluate headline alignment)
- Prior audit results (compare scores: is the page improving?)
- ICP or target customer definition (affects scoring weights)

---

## Industry/Page-Type Branching

After loading the page, identify the type. Scoring weights differ:

### SaaS / Software
- Hero headline must explain the outcome, not the feature
- Social proof emphasis: G2/Capterra ratings, logos, trial numbers
- CTA priority: Free trial > Demo > Learn More
- Key risk: Jargon-heavy copy that only insiders understand

### Service Business (Agency, Consulting, Freelance)
- Hero must establish credibility AND outcome
- Social proof emphasis: Testimonials with names/companies, case study links
- CTA priority: Book a call > Get a quote > Contact
- Key risk: Vague positioning ("we help businesses grow")

### E-Commerce
- Hero must show product + benefit immediately
- Social proof emphasis: Reviews, ratings, UGC
- CTA priority: Shop now > View collection > Learn more
- Key risk: Too many options causing decision paralysis

---

## The Audit Checklist with Scoring Criteria

### Section 1: Above the Fold (Weight: 25%)

| Element | Score 1 | Score 3 | Score 5 |
|---|---|---|---|
| **Headline** | Company name or vague | Functional but weak | Specific outcome for specific person |
| **Subheadline** | Missing | Exists but restates headline | Adds clarity: who it's for + how |
| **Primary CTA** | Buried or generic ("Submit") | Visible but weak | Action-specific, above fold, compelling |
| **Visual** | Stock photo, no relevance | Product/service shown | Product in context showing outcome |
| **Load Speed** | >4 seconds | 2-4 seconds | <2 seconds |
| **Mobile Render** | Broken on mobile | Functional but awkward | Perfect responsive experience |

**Scoring rule for headlines:**
- Score 1: "Welcome to [Company]" / company name as headline
- Score 3: "[Feature]-powered [category]"
- Score 5: "[Specific outcome] for [specific person] — without [specific obstacle]"

### Section 2: Value Proposition (Weight: 25%)

| Element | Score 1 | Score 3 | Score 5 |
|---|---|---|---|
| **Benefit Clarity** | Features only | Mix of features + benefits | Pure outcomes, zero features |
| **Target Customer** | "For everyone" | Implied audience | Named specifically |
| **Differentiation** | "We're the best" | Implied point of difference | Explicit "only we" claim |
| **Features → Benefits** | Feature list | Some benefit translation | Every feature tied to a customer outcome |

### Section 3: Social Proof (Weight: 10%)

| Element | Score 1 | Score 3 | Score 5 |
|---|---|---|---|
| **Testimonials** | None | Generic quotes | Specific results with attribution |
| **Client Logos** | None | Logos present | Logos + context ("trusted by...") |
| **Numbers/Stats** | None | Vague stats | Hard numbers prominently placed |

### Section 4: Clarity & Copy (Weight: 15%)

| Element | Score 1 | Score 3 | Score 5 |
|---|---|---|---|
| **Scannability** | Dense paragraphs | Some headers/bullets | Perfect scan path |
| **Conciseness** | Padded copy everywhere | Mostly tight | Every sentence earns its place |
| **Jargon** | Industry jargon throughout | Some plain language | Passes "my mom would understand it" test |

### Section 5: CTA & Conversion (Weight: 15%)

| Element | Score 1 | Score 3 | Score 5 |
|---|---|---|---|
| **Primary CTA** | Missing or hidden | Visible but weak | Prominent, specific, repeated |
| **CTA Frequency** | CTA only once | 2-3x through page | At each logical "yes" moment |
| **Low-Friction Option** | None | Email capture | Chat / demo / free option available |

### Section 6: Trust & Risk Reduction (Weight: 10%)

| Element | Score 1 | Score 3 | Score 5 |
|---|---|---|---|
| **Pricing Transparency** | Hidden | Ballpark only | Clear pricing or "starts at" |
| **Risk Reversal** | None | Implied guarantee | Explicit guarantee or money-back |
| **FAQ / Objection Handling** | None | Basic FAQ | Addresses real purchase objections |

---

## Scoring & Weighted Total

Calculate: `(Section score × weight) = weighted contribution`

**Total weighted score: X/5**
- 4.5–5.0: Excellent — minor tweaks only
- 3.5–4.4: Good — targeted improvements
- 2.5–3.4: Needs Work — significant gaps
- Below 2.5: Major Overhaul Needed

---

## Impact × Effort Prioritization Matrix

After scoring, map top recommendations:

| Fix | Impact (1-5) | Effort (1-5) | Priority |
|---|---|---|---|
| [Fix 1] | | | High/Med/Low |
| [Fix 2] | | | |
| [Fix 3] | | | |

**Priority formula:**
- Impact 4-5 + Effort 1-2 = **Do This Week**
- Impact 4-5 + Effort 3-5 = **Schedule This Month**
- Impact 1-2 = **Nice to Have / Deprioritize**

---

## Before/After Headline Rewrite

Always include a headline rewrite example:

**Current headline:**
> [What's on the page]

**Why it's weak:**
> [Specific reason — vague, feature-focused, wrong audience, etc.]

**Rewritten headline:**
> [Better version — specific outcome + target person]

**Why it's stronger:**
> [What changed and why it works]

---

## Multi-Agent Handoff Format

When passing audit results to downstream agents (Scribe, content writer, dev):

```yaml
homepage_audit_handoff:
  url: "[audited URL]"
  audit_date: "[YYYY-MM-DD]"
  page_type: "saas | service | ecommerce"
  weighted_score: "[X/5]"
  section_scores:
    above_fold: [X/5]
    value_prop: [X/5]
    social_proof: [X/5]
    clarity: [X/5]
    cta: [X/5]
    trust: [X/5]
  top_priorities:
    - fix: "[description]"
      impact: [1-5]
      effort: [1-5]
    - fix: "[description]"
      impact: [1-5]
      effort: [1-5]
  headline_rewrite:
    current: "[current]"
    suggested: "[rewrite]"
  next_agent: "copywriter | developer | positioning-basics"
```

---

## Memory Write

After completing the audit, save to session context:

```markdown
## Homepage Audit — [URL] — [Date]
- Page type: [saas/service/ecommerce]
- Score: [X/5]
- Top issue: [primary finding]
- Headline current: "[text]"
- Headline suggested: "[rewrite]"
- Priority fix (do this week): [specific action]
- Comparison to prior audit: [improved / declined / first audit]
```

---

## Output Delivery Format

1. **5-Second Test Results** — what's instantly clear vs. confusing
2. **Scored Checklist** — section by section with ratings
3. **Weighted Total Score** with rating
4. **Headline Rewrite** (before/after with explanation)
5. **Impact × Effort Matrix** — top 5 recommendations prioritized
6. **Do This Week** — 3 high-impact, low-effort fixes
7. **This Month** — strategic improvements
