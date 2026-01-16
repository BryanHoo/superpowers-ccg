# Proactive Multi-Model Collaboration Design

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Enhance multi-model coordination so Claude proactively triggers Codex/Gemini during code generation, review, and debugging phases.

**Architecture:** Embed standardized "Collaboration Checkpoints" into each skill at key stages (start, mid, end). Claude autonomously decides when to invoke external models without user confirmation.

**Tech Stack:** Markdown skills, codeagent-wrapper CLI, existing multi-model-core module

---

## Problem Statement

Current state: Claude tends to complete tasks independently, rarely invoking Codex/Gemini even when specialized expertise would improve results.

Desired state: Claude proactively triggers external models for:
- Code generation (Codex for backend, Gemini for frontend)
- Code review and optimization
- Problem diagnosis and debugging

## Design Overview

### Checkpoint Architecture

```
Skill Execution Flow:
┌─────────────────────────────────────────────┐
│  Task Start                                 │
│     ↓                                       │
│  ▶ Checkpoint 1: Task Analysis ◀            │
│     ↓                                       │
│  Execution Phase                            │
│     ↓                                       │
│  ▶ Checkpoint 2: Mid-Review ◀               │
│     ↓                                       │
│  Completion Phase                           │
│     ↓                                       │
│  ▶ Checkpoint 3: Quality Gate ◀             │
│     ↓                                       │
│  Task End                                   │
└─────────────────────────────────────────────┘
```

### Checkpoint Types

| Checkpoint | Timing | Purpose |
|------------|--------|---------|
| **Task Analysis** | Before start | Determine if expert model should participate |
| **Mid-Review** | Key decision points | Seek second opinion on uncertainties |
| **Quality Gate** | Before completion | Have expert model review output |

## Trigger Conditions

### Critical Tasks (Auto-Trigger)

Tasks matching ANY of these conditions trigger external models automatically:

**Core Business Logic:**
- Keywords: payment, auth, security, transaction, encryption
- Keywords (CN): 认证, 支付, 权限, 加密, 交易

**Architecture Design:**
- Creating new directory structures
- Modifications spanning 3+ modules
- Keywords: design, architecture, refactor, 设计, 架构, 重构

**Complexity Metrics:**
- Modified files ≥ 3
- Estimated code lines ≥ 100
- Cross frontend-backend modifications

**Debug Complexity:**
- Unclear error messages
- 2+ failed fix attempts
- Involves async/concurrency/state management

### General Tasks (Autonomous Evaluation)

For non-critical tasks, Claude evaluates:

1. **Expected benefit** - Will expert model significantly improve outcome?
2. **Domain clarity** - Is this clearly frontend or backend?
3. **Cost-benefit** - Does invocation cost justify expected improvement?

If evaluation is positive → invoke silently with notification.

## Autonomous Decision Flow

```
Claude Autonomous Decision:
┌─────────────────────────────────────────────────┐
│  Checkpoint Triggered                           │
│     ↓                                          │
│  Collect task info (files, stack, complexity)   │
│     ↓                                          │
│  Critical task? ──YES──→ Invoke, notify user    │
│     ↓ NO                                       │
│  General task evaluation:                       │
│  - Expected benefit > invocation cost?          │
│  - Domain clear (frontend/backend)?             │
│     ↓                                          │
│  Worth invoking? ──YES──→ Invoke, notify user   │
│     ↓ NO                                       │
│  Claude handles independently (no notification) │
└─────────────────────────────────────────────────┘
```

## User Notification

Only notify when actually invoking (one sentence):

```
我将使用 Codex 来优化这个数据库查询
我将使用 Gemini 来审查这个组件实现
我将使用交叉验证来分析这个全栈问题
```

No notification when Claude handles independently.

## Module Structure

### New File: multi-model-core/checkpoints.md

```
multi-model-core/
├── SKILL.md              # Core description
├── INTEGRATION.md        # Integration guide (existing)
├── routing-decision.md   # Routing decision (existing)
├── routing-rules.md      # Routing rules (existing)
└── checkpoints.md        # NEW: Checkpoint logic
```

### Checkpoint Template Content

```markdown
## Collaboration Checkpoint Template

### Checkpoint 1: Task Start

**Collect:**
- Task description and goal
- Files and directories involved
- Tech stack and frameworks

**Evaluate:**
1. Check critical task conditions → Match: invoke directly
2. Evaluate general task signals → Positive: invoke
3. Neither: Claude handles independently

### Checkpoint 2: Key Decision Point

**Triggers:**
- Multiple implementation approaches to choose from
- Potential performance/security issues discovered
- Debugging stalled

**Behavior:** Proactively invoke cross-validation for multiple perspectives

### Checkpoint 3: Before Completion

**Triggers:**
- Code generation complete, ready to commit
- Fix complete, ready to verify

**Behavior:** Invoke domain expert for review
```

