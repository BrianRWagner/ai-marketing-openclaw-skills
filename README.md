# OpenClaw Marketing Skills

Professional, production-ready OpenClaw skills curated by **Brian Wagner** for modern marketing workflows.

This public repository showcases seven practical skills that accelerate content strategy, audience research, daily execution, and multi-channel distribution.

## What's Included

- `de-ai-ify` - remove AI-sounding language and restore human voice.
- `social-card-gen` - generate platform-aware social posts from source content.
- `youtube-summarizer` - convert YouTube transcripts into structured summaries.
- `newsletter-creation-curation` - build newsletter systems by market, stage, and goal.
- `plan-my-day` - produce an energy-optimized daily action plan.
- `reddit-insights` - semantic Reddit research for pain points and market intelligence.
- `last30days` - rapid trend analysis across Reddit, X, and the web.

## Repository Structure

```text
openclaw-marketing-skills/
  README.md
  skills/
    de-ai-ify/
    social-card-gen/
    youtube-summarizer/
    newsletter-creation-curation/
    plan-my-day/
    reddit-insights/
    last30days/
```

## Install a Skill

1. Clone the repository:

```bash
git clone https://github.com/BrianRWagner/openclaw-marketing-skills.git
cd openclaw-marketing-skills
```

2. Copy one skill into your local OpenClaw/Codex skills directory (example shown for `de-ai-ify`):

```bash
mkdir -p "$HOME/.codex/skills"
cp -R skills/de-ai-ify "$HOME/.codex/skills/de-ai-ify"
```

3. Restart your agent session so the skill is reloaded.

## Install All Skills

```bash
mkdir -p "$HOME/.codex/skills"
cp -R skills/* "$HOME/.codex/skills/"
```

## Skill Index

| Skill | Primary Use Case | Level |
|---|---|---|
| `de-ai-ify` | Humanize AI-generated drafts | Beginner |
| `social-card-gen` | Generate social copy from long-form content | Beginner |
| `youtube-summarizer` | Fast insight extraction from YouTube videos | Intermediate |
| `newsletter-creation-curation` | Build full newsletter motion by GTM context | Advanced |
| `plan-my-day` | Time-blocked execution planning | Beginner |
| `reddit-insights` | Semantic Reddit market/pain-point analysis | Intermediate |
| `last30days` | Multi-source trend research and synthesis | Intermediate |

## Quality Standards

- Clear trigger conditions in each `SKILL.md`.
- Actionable workflows with realistic outputs.
- Reusable in live marketing and research operations.

## License

Provided as-is for educational and operational use. Validate compliance with your organization policies before deploying in production.
