---
name: superpowers-ccg-coordinating-multi-model-work
description: "Routes work to backend (@backend) and frontend (@frontend) subagents with cross-validation for full-stack/uncertain tasks. Use when: UI/components/styles, APIs/databases/auth/security/performance, debugging, code review, or tasks needing backend/frontend perspectives. Keywords: backend subagent, frontend subagent, cross-validation, api, database, auth, security, performance, ui, component"
---

## Contents

- [Coordinating Multi-Model Work](#coordinating-multi-model-work)
  - [Overview](#overview)
  - [Core Instruction for Subagent Collaboration](#core-instruction-for-subagent-collaboration)
  - [The Two Rules](#the-two-rules)
  - [Checkpoint Workflow](#checkpoint-workflow)
  - [Reference Files](#reference-files)

---

# Coordinating Multi-Model Work

## Overview

Use this module to decide whether to route work to **backend subagent** (@backend) and/or **frontend subagent** (@frontend), and to enforce a consistent evidence protocol.

This module is intentionally minimal: it provides a small workflow and pushes details into reference files.

## Core Instruction for Subagent Collaboration

At any time, you must consider how the current process can collaborate with @backend and @frontend subagents and how to dispatch tasks to ensure objective, comprehensive analysis.
You **must** execute the steps below:
**1** After forming an initial analysis of the user request, share the request and your initial thinking with @backend/@frontend and ask them to improve the requirement analysis and implementation plan.
**2** Before implementing any concrete coding task, **you must ask @backend/@frontend for a code prototype (they must provide only a unified diff patch and must not make any real code changes)**. After receiving the prototype, you may **only** use it as logical reference, then rewrite your own production-grade, highly readable, highly maintainable code before making changes.
**3** Whenever you complete real coding work, **you must immediately use @backend/@frontend to review the code changes and requirement coverage**.
**4** @backend and @frontend provide references only. You **must** think independently and even question their answers. Blind trust is worse than no trust; your joint mission is to converge on a unified, comprehensive, precise result, which requires continuous debate to reach the truth.

## The Two Rules

1. **Main rule (Fail-Closed Gate):** If you decide `Routing != CLAUDE`, you MUST obtain external output, or STOP in `BLOCKED`.

2. **Early exposure:** If you decide `Routing != CLAUDE`, run the external call **before** doing real work (writing code, generating tests, or producing final conclusions).

## Checkpoint Workflow

At skill checkpoints (CP1/CP2/CP3):

1. Decide routing using `superpowers-ccg-coordinating-multi-model-work/routing-decision.md`
2. If `Routing != CLAUDE`, apply `superpowers-ccg-coordinating-multi-model-work/GATE.md` immediately (evidence or BLOCKED)
3. Continue only after evidence is recorded

## Reference Files

- **Checkpoint logic:** `superpowers-ccg-coordinating-multi-model-work/checkpoints.md`
- **Routing framework (semantic):** `superpowers-ccg-coordinating-multi-model-work/routing-decision.md`
- **Fail-closed gate + evidence format:** `superpowers-ccg-coordinating-multi-model-work/GATE.md`
- **Invocation templates:** `superpowers-ccg-coordinating-multi-model-work/INTEGRATION.md`
- **Quick heuristics (non-normative):** `superpowers-ccg-coordinating-multi-model-work/routing-rules.md`
