# Quality Gate Logic

## Voice Rules Checklist

| Rule | What It Means |
|------|---------------|
| **Never start with "I"** | Lead with observation, hook, or insight |
| **Emotion first** | First line makes someone feel before they think |
| **Real numbers** | Specific data beats vague claims |
| **No AI tells** | Never: "delve into", "unleash", "unlock", "game-changing" |
| **No generic closers** | Don't end with "What do you think?" — end with a punch |
| **Corey Test** | Read it out loud. If a normal human cringes, rewrite it. |

**The Corey Test:** Imagine reading the post to a skeptical friend named Corey. Would he roll his eyes? Feel fake or salesy? If yes — rewrite until it sounds like something you'd say at dinner.

## Proof Scoring — 4 Dimensions

| Dimension | Weight | What's Measured |
|-----------|--------|-----------------|
| Voice match | 30% | Does it sound like the configured voice? |
| Hook strength | 25% | Does line 1 make you stop scrolling? |
| Substance | 25% | Real insight, not just opinions? |
| Closer | 20% | Does it end with punch, not a question? |

## Rejected Draft Format

```markdown
---
PROOF REVIEW — REJECTED
Score: 5/10

Fix instructions:
1. Hook is too generic. Rewrite with a specific story or data point.
2. "leverage the power of" is an AI tell. Cut it.
3. Closer is a question — ends weakly. Replace with declarative statement.

Resubmit after fixes.
---
```

## Approved Draft Format

```markdown
---
PROOF REVIEW — APPROVED
Score: 8/10

Notes:
- Strong hook, punchy opener ✅
- Real numbers in paragraph 2 ✅
- Closer could be sharper but acceptable

**Posted:** ❌
---
```

## Calendar Integration

Content calendar at `bambf/content/4-week-calendar.md` uses Obsidian wikilinks:

```markdown
| Date | Platform | Angle | Status | File |
|------|----------|-------|--------|------|
| Mar 1 | LinkedIn | AI Systems | ✅ Ready | [[content/ready-to-post/linkedin/2026-03-01-ai-systems\|2026-03-01-ai-systems]] |
```

Proof appends wikilinks to the calendar automatically when approving drafts.
