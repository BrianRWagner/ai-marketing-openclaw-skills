# Content Skill Graph

**Use when:** You want an AI content agent (Scribe, Claude, any LLM) to produce platform-native posts — not flat copies of the same idea — by traversing a wikilink graph instead of reading disconnected flat files.

**Scope:** Content system architecture, graph-node creation, voice/platform encoding, AI agent prompting for content output. Does NOT cover ad copy, email sequences, or landing pages (separate skills for those).

---

## The Problem With Flat Files

Most people hand their AI a single brand voice document and say "write like me."

The result: every post sounds like a remix of the same brief. LinkedIn post = X post with line breaks removed. Five attempts at the same topic = five versions of the same idea with synonyms swapped.

The document isn't wrong. The architecture is.

A flat file is read once. A graph is *traversed* — voice node, platform node, pillar node, engine node. Every traversal path produces a different output. Same topic, five platforms, five genuinely different posts.

**Your AI is already a graph traverser. The question is whether you gave it a graph worth traversing.**

---

## What This Skill Delivers

A complete, copy-paste-ready **Content Skill Graph** — 11 interconnected markdown nodes linked with wikilinks — that any AI content agent reads in a structured traversal order instead of a single flat document.

**What's included:**
- `index.md` — the entry point with traversal instructions and 7 Voice Checks
- 3 Voice nodes (brand-voice, anti-patterns, tone-calibration)
- 2 Platform nodes (linkedin, x)
- 3 Engine nodes (hooks, structures, repurpose)
- 2 Audience nodes (primary, segments)
- Pillar nodes (4 content pillars with angles, hooks, proof types)

**Result:** Same topic → 5 genuinely different posts. Each one native to its platform.

---

## The Architecture

```
index.md (entry point)
    │
    ├── voice/
    │   ├── brand-voice.md      ← Rules, openers, transitions, identity anchors
    │   ├── anti-patterns.md    ← Never-say list (AI tells, corporate-speak)
    │   └── tone-calibration.md ← Tone shifts per audience tier
    │
    ├── platforms/
    │   ├── linkedin.md         ← Format, algorithm, dwell time, Clear > Clever
    │   └── x.md                ← One-sentence discipline, thread format, character limits
    │
    ├── engine/
    │   ├── hooks.md            ← 6 proven hook formulas with examples
    │   ├── structures.md       ← Hook → Build → Land, story arc, proof structure
    │   └── repurpose.md        ← Platform-native remix rules (not copy-paste)
    │
    └── audience/
        ├── primary.md          ← CMOs, VPs — what they need to see fast
        └── segments.md         ← Tier 1 / 2 / 3 breakdown with voice adjustments
```

**Traversal order (hardcoded in index.md):**
`voice → platform → pillar → hooks → structure → output`

---

## Setup: Build Your Own Graph (5 Steps)

### Step 1 — Create the folder structure

```bash
mkdir -p your-content-graph/{voice,platforms,engine,audience,pillars}
```

### Step 2 — Build your index.md

The index is the entry point your AI reads first. It must contain:
- One-paragraph bio of who you are and what this system does
- Numbered traversal instructions (which nodes to read, in what order)
- The traversal order: `voice → platform → pillar → hooks → structure → output`
- A node map with wikilinks to every file
- Your voice QA checks (adapt the 7 Voice Checks below)

**Template:**
```markdown
# [Your Name] Content Skill Graph — Index

## Who [You Are] + What This System Does
[2–3 sentences: your experience, your positioning, what makes your content different]

## Execution Instructions
When given a topic or post brief:
1. Read [[voice/brand-voice]] — non-negotiable foundation
2. Read [[voice/anti-patterns]] — know what never to say
3. Check [[platforms/linkedin]] or [[platforms/x]] for platform rules
4. Find the right pillar in [[pillars/index]]
5. Apply [[engine/hooks]] for the opening line
6. Use [[engine/structures]] for post architecture
7. Run the Voice Checks before submitting

## Node Map
[Table of all nodes with wikilinks and 1-sentence descriptions]

## Voice Checks
[Your QA system — see the 7 Voice Checks below]
```

### Step 3 — Build your voice node

`voice/brand-voice.md` is the most important file in the graph. Include:

