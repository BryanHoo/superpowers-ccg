---
name: writing-plans
description: "Creates comprehensive implementation plans with bite-sized tasks, exact file paths, and TDD steps. Use when: having a spec or requirements for multi-step tasks, before writing code. Keywords: implementation plan, task breakdown, planning, roadmap"
---

# Writing Plans

## Overview

Write comprehensive implementation plans assuming the engineer has zero context for our codebase and questionable taste. Document everything they need to know: which files to touch for each task, code, testing, docs they might need to check, how to test it. Give them the whole plan as bite-sized tasks. DRY. YAGNI. TDD. Frequent commits.

Assume they are a skilled developer, but know almost nothing about our toolset or problem domain. Assume they don't know good test design very well.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

**► Checkpoint 1 (Task Analysis):** Before writing the plan, apply checkpoint logic from `multi-model-core/checkpoints.md`:
- Collect: overall scope, files involved, tech stack, complexity
- Check critical task conditions → Match: invoke expert model for architecture review
- Evaluate general task signals → Positive: invoke for plan quality assessment

**Context:** This should be run in a dedicated worktree (created by brainstorming skill).

**Save plans to:** `docs/plans/YYYY-MM-DD-<feature-name>.md`

## Bite-Sized Task Granularity

**Each step is one action (2-5 minutes):**
- "Write the failing test" - step
- "Run it to make sure it fails" - step
- "Implement the minimal code to make the test pass" - step
- "Run the tests and make sure they pass" - step
- "Commit" - step

## Plan Document Header

**Every plan MUST start with this header:**

```markdown
# [Feature Name] Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

---
```

## Task Structure

```markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

**Step 1: Write the failing test**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

**Step 2: Run test to verify it fails**

Run: `pytest tests/path/test.py::test_name -v`
Expected: FAIL with "function not defined"

**Step 3: Write minimal implementation**

```python
def function(input):
    return expected
```

**Step 4: Run test to verify it passes**

Run: `pytest tests/path/test.py::test_name -v`
Expected: PASS

**Step 5: Commit**

```bash
git add tests/path/test.py src/path/file.py
git commit -m "feat: add specific feature"
```
```

## Remember
- Exact file paths always
- Complete code in plan (not "add validation")
- Exact commands with expected output
- Reference relevant skills with @ syntax
- DRY, YAGNI, TDD, frequent commits

## Multi-Model Task Routing

**Related skill:** superpowers:multi-model-core

When writing plans, you can optionally annotate tasks with model hints to guide execution. However, these hints are **suggestions only** - actual execution uses semantic analysis.

**Task annotation format (optional):**

```markdown
### Task N: [Component Name]
**Model hint:** `auto` | `codex` | `gemini` | `cross-validation`

**Files:**
- Create: `exact/path/to/file.py`
...
```

**Routing hint meanings:**

- `auto` - Executor determines routing through semantic analysis (default)
- `codex` - Suggests backend focus (API, database, algorithms)
- `gemini` - Suggests frontend focus (components, styles, interactions)
- `cross-validation` - Suggests critical task needing dual-model verification

**How execution handles hints:**

During plan execution (via `executing-plans` or `subagent-driven-development`):

1. Executor reads the `Model hint` if present
2. **Applies semantic routing** using `multi-model-core/routing-decision.md`:
   - Collects task information (files, description, tech stack)
   - Analyzes task domain, complexity, and uncertainty
   - Makes routing decision based on semantic understanding
   - Uses hint as **guidance**, not strict rule

3. Routes task to optimal model:
   - Frontend → GEMINI
   - Backend → CODEX
   - Full-stack/uncertain → CROSS_VALIDATION
   - Simple → CLAUDE

**Example with hints:**

```markdown
### Task 1: Create API endpoint
**Model hint:** `codex`

**Files:**
- Create: `server/api/users.go`
- Test: `server/api/users_test.go`
...

### Task 2: Create user profile component
**Model hint:** `gemini`

**Files:**
- Create: `src/components/UserProfile.tsx`
- Create: `src/components/UserProfile.css`
...

### Task 3: Integrate API with component
**Model hint:** `cross-validation`

**Files:**
- Modify: `src/components/UserProfile.tsx`
- Modify: `server/api/users.go`
...
```

**Important notes:**

- Model hints are **optional** - executor can always succeed without them
- Hints are **suggestions** - executor may route differently based on semantic analysis
- Missing or `auto` hint → Executor performs full semantic analysis
- Plan author doesn't need to understand routing logic deeply
- Focus on clear task descriptions and file paths; routing is handled automatically

## Execution Handoff

**► Checkpoint 3 (Quality Gate):** Before handoff, apply checkpoint logic from `multi-model-core/checkpoints.md`:
- Plan complete and ready for execution → invoke domain expert for final review
- Critical tasks identified in plan → invoke cross-validation for architecture verification

After saving the plan, offer execution choice:

**"Plan complete and saved to `docs/plans/<filename>.md`. Two execution options:**

**1. Subagent-Driven (this session)** - I dispatch fresh subagent per task, review between tasks, fast iteration

**2. Parallel Session (separate)** - Open new session with executing-plans, batch execution with checkpoints

**Which approach?"**

**If Subagent-Driven chosen:**
- **REQUIRED SUB-SKILL:** Use superpowers:subagent-driven-development
- Stay in this session
- Fresh subagent per task + code review

**If Parallel Session chosen:**
- Guide them to open new session in worktree
- **REQUIRED SUB-SKILL:** New session uses superpowers:executing-plans
