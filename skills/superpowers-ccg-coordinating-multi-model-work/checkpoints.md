# Collaboration Checkpoints

## Overview

Checkpoints are used at key stages to decide whether external models are needed, and to enforce a unified evidence protocol (Evidence / BLOCKED).

## Checkpoints

### CP1: Task Analysis (Before starting)

Goal: decide whether external models are needed.

- Collect: task goals, involved files, tech stack, risks/uncertainty
- Use: semantic routing via `coordinating-multi-model-work/routing-decision.md`

**Early exposure:** once you decide `Routing != CLAUDE`, immediately execute `GATE.md` (use MCP tools to obtain Evidence or output BLOCKED). Do not write plans or code first.

### CP2: Mid-Review (Key decision point)

Triggered by:

- Branching approaches (2+ viable paths with different costs/risks)
- Debugging uncertainty (root cause unclear, conflicting evidence)
- Security/performance/data consistency concerns

Action: prefer `CROSS_VALIDATION`, and follow early exposure + evidence.

### CP3: Quality Gate (Before output)

Goal: perform a final Codex/Gemini review before "final output/final conclusion/claiming tests passed/requesting code review".

- If `Routing != CLAUDE`: Evidence required
- External failure: must BLOCKED (fail-closed)

## User Override

Users can explicitly override routing:

- "Use Codex" / "Use Gemini" / "Cross-validate" → force corresponding Routing
- "Do not use external models" → force `Routing = CLAUDE`
