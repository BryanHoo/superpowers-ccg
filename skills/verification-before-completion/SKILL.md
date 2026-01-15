---
name: verification-before-completion
description: Use when about to claim work is complete, fixed, or passing, before committing or creating PRs - requires running verification commands and confirming output before making any success claims; evidence before assertions always
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

## The Gate Function

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

| Claim | Requires | Not Sufficient |
|-------|----------|----------------|
| Tests pass | Test command output: 0 failures | Previous run, "should pass" |
| Linter clean | Linter output: 0 errors | Partial check, extrapolation |
| Build succeeds | Build command: exit 0 | Linter passing, logs look good |
| Bug fixed | Test original symptom: passes | Code changed, assumed fixed |
| Regression test works | Red-green cycle verified | Test passes once |
| Agent completed | VCS diff shows changes | Agent reports "success" |
| Requirements met | Line-by-line checklist | Tests passing |

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

| Excuse | Reality |
|--------|---------|
| "Should work now" | RUN the verification |
| "I'm confident" | Confidence ≠ evidence |
| "Just this once" | No exceptions |
| "Linter passed" | Linter ≠ compiler |
| "Agent said success" | Verify independently |
| "I'm tired" | Exhaustion ≠ excuse |
| "Partial check is enough" | Partial proves nothing |
| "Different words so rule doesn't apply" | Spirit over letter |

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

**Related skill:** superpowers:multi-model-core

For critical features or complex changes, semantic routing can guide cross-validation strategy.

**1. Apply Semantic Routing Decision:**

When considering cross-model verification, analyze using `multi-model-core/routing-decision.md`:

- **Collect verification context:**
  - What domains are affected by the changes (frontend, backend, or both)
  - Criticality level of the changes
  - Complexity and integration points

- **Determine verification strategy:**
  - Backend-only critical changes → CODEX verification
  - Frontend-only critical changes → GEMINI verification
  - Full-stack or architectural changes → CROSS_VALIDATION
  - Standard changes → CLAUDE verification (with evidence from test output)

**2. CRITICAL - Evidence always required:**

Cross-model verification is **additional** to, not a replacement for:
- Running actual test commands
- Checking actual build output
- Verifying actual command results

**Never claim success based solely on model confirmation without running verification commands.**

**3. For CROSS_VALIDATION of critical changes:**

> **IMPORTANT**: All prompts sent to external models via codeagent-wrapper must be in English.

```bash
# Backend verification → Codex
codeagent-wrapper --backend codex - "$PWD" <<'EOF'
## Verification Request

### Change Summary
[Change description]

### Please Verify
1. Is backend logic correctly implemented?
2. Does the API meet expectations?
3. Are there any missed boundary conditions?
4. Are there potential performance or security issues?

### Expected Output
- Verification conclusion (pass/fail)
- Issues found (if any)
EOF

# Frontend verification → Gemini
codeagent-wrapper --backend gemini - "$PWD" <<'EOF'
## Verification Request

### Change Summary
[Change description]

### Please Verify
1. Is frontend implementation correct?
2. Does user experience meet expectations?
3. Are there any missed interaction scenarios?
4. Are there accessibility issues?

### Expected Output
- Verification conclusion (pass/fail)
- Issues found (if any)
EOF
```

**4. Result integration:**

```markdown
## Verification Results

### Evidence from Commands
[Actual test output, build results, etc.]

### Cross-Validation Confirmation (if applicable)
- [Model] verification: [pass/fail]
- Issues found: [list any issues]

### Final Determination
[Can only claim completion if BOTH evidence AND cross-validation pass]
```

**Fallback:** If external models are not available, ensure Claude's verification is more rigorous with comprehensive evidence gathering.
