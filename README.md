# Superpowers-CCG

[中文](README-zh.md) | English

Superpowers-CCG is an enhanced version based on [Superpowers](https://github.com/obra/superpowers), integrating CCG (Claude + Codex + Gemini) multi-model collaboration capabilities.

## Core Features

- **Superpowers Methodology** - Complete software development workflow (brainstorming → planning → TDD → code review)
- **Multi-Model Collaboration** - Automatically routes tasks to the most suitable model (Codex for backend, Gemini for frontend)
- **Cross-Validation** - Dual-model verification for complex problems and design decisions

## How It Works

When you launch the coding agent, it doesn't write code immediately. Instead, it first understands your requirements and refines the design through conversation.

After the design is confirmed, the agent creates a detailed implementation plan, emphasizing TDD, YAGNI, and DRY principles.

During execution, the agent **automatically routes** tasks to the most suitable model based on task characteristics:

- **Frontend Tasks** (components, styles, interactions) → Gemini
- **Backend Tasks** (API, database, algorithms) → Codex
- **Full-Stack/Complex Problems** → Dual-model cross-validation

Throughout the process, Claude orchestrates decisions and code reviews to ensure quality.

## Installation

### 1. Install Superpowers-CCG Plugin

**Claude Code (via Plugin Marketplace)**

```bash
# Add marketplace
/plugin marketplace add BryanHoo/superpowers-ccg

# Install plugin
/plugin install superpowers-ccg@BryanHoo-superpowers-ccg
```

After installation, `codeagent-wrapper` will be automatically configured in the `~/.claude/bin/` directory, no manual copying required.

## Basic Workflow

1. **brainstorming** - Activate before writing code. Refine ideas through questions, explore alternatives, present design in sections for validation. Save design document.

2. **using-git-worktrees** - Activate after design approval. Create isolated workspace and new branch, run project setup, verify test baseline.

3. **writing-plans** - Activate with approved design. Break work into small tasks (2-5 minutes each). Each task has exact file paths, complete code, and verification steps. **Supports Model hint annotations** to specify which model to route tasks to.

4. **subagent-driven-development** or **executing-plans** - Activate with plan ready. Dispatch each task to a new subagent with two-stage review (spec compliance + code quality), or execute in batches with manual checkpoints. **Automatically routes tasks to Codex/Gemini**.

5. **test-driven-development** - Activate during implementation. Enforce RED-GREEN-REFACTOR: write failing test, see it fail, write minimal code, see it pass, commit. **Supports test generation routing by tech stack**.

6. **requesting-code-review** - Activate between tasks. Review according to plan, report issues by severity. **Supports dual-model cross-review**.

7. **finishing-a-development-branch** - Activate when tasks complete. Verify tests, present options (merge/PR/keep/discard), cleanup worktree.

**The agent checks relevant skills before any task.** This is a mandatory workflow, not a suggestion.

## Multi-Model Capabilities

### multi-model-core

Core module providing automatic routing and cross-validation:

> **Important Note**: Inter-model communication must use English. All prompts and task descriptions sent to Codex/Gemini must be in English, ensuring standardization and efficiency of multi-model collaboration. User interactions still follow the user's language configuration.

**Routing Rules:**

- Based on file types (`.tsx` → Gemini, `.go` → Codex)
- Based on directory structure (`components/` → Gemini, `server/` → Codex)
- Based on task keywords (UI/styles → Gemini, API/database → Codex)

**Cross-Validation Triggers:**

- Full-stack issues (frontend-backend interaction)
- High uncertainty (multiple possible causes)
- Design decisions (architecture choices)
- Complex bugs (difficult to locate)

### Enhanced Skills

| Skill                          | Multi-Model Capability     |
| ------------------------------ | -------------------------- |
| systematic-debugging           | Cross-validation diagnosis |
| brainstorming                  | Multi-model design evaluation |
| writing-plans                  | Task routing annotation |
| executing-plans                | Automatic routing execution |
| subagent-driven-development    | Multi-model task distribution |
| requesting-code-review         | Dual-model code review |
| test-driven-development        | Test generation routing |
| verification-before-completion | Cross-validation confirmation |

## Skills Library

### Testing

- **test-driven-development** - RED-GREEN-REFACTOR cycle (includes testing anti-patterns reference)

### Debugging

- **systematic-debugging** - 4-phase root cause analysis workflow (includes root-cause-tracing, defense-in-depth, condition-based-waiting techniques)
- **verification-before-completion** - Ensure issues are truly fixed

### Collaboration

- **brainstorming** - Socratic design refinement
- **writing-plans** - Detailed implementation plans
- **executing-plans** - Batch execution with checkpoints
- **dispatching-parallel-agents** - Concurrent subagent workflow
- **requesting-code-review** - Pre-review checklist
- **receiving-code-review** - Respond to feedback
- **using-git-worktrees** - Parallel development branches
- **finishing-a-development-branch** - Merge/PR decision workflow
- **subagent-driven-development** - Fast iteration with two-stage review

### Multi-Model

- **multi-model-core** - Multi-model invocation core (routing rules, cross-validation, prompt templates)

### Meta-Skills

- **writing-skills** - Create new skills following best practices
- **using-superpowers** - Skills system introduction

## Design Philosophy

- **Test-Driven Development** - Always write tests first
- **Systematic Over Ad-Hoc** - Process over guessing
- **Reduce Complexity** - Simplicity is the primary goal
- **Evidence Over Claims** - Verify before declaring success
- **Multi-Model Collaboration** - Specialized models handle specialized tasks

Read more: [Superpowers for Claude Code](https://blog.fsck.com/2025/10/09/superpowers/)

## Contributing

Skills are stored directly in this repository. To contribute:

1. Fork the repository
2. Create a branch for your skill
3. Create and test new skills following the `writing-skills` skill
4. Submit a PR

See `skills/writing-skills/SKILL.md` for details.

## Updates

Update skills by updating the plugin:

```bash
/plugin update superpowers-ccg
```

## Architecture

```
Claude Code (Orchestration)
       │
   ┌───┴───┐
   ↓       ↓
Codex   Gemini
(Backend) (Frontend)
   │       │
   └───┬───┘
       ↓
  Unified Patch
```

External models have no write access, only return patches, which are applied after Claude review.

## License

MIT License - See LICENSE file

## Support

- **Issues**: https://github.com/BryanHoo/superpowers-ccg/issues

## Acknowledgments

- [obra/superpowers](https://github.com/obra/superpowers) - Original Superpowers project
- [fengshao1227/ccg-workflow](https://github.com/fengshao1227/ccg-workflow) - CCG workflow
- [cexll/myclaude](https://github.com/cexll/myclaude) - codeagent-wrapper
