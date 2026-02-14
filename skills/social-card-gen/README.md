# social-card-gen

Generate social-ready copy for X/Twitter, LinkedIn, and Reddit from one source asset.

## Best For

- Product launches
- Blog post distribution
- Feature announcements

## What It Does

- Adapts tone and length by platform
- Keeps core message consistent across channels
- Produces quick publish-ready drafts

## Install

```bash
mkdir -p "$HOME/.codex/skills"
cp -R social-card-gen "$HOME/.codex/skills/social-card-gen"
```

## Use

```bash
npx ai-social README.md --platform twitter
npx ai-social announcement.md --platform all
```

## Requirements

- Node.js 18+
- `OPENAI_API_KEY` configured in your environment
