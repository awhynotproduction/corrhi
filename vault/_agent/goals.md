---
updated:
type: agent-brain
---

# Goals & Session Continuity

## Last Session
2026-04-16 — **MKV conversion + disk cleanup.** Converted David Byrne Coachella MKV (VP9→H.265 via VideoToolbox) to MP4 for QuickTime playback. Then deep disk cleanup: found ~44 GB duplicates between local and My Passport external drive (drone footage, Coachella videos, Insta360, hat shoots, film photos). Tony copied unsynced folders to external, deleted local copies. Cleared ~10 GB of caches (npm 4.6G, Spotify 1.9G, Playwright 1G, pip 645M, Homebrew 450M, node_modules 1.1G). Also scanned for local-to-local dupes (4.7 GB — aln vital WIP/Assets overlap, COACH ULT in Downloads already in Music, duplicate .venvs). Tony decided those were too small/risky to touch. Total freed: ~35+ GB.

## Pick Up Next Session
- **PRIORITY: Generate consolidated shopping list** — every part, every quantity, organized by vendor, so Tony can order immediately
- Pen mechanism: either give it the full design treatment or document it as "prototype in shop"
- Build CLEAN master assembly from verified joint STEPs
- McMaster part verification (still need login)
- Source wood from Valente Lumber
- Deflection check on 108" arms

## Active Priorities

### User Handles (Claude supports)
- **ORDER PARTS** — exhibition is May 2, shipping time is the bottleneck
- McMaster authentication for real part verification
- Stud finder check at (94.5", 19") before wall mount install
- Wood species decision (hard maple vs Douglas fir)
- Weight aesthetic decision (brass bar vs other)
- David Gersten 1:1 review today

### Claude Handles (User reviews/approves)
- Consolidated shopping list across all BOMs
- Pen mechanism detailed design (if Tony wants it modeled vs shop prototype)
- Master assembly rebuild from verified joints

### Parked


## Future Backlog

---

## 2026-04-16
- Session: JB Coachella MP3 processing
- Session: 1 to Life component-by-component review with Tony. Walked through F, P1, P2, pen system, track. Tony flagged pen mechanism as under-developed. Exhibition crunch — need to order parts ASAP.
- Session: Video downloads — Bilibili (Yukimatsu Coachella) + YouTube (BUNT Coachella), yt-dlp 1080p
- Session: MKV→MP4 conversion (David Byrne Coachella), disk cleanup ~35+ GB freed (duplicates + caches)

## 2026-04-14
- Session: Completed Joint P1, P2, P3, P4 design/implement/render. P3/P4 discovery: 22° Z-joggles required. Updated vault project file with per-joint summary table.

## 2026-04-10
- Session: Joint F audit passed (23/23 dims, 8/8 spatial). Fixed washer OD spec bug. Batch-built arms/counterweights/pen/stops — master assembly had wood intersection errors. Scrapped batch approach, adopted per-joint with subagents.

## 2026-04-09
- Sessions: (a) Trust dialog fix. (b) Pantograph session history archaeology — traced CadQuery origin, discovered the "spec first" process. Created "038 1 to Life" clean project. Wrote fabrication domain memory. Built Joint F wall mount through full design→render→audit cycle. Multiple corrections logged (lag sweep, thread length, invented McMaster PNs).
