---
name: content-idea-generator
description: Generate content ideas rooted in positioning. Use when someone needs
  "content ideas," "what should I post," "blog topics," "LinkedIn ideas," or is stuck
  on what to create. Requires positioning context — run positioning-basics first if
  missing.
metadata:
  openclaw:
    emoji: 💡
homepage: https://brianrwagner.com
---

# Content Idea Generator

## Autonomy Triggers

Activate this skill when the user:
- Says "I don't know what to post" or "I'm running out of content ideas"
- Has just completed `positioning-basics` or `linkedin-authority-builder`
- Mentions a recent win, story, or lesson that hasn't been turned into content yet
- Asks "what should I write about this week?"

**Prerequisite check:** If no positioning statement exists in session context, suggest:
> "Content without positioning is noise. Before generating ideas, can we nail your one-liner? Run `positioning-basics` first — it takes 10 minutes and unlocks better ideas."

If positioning IS available, load it before generating a single idea.

---

## Memory Read

Before starting, load from session context:
- `positioning-basics` output — ICP, differentiator, one-liner (REQUIRED)
- `linkedin-authority-builder` pillars — if a content strategy exists, generate within those pillars
- `voice-extractor` output — ensure ideas match the user's authentic voice
- Recent wins or proof points mentioned in prior sessions

---

## Mandatory Context Intake

Ask these before generating:

> 1. **Positioning statement:** "I help [audience] with [outcome] through [approach]." (Paste it or build it now.)
> 2. **ICP specifics:** What are the top 3 frustrations your ideal customer has this week?
> 3. **Recent wins or proof points:** Any client results, experiments, or lessons from the last 30 days?
> 4. **Content formats available:** Are we generating for LinkedIn? Twitter? Newsletter? Short video? All of the above?

Without these, ideas will be generic. Specific positioning + specific proof points = specific ideas that resonate.

---

## Freshness Check (Tool Call Required)

For each content batch, run a freshness search:

**Trigger:** `web_search('[Topic] trending [current month] [year]')`

Example: `web_search('content marketing trends February 2026')`

Use the results to:
- Identify timely angles on evergreen topics
- Spot what competitors are NOT covering (positioning opportunity)
- Ground at least 1 idea per batch in something current

---

## Content Quality Filter

Every generated idea must pass 3 tests before being delivered:

1. **Specific?** — Does the idea have a concrete angle, or is it generic? ("How to use LinkedIn" → fails. "How to get inbound DMs from framework posts when you have <500 followers" → passes.)
2. **Hook angle?** — Does the idea have an obvious first line that stops the scroll?
3. **ICP pain connection?** — Does the idea address a real frustration of the specific ideal customer?

Flag any idea that fails: "This idea is too generic for your positioning — here's a more specific angle."

---

## Content Frameworks

### 1. The Problem Call-Out
Name the pain your audience won't admit publicly.
**Template:** "The #1 mistake [audience] makes with [topic]"

### 2. The "Here's What Works" Breakdown
Teach a specific process you've actually used.
**Template:** "How to [achieve outcome] without [common obstacle]"

### 3. The Contrarian Take
Challenge something everyone assumes is true. (Only if you genuinely believe it.)
**Template:** "Stop [common advice]. Here's what actually works."

### 4. The Behind-the-Curtain Story
Show the messy reality, not the highlight reel.
**Template:** "I [tried thing]. Here's what actually happened."

### 5. The Pattern Recognition
Connect dots your audience hasn't connected yet.
**Template:** "What [experience A] taught me about [topic B]"

### 6. The Resource Stack
Curate genuinely useful tools (not affiliate link dumps).
**Template:** "[Number] tools I actually use for [outcome]"

---

## Fluff Filter (What NOT to Create)

❌ "Grateful for the journey" posts — nobody cares, show the work
❌ Generic motivational quotes — add your specific take or skip it
❌ "Thought leadership" with no actual thoughts
❌ Engagement bait with no value ("Agree? Comment YES")
❌ Content outside your positioning — stay in your lane

**The test:** Would you engage with this if someone else posted it? No? Don't post it.

---

## Multi-Agent Handoff Format

Pass approved ideas to Scribe or content production agents:

```yaml
content_idea_handoff:
  positioning_used: "[one-liner]"
  icp: "[description]"
  batch_date: "[YYYY-MM-DD]"
  quick_wins:
    - idea: "[title/angle]"
      hook: "[first line]"
      platform: "[LinkedIn/Twitter/Newsletter]"
      framework: "[which template]"
      icp_pain: "[what frustration it addresses]"
      quality_check: "passed"
  authority_builders:
    - idea: "[title/angle]"
      hook: "[first line]"
      platform: "[platform]"
      research_needed: "[yes/no — what to find]"
  freshness_source: "[what web search returned]"
  downstream_agent: "scribe | linkedin-authority-builder"
```

---

## Output Format

Deliver ideas in two batches:

### Quick Wins (Post This Week)
5 ideas ready to create now — low effort, high resonance.

For each:
- **Hook** (first line that stops the scroll)
- **Core insight** (the one thing they should remember)
- **Platform fit** (LinkedIn, Twitter, Newsletter, etc.)
- **ICP pain addressed** (which frustration this speaks to)

### Authority Builders (This Month)
3 ideas that need research or depth — worth the investment.

For each:
- Hook, core insight, platform
- **Research needed** (what to find before writing)
- **Estimated production time**

---

## Memory Write

After delivering ideas, save to session context:

```markdown
## Content Ideas — [Date]
- Positioning used: "[one-liner]"
- Freshness search: "[query + key finding]"
- Quick wins generated: [number]
- Authority builders generated: [number]
- Next idea session: [suggest date — 1-2 weeks out]
```
