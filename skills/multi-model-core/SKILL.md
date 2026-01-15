---
name: multi-model-core
description: Multi-Model Core Module - Provides automatic routing and cross-validation for Codex/Gemini
---

# Multi-Model Core Module

## Overview

This module provides multi-model invocation capabilities for superpowers skills, calling Codex (backend expert) and Gemini (frontend expert) through codeagent-wrapper.

**Core Features**:
- **Automatic Routing** - Intelligently selects models based on task characteristics
- **Cross-Validation** - Dual-model verification for complex scenarios
- **Seamless Integration** - Other skills can reference on demand

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

### 2. Routing Rules

Consider the following factors to determine routing target:

| Factor | Gemini (Frontend) | Codex (Backend) |
|------|---------------|-----------------|
| **File Types** | `.tsx`, `.vue`, `.css`, `.scss`, `.html`, `.svelte` | `.go`, `.py`, `.java`, `.rs`, `.sql`, `.sh` |
| **Directories** | `components/`, `pages/`, `styles/`, `ui/`, `frontend/` | `server/`, `api/`, `services/`, `backend/`, `cmd/` |
| **Keywords** | UI, styles, components, layout, animation, responsive, interaction | API, database, algorithms, performance, concurrency, security, architecture |

**Decision Matrix**:
```
                Strong Frontend    Weak Frontend
               ┌──────────────┬──────────────┐
Strong Backend │Cross-Validate│    Codex     │
               ├──────────────┼──────────────┤
Weak Backend   │    Gemini    │    Claude    │
               └──────────────┴──────────────┘
```

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

This module is referenced by the following skills:

| Skill | Usage Scenario |
|-------|----------------|
| `systematic-debugging` | Dual-model cross-diagnosis during root cause analysis |
| `brainstorming` | Multi-perspective validation during solution evaluation |
| `writing-plans` | Professional model assistance during technical proposal design |
| `executing-plans` | Routing by task type during implementation phase |
| `subagent-driven-development` | Distributing subtasks by frontend/backend |
| `requesting-code-review` | Dual-model cross-review |
| `test-driven-development` | Test generation routing by tech stack |
| `verification-before-completion` | Cross-confirmation during verification phase |

## Quick Reference

```
Need external model?
     │
     ├─ Frontend task → Gemini
     ├─ Backend task → Codex
     ├─ Full-stack/Complex → Cross-validation
     └─ Simple task → Claude handles directly
```
