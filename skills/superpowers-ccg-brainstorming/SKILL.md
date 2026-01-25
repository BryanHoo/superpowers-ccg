---
name: brainstorming
description: "Explores user intent, requirements and design through collaborative dialogue before implementation. Use when: creating features, building components, adding functionality, modifying behavior, or starting any creative work. Keywords: design, requirements, spec, ideation, planning"
---

# Brainstorming Ideas Into Designs

## Overview

Help turn ideas into fully formed designs and specs through natural collaborative dialogue.

Start by understanding the current project context, then ask questions one at a time to refine the idea. Once you understand what you're building, present the design in small sections (200-300 words), checking after each section whether it looks right so far.

## Protocol Threshold (Required)

Follow the [CP Protocol Threshold] injected by hooks:

- Before the first Task call: output a standalone [CP1 Assessment] block (the block itself must not include tool calls; tool calls may follow in the same reply)
- Before providing a final design conclusion or requesting review: output a standalone [CP3 Assessment] block (the block itself must not include tool calls; the conclusion may follow in the same reply)

If unmet -> immediately perform the CP assessment, then continue the flow right away; do not stop or interrupt.

## The Process

**Understanding the idea:**

- Check out the current project state first (files, docs, recent commits)
- Ask questions one at a time to refine the idea
- Prefer multiple choice questions when possible, but open-ended is fine too
- Only one question per message - if a topic needs more exploration, break it into multiple questions
- Focus on understanding: purpose, constraints, success criteria

**Model tip for exploration:** When dispatching subagents to explore the codebase, use `model: haiku` for fast, cost-effective searches. Haiku excels at file pattern matching and quick lookups.

Hard reminder: before your first Task tool call, you must output a standalone `【CP1 Assessment】` block (fixed format with fields).

**► Checkpoint 1 (Task Analysis):** After understanding the idea, apply checkpoint logic from `coordinating-multi-model-work/checkpoints.md`:

- Collect: task description, files involved, tech stack
- Check critical task conditions → Match: invoke directly
- Evaluate general task signals → Positive: invoke
- Neither: Claude handles independently

**Exploring approaches:**

- Propose 2-3 different approaches with trade-offs
- Present options conversationally with your recommendation and reasoning
- Lead with your recommended option and explain why

**► Checkpoint 2 (Mid-Review):** When multiple approaches have significant trade-offs, apply checkpoint logic from `coordinating-multi-model-work/checkpoints.md`:

- Multiple implementation approaches to choose from → invoke cross-validation
- Potential performance/security issues discovered → invoke domain expert

**Presenting the design:**

- Once you believe you understand what you're building, present the design
- Hard reminder: before giving a final design conclusion or claiming the design is finalized, you must output a standalone `【CP3 Assessment】` block (fixed format with fields).
- Break it into sections of 200-300 words
- Ask after each section whether it looks right so far
- Cover: architecture, components, data flow, error handling, testing
- Be ready to go back and clarify if something doesn't make sense

## After the Design

**Documentation:**

- Write the validated design to `docs/plans/YYYY-MM-DD-<topic>-design.md`
- Use elements-of-style:writing-clearly-and-concisely skill if available
- Commit the design document to git

**Implementation (if continuing):**

- Ask: "Ready to set up for implementation?"
- Use superpowers:using-git-worktrees to create isolated workspace
- Use superpowers:writing-plans to create detailed implementation plan

## Key Principles

- **One question at a time** - Don't overwhelm with multiple questions
- **Multiple choice preferred** - Easier to answer than open-ended when possible
- **YAGNI ruthlessly** - Remove unnecessary features from all designs
- **Explore alternatives** - Always propose 2-3 approaches before settling
- **Incremental validation** - Present design in sections, validate each
- **Be flexible** - Go back and clarify when something doesn't make sense

## Multi-Model Design Validation

**Related skill:** superpowers:coordinating-multi-model-work

At checkpoints, when invoking external models:

1. **Apply semantic routing** using `coordinating-multi-model-work/routing-decision.md`
2. **Notify user**: "I will use [model] to evaluate this design"
3. **Call MCP tool** with English prompts (see `coordinating-multi-model-work/INTEGRATION.md` for templates). Use Codex MCP (`mcp__codex__codex`) for backend, Gemini MCP (`mcp__gemini__gemini`) for frontend, and call both in parallel for CROSS_VALIDATION.
4. **Integrate results** into design recommendation

**Full checkpoint logic:** See `coordinating-multi-model-work/checkpoints.md`

**Fallback (Fail-Closed):** If Codex MCP / Gemini MCP is unavailable or times out when Routing != CLAUDE, STOP and follow `coordinating-multi-model-work/GATE.md` (do not proceed with a final design recommendation).
