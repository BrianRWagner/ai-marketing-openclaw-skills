# Content Skill Graph (OpenClaw)

**Use when:** Building or running an AI content agent that needs to produce platform-native posts (not flat copies) by traversing a wikilink graph.

**Scope:** Content system architecture, graph-node creation, voice encoding, AI agent prompting. Not for ads, emails, or landing pages.

---

## What It Is

A wikilink graph your AI agent traverses — not a flat file it reads once. Same topic → different traversal path → genuinely different post.

**Architecture:**
```
index.md → voice/ → platforms/ → engine/ → audience/ → pillars/
```

**Key insight:** Your AI is already a graph traverser. Give it a graph worth traversing.

---

## Setup (5 Steps)

**Step 1 — Create folders**
```bash
mkdir -p your-content-graph/{voice,platforms,engine,audience,pillars}
```

**Step 2 — Build index.md**
- Who you are (2–3 sentences)
- Numbered traversal instructions (1–7 steps)
- Traversal order: `voice → platform → pillar → hooks → structure → output`
- Node map with wikilinks to every file
- Your 7 Voice Checks

**Step 3 — Build voice/brand-voice.md**
Must include:
- Your one-liner positioning anchor
- Your "Most Like Me" example post (non-negotiable — AI learns from patterns)
- Opener rules (how you start posts)
- Your transition phrases
- Your information advantage (what only you know)
- Your core tension (the worldview that drives your content)

**Step 4 — Build platform nodes**

`platforms/linkedin.md`:
- Fundamental format rule (Clear > Clever or your equivalent)
- Paragraph structure (1–2 sentences, white space)
- "See more" break strategy
- Algorithm signals ranked by weight

`platforms/x.md`:
- Character limit rules
- One-sentence discipline
- Thread format rules

**Step 5 — Build engine nodes**

`engine/hooks.md` — 4+ hook formulas with real examples from your own posts

`engine/structures.md` — Hook → Build → Land + your post architecture variants

`engine/repurpose.md` — What changes between platforms (NOT just reformatting)

---

## 7 Voice Checks (Run Before Every Post)

1. **Corey Test** — Does it show the actual system with real numbers? Or just abstraction?
2. **Uniqueness Test** — Could only you write this? At least one specific marker required.
3. **Energy Test** — Does the opening line stop scrolling? Read it out loud.
4. **Real Result Test** — Number, time saved, deal closed, thing that happened?
5. **Proof of Work Test** — Tool named, client mentioned, revenue figure, specific moment?
6. **Specific Reader Test** — One named person in mind while writing?
7. **Landing Test** — Does it close with conviction? Specific question, not "What do you think?"

---

## Agent Prompt Template

```
You are [name]'s content agent.

Before writing:
1. Read index.md — entry point
2. Follow traversal order: voice → platform → pillar → hooks → structure
3. Navigate via wikilinks from index
4. Run all 7 Voice Checks before submitting

Topic: [topic]
Platform: [linkedin/x/both]
Audience tier: [1/2/3]
```

---

## Reference Files

Copy from `references/` folder:
- `index-template.md` — swap bio and nodes
- `brand-voice-template.md` — all required sections
- `linkedin-template.md` — platform node template
- `hooks-template.md` — 6 formula types
- `anti-patterns-template.md` — starter never-say list
- `structures-template.md` — post architecture templates

---

## Done When

- [ ] index.md has numbered traversal instructions + node map + Voice Checks
- [ ] voice/brand-voice.md has a real "Most Like Me" example post
- [ ] Each platform node has algorithm/format rules (not just "be authentic")
- [ ] engine/hooks.md has 4+ formula types with real examples
- [ ] engine/repurpose.md defines what actually changes per platform
- [ ] Test passed: same topic → 3 nodes → 3 genuinely different posts
