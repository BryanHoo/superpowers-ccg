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

When executing plans, automatically route to the most suitable model based on task characteristics:

**Routing logic:**

1. Check if the task has a `Model hint` annotation
2. If annotated and not `auto`, route according to the annotation
3. If `auto` or no annotation, comprehensively evaluate:
   - File type (`.go`, `.py` → Codex; `.tsx`, `.vue` → Gemini)
   - Directory structure (`server/`, `api/` → Codex; `components/`, `pages/` → Gemini)
   - Task keywords (API, database → Codex; UI, styles → Gemini)

**Execution with external model:**

```bash
# Call corresponding model based on routing result
codeagent-wrapper --backend <codex|gemini> - "$PWD" <<'EOF'
## Task Background
[Context extracted from plan]

## Specific Task
[Detailed steps of the task]

## Verification Requirements
[Expected verification commands and output]
EOF
```

**Cross-validation tasks:**

For tasks annotated as `cross-validation`, or tasks that Claude determines require cross-validation:

1. Call Codex and Gemini in parallel
2. Integrate results from both
3. Execute after resolving divergences

**Fallback:** If external models are not available, Claude executes the task directly.