| Section | What to include |
|---------|-----------------|
| One-Liner | Your positioning anchor — the sentence that defines your content lens |
| "Most Like Me" Template | One real post you've written that represents your best voice |
| Opener Rules | How you start posts (emotion first? mid-scene? specific formats?) |
| Transition Phrases | Your actual language for moving between ideas |
| Information Advantage | What you uniquely know that nobody else can copy |
| Core Tension | The fundamental tension that drives your content worldview |

**Critical:** The "Most Like Me" template is non-negotiable. The AI learns from patterns faster than rules. Give it your best example.

### Step 4 — Build your platform nodes

Each platform node encodes rules the AI cannot guess from your voice file:

**linkedin.md must include:**
- The fundamental formatting rule (Clear > Clever vs other approaches)
- Paragraph structure (1–2 sentences, white space)
- The "see more" break strategy
- Algorithm signals ranked by weight
- Content types that outperform for your audience

**x.md must include:**
- Character limit rules
- One-sentence discipline
- Thread format (when to use, how to break)
- What works vs what falls flat for your voice

### Step 5 — Build your engine nodes

**hooks.md:** Your proven opening line formulas. Don't invent — pull from posts that actually worked. Group them by type (outcome-first, contrarian, story-open, data, question-as-tension). Include platform calibration table.

**structures.md:** Your post architectures. Hook → Build → Land is universal. Document the variations that work for your content types.

**repurpose.md:** Your rules for platform-native remix — NOT copy-paste. What changes between LinkedIn and X isn't just formatting; it's voice level, depth, and call-to-action.

---

## The 7 Voice Checks (QA System)

*Run these before submitting any post. Adapt to your own specificity markers.*

### 1. Corey Test
Does it show the ACTUAL system — not the concept? Could someone copy this today? Real numbers, step-by-step action? If it's all abstraction, it fails.
→ Reference bar: Corey Ganim's thread showing 50–70 hours/month saved at $15–20/month — that's the specificity level required.

### 2. Uniqueness Test (formerly Brian Test)
Is this something ONLY YOU could write? If any person in your niche could swap in their name and it still works — it's not sharp enough.
→ Specificity markers: your company, your client, your revenue number, your exact tool stack, your industry. At least one per post.

### 3. Energy Test
Does the opening line create forward motion? Does it make someone stop scrolling?
→ Test: read the first sentence out loud. If it sounds like a meeting invite, rewrite it. Best openers are mid-emotion, mid-scene, or mid-tension — never context-setting.

### 4. Real Result Test
Is there a real result in this post? A number, a time saved, a deal closed, a thing that happened?
→ "I leveraged AI synergistically" fails. "My agents finished 3 deliverables while I slept" passes.

### 5. Proof of Work Test
Does this include lived context? Not just an opinion — a moment, a tool named, a client mentioned, a revenue figure, a specific hour of day.
→ Proof of work separates you from the AI-content noise.

### 6. Specific Reader Test
Is there ONE specific person in mind while writing? Name them internally before starting: "I'm writing this for a CMO at a 200-person company who's afraid their team is falling behind."
→ Vague audiences produce vague posts.

### 7. Landing Test
Does it land? Does the post close with conviction — a statement or specific question?
→ "What do you think?" fails. "Which of these have you actually tried?" passes. Never end mid-air.

---

## Example Output: Flat File vs Graph Traversal

**Topic:** AI tools and content marketing

---

### Flat File Output (what most people get)
```
AI is transforming content marketing in incredible ways. 
Here are 5 ways you can leverage AI for your content strategy:

1. Use AI for content ideas
2. Use AI for writing first drafts  
3. Use AI for SEO optimization
4. Use AI for social media posts
5. Use AI for email campaigns

The key is to use AI as a tool, not a replacement for creativity.
What strategies are you using? Let me know in the comments!
```

**What went wrong:** Generic opener. No specificity. No proof. No platform format. Ends with "let me know in the comments." Could have been written by anyone. Will resonate with no one.

---

### Graph Traversal Output (same topic, LinkedIn, Outcome-First hook, Tier 1 audience)
```
Two marketing teams. Same AI stack.

One is producing the same content faster.
The other just eliminated three agencies.

The difference isn't the tools.

Team 1 gave AI a single brief and said "write like us." 
Team 2 built a connected system: voice rules, platform rules, 
audience profiles, hook formulas — all linked.

AI doesn't know what platform-native means.
It knows what you told it to mean.

The teams winning right now aren't the ones with better prompts.
They're the ones who built a graph worth traversing.

Which team are you building?
```

