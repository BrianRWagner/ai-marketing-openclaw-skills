---
name: de-ai-ify
description: "Remove AI-generated jargon and restore human voice to text. Use when: content sounds robotic, AI detection scores are high, writing feels 'off', text needs to sound more human before publishing. Triggers: 'make this sound human', 'de-AI this', 'remove AI patterns', 'sounds too robotic'. NOT for: fact-checking, fixing bad arguments, or rewriting poorly structured content."
version: 3.0.0
author: theflohart
tags: [writing, editing, voice, content-quality]
---

# De-AI-ify Text

AI-generated text has tells. Not because the grammar is wrong — because the rhythm is wrong. AI writes like a student trying to sound smart. Humans write like people trying to be understood.

The difference between "AI slop" and "sounds human" isn't vocabulary — it's confidence. AI hedges, over-transitions, and front-loads every paragraph with throat-clearing. Humans just say the thing.

---

## Why AI Text Feels Off

Three things give it away every time:

**1. The Cadence Problem**
AI writes in a monotone rhythm. Every sentence is roughly the same length. Every paragraph opens with a transition. Read it aloud and it sounds like a metronome. Human writing breathes — short punchy sentences followed by longer ones that develop the thought. Like this paragraph.

**2. The Confidence Problem**
"It's important to note that arguably, one might consider..." — AI can't commit. It hedges because it was trained to be inoffensive. The fix isn't removing hedge words. It's making actual claims. "This works" is more human than "This could potentially be effective."

**3. The Vocabulary Problem**
Nobody says "leverage" in conversation. Nobody says "utilize" or "facilitate" or "harness the power of." These are resume words — they sound impressive and say nothing. Every one of them has a simpler, more human equivalent.

---

## The Patterns to Kill

### Throat-Clearing (cut entirely)
These add zero information. Delete them and the sentence gets better:
- "It's important to note that..."
- "It's worth mentioning that..."
- "In today's fast-paced world..."
- "Let's dive deep into..."
- "As we all know..."
- "It goes without saying..."

**Before:** "It's important to note that customer retention is more cost-effective than acquisition."
**After:** "Retention is 5x cheaper than acquisition."

### Filler Transitions (replace or cut)
AI leans on these because it can't write natural flow:
- "Moreover" → Cut it. Start the next sentence.
- "Furthermore" → Cut it. Or use "And."
- "Additionally" → "Also" or just start the sentence.
- "Nevertheless" → "But" or "Still"
- "In conclusion" → Just conclude. Don't announce it.

**The test:** Read the paragraph without the transition word. If it still flows, the transition was filler.

### Resume Words (simplify)
| AI Says | Humans Say |
|---------|-----------|
| utilize | use |
| facilitate | help |
| optimize | improve |
| leverage | use |
| implement | do, build, set up |
| comprehensive | full, complete |
| innovative | new (or cut — everything claims innovation) |
| transformative | (usually just cut the whole sentence) |
| synergize | work together |
| ideate | brainstorm |
| myriad | many |
| plethora | lots of, many |

### Structural Tells
- **Rhetorical Q&A:** "What makes a great headline? It's all about..." — AI asks itself questions then answers them. Real writers just make the point.
- **Triple Pattern:** AI loves groups of three. Three examples. Three adjectives. Three bullet points. Vary it. Sometimes two is enough. Sometimes four is better. Patterns aren't wrong — predictable patterns are.
- **Parallel Everything:** "We don't just build products — we build relationships. We don't just write code — we write futures." One parallel is a device. Three in a row is AI.
- **List Announcing:** "Here are the top 5 ways to..." — Just give the list. The reader can see it's 5 things.

---

## What Makes Text Sound Human

**Varied rhythm.** Short sentence. Then a longer one that develops the thought and gives it context. Then short again. Break the metronome.

**Confidence.** Make claims. "This works" not "this could potentially be beneficial." If you're uncertain, say "I'm not sure" — that's also human.

**Specificity.** "Companies using data see better results" → "Spotify's algorithm keeps users 40% longer than competitors." Specifics are inherently more human because AI defaults to vague.

