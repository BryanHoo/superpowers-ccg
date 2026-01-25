# Subagent Gate (Fail-Closed)

Use this gate whenever a skill decides **Routing != CLAUDE** (BACKEND/FRONTEND/CROSS_VALIDATION).

## Core Rule

- If Routing != CLAUDE, you MUST obtain subagent output via @backend and/or @frontend.
- If you cannot obtain subagent output (timeout, subagent unavailable, permission blocked), you MUST STOP.
- Do NOT provide a final conclusion, final patch, or "best effort" solution without subagent output.

**Early exposure:** If you decide `Routing != CLAUDE`, run the subagent invocation immediately (before doing real work). Do not defer the gate until the end.

## Invocation

Use the templates in `INTEGRATION.md`.

Timeout policy:
- Use the existing timeout configuration in your environment.
- If the first attempt times out, retry at most once after applying your existing timeout escalation procedure.

## Evidence Requirement

Before continuing past a checkpoint (or producing final output), include an Evidence block:

```text
[Subagent Gate]
Routing: BACKEND | FRONTEND | CROSS_VALIDATION
Why: <one sentence>

Evidence:
- Subagent: @backend | @frontend
- Prompt summary: <关键输入要点>
- Result: <3-6 bullets>
- Integration: <采纳/拒绝原因>
```

## Failure Handling (Fail-Closed)

If the subagent call fails:

```text
[Subagent Gate]
Routing: BACKEND | FRONTEND | CROSS_VALIDATION
Status: BLOCKED
Reason: timeout | subagent-unavailable | permission-blocked | other

Next action:
- Provide the exact subagent invocation for the user.
- Ask the user to re-run after fixing the blocker.

Stop here. Do not proceed.
```

## Pre-Output Self-Check (Mandatory)

- If Routing != CLAUDE: do I have Evidence?
- If not: did I stop in BLOCKED state (no final answer)?