**What changed:** Parable open (from engine/hooks — Parable model). LinkedIn format (from platforms/linkedin — 1-2 sentences per paragraph, white space). CMO audience language (from audience/primary). Ends with a specific, easy-to-answer question. Zero AI tells.

---

### Graph Traversal Output (same topic, X, Contrarian hook, standalone tweet)
```
Most marketers are using AI to go faster.

A small group is using it to go somewhere different.

The first group is efficient.
The second group is building a moat.
```

**What changed:** One-sentence discipline (from platforms/x). Contrarian formula (from engine/hooks). Parable compressed to tweet format (from engine/repurpose). No call to action needed — the tension is the point.

---

## Meta-Insight

These are not three different AI outputs from the same prompt. They're three traversal paths through the same graph — each path activating different rules, different formats, different audience calibrations.

The graph is what makes them different.

**Your AI is already a graph traverser. The question is whether you gave it a graph worth traversing.**

---

## Prompting Your AI Agent

Once your graph is built, give your agent this prompt structure:

```
You are [name]'s content agent. Before writing anything:

1. Read [index.md] first — this is your entry point
2. Follow the traversal order: voice → platform → pillar → hooks → structure
3. Use the wikilinks in the index to navigate to each node
4. Run all Voice Checks before submitting
5. Do not skip any node — every node shapes the output

Topic: [topic]
Platform: [linkedin/x/both]
Pillar: [which pillar if known]
Audience tier: [1/2/3 if known]
```

---

## Quality Checklist (Self-Assess Before Publishing)

- [ ] index.md has numbered traversal instructions
- [ ] voice/brand-voice.md includes a real "Most Like Me" example post
- [ ] voice/anti-patterns.md includes at least 10 specific phrases to never use
- [ ] Each platform node has algorithm/format rules, not just "be authentic"
- [ ] engine/hooks.md includes 4+ formula types with real examples
- [ ] engine/repurpose.md defines what changes per platform (not just reformatting)
- [ ] Voice Checks adapted to your specificity markers (not Brian's)
- [ ] AI agent given explicit traversal instructions pointing to index.md
- [ ] Test: same topic → 3 nodes → 3 genuinely different posts

---

## Files Included in This Skill

| File | Purpose |
|------|---------|
| `references/index-template.md` | Copy-paste index.md template — swap your bio and nodes |
| `references/brand-voice-template.md` | Voice node template with all required sections |
| `references/linkedin-template.md` | LinkedIn platform node template |
| `references/hooks-template.md` | Hooks node template with 6 formula types |
| `references/anti-patterns-template.md` | Anti-patterns node starter list |
| `references/structures-template.md` | Post structures node template |

---

## Frameworks Hardcoded in This Skill

- **Corey Ganim Model** — outcome-first hook formula (proof-of-work content)
- **Clear > Clever** — LinkedIn's fundamental formatting rule
- **Hook → Build → Land** — universal post architecture
- **Tier 1 / 2 / 3 Audience Model** — voice calibration by audience sophistication
- **7 Voice Checks** — QA system for consistency across posts
- **Platform-Native Remix** — LinkedIn vs X as different outputs, not reformats

---

## Decision Logic

**When to use a contrarian hook:** Strong opinion + proof to back it. Don't use contrarian when you're speculating.

**When to use outcome-first:** You have a real result. A number. A thing that happened. If you don't have proof, use story-open instead.

**When to skip repurposing:** When the idea is inherently LinkedIn-native (long proof posts, executive stories). X gets different ideas, not compressed versions of LinkedIn posts.

**When a post fails the Voice Checks:** Rewrite — don't publish and revise. Failed checks = failed post.

---

## Maintenance

- Add new hook examples as you find posts that work
- Update voice/anti-patterns.md whenever you catch an AI tell that slipped through
- Version your index.md after major traversal order changes
- Review platform nodes quarterly — algorithm rules change

---

*Skill version 1.0 | Built by Forge | 2026-03-17*
*"Your AI is already a graph traverser. The question is whether you gave it a graph worth traversing."*
