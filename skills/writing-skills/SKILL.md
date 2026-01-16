---
name: writing-skills
description: "Creates and maintains Claude Code skills using TDD principles for process documentation. Use when: creating new skills, editing existing skills, verifying skills work, or deploying skills. Keywords: skill creation, SKILL.md, skill authoring, agent skills"
---

# Writing Skills

## Overview

**Writing skills IS Test-Driven Development applied to process documentation.**

You write test cases (pressure scenarios with subagents), watch them fail (baseline behavior), write the skill (documentation), watch tests pass (agents comply), and refactor (close loopholes).

**Core principle:** If you didn't watch an agent fail without the skill, you don't know if the skill teaches the right thing.

**REQUIRED BACKGROUND:** You MUST understand superpowers:test-driven-development before using this skill.

**Official guidance:** See anthropic-best-practices.md for Anthropic's official skill authoring best practices.

## What is a Skill?

A **skill** is a reference guide for proven techniques, patterns, or tools.

**Skills are:** Reusable techniques, patterns, tools, reference guides

**Skills are NOT:** Narratives about how you solved a problem once

## TDD Mapping for Skills

| TDD Concept | Skill Creation |
|-------------|----------------|
| **Test case** | Pressure scenario with subagent |
| **Production code** | Skill document (SKILL.md) |
| **Test fails (RED)** | Agent violates rule without skill |
| **Test passes (GREEN)** | Agent complies with skill present |
| **Refactor** | Close loopholes while maintaining compliance |

## When to Create a Skill

**Create when:**
- Technique wasn't intuitively obvious to you
- You'd reference this again across projects
- Pattern applies broadly (not project-specific)
- Others would benefit

**Don't create for:**
- One-off solutions
- Standard practices well-documented elsewhere
- Project-specific conventions (put in CLAUDE.md)
- Mechanical constraints (automate instead)

## Skill Types

- **Technique:** Concrete method with steps (condition-based-waiting, root-cause-tracing)
- **Pattern:** Way of thinking about problems (flatten-with-flags, test-invariants)
- **Reference:** API docs, syntax guides, tool documentation (office docs)

## Directory Structure

```
skills/
  skill-name/
    SKILL.md              # Main reference (required)
    supporting-file.*     # Only if needed
```

**Flat namespace** - all skills in one searchable namespace

**Separate files for:** Heavy reference (100+ lines), reusable tools

**Keep inline:** Principles, concepts, code patterns (< 50 lines)

## The Iron Law

```
NO SKILL WITHOUT A FAILING TEST FIRST
```

This applies to NEW skills AND EDITS to existing skills.

Write skill before testing? Delete it. Start over.

**REQUIRED BACKGROUND:** superpowers:test-driven-development explains why this matters.

## Detailed Reference

For complete guidance, see these reference files:

- **[STRUCTURE.md](STRUCTURE.md)** - SKILL.md structure, CSO, flowcharts, code examples, file organization
- **[TESTING.md](TESTING.md)** - Testing skill types, rationalizations, bulletproofing, RED-GREEN-REFACTOR
- **[CHECKLIST.md](CHECKLIST.md)** - Creation checklist, anti-patterns, discovery workflow

## Quick Reference

```
RED Phase:    Create pressure scenario → Run WITHOUT skill → Document failures
GREEN Phase:  Write minimal skill → Run WITH skill → Verify compliance
REFACTOR:     Find new rationalizations → Add counters → Re-test
```

## The Bottom Line

**Creating skills IS TDD for process documentation.**

Same Iron Law: No skill without failing test first.
Same cycle: RED (baseline) → GREEN (write skill) → REFACTOR (close loopholes).
Same benefits: Better quality, fewer surprises, bulletproof results.

If you follow TDD for code, follow it for skills.
