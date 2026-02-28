# Technical SEO Checklist

## Priority Order
1. Crawlability & Indexation (can Google find and index it?)
2. Technical Foundations (fast and functional?)
3. On-Page Optimization (content optimized?)
4. Content Quality (deserves to rank?)
5. Authority & Links (has credibility?)

---

## Crawlability

### Robots.txt
- [ ] No unintentional blocks
- [ ] Important pages allowed
- [ ] Sitemap reference included

### XML Sitemap
- [ ] Exists and accessible
- [ ] Submitted to Search Console
- [ ] Contains only canonical, indexable URLs
- [ ] Updated regularly

### Indexation
- [ ] No noindex tags on important pages
- [ ] Canonicals pointing correct direction
- [ ] No redirect chains/loops
- [ ] No soft 404s

### Canonicalization
- [ ] All pages have canonical tags
- [ ] HTTP → HTTPS consistency
- [ ] www vs. non-www consistent
- [ ] Trailing slash consistent

---

## Core Web Vitals Benchmarks

| Metric | Good | Needs Improvement | Poor |
|--------|------|-------------------|------|
| LCP (Largest Contentful Paint) | < 2.5s | 2.5-4s | > 4s |
| INP (Interaction to Next Paint) | < 200ms | 200-500ms | > 500ms |
| CLS (Cumulative Layout Shift) | < 0.1 | 0.1-0.25 | > 0.25 |

Speed factors: Server response (TTFB), image optimization, JavaScript, caching, CDN, font loading

---

## URL Structure
- [ ] Readable, descriptive URLs
- [ ] Keywords in URLs where natural
- [ ] Consistent structure
- [ ] No unnecessary parameters
- [ ] Lowercase and hyphen-separated

## Mobile
- [ ] Responsive design
- [ ] Same content as desktop
- [ ] Tap targets properly sized

## Security
- [ ] HTTPS across entire site
- [ ] Valid SSL certificate
- [ ] No mixed content

---

## On-Page Checklist

### Title Tags
- [ ] Unique per page
- [ ] Primary keyword near beginning
- [ ] 50-60 characters
- [ ] Compelling for clicks
- Common issues: duplicates, too long, missing

### Meta Descriptions
- [ ] Unique per page
- [ ] 150-160 characters
- [ ] Includes primary keyword
- [ ] Clear value proposition + CTA

### Heading Structure
- [ ] One H1 per page
- [ ] H1 contains primary keyword
- [ ] Logical hierarchy (H1 → H2 → H3)

### Internal Linking
- [ ] Important pages well-linked
- [ ] Descriptive anchor text
- [ ] No broken internal links
- [ ] No orphan pages

### Images
- [ ] Descriptive file names
- [ ] Alt text on all images
- [ ] Compressed file sizes
- [ ] Lazy loading implemented

---

## Tools

**Free:** Google Search Console (essential), PageSpeed Insights, Mobile-Friendly Test, Rich Results Test, Schema Validator

**Paid:** Screaming Frog, Ahrefs/Semrush, Sitebulb, ContentKing
