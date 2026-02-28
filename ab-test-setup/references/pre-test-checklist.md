# Pre-Test Checklists

## Pre-Launch Checklist
- [ ] Hypothesis documented (observation + change + expected outcome + metric)
- [ ] Primary metric defined and tied to hypothesis
- [ ] Secondary metrics selected for context
- [ ] Guardrail metrics defined (what can't get worse)
- [ ] Sample size calculated
- [ ] Test duration estimated
- [ ] Variants implemented correctly
- [ ] Tracking verified on all variants
- [ ] QA completed on all variants
- [ ] Traffic allocation set
- [ ] Stakeholders informed

## During the Test — DO
- Monitor for technical issues
- Check segment quality (bot traffic, etc.)
- Document any external factors (sales, campaigns, seasonality)

## During the Test — DON'T
- Peek at results and stop early
- Make changes to variants mid-test
- Add traffic from new sources
- End early because "you know the answer"

## Analysis Checklist
- [ ] Did you reach sample size?
- [ ] Is it statistically significant? (check p-value + confidence intervals)
- [ ] Is the effect size practically meaningful?
- [ ] Are secondary metrics consistent with primary?
- [ ] Any guardrail concerns?
- [ ] Segment differences? (mobile vs. desktop, new vs. returning)

## Common Mistakes

### Test Design
- Testing too small a change (undetectable)
- Testing too many things (can't isolate)
- No clear hypothesis
- Wrong audience segment

### Execution
- Stopping early
- Changing things mid-test
- Not verifying implementation
- Uneven traffic allocation

### Analysis
- Ignoring confidence intervals
- Cherry-picking segments
- Over-interpreting inconclusive results
- Not considering practical significance