## Skills Modification Plan

| Skill | CP1 | CP2 | CP3 | Primary Trigger Scenario |
|-------|:---:|:---:|:---:|-------------------------|
| `brainstorming` | ✓ | ✓ | - | Design evaluation |
| `writing-plans` | ✓ | - | ✓ | Plan complexity assessment |
| `executing-plans` | ✓ | ✓ | ✓ | Before/after each task |
| `subagent-driven-development` | ✓ | ✓ | ✓ | Subtask dispatch and review |
| `test-driven-development` | ✓ | - | ✓ | Test generation and implementation |
| `systematic-debugging` | ✓ | ✓ | - | Diagnosis and fix |
| `requesting-code-review` | - | - | ✓ | Review phase |
| `verification-before-completion` | - | - | ✓ | Final verification |

## Fallback Handling

When external model call fails:

1. Log failure reason
2. Notify user: "注意: [模型]不可用，将使用 Claude 继续"
3. Claude completes task independently
4. Mark in output that external model was not used

## User Override

Users can still override autonomous decisions:

| User Command | Behavior |
|--------------|----------|
| "用 Codex" | Force use Codex |
| "用 Gemini" | Force use Gemini |
| "都用" / "交叉验证" | Force cross-validation |
| "不要用外部模型" | Claude handles independently |

## Success Metrics

| Metric | Current | Target |
|--------|---------|--------|
| External model invocation frequency | Low (explicit scenarios only) | Medium-High (covers generation/review/diagnosis) |
| Critical task coverage | Low | 100% (auto-trigger) |
| Expert review availability | None | Every generation has review option |

## Implementation Tasks

### Task 1: Create checkpoints.md

**Files:**
- Create: `skills/multi-model-core/checkpoints.md`

**Steps:**
1. Create checkpoint template with all three checkpoint types
2. Include critical task detection logic
3. Include general task evaluation logic
4. Include notification format

### Task 2: Update brainstorming skill

**Files:**
- Modify: `skills/brainstorming/SKILL.md`

**Steps:**
1. Add Checkpoint 1 at "Understanding the idea" phase
2. Add Checkpoint 2 at "Exploring approaches" phase
3. Reference checkpoints.md for logic

### Task 3: Update writing-plans skill

**Files:**
- Modify: `skills/writing-plans/SKILL.md`

**Steps:**
1. Add Checkpoint 1 at plan start
2. Add Checkpoint 3 before execution handoff
3. Reference checkpoints.md for logic

### Task 4: Update executing-plans skill

**Files:**
- Modify: `skills/executing-plans/SKILL.md`

**Steps:**
1. Add Checkpoint 1 before each task execution
2. Add Checkpoint 2 during task execution
3. Add Checkpoint 3 after task completion
4. Reference checkpoints.md for logic

### Task 5: Update subagent-driven-development skill

**Files:**
- Modify: `skills/subagent-driven-development/SKILL.md`

**Steps:**
1. Add Checkpoint 1 before dispatching subagent
2. Add Checkpoint 2 during subagent execution review
3. Add Checkpoint 3 after subagent completion
4. Reference checkpoints.md for logic

### Task 6: Update test-driven-development skill

**Files:**
- Modify: `skills/test-driven-development/SKILL.md`

**Steps:**
1. Add Checkpoint 1 at RED phase (test generation)
2. Add Checkpoint 3 at GREEN phase (implementation review)
3. Reference checkpoints.md for logic

### Task 7: Update systematic-debugging skill

**Files:**
- Modify: `skills/systematic-debugging/SKILL.md`

**Steps:**
1. Add Checkpoint 1 at Phase 1 (Root Cause Investigation)
2. Add Checkpoint 2 at Phase 3 (Hypothesis Testing)
3. Reference checkpoints.md for logic

### Task 8: Update requesting-code-review skill

**Files:**
- Modify: `skills/requesting-code-review/SKILL.md`

**Steps:**
1. Add Checkpoint 3 for review invocation
2. Reference checkpoints.md for logic

### Task 9: Update verification-before-completion skill

**Files:**
- Modify: `skills/verification-before-completion/SKILL.md`

**Steps:**
1. Add Checkpoint 3 for final verification
2. Reference checkpoints.md for logic

### Task 10: Update multi-model-core SKILL.md

**Files:**
- Modify: `skills/multi-model-core/SKILL.md`

**Steps:**
1. Add reference to checkpoints.md in documentation
2. Update integration table with checkpoint information
