---
name: executing-plans
description: Use when you have a written implementation plan to execute in a separate session with review checkpoints
---

# Executing Plans

## Overview

Load plan, review critically, execute tasks in batches, report for review between batches.

**Core principle:** Batch execution with checkpoints for architect review.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

## The Process

### Step 1: Load and Review Plan
1. Read plan file
2. Review critically - identify any questions or concerns about the plan
3. If concerns: Raise them with your human partner before starting
4. If no concerns: Create TodoWrite and proceed

### Step 2: Execute Batch
**Default: First 3 tasks**

For each task:
1. Mark as in_progress
2. Follow each step exactly (plan has bite-sized steps)
3. Run verifications as specified
4. Mark as completed

### Step 3: Report
When batch complete:
- Show what was implemented
- Show verification output
- Say: "Ready for feedback."

### Step 4: Continue
Based on feedback:
- Apply changes if needed
- Execute next batch
- Repeat until complete

### Step 5: Complete Development

After all tasks complete and verified:
- Announce: "I'm using the finishing-a-development-branch skill to complete this work."
- **REQUIRED SUB-SKILL:** Use superpowers:finishing-a-development-branch
- Follow that skill to verify tests, present options, execute choice

## When to Stop and Ask for Help

**STOP executing immediately when:**
- Hit a blocker mid-batch (missing dependency, test fails, instruction unclear)
- Plan has critical gaps preventing starting
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## When to Revisit Earlier Steps

**Return to Review (Step 1) when:**
- Partner updates the plan based on your feedback
- Fundamental approach needs rethinking

**Don't force through blockers** - stop and ask.

## Remember
- Review plan critically first
- Follow plan steps exactly
- Don't skip verifications
- Reference skills when plan says to
- Between batches: just report and wait
- Stop when blocked, don't guess

## Multi-Model Task Execution

**Related skill:** superpowers:multi-model-core

执行计划时，根据任务特征自动路由到最适合的模型：

**Routing logic:**

1. 检查任务是否有 `Model hint` 标注
2. 如果有标注且不是 `auto`，按标注路由
3. 如果是 `auto` 或无标注，综合判断：
   - 文件类型（`.go`, `.py` → Codex; `.tsx`, `.vue` → Gemini）
   - 目录结构（`server/`, `api/` → Codex; `components/`, `pages/` → Gemini）
   - 任务关键词（API、数据库 → Codex; UI、样式 → Gemini）

**Execution with external model:**

```bash
# 根据路由结果调用对应模型
codeagent-wrapper --backend <codex|gemini> - "$PWD" <<'EOF'
## 任务背景
[从计划中提取的上下文]

## 具体任务
[任务的详细步骤]

## 验证要求
[期望的验证命令和输出]
EOF
```

**Cross-validation tasks:**

对于标注为 `cross-validation` 的任务，或 Claude 判断需要交叉验证的任务：

1. 并行调用 Codex 和 Gemini
2. 整合两方结果
3. 解决分歧后执行

**Fallback:** 如果外部模型不可用，Claude 直接执行任务。
