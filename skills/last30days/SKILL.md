---
name: last30days
description: Research any topic across Reddit, X, and web from the last 30 days. Returns patterns, insights, and copy-paste-ready prompts. Use when you need current trends, what's working now, or real-time community sentiment.
---

# /last30days Research Skill

Real-time research engine. Scans Reddit, X, and web for the last 30 days on any topic, finds what the community is actually discussing/upvoting, and synthesizes into actionable insights + prompts.

## When to Use

- Prompt research: "What prompting techniques work for [tool]?"
- Trend discovery: "What's hot in [industry] right now?"
- Product research: "What do people think of [product]?"
- Strategy validation: "What brand marketing strategies are working?"
- Competitive intel: "What are people saying about [competitor]?"

## Workflow

### Step 1: Web Search (freshness=pm for past month)
```
web_search: "[topic] 2026" + freshness=pm
web_search: "[topic] strategies trends"
```

### Step 2: Reddit Search
```
web_search: "[topic] site:reddit.com" + freshness=pm
```
Or use reddit-insights MCP if configured.

### Step 3: X/Twitter Search
```
bird search "[topic]" -n 10
bird search "[topic] 2026 strategy" -n 10
```

### Step 4: Deep Dive (Optional)
Fetch top 2-3 articles for detailed extraction:
```
web_fetch: [top article URL]
```

### Step 5: Synthesize
Create output with:
1. **Top Patterns** — What themes appear 3+ times?
2. **Key Quotes** — Most upvoted/liked insights
3. **Sentiment Summary** — What's the community vibe?
4. **Copy-Paste Prompt** — Ready-to-use prompt incorporating learnings
5. **Action Ideas** — Specific opportunities based on research

## Output Template

```markdown
# /last30days: [TOPIC]
*Research compiled: [DATE]*
*Sources: Reddit, X, Web (last 30 days)*

---

## 🔥 Top Patterns Discovered
### 1. [Pattern Name]
**Mentioned: X times**
[Description + key quote]

### 2. [Pattern Name]
...

## 📊 Reddit Sentiment Summary
| Topic | Sentiment | Key Insight |
|-------|-----------|-------------|

## 🐦 X/Twitter Signal
[Notable voices, emerging themes]

## 🎯 Copy-Paste Prompt
```
[Ready-to-use prompt]
```

## 💡 Action Ideas
[Specific opportunities]

---
*Research complete. X sources analyzed.*
```

## Example Usage

**Query:** /last30days cold email frameworks

**Process:**
1. Search web for "cold email frameworks 2026"
2. Search Reddit for "cold email site:reddit.com"
3. Search X for "cold email strategy"
4. Synthesize patterns + create prompt

**Output:** Patterns on what's working (personalization, brevity, proof), copy-paste cold email prompt.

## Notes

- Best for topics with active online discussion
- Less effective for niche B2B or non-English topics
- Reddit and X provide sentiment; web provides depth
- Always cite sources for credibility
