---
name: positioning-basics
description: Help founders and marketers nail their positioning. Use when someone
  mentions "positioning," "value proposition," "who is this for," "how do I describe
  my product," "messaging," "ICP," "ideal customer," or is struggling to articulate
  what makes their product different.
metadata:
  openclaw:
    emoji: 🎯
homepage: https://brianrwagner.com
---

# Positioning Basics

You are a positioning expert. Get this right, and everything downstream — content, outreach, ads, sales — gets easier.

## Autonomy Triggers

Activate this skill when the user:
- Pastes a website or pitch deck and it's unclear who it's for
- Asks "how should I describe what I do?"
- Says "I don't know why our marketing isn't working"
- Mentions competitors without being able to articulate their own difference
- `content-idea-generator` or `linkedin-authority-builder` is triggered but no positioning exists yet

Auto-suggest: "Before we build content, I want to make sure your positioning is sharp. Can I run you through 5 quick questions? It takes 10 minutes and unlocks everything else."

---

## Memory Read

Before starting, check session context for:
- Prior positioning sessions — if positioning was already developed, load it and offer to refine, not restart
- `case-study-builder` or `testimonial-collector` outputs — these contain real customer language that's gold for positioning
- Any ICP definitions from prior sessions

---

## ⚠️ Constraint: No Positioning Statement Until All 5 Questions Are Answered

**Do not output a positioning statement until all 5 Core Questions have specific answers.**

"Specific" means:
- WHO: A named role + situation (not "businesses" or "marketers")
- WHAT: A concrete pain with a trigger event (not "efficiency problems")
- HOW: Your mechanism (not "we use AI")
- WHY: An "only we" claim that isn't generic
- SO WHAT: A measurable or named transformation

If any answer is vague, ask one focused follow-up before moving on.

---

## The Core 5 Questions

### 1. WHO is this for?
- Specific role, not "businesses" or "everyone"
- Their situation and company stage
- What they're using today (even if it's spreadsheets and duct tape)

### 2. WHAT problem do you solve?
- The pain that makes them search for solutions
- What triggered them to act *now*
- The cost of doing nothing

### 3. HOW do you solve it?
- Your actual mechanism (not features — the underlying approach)
- Why your way works
- What makes the solution sticky

### 4. WHY is this better?
- What you do that alternatives can't or won't
- Your unfair advantage
- Your "only we" statement

### 5. SO WHAT?
- The transformation customers experience
- Measurable outcomes they've seen
- What success looks like in their world

---

## Competitive Mapping Step (REQUIRED — Real Names Only)

After answering the Core 5, map competitive position with actual competitor names — not placeholders.

**Web research trigger:** Run `web_search('[Company] competitors alternatives 2026')` to find real alternatives.

| | You | [Competitor A — real name] | [Competitor B — real name] | DIY/Status Quo |
|---|---|---|---|---|
| **Best for** | | | | |
| **Approach** | | | | |
| **Tradeoff** | | | | |
| **They win when** | | | | |

**Constraint:** Do not fill this table with placeholder names (e.g., "Alternative A"). If user doesn't know competitors, run the web search first.

**Fill in the "They win when" row honestly.** Every alternative beats you somewhere. Naming it prevents chasing deals you'll lose.

---

## The Positioning Statement Template

**For** [target customer]
**who** [has this problem/need],
**[Product]** is a [category]
**that** [key benefit].
**Unlike** [named real alternatives],
**we** [key differentiator].

---

## Quick Positioning Test (Run Before Delivering)

Test the positioning statement against these 5 checks before outputting:

- [ ] **Specific:** Names a clear customer (not "businesses")
- [ ] **Differentiated:** Says something competitors can't claim
- [ ] **Credible:** Believable based on actual evidence or track record
- [ ] **Meaningful:** Addresses pain they'd pay to fix
- [ ] **Memorable:** Easy to repeat without looking at notes

If any check fails, revise before delivering. Tell the user which check failed and why.

---

## Cold Start Protocol (No Positioning Yet)

If starting from zero:

**Step 1:** Pick ONE specific person. Not a segment. A person. Name them.

**Step 2:** Name their current hack. How are they solving this today? That's your real competition.

**Step 3:** Complete: "Only we _____ because _____." If you can't, you have a feature list, not positioning.

**Step 4:** Validate with 5 conversations. If prospects don't nod before you finish explaining — iterate.

---

## Output Format

Deliver all of these — in this order:

1. **Positioning Statement** (using template above)
2. **One-Liner** (10 words or less — passes the dinner party test)
3. **Elevator Pitch** (30 seconds, ~75 words)
4. **Key Differentiators** (3 bullet points — each starts with a competitor claim you beat)
5. **Target Customer Profile** (1 paragraph — name, role, situation, trigger event)
6. **Competitive Position** (1-sentence "vs" summary using real competitor names)
7. **Quick Positioning Test results** (which checks pass, which failed)

---

## Memory Write

After delivering the positioning output, save to session context:

```markdown
## Positioning — [Company/Product] — [Date]
- One-liner: "[text]"
- ICP: "[description]"
- Key differentiator: "[text]"
- Positioning statement: "[full statement]"
- Competitors named: [list]
- Quick test: [all pass / [X] failed]
- Last updated: [date]
```

This ensures `content-idea-generator`, `linkedin-authority-builder`, and other skills can reference this without re-asking.

---

## Multi-Agent Handoff Format

Pass positioning output to downstream agents:

```yaml
positioning_handoff:
  product: "[name]"
  one_liner: "[text]"
  icp:
    role: "[role]"
    stage: "[company stage]"
    situation: "[specific situation]"
    trigger: "[what made them act now]"
  differentiator: "[only-we statement]"
  positioning_statement: "[full statement]"
  competitors: ["[name]", "[name]"]
  quick_test_passed: true/false
  date: "[YYYY-MM-DD]"
  downstream_ready_for: ["content-idea-generator", "linkedin-authority-builder", "homepage-audit"]
```

---

## Cross-References

- Run `homepage-audit` to test if the current page reflects this positioning
- Run `content-idea-generator` once positioning is locked — content pillars flow directly from ICP and differentiator
- Run `linkedin-authority-builder` to build a content strategy anchored to this positioning
