## [2.0.1] — February 28, 2026

### What Changed
3-layer architecture refactor across all free skills + new Meeting Prep skill.

### Why
Skills audit (Feb 28) found 8 skills invisible to the trigger system (missing front matter), and the 3 highest-traffic skills bloated at 855–1,127 lines. Context window cost was too high.

### What's New
- **Meeting Prep skill** — pre-call prep brief with participant research, vault context pull, and question generation. Fires before WRS, sales, strategy, and partnership calls.

### Front Matter Fixed (was invisible to trigger system)
- `daily-briefing-builder` — added name + description YAML
- `tweet-draft-reviewer` — added name + description YAML  
- `vault-cleanup-auditor` — added name + description YAML

### Skills Added (new to repo)
- `email-sequence` — trimmed from 1,127 to 107 lines. Sequence templates moved to /references/sequences/
- `social-content` — trimmed from 855 to 121 lines. Platform guides moved to /references/platforms/
- `marketing-ideas` — trimmed from 570 to 104 lines. All 140 ideas moved to /references/ideas-library.md
- `pricing-strategy` — trimmed from 710 to 110 lines. Research methods + tier templates moved to /references/
- `ab-test-setup` — trimmed from 508 to 111 lines. Statistical tables + checklists moved to /references/
- `seo-audit` — trimmed from 384 to 95 lines. Technical checklist + audit template moved to /references/

### Architecture
All skills now follow the 3-layer pattern:
- Layer 1: YAML front matter (trigger label, ~50 tokens)
- Layer 2: Lean SKILL.md (routing, steps, I/O, ~100-150 lines)
- Layer 3: /references/ folder (heavy content only when needed)

---

# Changelog

All notable changes to the AI Marketing Skills for OpenClaw library.

---

## [2.0.0] — February 2026

### What Changed

Major upgrade across 12 skills. Every updated skill was graded against the [OpenClaw Skill Effectiveness Rubric](https://brianrwagner.com) and rebuilt to score 85+/100.

### Added to all upgraded skills

- **Autonomy Triggers** — defined conditions that activate the skill without human prompting
- **Memory Read** — explicit list of what context to load from session/files before starting
- **Memory Write** — what to save after completion, including exact file paths
- **Multi-Agent Handoff** — YAML-structured output block for downstream agents (Scribe, schedulers, etc.) to consume without interpretation

### Skills Upgraded

| Skill | Before | After | Key Changes |
|-------|--------|-------|-------------|
| `marketing-principles` | 52 | 88 | Context intake, decision engine, inversion critique, per-principle templates, memory write |
| `social-card-gen` | 59 | 88 | Platform reasoning inline, intake gate, quality self-review, guardrails, offline fallback |
| `testimonial-collector` | 73 | 89 | 5-question intake, quality scoring, drafting framework, iteration loop, placement guide, handoff to case-study-builder |
| `homepage-audit` | 65 | 89 | Mandatory URL intake, page-type branching, scoring criteria, impact×effort matrix, competitive mode |
| `case-study-builder` | 65 | 89 | Structured intake form, outcome extraction protocol, self-critique pass, distribution plan, handoff to testimonial-collector |
| `positioning-basics` | 67 | 88 | Tool calls for competitive research, memory write, output gate, iteration loop |
| `linkedin-authority-builder` | 68 | 88 | Intake gate, memory write to strategy file, cross-links, content calendar, 30-day review trigger |
| `content-idea-generator` | 68 | 89 | Context intake, freshness web search, quality filter, multi-agent handoff to Scribe |
| `voice-extractor` | 65 | 88 | Constraint handling, failure modes, quick/full mode docs, validation step, memory write |
| `cold-outreach-sequence` | 65 | 88 | Research tool calls, personalization scoring, pipeline tracker, post-breakup re-engagement |
| `newsletter-creation-curation` | 77 | 90 | Execution template, memory write, multi-agent handoff for Scribe |
| `ai-discoverability-audit` | 80 | 90 | Re-audit trigger, baseline comparison, penalty guardrails, memory write with timestamp |

### Skills Unchanged (already 85+)

`go-mode` (93), `de-ai-ify` (91), `last30days` (88), `plan-my-day` (86), `youtube-summarizer` (85), `linkedin-profile-optimizer` (85), `reddit-insights` (84)

---

## [1.0.0] — February 2026

### Initial Release

19 OpenClaw-optimized marketing skills. Forked and optimized from the [Claude Code version](https://github.com/BrianRWagner/ai-marketing-claude-code-skills) with OpenClaw-specific metadata (emoji, homepage, leaner prose).