**Contractions.** "It is" → "It's." "They are" → "They're." Unless the formality is intentional (legal docs, academic papers), contractions sound natural.

**First person.** "I've seen" and "In my experience" signal a real person behind the words. Use them where appropriate.

**Imperfection.** Starting sentences with "And" or "But." Using sentence fragments. Occasionally. Like that. Perfect grammar at all times is a tell.

---

## Process

When given text to de-AI-ify:

1. **Score the original** — How many AI tells per 500 words? Quick gut check: does it sound like a person or a language model?
2. **Kill the throat-clearing** — Cut every sentence that adds no information
3. **Simplify the vocabulary** — Resume words → human words
4. **Break the rhythm** — Vary sentence length. Add some short ones. Let some breathe.
5. **Add confidence** — Replace hedging with claims (flag any where the claim might be wrong)
6. **Score the result** — Should score 8+/10 for published content

Output the transformed text with a brief change summary.

---

## Before/After Examples

### Marketing Copy

**Before (score: 3/10):**
> "It's no secret that in today's competitive marketplace, leveraging data-driven insights is crucial for optimizing customer engagement. Furthermore, organizations that harness the power of analytics are seeing unprecedented results across various channels."

**After (score: 9/10):**
> "Companies using customer data see 23% higher revenue. Spotify's algorithm keeps users 40% longer. Netflix saves $1B/year in retention. Data works when you act on it — not when you 'leverage' it."

**What changed:** Cut 2 throat-clearers, replaced 3 resume words, added 3 specific examples, halved the word count.

### Thought Leadership

**Before (score: 3/10):**
> "As we navigate the complexities of the modern workplace, it's crucial to recognize that employee engagement is not merely a nice-to-have — it's a strategic imperative. Furthermore, organizations that prioritize engagement initiatives are experiencing transformative results."

**After (score: 9/10):**
> "Disengaged employees cost $450-550B annually. But 85% of engagement programs fail because they're top-down. The companies that win ask employees what actually matters, then fix those 3 things."

**What changed:** Replaced vague assertion with data, added contrarian insight, used conversational tone ("But here's the thing"), specific number ("3 things").

### Technical Explanation

**Before (score: 4/10):**
> "The implementation of machine learning models facilitates the optimization of complex decision-making processes. Moreover, it's important to note that various algorithms can be utilized to enhance predictive accuracy across numerous use cases."

**After (score: 9/10):**
> "Machine learning helps computers learn from examples. Show it 1,000 labeled images and it learns to spot cats. Show it 10,000 sales calls and it predicts which deals close. More data = better predictions."

**What changed:** Killed 4 resume words, replaced abstract explanation with concrete examples, made it conversational.

---

## Scoring Guide

**0-3: AI Slop** — Multiple cliches, robotic rhythm, hedge words everywhere. Needs full rewrite.
**4-5: AI Heavy** — Some human touches but transitions and vocabulary give it away. Major edits needed.
**6-7: Mixed** — Could be AI or human. Lacks strong voice. Moderate editing.
**8-9: Human-like** — Natural rhythm, confident claims, specific examples. Light polish at most.
**10: Indistinguishable** — Reads like a skilled human writer with a point of view.

**Target:** 8+ for anything published. 7+ for internal docs.

---

## What This Doesn't Fix

- **Bad arguments** — If the logic is wrong, better voice won't save it
- **Missing facts** — De-AI-ify makes text sound human, not accurate. Verify claims separately
- **Structural problems** — If the piece is organized poorly, fix structure first
- **Wrong audience** — Human-sounding text aimed at the wrong reader is still wrong

---

## Quality Checklist

After transformation:
- [ ] Reads naturally when spoken aloud
- [ ] No throat-clearing sentences remain
- [ ] Sentence lengths vary (not all 15-20 words)
- [ ] At least one specific number, name, or example per paragraph
- [ ] Contractions used where natural
- [ ] No more than one "However/Moreover/Furthermore" per 500 words
- [ ] Score is 8+ for published content

---

*De-AI-ify v3.0.0 — Part of the OpenClaw Marketing Skills library*
