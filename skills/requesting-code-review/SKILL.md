---
name: requesting-code-review
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements
---

# Requesting Code Review

Dispatch superpowers:code-reviewer subagent to catch issues before they cascade.

**Core principle:** Review early, review often.

## When to Request Review

**Mandatory:**
- After each task in subagent-driven development
- After completing major feature
- Before merge to main

**Optional but valuable:**
- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing complex bug

## How to Request

**1. Get git SHAs:**
```bash
BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

**2. Dispatch code-reviewer subagent:**

Use Task tool with superpowers:code-reviewer type, fill template at `code-reviewer.md`

**Placeholders:**
- `{WHAT_WAS_IMPLEMENTED}` - What you just built
- `{PLAN_OR_REQUIREMENTS}` - What it should do
- `{BASE_SHA}` - Starting commit
- `{HEAD_SHA}` - Ending commit
- `{DESCRIPTION}` - Brief summary

**3. Act on feedback:**
- Fix Critical issues immediately
- Fix Important issues before proceeding
- Note Minor issues for later
- Push back if reviewer is wrong (with reasoning)

## Example

```
[Just completed Task 2: Add verification function]

You: Let me request code review before proceeding.

BASE_SHA=$(git log --oneline | grep "Task 1" | head -1 | awk '{print $1}')
HEAD_SHA=$(git rev-parse HEAD)

[Dispatch superpowers:code-reviewer subagent]
  WHAT_WAS_IMPLEMENTED: Verification and repair functions for conversation index
  PLAN_OR_REQUIREMENTS: Task 2 from docs/plans/deployment-plan.md
  BASE_SHA: a7981ec
  HEAD_SHA: 3df7661
  DESCRIPTION: Added verifyIndex() and repairIndex() with 4 issue types

[Subagent returns]:
  Strengths: Clean architecture, real tests
  Issues:
    Important: Missing progress indicators
    Minor: Magic number (100) for reporting interval
  Assessment: Ready to proceed

You: [Fix progress indicators]
[Continue to Task 3]
```

## Integration with Workflows

**Subagent-Driven Development:**
- Review after EACH task
- Catch issues before they compound
- Fix before moving to next task

**Executing Plans:**
- Review after each batch (3 tasks)
- Get feedback, apply, continue

**Ad-Hoc Development:**
- Review before merge
- Review when stuck

## Red Flags

**Never:**
- Skip review because "it's simple"
- Ignore Critical issues
- Proceed with unfixed Important issues
- Argue with valid technical feedback

**If reviewer wrong:**
- Push back with technical reasoning
- Show code/tests that prove it works
- Request clarification

See template at: requesting-code-review/code-reviewer.md

## Multi-Model Code Review

**Related skill:** superpowers:multi-model-core

对于涉及前后端的代码变更，可以使用双模型交叉审查：

**When to trigger:**
- 变更同时涉及前端和后端代码
- 关键功能的代码审查
- 需要多视角验证的复杂变更

**How to use:**

```bash
# 获取变更范围
BASE_SHA=$(git rev-parse HEAD~1)
HEAD_SHA=$(git rev-parse HEAD)
DIFF=$(git diff $BASE_SHA $HEAD_SHA)

# Codex 审查（后端视角）
codeagent-wrapper --backend codex - "$PWD" <<EOF
## 代码审查请求

### 变更范围
$DIFF

### 请从后端角度审查
1. API 设计和实现是否正确
2. 数据处理和验证是否完善
3. 性能和安全性考虑
4. 错误处理是否充分

### 输出格式
- Critical: [必须修复的问题]
- Important: [应该修复的问题]
- Minor: [建议改进的地方]
- Strengths: [做得好的地方]
EOF

# Gemini 审查（前端视角）
codeagent-wrapper --backend gemini - "$PWD" <<EOF
## 代码审查请求

### 变更范围
$DIFF

### 请从前端角度审查
1. 组件设计和结构是否合理
2. 用户体验和交互是否流畅
3. 样式和响应式是否完善
4. 可访问性是否考虑

### 输出格式
- Critical: [必须修复的问题]
- Important: [应该修复的问题]
- Minor: [建议改进的地方]
- Strengths: [做得好的地方]
EOF
```

**Result integration:**

```markdown
## 双模型代码审查报告

### Codex 审查（后端视角）
[Codex 的审查结果]

### Gemini 审查（前端视角）
[Gemini 的审查结果]

### 综合评估
- **Critical issues**: [合并两方的 Critical 问题]
- **Important issues**: [合并两方的 Important 问题]
- **Overall assessment**: [综合评价]
```

**Fallback:** 如果外部模型不可用，使用 Claude subagent 进行审查。
