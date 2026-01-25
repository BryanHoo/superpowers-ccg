---
name: verifying-before-completion
description: "Requires running verification commands and confirming output before making success claims. Use when: about to claim work is complete, fixed, or passing, before committing or creating PRs. Keywords: verify, evidence, completion check, test output, proof"
---

# Verification Before Completion

## Overview

Claiming work is complete without verification is dishonesty, not efficiency.

**Core principle:** Evidence before claims, always.

**Violating the letter of this rule is violating the spirit of this rule.**

## The Iron Law

```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```

If you haven't run the verification command in this message, you cannot claim it passes.

## Protocol Threshold (Required)

Follow the [CP Protocol Threshold] injected by hooks:

- Before the first Task call: output a standalone [CP1 Assessment] block (the block itself must not include tool calls; tool calls may follow in the same reply)
- Before claiming verification passed / completion / ready to commit or open a PR: output a standalone [CP3 Assessment] block (the block itself must not include tool calls; the claim may follow in the same reply)

If unmet -> immediately perform the CP assessment, then continue the flow right away; do not stop or interrupt.

## The Gate Function

Hard reminder: before claiming “verification passed/completed/fixed” or any similar conclusion, you must output a standalone `【CP3 Assessment】` block (fixed format with fields).

**► Checkpoint 3 (Quality Gate):** Before claiming completion, apply checkpoint logic from `coordinating-multi-model-work/checkpoints.md`:

- Critical changes complete → invoke domain expert for independent verification
- Full-stack changes → invoke cross-validation for comprehensive check

```
BEFORE claiming any status or expressing satisfaction:

1. IDENTIFY: What command proves this claim?
2. RUN: Execute the FULL command (fresh, complete)
3. READ: Full output, check exit code, count failures
4. VERIFY: Does output confirm the claim?
   - If NO: State actual status with evidence
   - If YES: State claim WITH evidence
5. ONLY THEN: Make the claim

Skip any step = lying, not verifying
```

## Common Failures

| Claim                 | Requires                        | Not Sufficient                 |
| --------------------- | ------------------------------- | ------------------------------ |
| Tests pass            | Test command output: 0 failures | Previous run, "should pass"    |
| Linter clean          | Linter output: 0 errors         | Partial check, extrapolation   |
| Build succeeds        | Build command: exit 0           | Linter passing, logs look good |
| Bug fixed             | Test original symptom: passes   | Code changed, assumed fixed    |
| Regression test works | Red-green cycle verified        | Test passes once               |
| Agent completed       | VCS diff shows changes          | Agent reports "success"        |
| Requirements met      | Line-by-line checklist          | Tests passing                  |

## Red Flags - STOP

- Using "should", "probably", "seems to"
- Expressing satisfaction before verification ("Great!", "Perfect!", "Done!", etc.)
- About to commit/push/PR without verification
- Trusting agent success reports
- Relying on partial verification
- Thinking "just this once"
- Tired and wanting work over
- **ANY wording implying success without having run verification**

## Rationalization Prevention

| Excuse                                  | Reality                |
| --------------------------------------- | ---------------------- |
| "Should work now"                       | RUN the verification   |
| "I'm confident"                         | Confidence ≠ evidence  |
| "Just this once"                        | No exceptions          |
| "Linter passed"                         | Linter ≠ compiler      |
| "Agent said success"                    | Verify independently   |
| "I'm tired"                             | Exhaustion ≠ excuse    |
| "Partial check is enough"               | Partial proves nothing |
| "Different words so rule doesn't apply" | Spirit over letter     |

## Key Patterns

**Tests:**

```
✅ [Run test command] [See: 34/34 pass] "All tests pass"
❌ "Should pass now" / "Looks correct"
```

**Regression tests (TDD Red-Green):**

```
✅ Write → Run (pass) → Revert fix → Run (MUST FAIL) → Restore → Run (pass)
❌ "I've written a regression test" (without red-green verification)
```

**Build:**

```
✅ [Run build] [See: exit 0] "Build passes"
❌ "Linter passed" (linter doesn't check compilation)
```

**Requirements:**

```
✅ Re-read plan → Create checklist → Verify each → Report gaps or completion
❌ "Tests pass, phase complete"
```

**Agent delegation:**

```
✅ Agent reports success → Check VCS diff → Verify changes → Report actual state
❌ Trust agent report
```

## Why This Matters

From 24 failure memories:

- your human partner said "I don't believe you" - trust broken
- Undefined functions shipped - would crash
- Missing requirements shipped - incomplete features
- Time wasted on false completion → redirect → rework
- Violates: "Honesty is a core value. If you lie, you'll be replaced."

## When To Apply

**ALWAYS before:**

- ANY variation of success/completion claims
- ANY expression of satisfaction
- ANY positive statement about work state
- Committing, PR creation, task completion
- Moving to next task
- Delegating to agents

**Rule applies to:**

- Exact phrases
- Paraphrases and synonyms
- Implications of success
- ANY communication suggesting completion/correctness

## The Bottom Line

**No shortcuts for verification.**

Run the command. Read the output. THEN claim the result.

This is non-negotiable.

## Multi-Model Cross-Verification

**Related skill:** superpowers:coordinating-multi-model-work

At checkpoint, apply semantic routing using `coordinating-multi-model-work/routing-decision.md`:

- Backend-only critical → CODEX verification (Codex MCP `mcp__codex__codex`)
- Frontend-only critical → GEMINI verification (Gemini MCP `mcp__gemini__gemini`)
- Full-stack/architectural → CROSS_VALIDATION (call both MCP tools)

**Full checkpoint logic:** See `coordinating-multi-model-work/checkpoints.md`

See `coordinating-multi-model-work/INTEGRATION.md` for invocation templates.

**CRITICAL:** Cross-model verification is **additional** to, not a replacement for running actual commands. **Never claim success based solely on model confirmation.**

**Fallback (Fail-Closed):** If external models are unavailable or time out, STOP and follow `coordinating-multi-model-work/GATE.md` (do not claim verification).
