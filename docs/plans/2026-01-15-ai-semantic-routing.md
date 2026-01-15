# AI 语义路由判断系统实施计划

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 将多模型路由决策从基于规则的评分算法改为 AI 语义判断，提升路由决策的灵活性和智能性。

**Architecture:** 创建新的路由决策框架文件 (routing-decision.md)，定义 Claude 进行语义判断的分析维度和输出格式。更新 multi-model-core 主文档说明新的路由机制，并更新 8 个相关技能文件，将其中的硬编码规则评分逻辑替换为语义判断引导。

**Tech Stack:** Markdown 文档、Shell 脚本（用于 codeagent-wrapper 调用）

---

## Task 1: 创建路由决策框架文档

**Model hint:** `auto`

**Files:**
- Create: `skills/multi-model-core/routing-decision.md`

**Step 1: 创建路由决策框架文档**

创建文件 `skills/multi-model-core/routing-decision.md`，内容参考设计文档中的决策框架部分，包含：
- 分析维度（任务本质、技术领域、复杂度）
- 决策输出格式
- 用户通知格式
- 示例场景

**Step 2: 验证文档创建**

```bash
ls -la skills/multi-model-core/routing-decision.md
```

Expected: File exists

**Step 3: 提交更改**

```bash
git add skills/multi-model-core/routing-decision.md
git commit -m "feat: add routing decision framework for AI semantic routing"
```

---

## Task 2: 更新 multi-model-core 主文档

**Model hint:** `auto`

**Files:**
- Modify: `skills/multi-model-core/SKILL.md:57-75`

**Step 1: 修改路由规则章节**

将"Routing Rules"章节替换为"Routing Decision Process"，说明：
- 使用语义分析替代硬编码规则
- 参考 routing-decision.md 框架
- routing-rules.md 仅作为参考知识

**Step 2: 验证修改**

```bash
grep -A 20 "Routing Decision" skills/multi-model-core/SKILL.md
```

**Step 3: 提交更改**

```bash
git add skills/multi-model-core/SKILL.md
git commit -m "docs: update multi-model-core to use semantic routing"
```

---

## Task 3: 更新 brainstorming 技能

**Model hint:** `auto`

**Files:**
- Modify: `skills/brainstorming/SKILL.md`

**Step 1: 更新多模型设计验证章节**

在"Multi-Model Design Validation"章节中，将触发条件从固定规则改为语义分析过程。

**Step 2: 提交更改**

```bash
git add skills/brainstorming/SKILL.md
git commit -m "refactor: brainstorming uses semantic routing for design validation"
```

---

## Task 4: 更新 systematic-debugging 技能

**Model hint:** `auto`

**Files:**
- Modify: `skills/systematic-debugging/SKILL.md`

**Step 1: 添加语义路由指导**

在交叉验证部分添加语义路由决策流程。

**Step 2: 提交更改**

```bash
git add skills/systematic-debugging/SKILL.md
git commit -m "refactor: systematic-debugging uses semantic routing for cross-validation"
```

---

## Task 5: 更新 executing-plans 技能

**Model hint:** `auto`

**Files:**
- Modify: `skills/executing-plans/SKILL.md`

**Step 1: 添加任务执行路由逻辑**

说明如何使用语义分析来路由计划中的每个任务。

**Step 2: 提交更改**

```bash
git add skills/executing-plans/SKILL.md
git commit -m "refactor: executing-plans uses semantic routing for task distribution"
```

---

## Task 6: 更新 subagent-driven-development 技能

**Model hint:** `auto`

**Files:**
- Modify: `skills/subagent-driven-development/SKILL.md`

**Step 1: 添加子任务路由策略**

说明如何使用语义分析来分发子任务到不同模型。

**Step 2: 提交更改**

```bash
git add skills/subagent-driven-development/SKILL.md
git commit -m "refactor: subagent-driven-development uses semantic routing for subtask dispatch"
```

---

## Task 7: 更新 requesting-code-review 技能

**Model hint:** `auto`

**Files:**
- Modify: `skills/requesting-code-review/SKILL.md`

**Step 1: 添加代码审查路由逻辑**

说明如何根据代码域选择审查策略。

**Step 2: 提交更改**

```bash
git add skills/requesting-code-review/SKILL.md
git commit -m "refactor: requesting-code-review uses semantic routing for review strategy"
```

---

## Task 8: 更新 test-driven-development 技能

**Model hint:** `auto`

**Files:**
- Modify: `skills/test-driven-development/SKILL.md`

**Step 1: 添加测试生成路由指导**

说明如何根据被测试代码类型选择模型。

**Step 2: 提交更改**

```bash
git add skills/test-driven-development/SKILL.md
git commit -m "refactor: test-driven-development uses semantic routing for test generation"
```

---

## Task 9: 更新 verification-before-completion 技能

**Model hint:** `auto`

**Files:**
- Modify: `skills/verification-before-completion/SKILL.md`

**Step 1: 添加验证路由指导**

说明如何根据验证范围选择策略。

**Step 2: 提交更改**

```bash
git add skills/verification-before-completion/SKILL.md
git commit -m "refactor: verification-before-completion uses semantic routing"
```

---

## Task 10: 更新 writing-plans 技能

**Model hint:** `auto`

**Files:**
- Modify: `skills/writing-plans/SKILL.md`

**Step 1: 更新 Model hint 说明**

说明 model hint 是建议而非强制，实际执行使用语义分析。

**Step 2: 提交更改**

```bash
git add skills/writing-plans/SKILL.md
git commit -m "refactor: writing-plans explains semantic routing for model hints"
```

---

## Task 11: 更新项目 README

**Model hint:** `auto`

**Files:**
- Modify: `README-zh.md`
- Modify: `README.md`

**Step 1: 更新路由机制说明**

将固定规则说明改为语义分析说明。

**Step 2: 提交更改**

```bash
git add README-zh.md README.md
git commit -m "docs: update README to reflect semantic routing mechanism"
```

---

## Task 12: 最终验证

**Model hint:** `auto`

**Step 1: 检查所有修改**

```bash
git status
git log --oneline -15
```

**Step 2: 验证引用一致性**

```bash
grep -r "routing-decision.md" skills/*/SKILL.md
```

Expected: 所有更新的技能都引用了新框架

**Step 3: 创建汇总提交（如需要）**

```bash
git log --oneline feature/ai-semantic-routing
```

---

## Completion Checklist

- [ ] Created `routing-decision.md` framework
- [ ] Updated `multi-model-core/SKILL.md`
- [ ] Updated 8 skills (brainstorming, systematic-debugging, executing-plans, subagent-driven-development, requesting-code-review, test-driven-development, verification-before-completion, writing-plans)
- [ ] Updated README documentation
- [ ] Final verification

## Success Criteria

1. Framework provides clear semantic analysis guidance
2. All skills reference the new framework
3. Documentation is updated and consistent
4. Backward compatible with existing workflows
