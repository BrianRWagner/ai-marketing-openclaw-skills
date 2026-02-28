# Van Westendorp Price Sensitivity Meter

Identifies the acceptable price range for your product through 4 survey questions.

## The Four Questions

Ask each respondent:
1. "At what price would you consider [product] so expensive you would NOT consider buying it?" (Too expensive)
2. "At what price would you consider [product] priced so low you would question its quality?" (Too cheap)
3. "At what price would [product] be starting to get expensive, but you'd still consider it?" (Expensive/high side)
4. "At what price would [product] be a bargain — a great buy for the money?" (Cheap/good value)

## How to Analyze

1. Plot cumulative distributions for each question
2. Find intersections:
   - **Point of Marginal Cheapness (PMC):** "Too cheap" crosses "Expensive"
   - **Point of Marginal Expensiveness (PME):** "Too expensive" crosses "Cheap"
   - **Optimal Price Point (OPP):** "Too cheap" crosses "Too expensive"
   - **Indifference Price Point (IDP):** "Expensive" crosses "Cheap"

**Acceptable price range:** PMC to PME  
**Optimal zone:** Between OPP and IDP

## Survey Tips
- Need 100-300 respondents for reliable data
- Segment by persona (different willingness to pay per segment)
- Use realistic product descriptions
- Add purchase intent questions

## Sample Output
```
Price Sensitivity Analysis Results:
─────────────────────────────────
Point of Marginal Cheapness:  $29/mo
Optimal Price Point:          $49/mo
Indifference Price Point:     $59/mo
Point of Marginal Expensiveness: $79/mo

Recommended range: $49-59/mo
Current price: $39/mo (below optimal)
Opportunity: 25-50% price increase without significant demand impact
```

---

# MaxDiff Analysis (Best-Worst Scaling)

Identifies which features customers value most — informs packaging decisions.

## How It Works
1. List 8-15 features
2. Show respondents sets of 4-5 features
3. Ask: "Which is MOST important? Which is LEAST important?"
4. Repeat across multiple sets
5. Statistical analysis produces importance scores

## Using MaxDiff for Packaging

| Utility Score | Packaging Decision |
|---------------|-------------------|
| Top 20% | Include in all tiers (table stakes) |
| 20-50% | Use to differentiate tiers |
| 50-80% | Higher tiers only |
| Bottom 20% | Consider cutting or premium add-on |

---

# Willingness to Pay Surveys

**Gabor-Granger method (recommended):**
"Would you buy [product] at [$X]?" (Yes/No) — vary price across respondents to build demand curve.

**Conjoint analysis (best):**
Show product bundles at different prices. Respondents choose preferred option. Statistical analysis reveals price sensitivity per feature.
