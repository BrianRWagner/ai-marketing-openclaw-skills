---
name: testimonial-collector
description: Systematically gather, score, and format client testimonials. Use when
  someone needs social proof, wants to collect feedback, needs to turn happy clients
  into public advocates, or says "I need testimonials," "can you help me ask for a
  review," or "write a testimonial draft."
metadata:
  openclaw:
    emoji: ⭐
homepage: https://brianrwagner.com
---

# Testimonial Collector

## Autonomy Triggers

Activate this skill (without waiting for explicit request) when the user:
- Mentions completing a project or client engagement
- Says a client "loved it" or "was really happy"
- Asks for help with social proof, proposals, or credibility
- Mentions they need content for their website or LinkedIn
- Is preparing for a sales call and needs proof points

Auto-suggest: "Want me to draft a testimonial ask for [client name] while we're on this?"

---

## Memory Read

Before starting, check session context for:
- `testimonial-library.md` — existing collected testimonials
- `client-roster.md` — active and past clients
- `case-study-builder` outputs — can pull quotes from those sessions

If a testimonial library exists, reference it: "You already have 3 testimonials. This new one should cover [gap in industry/format]."

---

## Mandatory 5-Question Intake

Ask these before generating anything:

> 1. **Client name/company and industry?** (For personalization and placement context)
> 2. **Project type and what you delivered?** (What the testimonial should cover)
> 3. **Key results — any numbers?** (Revenue, time saved, leads, growth — get specific)
> 4. **Desired format?** (Short quote / medium paragraph / full case study quote)
> 5. **Urgency?** (Need it this week? Or building a library over time?)

If results are vague (e.g., "things improved"), ask: "Can you name one specific number — even a rough estimate? That's what makes a testimonial credible."

---

## Testimonial Quality Scoring

Before drafting or after receiving a response, score the testimonial 1-5 on each dimension:

| Dimension | 1 | 3 | 5 |
|---|---|---|---|
| **Specificity** | No details at all | Vague references to outcome | Specific metric or named result |
| **Measurability** | "It was great" | "Noticeable improvement" | "40% increase in leads" |
| **Authentic Voice** | Sounds like marketing copy | Slightly stilted | Reads exactly how a person talks |
| **Length** | Too short (no context) | Decent but thin | Enough for all 3 formats |

**Score 4+ on all 4 = ready to use. Score 2 or below on any = needs iteration.**

---

## When to Ask

Timing is everything. These are your windows:

✅ **Right after a win.** They just saw results? Ask now.
✅ **When they thank you unprompted.** That's your cue.
✅ **At project completion.** Natural checkpoint.
✅ **When they renew or extend.** They're voting with their wallet.

The moment of peak happiness is the moment to ask. Don't wait.

---

## The Ask Templates

### Direct Ask
```
Subject: Quick favor (30 seconds)

Hey [Name],

Loved working on [project] with you — especially seeing [specific result].

Would you be open to sharing a quick testimonial I could use on my site?

No pressure. If yes, I can either:
A) Send you 3 questions to answer
B) Write a draft for you to approve/edit

Whatever's easier.
```

### Question Route
```
3 quick questions:
1. What was the situation before we worked together?
2. What changed or improved?
3. Would you recommend this to others? Why?

A few sentences each is perfect. I'll format it.
```

### Draft Route (AI-Assisted)
Use this framework when writing on the client's behalf:
- **Tone rule:** Match how they actually talk (check their emails/Slack for voice cues)
- **Structure:** Before → Transformation → Result → Recommendation
- **Avoid:** Superlatives ("amazing," "incredible") — use specifics instead
- **Avoid:** First-person brag ("Brian is the best") — lead with the client's situation
- **Length target:** 50-75 words for short format, 100-150 for medium

```
Draft template:
"[Client situation before]. [What the engagement involved — 1 sentence]. 
[Specific result with number if possible]. [Would/wouldn't hesitate to recommend — 1 sentence]."
```

---

## Iteration Loop

If the initial testimonial comes back weak (score ≤ 2 on any dimension):

Send this gentle prompt:
```
"Thanks so much — this is great. One small ask: could you add one specific number or outcome? 
Even a rough estimate ('saved us about 5 hours a week') makes it much more compelling for 
other clients who want proof. Total optional, but makes a big difference."
```

If a second ask still yields nothing specific, use Tier 3 proxy language: "noticeable improvement in X."

---

## The 3 Formats

### Short (2-liner) — Homepage, LinkedIn, Proposals
```
"[One punchy outcome sentence]"
— [Name], [Title] at [Company]
```
**Example:**
> "Went from zero LinkedIn presence to 3 inbound leads per week in 6 weeks."
> — Sarah Chen, CEO at TechCo

### Medium (2-3 sentences) — Services Page, Proposals
```
"[Problem sentence]. [What happened sentence]. [Recommendation sentence]."
— [Name], [Title] at [Company]
```

### Long (Full quote) — Case Study Pages, Downloadable PDFs
Combine all 5 deep-dive answers into a flowing narrative in the client's voice.

---

## Placement Guide

| Format | Where to use | Why |
|---|---|---|
| 2-liner (Short) | Homepage hero, LinkedIn featured, proposals | Trust at first glance |
| Medium | Services page, sales decks, email sequences | Overcome objections |
| Long | Dedicated case study page, PDF downloads | Deep proof for late-stage buyers |
| Video | Website, social | Highest trust — face + voice |

**Cross-reference:** After collecting, hand off to `case-study-builder` for full narrative expansion.

---

## Multi-Agent Handoff Format

When passing testimonials downstream (to Scribe, content agents, or case-study-builder):

```yaml
testimonial_handoff:
  client: "[Name / Company]"
  industry: "[Sector]"
  formats:
    short: "[2-liner text]"
    medium: "[Paragraph text]"
    long: "[Full quote text]"
  quality_scores:
    specificity: [1-5]
    measurability: [1-5]
    authentic_voice: [1-5]
    length: [1-5]
  placement_recommended: ["homepage", "proposals", "case-study"]
  permission_granted: true/false
  date_collected: "[YYYY-MM-DD]"
```

---

## Memory Write

After completing this session, append to `testimonial-library.md`:

```markdown
## [Client Name] — [Date]
- Industry: [sector]
- Format: short / medium / long
- Short: "[quote]"
- Quality score: [X/20]
- Placed at: [locations]
- Permission: granted / pending
```

---

## Following Up

Wait 5-7 days. One follow-up only:
```
"Hey [Name], just bumping this — no pressure at all. If timing's bad, totally get it. Let me know either way!"
```

If no response after follow-up: move on. Some people won't, and that's fine.
