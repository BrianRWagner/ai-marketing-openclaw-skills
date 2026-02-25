---
name: linkedin-authority-builder
description: Build a LinkedIn content system for thought leadership. Use when someone
  needs to establish authority, attract inbound leads, or build a consistent content
  presence. Run linkedin-profile-optimizer first, then this skill for content strategy.
metadata:
  openclaw:
    emoji: 💼
homepage: https://brianrwagner.com
---

# LinkedIn Authority Builder

## Autonomy Triggers

Activate this skill when the user:
- Says "I need to start posting on LinkedIn" or "how do I grow on LinkedIn"
- Asks for help building a personal brand
- Has completed `positioning-basics` — offer to build a content system around it
- Has completed `linkedin-profile-optimizer` — the natural next step is a content strategy
- Mentions wanting inbound leads, speaking gigs, or partnership opportunities

**Sequencing rule:** If `linkedin-profile-optimizer` hasn't been run yet, suggest running it first:
> "Before we build a content system, let's make sure your profile is optimized to convert the traffic we're about to send it. Want me to run `linkedin-profile-optimizer` first? It takes 10 minutes."

---

## Memory Read

Before starting, check session context for:
- `positioning-basics` output — use ICP, one-liner, and differentiator as content pillar inputs
- `content-idea-generator` outputs — if ideas already exist, build the calendar around them
- Prior LinkedIn strategy docs — compare and update, don't restart
- `voice-extractor` output — apply voice profile to all post structures

---

## Mandatory 5-Question Intake

> 1. **Current positioning:** What's your one-liner? Who do you help and with what outcome?
> 2. **Target audience on LinkedIn:** Specific titles, company stages, or industries you want to reach
> 3. **Posting history:** Have you posted before? What's worked, what hasn't?
> 4. **Content goals:** Leads? Job offers? Speaking gigs? Partnerships? Audience growth?
> 5. **Available time per week:** How many hours can you realistically put into LinkedIn?

The strategy depends on honest answers to #3 and #5. Don't build a 5-post-per-week plan for someone with 2 hours.

---

## Step 1: Nail Your Positioning

Before content, the one-liner must be locked.

**Formula:** `I help [specific audience] with [specific outcome] through [unique approach].`

**Example:** `I help growth-stage founders build marketing systems that scale — combining 15 years of strategy with AI-powered execution.`

If they can't say it in one sentence, content will be unfocused. Use `positioning-basics` output if available.

**LinkedIn headline formula:**
```
[Role] | [What you do for who OR tagline]
```

---

## Step 2: Pick Content Pillars (3-5 Topics)

Every post must fit a pillar. Pillars must pass this test:
- You have genuine expertise (not just interest)
- Your target audience cares about it
- You can produce content on it consistently
- It connects to what you sell or want to be known for

**The ratio:**
- 70% core expertise (builds authority)
- 20% adjacent insights (makes you interesting)
- 10% personal (makes you relatable)

---

## Step 3: Format Mix

| Format | Best For | Engagement |
|---|---|---|
| Story | Connection | High |
| Framework/List | Authority | High |
| Hot take | Reach | Variable |
| Case study | Proof | Medium |
| Behind-the-scenes | Trust | Medium |

**Winning weekly mix:**
- 2-3 frameworks (authority)
- 1-2 stories (connection)
- 1 proof point (credibility)

---

## Step 4: Hook Mastery

The first line determines everything. Make it count.

**Hooks that work:**
> "Most [audience] get [topic] wrong. Here's why:"
> "I spent [X years] learning this the hard way:"
> "[Counterintuitive statement that makes them stop scrolling]"

**Hook principles:** Specific > vague. Numbers add credibility. Tension creates curiosity.

---

## Step 5: Post Templates

### Story Post
```
[Hook — the moment or realization]
[Setup — quick context]
[Tension — what was hard or went wrong]
[Turn — the insight]
[Lesson — the takeaway]
[Question — drives engagement]
```

### Framework Post
```
[Hook — bold claim or problem]
[Why this matters — 1-2 sentences]
[The X-step framework:]
1. [Step + brief explanation]
2. [Step + brief explanation]
3. [Step + brief explanation]
[Key insight]
[CTA or question]
```

### Hot Take
```
[Controversial statement]
[Your reasoning — 2-3 sentences]
[The nuance people miss]
[What to do instead]
[Question to drive comments]
```

---

## Step 6: Content Calendar Output

Always deliver a real calendar with actual dates, not just a schedule template:

| Date | Day | Pillar | Format | Hook (first line) |
|---|---|---|---|---|
| [Date] | Monday | [Pillar] | Framework | "[First line]" |
| [Date] | Wednesday | [Pillar] | Story | "[First line]" |
| [Date] | Friday | [Pillar] | Hot Take | "[First line]" |

Fill in 4 weeks of actual dates. Generic "Monday/Wednesday/Friday" templates are not enough.

---

## Step 7: 30-Day Iteration Loop

After 30 days, review performance:

> "Which posts got the most comments? What pillar did they fall under?
> Which posts got the most impressions? Were they frameworks or stories?
> Which posts led to DMs or profile views?"

**Adjust pillar weights based on data.** If case study posts consistently outperform frameworks, shift the ratio.

---

## Multi-Agent Handoff Format

Pass to `content-idea-generator` or Scribe for ongoing idea generation:

```yaml
linkedin_strategy_handoff:
  one_liner: "[text]"
  headline: "[LinkedIn headline]"
  pillars:
    - name: "[pillar 1]"
      ratio: "30%"
    - name: "[pillar 2]"
      ratio: "25%"
  posting_rhythm: "[X times/week]"
  best_times: "[e.g., Tue/Thu 8am EST]"
  format_mix:
    frameworks: "[X/week]"
    stories: "[X/week]"
    proof_points: "[X/week]"
  calendar_path: "strategy/linkedin-[YYYY-MM-DD].md"
  review_date: "[30 days from now]"
  cross_reference: ["content-idea-generator", "voice-extractor"]
```

---

## Memory Write

Save completed strategy to file and session context:

**File path:** `strategy/linkedin-[YYYY-MM-DD].md`

```markdown
## LinkedIn Strategy — [Date]
- One-liner: "[text]"
- Target audience: "[description]"
- Pillars: [list]
- Rhythm: [X times/week]
- First 5 post hooks: [list]
- Calendar: [link or embedded]
- Review date: [30 days out]
- Goals: [leads / brand / speaking]
```

---

## Cross-References

- Run `linkedin-profile-optimizer` FIRST to ensure profile converts incoming traffic
- Use `content-idea-generator` for ongoing idea generation tied to these pillars
- Use `voice-extractor` to ensure all posts sound like the user, not generic AI
