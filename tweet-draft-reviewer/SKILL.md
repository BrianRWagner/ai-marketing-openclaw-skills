---
name: tweet-draft-reviewer
description: Review a tweet draft against 8 voice rules. Score 1-10, rule-by-rule breakdown, rewrite if score below 7. Use when user says "review this tweet," "check this draft," "does this tweet sound good," or pastes a tweet for feedback.
---
# Tweet Draft Reviewer

**Version:** 2.0.0  
**Price:** Free  
**Category:** Content  

---

## What It Does

Paste a tweet draft. Get a score out of 10, a rule-by-rule breakdown of what passes and what fails, and a suggested rewrite if the score is below 7. Takes 30 seconds. Saves you from posting something that sounds like a chatbot wrote it.

Built on 8 voice rules distilled from real content analysis — what separates high-engagement tweets from the ones that get skimmed.

Tracks every review in a log. After 5+ reviews, surfaces your most commonly failed rule so you can fix it at the source.

---

## The 8 Rules

| # | Rule | What It Checks |
|---|------|----------------|
| 1 | **No "I" opener** | Tweet must NOT start with the word "I" |
| 2 | **Strong opener** | Opens with emotion, observation, or specific fact — NOT a question |
| 3 | **No AI tells** | No: delve, certainly, game-changing, it's worth noting, invaluable |
| 4 | **No generic closers** | No: "what do you think?" / "drop a comment" / "thoughts?" |
| 5 | **Corey Test** | Specific enough someone could act on it today |
| 6 | **Character count** | Under 280 chars, OR clearly formatted as a thread |
| 7 | **Single point** | One clear idea — not trying to say 3 things at once |
| 8 | **Punchy rhythm** | Short sentences, no run-ons, no preamble |

---

## How to Use It

### Single tweet review
Paste your tweet draft and ask for a review:

```
Review this tweet draft:

[your tweet here]
```

### Batch review (proactive)
To scan your drafts folder for unreviewed files:

```
Review tweet drafts
```

The agent will scan `content/tweet-drafts/` for any `.md` file not containing `reviewed: true` and score each one.

---

## Output Format

```
TWEET REVIEW

Score: X/10

Rule-by-Rule:
1. ✅ / ❌ [rule name] — [reason]
2. ✅ / ❌ [rule name] — [reason]
...

---

Suggested Rewrite: (only if score < 7)

[rewritten tweet]

---

→ Ready to schedule. Use Typefully skill to queue. (if score ≥ 7)
```

---

## Rule Definitions

Apply each rule using these exact criteria:

### Rule 1: No "I" opener
- **Fail:** First word of the tweet is exactly `I` (as a standalone word — not "In", "It", "If")
- **Pass:** Anything else

**Before:** `I've been thinking about how AI agents change ops.`  
**After:** `AI agents changed how we run ops — here's what actually shifted.`

### Rule 2: Strong opener
- **Fail:** First sentence ends with `?` OR starts with "Have you", "Do you", "Are you", "What if", "What would"
- **Pass:** Declarative statement, a specific number/fact, a named scenario, or an emotional setup

**Before:** `Have you ever thought about what async AI workflows could do for your team?`  
**After:** `Our team ships content at 2am. No one's awake. Three agents are.`

### Rule 3: No AI tells
- **Fail:** Contains any of: `delve`, `certainly`, `game-changing`, `game changer`, `it's worth noting`, `invaluable`, `unleash`, `revolutionize`, `transformative`
- **Pass:** None detected

**Before:** `This game-changing approach to AI is truly transformative for founders.`  
**After:** `This approach to AI cuts founder ops time by 60%. Real number. Our client's result.`

### Rule 4: No generic closers
- **Fail:** Contains near the end: `what do you think`, `drop a comment`, `thoughts?`, `let me know in the comments`, `agree?`, `sound familiar?`
- **Pass:** Ends with a statement, directive, punch line, or thread hook

**Before:** `AI agents are changing everything for founders. What do you think?`  
**After:** `AI agents are changing everything for founders. The ones ignoring it are about to find out why.`

### Rule 5: Corey Test
- **Fail:** Uses vague language without specifics — "it changed how I work", "massive results", "so much better" — without numbers, names, or concrete outcomes
- **Pass:** Contains at least one specific: a number, a timeframe, a named tool, a concrete result ("3 posts", "2am", "Scribe agent", "saved 4 hours")

**Before:** `We've seen massive improvements in our content output since using AI agents.`  
**After:** `We went from 2 posts/week to 14 since deploying Scribe. Same team. Zero extra hours.`

### Rule 6: Character count
- **Pass:** 280 characters or fewer (count raw text)
- **Thread pass:** Over 280 chars BUT each section is numbered (1/, 2/, 3/) or separated by clear breaks
- **Fail:** Over 280 chars with no thread formatting

**Before (Fail):** [310-character tweet with no thread markers]  
**After (Pass):** [Same content split into 1/ and 2/ sections]

