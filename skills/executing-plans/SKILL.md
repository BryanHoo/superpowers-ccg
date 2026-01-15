---
name: executing-plans
description: Use when you have a written implementation plan to execute in a separate session with review checkpoints
---

# Executing Plans

## Overview

Load plan, review critically, execute tasks in batches, report for review between batches.

**Core principle:** Batch execution with checkpoints for architect review.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

## The Process

### Step 1: Load and Review Plan
1. Read plan file
2. Review critically - identify any questions or concerns about the plan
3. If concerns: Raise them with your human partner before starting
4. If no concerns: Create TodoWrite and proceed

### Step 2: Execute Batch
**Default: First 3 tasks**

For each task:
1. Mark as in_progress
2. Follow each step exactly (plan has bite-sized steps)
3. Run verifications as specified
4. Mark as completed

### Step 3: Report
When batch complete:
- Show what was implemented
- Show verification output
- Say: "Ready for feedback."

### Step 4: Continue
Based on feedback:
- Apply changes if needed
- Execute next batch
- Repeat until complete

### Step 5: Complete Development

After all tasks complete and verified:
- Announce: "I'm using the finishing-a-development-branch skill to complete this work."
- **REQUIRED SUB-SKILL:** Use superpowers:finishing-a-development-branch
- Follow that skill to verify tests, present options, execute choice

## When to Stop and Ask for Help

**STOP executing immediately when:**
- Hit a blocker mid-batch (missing dependency, test fails, instruction unclear)
- Plan has critical gaps preventing starting
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## When to Revisit Earlier Steps

**Return to Review (Step 1) when:**
- Partner updates the plan based on your feedback
- Fundamental approach needs rethinking

**Don't force through blockers** - stop and ask.

## Remember
- Review plan critically first
- Follow plan steps exactly
- Don't skip verifications
- Reference skills when plan says to
- Between batches: just report and wait
- Stop when blocked, don't guess

## Multi-Model Task Execution

**Related skill:** superpowers:multi-model-core

When executing plan tasks, apply semantic routing to determine the optimal execution model.

**1. Apply Semantic Routing Decision:**

For each task, analyze using `multi-model-core/routing-decision.md`:

- **Collect task information:**
  - File paths and extensions involved
  - Task description and objectives
  - Tech stack context from the plan

- **Determine routing:**
  - Backend task (API, database, algorithms) → CODEX
  - Frontend task (UI, components, styles) → GEMINI
  - Full-stack task or integration → CROSS_VALIDATION
  - Simple config/docs → CLAUDE

**2. Check for Model Hint:**

If the plan includes a `Model hint` annotation:
- Respect explicit hints (`codex`, `gemini`, `cross-validation`)
- For `auto` or no hint: proceed with semantic analysis

**3. Notify user:**
```
我将使用 [model] 来执行 [task description]
```

**4. Execute with external model:**

> **IMPORTANT**: All prompts sent to external models (Codex/Gemini) via codeagent-wrapper must be in English.

```bash
# Route to appropriate model based on analysis
codeagent-wrapper --backend <codex|gemini> - "$PWD" <<'EOF'
## Task Background
[Context extracted from plan]

## Specific Task
[Detailed steps of the task]

## Verification Requirements
[Expected verification commands and output]
EOF
```

**5. For CROSS_VALIDATION tasks:**

When task spans both domains or requires multi-perspective validation:

1. Invoke Codex and Gemini in parallel
2. Integrate results from both
3. Resolve any divergences before proceeding

**Fallback:** If external models are not available, Claude executes the task directly.
