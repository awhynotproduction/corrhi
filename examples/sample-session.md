# Sample Session — Annotated

This is what a typical corrhi session looks like. Names and details are fictional.

---

**User types `c` in Terminal.**

**Claude (via /open-session):**
> Overnight: reweave found 3 new connections, vault-health flagged 2 orphan notes.
> Most urgent: the grant application deadline is Friday and the budget section is empty.
> Want to knock out the budget, or something else first?

**User:** yeah let's do the grant budget. also I met someone interesting at the gallery opening last night — remind me to tell you about her

**Claude:**
> Got it. I'll note that for after the budget.
> *[Claude reads projects/grant-application.md, pulls milestones and next actions]*
>
> Here's where we are on the grant: narrative is drafted, timeline is done, budget section is blank. The template requires line items for personnel, materials, travel, and indirect costs. Your materials list from the project file mentions resin, plywood, and projection equipment.
>
> Want me to draft line items from what's in the project file, or do you have specific numbers?

**User:** draft it from the project file, I'll correct the numbers

*[Claude drafts budget, user corrects two line items]*

**Claude:**
> Updated. Total comes to $12,400. The template cap is $15,000 so you have room.
>
> Now — tell me about the person from the gallery opening.

**User:** Met a curator named Mika Sato, she runs a space in the Meatpacking District. We talked about installation art and she's interested in seeing my projector work. Should follow up with her this week.

**Claude:**
> *[Creates proposal in _review/person-mika-sato.md]*
> *[Adds "Follow up with Mika Sato about projector work" to projects/grant-application.md next actions — since the grant project involves projection]*
>
> Created a people note for Mika and linked the follow-up to your grant project since there's overlap. Anything else from the opening?

---

**Key things to notice:**
1. Claude matched the user's opening to goals.md (knew about the grant deadline)
2. The gallery person triggered CRM behavior automatically (rule #9)
3. Claude connected Mika to the grant project — cross-project visibility
4. Budget draft was from existing vault content, not invented
5. The session feels like working with a sharp chief of staff, not a chatbot