### Rule 7: Single point
- **Fail:** Makes 3+ distinct unrelated claims with no clear through-line
- **Pass:** One core idea, even if supported by 2-3 details

**Before:** `AI is changing content, ops, hiring, and also I wanted to talk about SEO and the future of marketing.`  
**After:** `AI is changing content ops specifically. One shift: drafting happens overnight now, not during your workday.`

### Rule 8: Punchy rhythm
- **Fail:** Any sentence over 20 words. Preamble like "I've been thinking a lot about..." or "Something I've noticed recently is..."
- **Pass:** Short sentences. No preamble. Gets to the point by line 2 at the latest.

**Before:** `I've been thinking a lot about how the way we approach content creation as founders has fundamentally shifted in the past year.`  
**After:** `Content creation for founders shifted in 2025. AI agents made it happen. Most people haven't caught up yet.`

---

## Scoring

Each of the 8 rules is pass (✅) or fail (❌). Score = passes out of 8, converted to /10:

```
8 passes = 10
7 passes = 9
6 passes = 8
5 passes = 6
4 passes = 5
3 passes = 4
2 passes = 3
1 pass   = 1
0 passes = 0
```

**Score ≥ 7** → Ready to post. Minor notes if any rules are borderline. Output includes: `→ Ready to schedule. Use Typefully skill to queue.`  
**Score < 7** → Provide a suggested rewrite before the draft should be posted.

---

## Review Log

After every review, append to `memory/tweet-review-log.md`:

```markdown
| Date | Draft Preview | Score | Failed Rules |
|------|--------------|-------|-------------|
| 2026-03-01 | "I've been thinking a lot about..." | 4/10 | 1, 2, 3, 8 |
```

**Pattern tracking:** After 5+ entries in the log, read the Failed Rules column and surface the most commonly failed rule:

```
📊 Pattern detected: You've failed Rule 2 (weak opener) in 7 of your last 10 reviews.
Fix: Lead with a specific fact, number, or named scenario instead of a question.
```

The agent surfaces this pattern automatically at the end of each review once 5+ reviews exist.

---

## Proactive Batch Trigger

```yaml
- trigger: "review tweet drafts" | noon scan if content/tweet-drafts/ folder exists
  action: Score all .md files in content/tweet-drafts/ not marked "reviewed: true"
  output: Batch score report — flag anything < 7 for rewrite queue
```

Mark a draft as reviewed by adding `reviewed: true` to its front matter or first line after the agent scores it.

---

## Autonomy Triggers

```yaml
- "review this tweet" | "score this tweet" | "tweet check"
  → Run through all 8 rules, output score + breakdown + rewrite if < 7

- "review tweet drafts"
  → Scan content/tweet-drafts/ for unreviewed files, batch score all

- "rewrite this tweet" | "fix this tweet"
  → Skip scoring, go straight to rewrite

- "quick tweet check [draft]"
  → Score only — the number and top 2 failures

- "tweet patterns" | "what rule do I keep failing"
  → Read memory/tweet-review-log.md, surface top recurring failures
```

---

## Before / After Example 1

### Before (Score: 4/10)

```
I've been thinking a lot about how AI is really changing the way founders 
approach content creation and productivity, and I think it's worth noting 
that the teams who figure out async AI workflows are going to have a 
massive advantage. What do you think about this?
```

**Fails:** Rules 1 (starts with "I"), 2 (slow opener), 3 ("it's worth noting"), 4 ("What do you think"), 5 (no specifics), 8 (run-on sentence)

### After (Score: 10/10)

```
The founders winning right now aren't working harder.

They have agents running at 2am. Content drafted. Research done. 
Queue processed.

By 7am they're reviewing output, not creating it.

Async AI ops is the new early morning routine.
```

**All 8 rules pass.**

---

## Before / After Example 2

### Before (Score: 5/10)

```
Running AI agents overnight changed how I think about productivity. 
The content is done before I wake up. What do you think about async AI workflows?
```

**Fails:** Rule 2 (gerund opener, not a strong hook), Rule 4 ("What do you think"), Rule 5 (vague — "changed how I think"), Rule 8 (setup is slow)

### After (Score: 9/10)

```
Woke up to 3 approved LinkedIn posts this morning. 
Scribe wrote them at 2am. Proof QA'd at 3am. 
I didn't touch them until 7am.

That's what async AI workflows actually look like.
```

**Passes 7/8 rules.** (Rule 1 borderline — "I" appears but not as opener ✅)

---

## Requirements

- No external tools or APIs required — pure LLM reasoning
- Paste the tweet draft directly in chat, OR maintain `content/tweet-drafts/` folder for batch review
- Write access to `memory/tweet-review-log.md` (auto-created)
- Works for single tweets and thread openers

---

*Stop guessing whether your tweet is good. Know before you post — and fix the pattern that keeps tripping you up.*
