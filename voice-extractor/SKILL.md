---
name: voice-extractor
description: Extract and document someone's authentic writing voice from samples.
  Use when someone needs a "voice guide," wants to capture their writing DNA, or needs
  to train AI to write in their style. Also useful for ghostwriting, brand voice documentation,
  or onboarding writers.
metadata:
  openclaw:
    emoji: 🎙️
homepage: https://brianrwagner.com
---

# Voice Extractor

## Autonomy Triggers

Activate this skill when the user:
- Says "write this in my voice" — but no voice guide exists yet
- Asks for help with ghostwriting or AI-generated content
- Pastes writing samples along with "does this sound like me?"
- Starts a content creation session and no voice profile exists in memory
- Completes `linkedin-authority-builder` — offer to create a voice guide before generating actual posts

Auto-suggest: "Before I write in your voice, let me extract a voice guide. Paste 3 writing samples — emails, posts, Slack messages — and I'll document your communication DNA."

---

## Memory Read

Before starting, check session context for:
- Existing voice profile at `~/.claude/voice-[name].md` — if it exists, load and offer to update, not rebuild
- Previous writing samples from this session
- Any tone preferences mentioned in prior sessions

---

## ⚠️ Sample Quantity Constraint

**If samples are too short or too few:**
- Minimum: 3 samples OR 500 total words
- If less than 500 words received: "These samples are too short to extract reliable voice patterns. Can you add 2-3 more — emails, Slack messages, or transcripts work great. The messier and more casual, the better."
- Do NOT attempt voice extraction from under 500 words — the patterns won't be reliable

**Best sources (in order of authenticity):**
1. Casual Slack or email (highest — raw voice)
2. Podcast or call transcript
3. LinkedIn posts or articles
4. Website copy (lowest — often edited to sound professional, not authentic)

---

## What NOT to Extract (Constraint Handling)

Identify and exclude these false signals:

- **Platform-specific tics** (LinkedIn line breaks, Twitter character-limit hacks)
- **Typos and autocorrect errors** (not voice, just mistakes)
- **Phrases borrowed from others** (quotes, retweets, things attributed to someone else)
- **Unusually formal writing** (legal docs, press releases — not the authentic voice)

Note in the voice guide: "Excluded X from extraction because [reason]."

---

## Quick Mode (`--quick`)

For fast extractions:
1. Read 3 samples
2. Pull 10 signature phrases
3. Note 3 things they'd never say
4. One sentence describing their energy

**Output:** Minimum viable voice guide — better than nothing, but note it's based on limited samples.

**Expected output vs Full mode:**
- Quick: ~15 phrases, 3 anti-patterns, 1-sentence energy description
- Full: Complete profile with confidence calibration, phrase library, and validated sample sentences

---

## Full Mode Extraction Process

### Step 1: Find Core Energy
What role do they naturally play?
- Teacher (breaks things down)
- Challenger (pushes back on assumptions)
- Cheerleader (builds confidence and momentum)
- Straight-shooter (cuts through BS)

What's the default energy?
- Calm authority ("Here's what works")
- High enthusiasm ("This is exciting")
- Understated confidence ("I've seen this a hundred times")

What do they genuinely care about? (Themes that repeat unprompted)

### Step 2: Extract Signature Phrases

**Transition phrases** — How do they shift topics?
**Emphasis phrases** — How do they land a point?
**Closers** — How do they wrap up?

Pull specific examples from the samples for each category.

### Step 3: Map Confidence Zones

| Zone | Markers | Voice Treatment |
|---|---|---|
| Expert | Zero hedging, definitive statements | "Here's what works. Full stop." |
| Experienced | "In my experience...", "What I've found..." | Still confident, just not absolute |
| Learning | "I'm testing this...", "What I'm seeing..." | Curious, exploratory |

**The calibration is what makes the voice feel real** — not every topic gets the same energy.

### Step 4: Document Anti-Patterns

Just as important as what they DO say is what they'd NEVER say.

Identify:
- Words that feel wrong
- Phrases that make them cringe
- Tones they avoid
- Jargon they hate (even industry-standard)

### Step 5: Validation Sentences

Generate 2 sample sentences using the extracted voice profile:
1. One that sounds like them
2. One that doesn't (the "off-brand" version)

Ask: "Does Version A actually sound like you when you're not overthinking it?"

If no: "What specifically feels off? That's where we refine."

---

## Voice Guide Template

```markdown
# [Name]'s Voice Guide

## Who You Are
- Core energy: [cheerleader/challenger/teacher/straight-shooter]
- Natural role: [how you show up]
- What you actually care about: [recurring themes]

## Signature Phrases
### Transitions
[List with examples from actual samples]

### Emphasis
[List with examples]

### Closers
[List with examples]

## Confidence Calibration
### Full authority (no hedging):
[Topics] — voice: [example sentence]

### Earned perspective:
[Topics] — voice: [example sentence]

### Active exploration:
[Topics] — voice: [example sentence]

## What You Never Do
[Words, phrases, tones — sourced from samples]

## Validation Examples
### This sounds like you:
"[Sample sentence in their voice]"

### This doesn't:
"[Same content, wrong voice — contrast is the lesson]"

## Extraction Notes
- Samples used: [number and types]
- Excluded: [any patterns excluded and why]
- Quick mode or full mode: [which]
```

---

## Memory Write

After completing voice extraction, save to file:

**Path:** `~/.claude/voice-[name].md` (or `voice-profiles/[name]-voice.md` in workspace)

Also save to session context:
```markdown
## Voice Profile — [Name] — [Date]
- Core energy: [label]
- Key phrases: [top 5]
- Anti-patterns: [top 3]
- Last updated: [date]
- File path: [path]
```

---

## Multi-Agent Handoff Format

Pass to Scribe or content production agents:

```yaml
voice_profile_handoff:
  name: "[person]"
  energy: "[cheerleader/challenger/teacher/straight-shooter]"
  signature_phrases:
    transitions: ["phrase 1", "phrase 2"]
    emphasis: ["phrase 1", "phrase 2"]
    closers: ["phrase 1"]
  anti_patterns: ["word/phrase to never use"]
  confidence_zones:
    expert: ["topic 1", "topic 2"]
    experienced: ["topic 1"]
    learning: ["topic 1"]
  profile_path: "[file path]"
  samples_count: [number]
  mode: "quick | full"
```
