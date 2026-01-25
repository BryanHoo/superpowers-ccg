# Routing Quick Heuristics (Non-Normative)

This file is a lightweight cheat sheet. It is **not** the routing decision algorithm.

Prefer semantic routing via `superpowers-ccg-coordinating-multi-model-work/routing-decision.md` and invoke the subagents (@backend, @frontend) accordingly.

## High-signal defaults

- UI/components/styles/interactions → **FRONTEND** (@frontend)
- APIs/databases/security/performance/concurrency → **BACKEND** (@backend)
- Full-stack changes or uncertain debugging → **CROSS_VALIDATION** (both @backend and @frontend)
- Simple documentation edits / trivial edits → **CLAUDE**

## Common file hints (examples)

- `**/*.tsx`, `**/*.css` → FRONTEND (@frontend)
- `**/*.go`, `**/*.py`, `**/*.sql`, `**/*.sh` → BACKEND (@backend)
- Mixed set across frontend + backend → CROSS_VALIDATION
- Design docs, implementation docs, requirements specs, architecture docs, and other critical documentation → CROSS_VALIDATION

## Reminder

If you choose `Routing != CLAUDE`, apply `superpowers-ccg-coordinating-multi-model-work/GATE.md` immediately (evidence or BLOCKED).
