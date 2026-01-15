---
name: brainstorming
description: "You MUST use this before any creative work - creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements and design before implementation."
---

# Brainstorming Ideas Into Designs

## Overview

Help turn ideas into fully formed designs and specs through natural collaborative dialogue.

Start by understanding the current project context, then ask questions one at a time to refine the idea. Once you understand what you're building, present the design in small sections (200-300 words), checking after each section whether it looks right so far.

## The Process

**Understanding the idea:**
- Check out the current project state first (files, docs, recent commits)
- Ask questions one at a time to refine the idea
- Prefer multiple choice questions when possible, but open-ended is fine too
- Only one question per message - if a topic needs more exploration, break it into multiple questions
- Focus on understanding: purpose, constraints, success criteria

**Exploring approaches:**
- Propose 2-3 different approaches with trade-offs
- Present options conversationally with your recommendation and reasoning
- Lead with your recommended option and explain why

**Presenting the design:**
- Once you believe you understand what you're building, present the design
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

**Related skill:** superpowers:multi-model-core

During the "Exploring approaches" phase, when design decisions require specialized expertise or multi-perspective validation:

**1. Apply Semantic Routing Decision:**

Before invoking external models, analyze the design using `multi-model-core/routing-decision.md`:

- **Collect task information:**
  - Design scope (frontend-only, backend-only, or full-stack)
  - Technical domains involved (UI, API, database, etc.)
  - Complexity and uncertainty level

- **Determine routing:**
  - Frontend-focused design → GEMINI
  - Backend-focused design → CODEX
  - Full-stack or architectural design → CROSS_VALIDATION
  - Simple design clarification → CLAUDE

**2. Notify user:**
```
我将使用 [model] 来评估这个设计方案
```

**3. Invoke external model(s):**

> **IMPORTANT**: All prompts sent to external models (Codex/Gemini) via codeagent-wrapper must be in English, regardless of your configured output language.

```bash
# For backend design → Codex
codeagent-wrapper --backend codex - "$PWD" <<'EOF'
## Design Proposal
[Design description]

## Please evaluate from backend architecture perspective
1. Architecture rationality and scalability
2. Data model and API design
3. Performance and security considerations
4. Tech stack recommendations

## Expected Output
- Design assessment (strengths/risks)
- Improvement suggestions
EOF

# For frontend design → Gemini
codeagent-wrapper --backend gemini - "$PWD" <<'EOF'
## Design Proposal
[Design description]

## Please evaluate from frontend architecture perspective
1. Component structure and state management
2. User experience and interaction design
3. Performance and accessibility
4. Tech stack recommendations

## Expected Output
- Design assessment (strengths/risks)
- Improvement suggestions
EOF

# For full-stack/architectural design → Both models in parallel
```

**4. Result integration:**

```markdown
## Design Assessment Results

### [Model] Perspective
[Assessment results]

### Comprehensive Recommendation
- **Key Insights**: [Critical findings]
- **Trade-offs**: [Design considerations]
- **Final Recommendation**: [Claude's integrated approach]
```

**Fallback:** If codeagent-wrapper is not available, continue with Claude's independent assessment.
