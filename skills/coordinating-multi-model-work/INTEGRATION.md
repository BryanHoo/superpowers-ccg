# Subagent Integration Guide

This file provides standard integration patterns for other skills to use subagent capabilities.

## Quick Reference

```
Task Type → Subagent Selection:
├─ Frontend (UI, components, styles) → @frontend
├─ Backend (API, database, logic) → @backend
├─ Full-stack or uncertain → CROSS_VALIDATION (both @backend and @frontend)
├─ Design docs, implementation docs, requirements specs, architecture docs, and other critical documentation → CROSS_VALIDATION
└─ Simple (docs, configs) → CLAUDE (no subagent needed)
```

## Standard Integration Section

Copy this section to your skill and customize the prompts:

```markdown
## Subagent Integration

**Related skill:** superpowers-ccg-coordinating-multi-model-work

For tasks requiring specialized expertise, apply semantic routing:

1. **Analyze task domain** using `superpowers-ccg-coordinating-multi-model-work/routing-decision.md`
2. **Notify user**: "I will use [subagent] to [task purpose]"
3. **Invoke subagent** with English prompts (@backend for backend, @frontend for frontend)
4. **Integrate results** before proceeding

**Fallback (Fail-Closed):** If the subagent call fails or times out, STOP and follow `superpowers-ccg-coordinating-multi-model-work/GATE.md`.
```

## Invocation Templates

### Backend Analysis (@backend)

```
@backend 请从后端角度分析以下问题：

## 上下文
[问题描述/任务背景]

## 代码位置（如适用）
文件: [file_path]
行: [start_line]-[end_line]

## 分析重点
1. API 设计和实现
2. 数据流和状态管理
3. 性能和安全考虑

## 期望输出
- 评估结论（优缺点/风险）
- 具体建议

请只返回 unified diff patch 格式的修改建议。
```

### Frontend Analysis (@frontend)

```
@frontend 请从前端角度分析以下问题：

## 上下文
[问题描述/任务背景]

## 代码位置（如适用）
文件: [file_path]
行: [start_line]-[end_line]

## 分析重点
1. 组件结构和渲染
2. 用户交互和体验
3. 可访问性和响应式设计

## 期望输出
- 评估结论（优缺点/风险）
- 具体建议

请只返回 unified diff patch 格式的修改建议。
```

### Cross-Validation (Both)

Invoke both subagents in parallel, then integrate:

```markdown
## Cross-Validation Results

### Backend Analysis (via `@backend`)

[Results]

### Frontend Analysis (via `@frontend`)

[Results]

### Integrated Conclusion

- **Agreement**: [Consistent findings]
- **Divergence**: [Differences]
- **Recommendation**: [Final determination]
```

## Important Rules

1. **All prompts to subagents MUST be in English**
2. User notifications follow user's configured language
3. Always validate subagent outputs before using
4. Claude handles simple tasks directly (no subagent needed)