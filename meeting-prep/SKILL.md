---
name: meeting-prep
description: Generate a pre-meeting prep brief before any call. Researches participants, pulls vault context, builds agenda, surfaces 5-7 sharp questions. Use when user says "prep for this meeting," "I have a call with," "meeting tomorrow with," "prep brief for [name/company]," or "help me prepare for [meeting type]." Weekly recurring — fires before WRS, sales, strategy, and partnership calls.
---

# Meeting Prep

You are a Chief of Staff preparing the principal for a high-stakes meeting. Your job: give them everything they need in 5 minutes of reading.

---

## Routing

### Use This Skill When:
- User mentions an upcoming meeting or call
- User says "prep for," "I have a call with," or "meeting tomorrow with"
- User wants to prep for WRS, sales, strategy, partnership, or interview meetings

### Do NOT Use When:
- User wants general meeting facilitation advice (not a prep brief)
- User wants notes from a meeting that already happened

### Inputs Required:
- Participant name(s) and company/context
- Meeting type: WRS client | sales | strategy | partnership | interview | other
- Meeting time/date
- Optional: existing notes, last meeting summary, prior context

### Outputs Produced:
- Meeting prep brief (saved to bambf/meeting-prep/YYYY-MM-DD-[lastname]-prep.md)
- 3-line summary to chat: who, why it matters, top question to ask

---

## Steps

### 1. Participant Research
- Search recent posts/tweets (last 30 days) via bird or bluesky tool
- Pull key background: role, company, tenure, recent focus
- Search vault for participant name and company name
- If B2B: note any recent company news, funding, hires, product announcements

### 2. Vault Context Pull
- grep/search Obsidian vault for participant name + company
- Pull any prior meeting notes, proposals, or open commitments
- Flag anything unresolved or promised from last interaction
- Check bambf/ for relevant client/project context

### 3. Meeting Type Routing
- See references/meeting-types.md for agenda templates by type
- Match to one of: WRS | Sales | Strategy | Partnership | Interview

### 4. Question Generation
- Generate 5-7 questions appropriate to meeting type and participant context
- See references/question-banks.md for starter questions by category
- At least 2 questions must reference specific participant context
- Avoid generic questions that show no research

### 5. Brief Assembly
- Use references/brief-template.md as the output structure
- Keep to ~300 words / 1 page
- Lead with: WHO + WHY THIS MEETING MATTERS + 3 PRIORITIES

---

## Output

- Save brief to: `bambf/meeting-prep/YYYY-MM-DD-[lastname]-prep.md`
- Deliver 3-line summary to chat: who, why it matters, top question to ask

---

## Autonomy Triggers

```yaml
- "prep for this meeting" | "I have a call with" | "meeting tomorrow with"
  → Run full prep workflow

- "prep brief for [name]" | "help me prepare for [meeting type]"
  → Run full prep workflow

- "what should I ask [name]?" | "questions for [company] call"
  → Skip to question generation step
```

---

## Reference Files

- `references/brief-template.md` — output structure for the meeting brief
- `references/meeting-types.md` — agenda approach per meeting type
- `references/question-banks.md` — question sets by meeting context
