# Test Design Templates

## Hypothesis Framework

```
Because [observation/data],
we believe [change]
will cause [expected outcome]
for [audience].
We'll know this is true when [metrics].
```

**Example:**
"Because users report difficulty finding the CTA (per heatmaps), we believe making the button larger and using contrasting color will increase CTA clicks by 15%+ for new visitors. We'll measure click-through rate from page view to signup start."

---

## Variant Documentation Template

```
Control (A):
- Screenshot / description of current state

Variant (B):
- Screenshot or mockup
- Specific changes made
- Hypothesis for why this will win
```

---

## Test Plan Document

```
# A/B Test: [Name]

## Hypothesis
[Full hypothesis using framework]

## Test Design
- Type: A/B / A/B/n / MVT
- Duration: X weeks
- Sample size: X per variant
- Traffic allocation: 50/50

## Variants
[Control and variant descriptions with visuals]

## Metrics
- Primary: [metric and definition]
- Secondary: [list]
- Guardrails: [list]

## Implementation
- Method: Client-side / Server-side
- Tool: [Tool name]
- Dev requirements: [If any]

## Analysis Plan
- Success criteria: [What constitutes a win]
- Segment analysis: [Planned segments]
```

---

## Results Documentation Template

```
Test Name: [Name]
Dates: [Start] - [End]

Hypothesis: [Full statement]

Results:
- Sample size: [achieved vs. target]
- Primary metric: [control] vs. [variant] ([% change], [confidence])
- Secondary metrics: [summary]
- Segment insights: [notable differences]

Decision: [Winner/Loser/Inconclusive]
Action: [What we're doing]

Learnings: [What we learned, what to test next]
```

---

## What to Vary

### Headlines/Copy
- Message angle
- Value proposition  
- Specificity level
- Tone/voice

### Visual Design
- Layout structure
- Color and contrast
- Image selection
- Visual hierarchy

### CTA
- Button copy
- Size/prominence
- Placement
- Number of CTAs

### Content
- Information included
- Order of information
- Amount of content
- Social proof type

---

## Metric Examples by Test Type

| Test | Primary | Secondary | Guardrail |
|------|---------|-----------|-----------|
| Homepage CTA | CTA click-through rate | Time to click, scroll depth | Bounce rate, downstream conversion |
| Pricing page | Plan selection rate | Time on page, plan distribution | Support tickets, refund rate |
| Signup flow | Signup completion rate | Field completion, time to complete | Activation rate |

---

## Interpreting Results

| Result | Conclusion |
|--------|------------|
| Significant winner | Implement variant |
| Significant loser | Keep control, learn why |
| No significant difference | Need more traffic or bolder test |
| Mixed signals | Dig deeper by segment |
