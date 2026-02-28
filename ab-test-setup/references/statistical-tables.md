# Statistical Reference Tables

## Sample Size Quick Reference

| Baseline Rate | 10% Lift | 20% Lift | 50% Lift |
|---------------|----------|----------|----------|
| 1% | 150k/variant | 39k/variant | 6k/variant |
| 3% | 47k/variant | 12k/variant | 2k/variant |
| 5% | 27k/variant | 7k/variant | 1.2k/variant |
| 10% | 12k/variant | 3k/variant | 550/variant |

Assumes: 95% significance, 80% power

## Duration Formula

```
Duration = (Sample size per variant × # variants)
           ──────────────────────────────────────────
           Daily traffic × Conversion rate
```

Minimum: 1-2 business cycles (usually 1-2 weeks)

## Calculators
- Evan Miller: https://www.evanmiller.org/ab-testing/sample-size.html
- Optimizely: https://www.optimizely.com/sample-size-calculator/

---

## Statistical Concepts

**Statistical significance (95% / p < 0.05):**
<5% chance the result is random. Not a guarantee — a threshold.

**Practical significance:**
Is the effect size meaningful for the business? Is it worth implementation cost?

**Confidence intervals:**
The range within which the true effect likely falls. Wide intervals = uncertain result.

**Peeking problem:**
Looking at results before reaching sample size leads to false positives. Solutions:
- Pre-commit to sample size, stick to it
- Use sequential testing if you must peek

---

## Test Type Reference

| Type | When to Use | Traffic Needed |
|------|-------------|----------------|
| A/B (Split) | Single change | 2x sample size |
| A/B/n | Test multiple options | n × sample size |
| MVT | Test interactions | Much higher |
| Split URL | Major page changes | 2x sample size |

---

## Traffic Allocation Options

**50/50 (standard):** Equal split, fastest to significance
**90/10 or 80/20:** Conservative, limits risk — takes longer
**Ramping:** Start small, increase over time — good for technical risk mitigation
