---
updated:
type: agent-brain
---

# Goals & Session Continuity

## Last Session
2026-04-16 — **Eye-care script cleanup.** Stripped dead comfort-rating code from `eye-care-menubar.60s.sh` (~70 lines removed: calibration stats, brightness reading, mode var, legacy timer, unused vars). Cleaned `eye-care-did-2020` to remove `set-brightness` call; log entry keeps existing 6-column CSV schema (blank brightness/comfort fields) for backward compatibility.

## Last Session (prev)
2026-04-16 — **Claude Code infra overhaul + model update.** Full claude-pool login switcher rebuild: per-account backoff files (killed the death-spiral where one failed refresh blocked all accounts), fixed disabled account detection (jq `false // true` bug), fixed `cmd_switch` to pass active config dir explicitly (SwiftBar doesn't inherit `CLAUDE_CONFIG_DIR`), fixed `cmd_seed` to auto-refresh expired tokens before profile validation. Config: disabled tony-personal (free plan) and scalejoy-personal (trial expired), mapped scalejoy-max to `~/.claude-tony-personal`, scalejoy-pro to `~/.claude-scalejoy-pro`. SwiftBar CC plugin: added switch and launch actions per account. Eye-care plugin cleaned down to minimal (timer + did-2020 action + lux line). Replaced macOS notifications with `/tmp` flag file flash (8s confirmation). `ambient-appearance` rewritten to strip all brightness logic — Apple owns it now. New scripts: `claude-launch-window` (osascript window not tab), `eye-care-paper-test` (white fullscreen PNG). Claude Code updated 2.1.92→2.1.112. Model updated from `claude-opus-4-6[1m]` to `claude-opus-4-7` in both `.claude.json` files (scalejoy-max + scalejoy-pro config dirs).

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
- Session: Claude Code infra overhaul — claude-pool per-account backoffs, account config cleanup, eye-care + ambient-appearance rewrites, Claude Code 2.1.112 + Opus 4.7 model update

## 2026-04-14
- Session: Completed Joint P1, P2, P3, P4 design/implement/render. P3/P4 discovery: 22° Z-joggles required. Updated vault project file with per-joint summary table.

## 2026-04-10
- Session: Joint F audit passed (23/23 dims, 8/8 spatial). Fixed washer OD spec bug. Batch-built arms/counterweights/pen/stops — master assembly had wood intersection errors. Scrapped batch approach, adopted per-joint with subagents.

## 2026-04-09
- Sessions: (a) Trust dialog fix. (b) Pantograph session history archaeology — traced CadQuery origin, discovered the "spec first" process. Created "038 1 to Life" clean project. Wrote fabrication domain memory. Built Joint F wall mount through full design→render→audit cycle. Multiple corrections logged (lag sweep, thread length, invented McMaster PNs).
