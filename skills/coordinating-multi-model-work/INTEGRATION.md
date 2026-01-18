# Multi-Model Integration Guide

This file provides standard integration patterns for other skills to use multi-model capabilities.

## Quick Reference

```
Task Type → Model Selection:
├─ Frontend (UI, components, styles) → GEMINI
├─ Backend (API, database, logic) → CODEX
├─ Full-stack or uncertain → CROSS_VALIDATION
└─ Simple (docs, configs) → CLAUDE (no external model needed)
```

## Standard Integration Section

Copy this section to your skill and customize the prompts:

```markdown
## Multi-Model Integration

**Related skill:** superpowers:coordinating-multi-model-work

For tasks requiring specialized expertise, apply semantic routing:

1. **Analyze task domain** using `coordinating-multi-model-work/routing-decision.md`
2. **Notify user**: "我将使用 [model] 来 [task purpose]"
3. **Invoke model** with English prompts via codeagent-wrapper
4. **Integrate results** before proceeding

**Fallback:** If codeagent-wrapper unavailable, continue with Claude's analysis.
```

## Invocation Templates

### Backend Analysis (Codex)

```bash
codeagent-wrapper --backend codex - "$PWD" <<'EOF'
## Context
[Problem/task description]

## Analysis Focus
1. API design and implementation
2. Data flow and state management
3. Performance and security considerations

## Expected Output
- Assessment with strengths/risks
- Specific recommendations
EOF
```

### Frontend Analysis (Gemini)

```bash
codeagent-wrapper --backend gemini - "$PWD" <<'EOF'
## Context
[Problem/task description]

## Analysis Focus
1. Component structure and rendering
2. User interaction and experience
3. Accessibility and responsive design

## Expected Output
- Assessment with strengths/risks
- Specific recommendations
EOF
```

### Cross-Validation (Both)

Invoke both models in parallel, then integrate:

```markdown
## Cross-Validation Results

### Codex Analysis (Backend)
[Results]

### Gemini Analysis (Frontend)
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
