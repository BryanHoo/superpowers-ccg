# Superpowers-CCG

中文 | [English](README.md)

Superpowers-CCG 是基于 [Superpowers](https://github.com/obra/superpowers) 的增强版本，融合了 CCG（Claude + Codex + Gemini）多模型协作能力。

## 核心特性

- **Superpowers 方法论** - 完整的软件开发工作流（brainstorming → planning → TDD → code review）
- **多模型协作** - 自动路由任务到最适合的模型（Codex 后端、Gemini 前端）
- **交叉验证** - 复杂问题和设计决策时双模型验证

## 工作原理

当你启动 coding agent 时，它不会直接写代码，而是先理解你的需求，通过对话提炼出设计方案。

设计确认后，agent 会制定详细的实施计划，强调 TDD、YAGNI 和 DRY 原则。

执行阶段，agent 会根据任务特征**自动路由**到最适合的模型：

- **前端任务**（组件、样式、交互）→ Gemini
- **后端任务**（API、数据库、算法）→ Codex
- **全栈/复杂问题** → 双模型交叉验证

整个过程中，Claude 负责编排决策和代码审核，确保质量。

## 安装

### 1. 安装 Superpowers-CCG 插件

**Claude Code（通过 Plugin Marketplace）**

```bash
# 添加 marketplace
/plugin marketplace add https://github.com/BryanHoo/superpowers-ccg

# 安装插件
/plugin install superpowers-ccg@BryanHoo-superpowers-ccg
```

安装完成后，`codeagent-wrapper` 会自动配置到 `~/.claude/bin/` 目录，无需手动复制。

### 2. 配置多模型调用能力（可选但推荐）

> 不配置全局提示在某些情况下，Claude默认倾向自己解决

在 `~/.claude/CLAUDE.md` 中添加以下内容，让 Claude 知道它拥有这个能力

```markdown
**⚠️ Important Notice: You Have Multi-Model Invocation Capabilities**

If you are Claude, please note: You can invoke external models (Codex and Gemini) through the `codeagent-wrapper` tool. This is NOT a hypothetical capability - it is a real and available feature.

**Your Capabilities:**

- Invoke **Codex** for backend tasks (APIs, databases, algorithms, performance optimization)
- Invoke **Gemini** for frontend tasks (UI, components, styles, interactions)
- Invoke **dual-model cross-validation** for complex full-stack problems

**How to Use:**
Check the `coordinating-multi-model-work` skill for the complete routing decision framework and invocation methods. This skill includes:

- Semantic routing decision process (`routing-decision.md`)
- Invocation templates and integration patterns (`INTEGRATION.md`)
- Collaboration checkpoint logic (`checkpoints.md`)
```

## 基本工作流

1. **brainstorming** - 在写代码前激活。通过提问提炼想法，探索替代方案，分段展示设计供验证。保存设计文档。

2. **using-git-worktrees** - 设计批准后激活。创建隔离的工作空间和新分支，运行项目设置，验证测试基线。

3. **writing-plans** - 有了批准的设计后激活。将工作分解为小任务（每个 2-5 分钟）。每个任务都有精确的文件路径、完整代码和验证步骤。**支持 Model hint 标注**，指定任务路由到哪个模型。

4. **developing-with-subagents** 或 **executing-plans** - 有了计划后激活。每个任务分发给新的 subagent，进行两阶段审查（规格合规性 + 代码质量），或分批执行并设置人工检查点。**自动路由任务到 Codex/Gemini**。

5. **practicing-test-driven-development** - 实施期间激活。强制执行 RED-GREEN-REFACTOR：写失败的测试，看它失败，写最小代码，看它通过，提交。**支持按技术栈路由测试生成**。

6. **requesting-code-review** - 任务之间激活。根据计划审查，按严重程度报告问题。**支持双模型交叉审查**。

7. **finishing-development-branches** - 任务完成时激活。验证测试，展示选项（合并/PR/保留/丢弃），清理 worktree。

**Agent 在任何任务前都会检查相关 skills。** 这是强制性工作流，不是建议。

## 多模型能力

### coordinating-multi-model-work

核心模块，提供自动路由和交叉验证能力：

> **重要提示**：模型间通信使用英语。所有发送给 Codex/Gemini 的提示词、任务描述必须使用英语，这确保了多模型协作的标准化和高效性。与用户的交互仍然遵循用户的语言配置。

**路由机制：**

- **语义分析** - Claude 分析任务描述、文件类型和技术栈，智能判断应该路由到哪个模型
- **决策因素** - 任务本质（UI/逻辑/数据）、技术领域（前端/后端）、复杂度（单一/跨域）
- **路由目标** - Gemini（前端）、Codex（后端）、交叉验证（全栈/不确定）、Claude（简单任务）

**交叉验证触发：**

- 全栈问题（前后端交互）
- 高不确定性（多种可能原因）
- 设计决策（架构选择）
- 复杂 bug（难以定位）

### 增强的 Skills

| Skill                              | 多模型能力                          |
| ---------------------------------- | ----------------------------------- |
| debugging-systematically           | 交叉验证诊断及嵌入检查点            |
| brainstorming                      | 多模型设计评估及 CP1/CP2 检查点     |
| writing-plans                      | 任务路由标注及 CP1/CP3 检查点       |
| executing-plans                    | 自动路由执行及 CP1/CP2/CP3 检查点   |
| developing-with-subagents          | 多模型任务分发及 CP1/CP2/CP3 检查点 |
| requesting-code-review             | 双模型代码审查及 CP3 检查点         |
| practicing-test-driven-development | 测试生成路由及 CP1/CP3 检查点       |
| verifying-before-completion        | 交叉验证确认及 CP3 检查点           |

## Skills 库

### 测试

- **practicing-test-driven-development** - 精简的 RED-GREEN-REFACTOR 循环，含主动多模型检查点（包含测试反模式参考）

### 调试

- **debugging-systematically** - 精简的 4 阶段根因分析流程，含主动多模型检查点（包含 root-cause-tracing、defense-in-depth、condition-based-waiting 技术）
- **verifying-before-completion** - 确保问题真正修复（含 CP3 检查点）

### 协作

- **brainstorming** - 苏格拉底式设计提炼
- **writing-plans** - 详细实施计划
- **executing-plans** - 分批执行带检查点
- **dispatching-parallel-agents** - 并发 subagent 工作流
- **requesting-code-review** - 预审查清单
- **receiving-code-review** - 响应反馈
- **using-git-worktrees** - 并行开发分支
- **finishing-development-branches** - 合并/PR 决策工作流
- **developing-with-subagents** - 快速迭代带两阶段审查

### 多模型

- **coordinating-multi-model-work** - 多模型调用核心（路由规则、交叉验证、提示词模板、主动协作检查点）

## 设计理念

- **测试驱动开发** - 始终先写测试
- **系统化优于临时** - 流程优于猜测
- **降低复杂度** - 简单性是首要目标
- **证据优于声明** - 验证后再宣布成功
- **多模型协作** - 专业模型处理专业任务
- **简化文档** - 遵循 Anthropic 最佳实践，删除 Claude 已知的冗余解释内容
- **主动协作** - 嵌入自主决策检查点用于多模型协作

更多阅读: [Superpowers for Claude Code](https://blog.fsck.com/2025/10/09/superpowers/)

## 贡献

Skills 直接存放在此仓库中。贡献方式：

1. Fork 仓库
2. 为你的 skill 创建分支
3. 按照 `writing-skills` skill 创建和测试新 skills
4. 提交 PR

详见 `skills/writing-skills/SKILL.md`。

## 更新

通过更新插件来更新 skills：

```bash
/plugin update superpowers-ccg
```

## 评估和检查清单

Superpowers-CCG 框架包括系统性评估场景和工作流检查清单，以确保一致的进度跟踪：

- **评估场景** - 关键技能的综合测试场景，记录在 `EVALUATION.md` 中
- **工作流检查清单** - 适用于 executing-plans 和 developing-with-subagents 的可复制检查清单模板
- **多模型检查点** - 主动协作检查点，使 Claude 能够自主决定在关键阶段何时调用 Codex/Gemini

### 多模型协作检查点

该框架现在在 8 个关键技能中嵌入了协作检查点：

- **CP1（任务分析）** - 任务开始前评估
- **CP2（中期审查）** - 在关键决策点调用
- **CP3（质量门）** - 完成前审查

这些检查点集成到：

- brainstorming: CP1（想法分析），CP2（方法探索）
- writing-plans: CP1（计划开始），CP3（执行交接）
- executing-plans: CP1/CP2/CP3（每项任务检查点）
- developing-with-subagents: CP1/CP2/CP3（分派/执行/审查）
- practicing-test-driven-development: CP1（RED 阶段），CP3（GREEN 阶段）
- debugging-systematically: CP1（调查），CP2（假设测试）
- requesting-code-review: CP3（审查调用）
- verifying-before-completion: CP3（最终验证）

## 架构

```
Claude Code (编排)
       │
   ┌───┴───┐
   ↓       ↓
Codex   Gemini
(后端)   (前端)
   │       │
   └───┬───┘
       ↓
  Unified Patch
```

外部模型无写入权限，仅返回 Patch，由 Claude 审核后应用。

## 许可证

MIT License - 详见 LICENSE 文件

## 支持

- **Issues**: https://github.com/BryanHoo/superpowers-ccg/issues

## 致谢

- [obra/superpowers](https://github.com/obra/superpowers) - 原始 Superpowers 项目
- [fengshao1227/ccg-workflow](https://github.com/fengshao1227/ccg-workflow) - CCG 工作流
- [cexll/myclaude](https://github.com/cexll/myclaude) - codeagent-wrapper
