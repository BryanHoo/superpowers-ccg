---
name: multi-model-core
description: "Routes tasks to optimal AI models (Codex for backend, Gemini for frontend) and enables cross-validation. Use when: needing specialized model expertise, cross-validating critical changes, or leveraging multi-model capabilities. Keywords: Codex, Gemini, model routing, cross-validation"
---

# Multi-Model Core Module

## Overview

This module provides multi-model invocation capabilities for superpowers skills, calling Codex (backend expert) and Gemini (frontend expert) through codeagent-wrapper.

**Core Features**:
- **Automatic Routing** - Intelligently selects models based on task characteristics
- **Cross-Validation** - Dual-model verification for complex scenarios
- **Collaboration Checkpoints** - Embedded triggers at key skill stages
- **Seamless Integration** - Other skills can reference on demand

## Module Files

| File | Purpose |
|------|---------|
| `SKILL.md` | This file - core module documentation |
| `INTEGRATION.md` | Invocation templates for external models |
| `routing-decision.md` | Semantic routing decision framework |
| `routing-rules.md` | Reference patterns for categorization |
| `checkpoints.md` | **NEW** - Collaboration checkpoint logic for autonomous triggering |

## Prerequisites

Before using multi-model features, you need to install codeagent-wrapper:

```bash
# Create directory
mkdir -p ~/.claude/bin

# Copy the binary for your platform (example for macOS ARM64)
cp bin/codeagent-wrapper-darwin-arm64 ~/.claude/bin/codeagent-wrapper

# Add execute permission
chmod +x ~/.claude/bin/codeagent-wrapper

# Verify installation
~/.claude/bin/codeagent-wrapper --help
```

**Platform Binaries:**
- macOS Intel: `bin/codeagent-wrapper-darwin-amd64`
- macOS Apple Silicon: `bin/codeagent-wrapper-darwin-arm64`
- Linux x64: `bin/codeagent-wrapper-linux-amd64`
- Linux ARM64: `bin/codeagent-wrapper-linux-arm64`
- Windows x64: `bin/codeagent-wrapper-windows-amd64.exe`
- Windows ARM64: `bin/codeagent-wrapper-windows-arm64.exe`

**External Model CLIs (Optional):**
- Codex CLI: `npm install -g @openai/codex`
- Gemini CLI: `npm install -g @google/gemini-cli`

## How to Use

### 1. Determine If External Models Are Needed

During skill execution, consider invoking external models in the following situations:

- Need deep analysis of specific tech stack code
- Need professional domain design suggestions
- Need multi-perspective validation of solutions or diagnostics

### 2. Routing Decision Process

This module uses **semantic analysis** instead of hardcoded scoring algorithms to determine optimal model routing. Claude analyzes task characteristics using reasoning to make intelligent, context-aware routing decisions.

**When to Use**: Before executing implementation tasks, debugging, generating tests, or code reviews.

**Decision Framework**: See `routing-decision.md` for the complete semantic routing framework.

**Standard Information Collection**:
1. **Task Description** - What is the user requesting? What problem needs solving?
2. **File Information** - Which files are involved? What extensions and directories?
3. **Tech Stack** - Inferred from project files (package.json, go.mod, etc.)

**Analysis Process**:
1. **Analyze Task Essence** - What problem is primarily being solved? (UI feature, performance, architecture, debugging)
2. **Evaluate Technical Domain** - Does it lean frontend (UI/interaction) or backend (logic/data)?
3. **Assess Complexity** - Does it span multiple domains? Is the root cause uncertain?

**Decision Logic**: Prefer specialized models (GEMINI/CODEX) for single-domain tasks, use CROSS_VALIDATION for multi-domain or uncertain tasks, default to CLAUDE for simple non-technical tasks. When in doubt, choose CROSS_VALIDATION.

**Routing Decisions**:
- **GEMINI** - Frontend expert for UI, components, styles, interactions
- **CODEX** - Backend expert for APIs, databases, algorithms, performance
- **CROSS_VALIDATION** - Both models for full-stack tasks or high uncertainty
- **CLAUDE** - Simple tasks (docs, configs, trivial edits)

**Reference Knowledge**: The `routing-rules.md` file contains categorization patterns (file extensions, directory structures, keywords) that can be referenced as guidance, but these are **reference knowledge only**, not strict rules. Semantic understanding and task context should guide the final decision.

