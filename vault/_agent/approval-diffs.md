---
type: agent-brain
purpose: Raw correction log — input to /tune-claude synthesis
---

# Approval Diffs

When the user corrects Claude's approach or edits a proposal, log the correction here. Format:

```
### YYYY-MM-DD — Brief description
- What Claude did:
- What the user wanted:
- Pattern:
```

---

### 2026-04-14 — Skipped per-joint audit subagent for P2/P3/P4 (efficiency trade-off)
- What Claude did: After the full design→implement→render→audit cycle worked well for F and P1, Claude reduced the audit step for P3, P4, and P2 to a quick visual check of the iso_topfront render instead of spawning a fresh audit subagent. This was an explicit speed-vs-thoroughness trade-off.
- What the user wanted: Tony said "continue autonomously through everything" — implicit authorization to batch. The visual checks all passed (arms in separate Z planes, no intersections visible). But the full subagent audit on Joint F caught a real spec bug (washer OD vs counterbore) that a visual check would miss.
- Pattern: The per-joint audit subagent is valuable for catching spec-internal inconsistencies (dimension mismatches between parts list and fabrication steps). Quick visual checks only catch gross geometry errors (intersections, wrong orientation). For production-quality work, run the full audit. For iterative drafts, the visual check is acceptable but mark the joint as "visually verified, not fully audited."

### 2026-04-16 — MP3 tagging: overwrote featured artist metadata
- What Claude did: Set `artist=Justin Bieber` on all 31 tracks, overwriting any existing featured artist credits in the original MP3 metadata. The originals were already deleted by the time Tony noticed.
- What the user wanted: Preserve collaborating artist info. Tracks with live guest appearances (STAY/Kid LAROI, DEVOTION/Dijon, I THINK YOU'RE SPECIAL/Tems, Essence/Wizkid+Tems, DAISIES/Mk.gee) should have had those artists in the metadata.
- Pattern: When batch-modifying media metadata, READ existing tags first and preserve fields you're not intentionally changing. Don't blindly overwrite — merge. Especially for `artist` fields, check if there are featured/collaborating artists before flattening to a single name.

### 2026-04-09 — No corrections (trust dialog fix session)

### 2026-04-09 — Wall mount design: missed lag bolt sweep clearance
- What Claude did: Drafted wall mount build plan with 4 lag bolts at the corners of a 6x6 plate, did not consider that the rotating arm (2" wide, swinging around the center pivot) would sweep directly over those lag bolt heads at every angle.
- What the user wanted: Catch this BEFORE presenting the plan. Tony asked "did you think through the z clearance for the arm rotation over the bolts in the plate?"
- Pattern: When designing any component with moving parts, MUST trace every moving part through its full range of motion and check interference with every static part — including fasteners, hardware, and mounting features. Static clearance checks alone are insufficient. Added as Step 0 to fabrication domain memory.

### 2026-04-09 — Wall mount design: thread length vs plate thickness mismatch
- What Claude did: Spec'd plate center hole at 3/8" (matching shoulder bolt diameter), assumed thread would pass through plate to a recessed nut. Did not check that the bolt's threaded section (0.375") is shorter than the plate thickness (0.75"). Found error during CadQuery verification, not during spec writing.
- What the user wanted: Verify the actual hardware geometry against the structure it passes through, before writing the spec.
- Pattern: For any fastener passing through a structural member, verify thread length ≥ member thickness + nut engagement (typically 1.5x diameter of thread). Don't assume — check the spec sheet. The fix here was enlarging the center hole to 13/32" so the shoulder passes through the plate and the thread engages the nut on the back side directly.

### 2026-04-10 — Joint F audit caught lag washer OD vs counterbore Ø inconsistency
- What Claude did: In joint-F-build-plan.md, specced lag washer OD = 0.688" and lag counterbore Ø = 0.625". The washer cannot fit inside the counterbore.
- What the user wanted: Internal spec cross-checks — every dimension in the parts list must be compatible with every dimension in the fabrication instructions. Write the parts list and the hole/cavity dimensions TOGETHER, don't leave them for a later verification pass.
- Pattern: For any counterbore/recess/cavity that holds another part, verify: cavity diameter > part diameter, cavity depth ≥ part height (plus any required clearance). Make a small table cross-checking every "part goes in cavity" relationship before declaring the spec done. Fixed by switching to 5/16" narrow SAE washer at 0.600" OD.

### 2026-04-10 — Arms build: wood-to-wood collision at bar-end joints (P1, P2) + anchor junction broken
- What Claude did: Batch-produced 6 build plans and 6 CadQuery scripts in one session without visually verifying the output in Fusion between components. Master assembly STEP had: (a) wood-to-wood collision at P1 and P2 (both arms' wood extending to the pivot in the same Z plane), (b) anchor/F joint with arms appearing to pass through the plate and multiple arm bodies visually overlapping, (c) no per-joint spec — just a table with joint positions.
- What the user wanted: One joint at a time. Each joint gets its own full build plan (not a row in a table). Each plan includes a cross-section showing exactly which parts occupy which Z positions, the force path through the joint, and how the parts physically fit together without intersecting. Every plan is verified against the others and against the CadQuery output BEFORE moving to the next component.
- Pattern: (1) Never batch-produce build plans without visual verification between them. The verification step is mandatory and non-skippable. (2) Write one document per joint (F, P1, P2, P3, P4), not a single "arms" document. Each joint has distinct topology: bar-end-to-bar-end (P1, P2) requires one arm's wood to stop short; pass-through (P3, P4) requires bent fork plates bridging Z planes. These are not interchangeable. (3) When a 3D assembly shows intersecting bodies, that's a real spec error, not a rendering artifact. STOP and fix the spec before continuing. (4) Speed vs correctness: batching 6 components in one session saved minutes but produced a master assembly that Tony had to audit. Better to produce one verified component than six broken ones.

### 2026-04-09 — Wall mount BOM: invented McMaster part numbers
- What Claude did: Listed McMaster part numbers in the wall mount build plans (97345A531 shoulder bolt, 92137A616 lag screw, 97431A310 E-clip, etc.) without verifying any of them. The vendor-mcmaster/ directory in the project already had real downloaded STEP files (90298A628 shoulder screw, 92351A636 wood screw, etc.) that I should have referenced first. The PNs I cited didn't match what was actually on disk.
- What the user wanted: Research real McMaster parts FIRST. Download STEP files into vendor-mcmaster/. Use the verified part geometry as input to the spec. Then the CadQuery model uses the real STEP files, which lets the model serve as a SPATIAL verification of the spec (does the real part actually fit?).
- Pattern: vendor-mcmaster/ is a real, expandable resource — not a closed set. Whenever a build plan needs a real fastener: (1) check what's already in vendor-mcmaster/, (2) if not there, download the real STEP for the chosen part and add it, (3) use the actual dimensions from the part (not from memory), (4) use the real STEP in the CadQuery model so spatial fit is automatically verified. The 3D model becomes part of the validation loop, not just a visualization.
