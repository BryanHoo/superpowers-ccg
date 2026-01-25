---
name: executing-plans
description: "Executes written implementation plans task-by-task with review checkpoints between batches. Use when: having a plan document to execute in a dedicated session. Keywords: execute plan, implementation, batch execution, checkpoints"
---

# Executing Plans

## Overview

Load plan, review critically, execute tasks in batches, report for review between batches.

**Core principle:** Batch execution with checkpoints for architect review.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

## Protocol Threshold (Required)

Follow the [CP Protocol Threshold] injected by hooks:

- Before the first Task call: output a standalone [CP1 Assessment] block (the block itself must not include tool calls; tool calls may follow in the same reply)
- Before claiming a batch is complete / verification passed / ready to wrap up: output a standalone [CP3 Assessment] block (the block itself must not include tool calls; the conclusion may follow in the same reply)

If unmet -> immediately perform the CP assessment, then continue the flow right away; do not stop or interrupt.

## The Process

### Step 1: Load and Review Plan

1. Read plan file
2. Review critically - identify any questions or concerns about the plan
3. If concerns: Raise them with your human partner before starting
4. If no concerns: Create TodoWrite and proceed

### Step 2: Execute Batch

**Default: First 3 tasks**

**Claude Model Selection:** When dispatching Claude subagents for task execution, use `model: sonnet` for implementation work. Sonnet excels at code writing and is more cost-effective than Opus for execution tasks.

Copy this checklist template for each batch:

```
Batch Progress:
- [ ] Task N: [description] - in_progress
- [ ] Task N+1: [description] - pending
- [ ] Task N+2: [description] - pending

Current Task:
- [ ] Checkpoint 1 (Task Analysis) applied
- [ ] All steps followed exactly
- [ ] Checkpoint 2 (Mid-Review) if needed
- [ ] Verifications run
- [ ] Checkpoint 3 (Quality Gate) applied
- [ ] Task marked complete
```

For each task:

1. Mark as in_progress
2. Hard reminder: before your first Task tool call, you must output a standalone `【CP1 Assessment】` block (fixed format with fields).
3. **► Checkpoint 1 (Task Analysis):** Apply checkpoint logic from `coordinating-multi-model-work/checkpoints.md`:
   - Collect: task files, description, tech stack from plan
   - Check critical task conditions → Match: invoke expert model
   - Evaluate general task signals → Positive: invoke
4. Follow each step exactly (plan has bite-sized steps)
5. **► Checkpoint 2 (Mid-Review):** If blocked or uncertain:
   - Multiple approaches possible → invoke cross-validation
   - Debugging stalled → invoke domain expert
6. Run verifications as specified
7. **► Checkpoint 3 (Quality Gate):** Before marking complete:
   - Code generation complete → invoke domain expert for review
8. Mark as completed

### Step 3: Report

When batch complete:

- Hard reminder: before claiming a batch is complete or verification passed, you must output a standalone `【CP3 Assessment】` block (fixed format with fields).
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

- Announce: "I'm using the finishing-development-branches skill to complete this work."
- **REQUIRED SUB-SKILL:** Use superpowers:finishing-development-branches
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

**Related skill:** superpowers:coordinating-multi-model-work

At checkpoints, apply semantic routing from `coordinating-multi-model-work/routing-decision.md`:

- **Routing decision:**
  - Backend task (API, database, algorithms) → CODEX
  - Frontend task (UI, components, styles) → GEMINI
  - Full-stack task or integration → CROSS_VALIDATION
  - Simple config/docs → CLAUDE

- **Check for Model Hint:** If plan includes `Model hint`, respect explicit hints

- **Notify user:** "I will use [model] to execute [task description]"

- **Call MCP tool** with English prompts (see `coordinating-multi-model-work/INTEGRATION.md` for templates). Use Codex MCP (`mcp__codex__codex`) for backend, Gemini MCP (`mcp__gemini__gemini`) for frontend, and call both in parallel for CROSS_VALIDATION.

**Full checkpoint logic:** See `coordinating-multi-model-work/checkpoints.md`

**Fallback (Fail-Closed):** If external models are not available or time out, STOP and follow `coordinating-multi-model-work/GATE.md` (do not proceed with task completion output).
