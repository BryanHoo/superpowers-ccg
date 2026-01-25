---
name: requesting-code-review
description: "Dispatches code-reviewer subagent to catch issues before they cascade. Use when: completing tasks, implementing major features, before merging, or verifying work meets requirements. Keywords: code review, review request, quality check, PR review"
---

# Requesting Code Review

Dispatch superpowers:code-reviewer subagent to catch issues before they cascade.

**Core principle:** Review early, review often.

## Protocol Threshold (Required)

Follow the [CP Protocol Threshold] injected by hooks:

- Before the first Task call: output a standalone [CP1 Assessment] block (the block itself must not include tool calls; tool calls may follow in the same reply)
- Before requesting review or outputting any review conclusion: output a standalone [CP3 Assessment] block (the block itself must not include tool calls; the request/conclusion may follow in the same reply)

If unmet -> immediately perform the CP assessment, then continue the flow right away; do not stop or interrupt.

## When to Request Review

**Mandatory:**

- After each task in subagent-driven development
- After completing major feature
- Before merge to main

**Optional but valuable:**

- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing complex bug

## How to Request

Hard reminder: before requesting review or outputting any “review conclusion,” you must output a standalone `【CP3 Assessment】` block (fixed format with fields).

**► Checkpoint 3 (Quality Gate):** Before requesting review, apply checkpoint logic from `coordinating-multi-model-work/checkpoints.md`:

- Code changes complete → invoke domain expert for specialized review
- Critical business logic changes → invoke cross-validation for comprehensive assessment

**1. Get git SHAs:**

```bash
BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

**2. Dispatch code-reviewer subagent:**

Use Task tool with superpowers:code-reviewer type, fill template at `code-reviewer.md`

**Note:** Code review requires deep reasoning for quality assessment. Use default Opus model (do not specify `model` parameter) to ensure thorough analysis.

**Placeholders:**

- `{WHAT_WAS_IMPLEMENTED}` - What you just built
- `{PLAN_OR_REQUIREMENTS}` - What it should do
- `{BASE_SHA}` - Starting commit
- `{HEAD_SHA}` - Ending commit
- `{DESCRIPTION}` - Brief summary

**3. Act on feedback:**

- Fix Critical issues immediately
- Fix Important issues before proceeding
- Note Minor issues for later
- Push back if reviewer is wrong (with reasoning)

## Example

```
[Just completed Task 2: Add verification function]

You: Let me request code review before proceeding.

BASE_SHA=$(git log --oneline | grep "Task 1" | head -1 | awk '{print $1}')
HEAD_SHA=$(git rev-parse HEAD)

[Dispatch superpowers:code-reviewer subagent]
  WHAT_WAS_IMPLEMENTED: Verification and repair functions for conversation index
  PLAN_OR_REQUIREMENTS: Task 2 from docs/plans/deployment-plan.md
  BASE_SHA: a7981ec
  HEAD_SHA: 3df7661
  DESCRIPTION: Added verifyIndex() and repairIndex() with 4 issue types

[Subagent returns]:
  Strengths: Clean architecture, real tests
  Issues:
    Important: Missing progress indicators
    Minor: Magic number (100) for reporting interval
  Assessment: Ready to proceed

You: [Fix progress indicators]
[Continue to Task 3]
```

## Integration with Workflows

**Subagent-Driven Development:**

- Review after EACH task
- Catch issues before they compound
- Fix before moving to next task

**Executing Plans:**

- Review after each batch (3 tasks)
- Get feedback, apply, continue

**Ad-Hoc Development:**

- Review before merge
- Review when stuck

## Red Flags

**Never:**

- Skip review because "it's simple"
- Ignore Critical issues
- Proceed with unfixed Important issues
- Argue with valid technical feedback

**If reviewer wrong:**

- Push back with technical reasoning
- Show code/tests that prove it works
- Request clarification

See template at: requesting-code-review/code-reviewer.md

## Multi-Model Code Review

**Related skill:** superpowers:coordinating-multi-model-work

At checkpoint, apply semantic routing from `coordinating-multi-model-work/routing-decision.md`:

- **Routing decision:**
  - Backend changes only (API, database, algorithms) → CODEX
  - Frontend changes only (UI, components, styles) → GEMINI
  - Full-stack changes or architectural impact → CROSS_VALIDATION
  - Simple changes or documentation → CLAUDE subagent

- **Notify user:** "I will use [model] to review these code changes"

- **Call MCP tool** with English prompts (see `coordinating-multi-model-work/INTEGRATION.md` for templates). Use Codex MCP (`mcp__codex__codex`) for backend, Gemini MCP (`mcp__gemini__gemini`) for frontend, and call both in parallel for CROSS_VALIDATION.

**Full checkpoint logic:** See `coordinating-multi-model-work/checkpoints.md`

**Fallback (Fail-Closed):** If external models are not available or time out, STOP and follow `coordinating-multi-model-work/GATE.md` (do not proceed with a final review).
