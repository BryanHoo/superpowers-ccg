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

**When to trigger:** Claude intelligently triggers multi-model validation in the following situations:
- Design involves frontend-backend architecture decisions
- Need to evaluate multiple technical approaches
- Critical design requires multi-perspective validation

**How to use:**

> **IMPORTANT**: All prompts sent to external models (Codex/Gemini) via codeagent-wrapper must be in English, regardless of your configured output language.

During the "Exploring approaches" phase, for designs involving frontend and backend:

```bash
# Parallel invocation for specialized perspectives

# Codex (backend architecture perspective)
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

# Gemini (frontend architecture perspective)
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
```

**Result integration:**

```markdown
## Multi-Model Design Assessment

### Codex Assessment (Backend Perspective)
[Codex assessment results]

### Gemini Assessment (Frontend Perspective)
[Gemini assessment results]

### Comprehensive Recommendation
- **Points of Agreement**: [Design points both agree on]
- **Trade-offs Required**: [Areas with differing opinions]
- **Final Recommendation**: [Claude's integrated recommended approach]
```

**Fallback:** If codeagent-wrapper is not available, continue with Claude's independent assessment.
