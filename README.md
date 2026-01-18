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

4. **developing-with-subagents** or **executing-plans** - Activate with plan ready. Dispatch each task to a new subagent with two-stage review (spec compliance + code quality), or execute in batches with manual checkpoints. **Automatically routes tasks to Codex/Gemini**.

5. **practicing-test-driven-development** - Activate during implementation. Enforce RED-GREEN-REFACTOR: write failing test, see it fail, write minimal code, see it pass, commit. **Supports test generation routing by tech stack**.

6. **requesting-code-review** - Activate between tasks. Review according to plan, report issues by severity. **Supports dual-model cross-review**.

7. **finishing-development-branches** - Activate when tasks complete. Verify tests, present options (merge/PR/keep/discard), cleanup worktree.

**The agent checks relevant skills before any task.** This is a mandatory workflow, not a suggestion.

## Multi-Model Capabilities

### coordinating-multi-model-work

Core module providing automatic routing and cross-validation:

> **Important Note**: Inter-model communication must use English. All prompts and task descriptions sent to Codex/Gemini must be in English, ensuring standardization and efficiency of multi-model collaboration. User interactions still follow the user's language configuration.

**Routing Mechanism:**

- **Semantic Analysis** - Claude analyzes task description, file types, and tech stack to intelligently determine which model to route to
- **Decision Factors** - Task nature (UI/logic/data), technical domain (frontend/backend), complexity (single/cross-domain)
- **Routing Targets** - Gemini (frontend), Codex (backend), Cross-validation (full-stack/uncertain), Claude (simple tasks)

**Cross-Validation Triggers:**

- Full-stack issues (frontend-backend interaction)
- High uncertainty (multiple possible causes)
- Design decisions (architecture choices)
- Complex bugs (difficult to locate)

### Enhanced Skills

| Skill                          | Multi-Model Capability     |
| ------------------------------ | -------------------------- |
| debugging-systematically       | Cross-validation diagnosis with embedded checkpoints |
| brainstorming                  | Multi-model design evaluation with CP1/CP2 checkpoints |
| writing-plans                  | Task routing annotation with CP1/CP3 checkpoints |
| executing-plans                | Automatic routing execution with CP1/CP2/CP3 checkpoints |
| developing-with-subagents      | Multi-model task distribution with CP1/CP2/CP3 checkpoints |
| requesting-code-review         | Dual-model code review with CP3 checkpoint |
| practicing-test-driven-development | Test generation routing with CP1/CP3 checkpoints |
| verifying-before-completion    | Cross-validation confirmation with CP3 checkpoint |

## Skills Library

### Testing

- **practicing-test-driven-development** - Streamlined RED-GREEN-REFACTOR cycle with proactive multi-model checkpoints (includes testing anti-patterns reference)

### Debugging

- **debugging-systematically** - Streamlined 4-phase root cause analysis workflow with proactive multi-model checkpoints (includes root-cause-tracing, defense-in-depth, condition-based-waiting techniques)
- **verifying-before-completion** - Ensure issues are truly fixed with CP3 checkpoint

### Collaboration

- **brainstorming** - Socratic design refinement
- **writing-plans** - Detailed implementation plans
- **executing-plans** - Batch execution with checkpoints
- **dispatching-parallel-agents** - Concurrent subagent workflow
- **requesting-code-review** - Pre-review checklist
- **receiving-code-review** - Respond to feedback
- **using-git-worktrees** - Parallel development branches
- **finishing-development-branches** - Merge/PR decision workflow
- **developing-with-subagents** - Fast iteration with two-stage review

### Multi-Model

- **coordinating-multi-model-work** - Multi-model invocation core (routing rules, cross-validation, prompt templates, proactive collaboration checkpoints)

### Meta-Skills

- **writing-skills** - Create new skills following best practices (now modularized with STRUCTURE.md, TESTING.md, and CHECKLIST.md)
- **using-superpowers** - Skills system introduction
- **coordinating-multi-model-work** - Unified invocation templates and integration patterns (moved from inline documentation to centralized INTEGRATION.md)

## Design Philosophy

- **Test-Driven Development** - Always write tests first
- **Systematic Over Ad-Hoc** - Process over guessing
- **Reduce Complexity** - Simplicity is the primary goal
- **Evidence Over Claims** - Verify before declaring success
- **Multi-Model Collaboration** - Specialized models handle specialized tasks
- **Streamlined Documentation** - Following Anthropic best practices by removing redundant explanatory content that Claude already knows
- **Proactive Collaboration** - Embedding autonomous decision-making checkpoints for multi-model collaboration

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

## Evaluation and Checklists

The Superpowers-CCG framework includes systematic evaluation scenarios and workflow checklists to ensure consistent progress tracking:

- **Evaluation Scenarios** - Comprehensive test scenarios for key skills documented in `EVALUATION.md`
- **Workflow Checklists** - Copyable checklist templates for executing-plans and developing-with-subagents
- **Multi-Model Checkpoints** - Proactive collaboration checkpoints enabling Claude to autonomously decide when to invoke Codex/Gemini at key stages

### Multi-Model Collaboration Checkpoints

The framework now includes embedded collaboration checkpoints in 8 key skills:

- **CP1 (Task Analysis)** - Evaluate before task start
- **CP2 (Mid-Review)** - Invoke at key decision points
- **CP3 (Quality Gate)** - Review before completion

These checkpoints are integrated into:
- brainstorming: CP1 (idea analysis), CP2 (approach exploration)
- writing-plans: CP1 (plan start), CP3 (execution handoff)
- executing-plans: CP1/CP2/CP3 (per-task checkpoints)
- developing-with-subagents: CP1/CP2/CP3 (dispatch/execution/review)
- practicing-test-driven-development: CP1 (RED phase), CP3 (GREEN phase)
- debugging-systematically: CP1 (investigation), CP2 (hypothesis testing)
- requesting-code-review: CP3 (review invocation)
- verifying-before-completion: CP3 (final verification)

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
