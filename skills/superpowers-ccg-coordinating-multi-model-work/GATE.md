# Multi-Model Gate (Fail-Closed)

Use this gate whenever a skill decides **Routing != CLAUDE** (CODEX/GEMINI/CROSS_VALIDATION).

## Core Rule

- If Routing != CLAUDE, you MUST obtain external model output via the Codex/Gemini MCP tools (`mcp__codex__codex`, `mcp__gemini__gemini`).
- If you cannot obtain external output (timeout, tool unavailable, permission blocked), you MUST STOP.
- Do NOT provide a final conclusion, final patch, or “best effort” solution without external output.

**Early exposure:** If you decide `Routing != CLAUDE`, run the external invocation immediately (before doing real work). Do not defer the gate until the end.

## Invocation

Use the templates in `INTEGRATION.md`.

Timeout policy:
- Use the existing timeout configuration in your environment (e.g. `CODEX_TIMEOUT`).
- Do NOT invent new timeout constants in the skill.
- If the first attempt times out, retry at most once after applying your existing timeout escalation procedure.

## Evidence Requirement

Before continuing past a checkpoint (or producing final output), include an Evidence block:

```text
[Multi-Model Gate]
Routing: CODEX | GEMINI | CROSS_VALIDATION
Why: <one sentence>

Evidence:
- Tool: mcp__codex__codex | mcp__gemini__gemini
- Params: <key MCP parameters used (PROMPT, cd, SESSION_ID, sandbox, model, etc.)>
- Result: <3-6 bullets of what the external model said>
- Integration: <what you accepted/rejected and why>
```

## Failure Handling (Fail-Closed)

If the external call fails:

```text
[Multi-Model Gate]
Routing: CODEX | GEMINI | CROSS_VALIDATION
Status: BLOCKED
Reason: timeout | tool-unavailable | permission-blocked | other

Next action:
- Provide the exact rerun MCP tool call (tool + params) for the user.
- Ask the user to re-run after fixing the blocker.

Stop here. Do not proceed.
```

## Pre-Output Self-Check (Mandatory)

- If Routing != CLAUDE: do I have Evidence?
- If not: did I stop in BLOCKED state (no final answer)?
