# Multi-Model Integration Guide

This file provides standard integration patterns for other skills to use multi-model capabilities.

## Quick Reference

```
Task Type → Model Selection:
├─ Frontend (UI, components, styles) → GEMINI
├─ Backend (API, database, logic) → CODEX
├─ Full-stack or uncertain → CROSS_VALIDATION
├─ Design docs, implementation docs, requirements specs, architecture docs, and other critical documentation → CROSS_VALIDATION
└─ Simple (docs, configs) → CLAUDE (no external model needed)
```

## Standard Integration Section

Copy this section to your skill and customize the prompts:

```markdown
## Multi-Model Integration

**Related skill:** superpowers:coordinating-multi-model-work

For tasks requiring specialized expertise, apply semantic routing:

1. **Analyze task domain** using `coordinating-multi-model-work/routing-decision.md`
2. **Notify user**: "I will use [model] to [task purpose]"
3. **Invoke model** with English prompts via the MCP tools (`mcp__codex__codex` for backend, `mcp__gemini__gemini` for frontend)
4. **Integrate results** before proceeding

**Fallback (Fail-Closed):** If the MCP tool call fails or times out, STOP and follow `coordinating-multi-model-work/GATE.md`.
```

## Invocation Templates

### Backend Analysis (Codex MCP)

```json
{
  "tool": "mcp__codex__codex",
  "params": {
    "PROMPT": "## Context\n[Problem/task description]\n\n## Code Location (if applicable)\nFile: [file_path]\nLines: [start_line]-[end_line]\n\nNote: Use your CLI tools to read the file at the specified location.\n\n## Analysis Focus\n1. API design and implementation\n2. Data flow and state management\n3. Performance and security considerations\n\n## Expected Output\n- Assessment with strengths/risks\n- Specific recommendations",
    "cd": "$PWD",
    "sandbox": "default",
    "SESSION_ID": "<reuse-or-new>",
    "model": "codex-latest"
  }
}
```

### Frontend Analysis (Gemini MCP)

```json
{
  "tool": "mcp__gemini__gemini",
  "params": {
    "PROMPT": "## Context\n[Problem/task description]\n\n## Code Location (if applicable)\nFile: [file_path]\nLines: [start_line]-[end_line]\n\nNote: Use your CLI tools to read the file at the specified location.\n\n## Analysis Focus\n1. Component structure and rendering\n2. User interaction and experience\n3. Accessibility and responsive design\n\n## Expected Output\n- Assessment with strengths/risks\n- Specific recommendations",
    "sandbox": "default",
    "SESSION_ID": "<reuse-or-new>",
    "model": "gemini-latest"
  }
}
```

### Cross-Validation (Both)

Invoke both MCP tools in parallel, then integrate:

```markdown
## Cross-Validation Results

### Codex Analysis (Backend via mcp**codex**codex)

[Results]

### Gemini Analysis (Frontend via mcp**gemini**gemini)

[Results]

### Integrated Conclusion

- **Agreement**: [Consistent findings]
- **Divergence**: [Differences]
- **Recommendation**: [Final determination]
```

## Important Rules

1. **All prompts to external models MUST be in English**
2. User notifications follow user's configured language
3. Always validate external model outputs before using
4. Claude handles simple tasks directly (no external model needed)