**User Notification**: After making a routing decision, Claude will briefly notify the user which model is being used (e.g., "我将使用 Codex 来优化数据库查询性能").

### 3. Cross-Validation Triggers

Intelligently trigger cross-validation in the following situations:

1. **Full-Stack Issues** - Involves both frontend and backend
2. **High Uncertainty** - Multiple possible causes, difficult to determine
3. **Design Decisions** - Need to evaluate multiple architecture options
4. **Complex Bugs** - Difficult to locate, requires multi-perspective analysis
5. **Critical Changes** - Modifications affecting core functionality

### 4. Invocation Execution

#### Single Model Invocation

```bash
codeagent-wrapper --backend <codex|gemini> - "$PWD" <<'EOF'
# Task Background
[Provide necessary context]

# Specific Task
[Clearly describe the task to be completed]

# Expected Output
[Specify the expected output format]
EOF
```

#### Cross-Validation Invocation

Invoke both models in parallel, analyzing from different perspectives:

**Codex Task** (Backend Perspective):
```bash
codeagent-wrapper --backend codex - "$PWD" <<'EOF'
Please analyze from backend/logic perspective:
[Specific problem description]

Focus on:
- API design and implementation
- Data flow and state management
- Performance and security
EOF
```

**Gemini Task** (Frontend Perspective):
```bash
codeagent-wrapper --backend gemini - "$PWD" <<'EOF'
Please analyze from frontend/UI perspective:
[Specific problem description]

Focus on:
- Component structure and rendering
- User interaction and experience
- Styling and responsive design
EOF
```

### 5. Result Integration

#### Single Model Result

Directly adopt the model output, Claude validates reasonableness before continuing the workflow.

#### Cross-Validation Result

```markdown
## Cross-Validation Results

### Codex Analysis (Backend Perspective)
[Codex's analysis results]

### Gemini Analysis (Frontend Perspective)
[Gemini's analysis results]

### Comprehensive Conclusion
- **Points of Agreement**: [Consistent conclusions from both]
- **Points of Divergence**: [Areas where there are differences]
- **Final Recommendation**: [Claude's recommendation after comprehensive evaluation]
```

## Fallback Handling

If codeagent-wrapper is not available or invocation fails:

1. Record the failure reason
2. Fall back to Claude handling independently
3. Note in the output that external models were not used

## Important Notes

1. **Language Standards** - **Inter-model communication must use English**
   - Prompts, task descriptions, and code comments sent to Codex/Gemini must be in English
   - This ensures standardization and efficiency of multi-model collaboration
   - User interactions still follow the user's language configuration (e.g., Chinese configuration in CLAUDE.md)
   - Example: Even if the user has configured Chinese output, English prompts must still be used when calling external models
2. **Timeout Control** - External invocations have a default timeout of 7200 seconds, adjustable via `CODEX_TIMEOUT` environment variable
3. **Result Validation** - Claude should validate the reasonableness of results returned by external models
4. **Privacy Consideration** - Be cautious when sending sensitive code to external models
5. **Cost Awareness** - Avoid unnecessary external invocations, Claude handles simple tasks directly

## Integration with Other Skills

This module is referenced by the following skills, each with embedded collaboration checkpoints:

| Skill | Checkpoints | Usage Scenario |
|-------|-------------|----------------|
| `brainstorming` | CP1, CP2 | Design evaluation and approach validation |
| `writing-plans` | CP1, CP3 | Plan complexity assessment and quality gate |
| `executing-plans` | CP1, CP2, CP3 | Before/during/after each task |
| `subagent-driven-development` | CP1, CP2, CP3 | Subtask dispatch, execution, and review |
| `test-driven-development` | CP1, CP3 | Test generation and implementation review |
| `systematic-debugging` | CP1, CP2 | Root cause investigation and hypothesis testing |
| `requesting-code-review` | CP3 | Code review invocation |
| `verification-before-completion` | CP3 | Final verification |

**Checkpoint Types:**
- **CP1 (Task Analysis)** - Evaluate at task start
- **CP2 (Mid-Review)** - Invoke at key decision points
- **CP3 (Quality Gate)** - Review before completion

**See `checkpoints.md` for full checkpoint logic and trigger conditions.**

## Quick Reference

```
Need external model?
     │
     ├─ Frontend task → Gemini
     ├─ Backend task → Codex
     ├─ Full-stack/Complex → Cross-validation
     └─ Simple task → Claude handles directly
```
