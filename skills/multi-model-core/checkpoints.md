# Collaboration Checkpoints

## Overview

嵌入式检查点使 Claude 能够在技能执行的关键阶段自主决定是否调用外部模型（Codex/Gemini）。

**核心原则：** Claude 自主评估并决策，仅在实际调用时通知用户。

## Checkpoint Types

| 检查点 | 时机 | 目的 |
|--------|------|------|
| **CP1: Task Analysis** | 任务开始前 | 确定是否需要专家模型参与 |
| **CP2: Mid-Review** | 关键决策点 | 对不确定的问题寻求第二意见 |
| **CP3: Quality Gate** | 完成前 | 让专家模型审查输出 |

## Checkpoint 1: Task Analysis

**收集信息：**
- 任务描述和目标
- 涉及的文件和目录
- 技术栈和框架

**评估流程：**
1. 检查关键任务条件 → 匹配：直接调用
2. 评估一般任务信号 → 正向：调用
3. 两者都不满足：Claude 独立处理

## Checkpoint 2: Mid-Review

**触发条件：**
- 多个实现方案需要选择
- 发现潜在性能/安全问题
- 调试陷入停滞

**行为：** 主动调用交叉验证获取多角度视角

## Checkpoint 3: Quality Gate

**触发条件：**
- 代码生成完成，准备提交
- 修复完成，准备验证

**行为：** 调用领域专家进行审查

---

## Critical Task Detection

**关键任务自动触发外部模型，无需用户确认。**

### Core Business Logic
```
关键词: payment, auth, security, transaction, encryption
关键词(中文): 认证, 支付, 权限, 加密, 交易
```

### Architecture Design
```
- 创建新目录结构
- 修改跨越 3+ 模块
- 关键词: design, architecture, refactor, 设计, 架构, 重构
```

### Complexity Metrics
```
- 修改文件 ≥ 3
- 预计代码行数 ≥ 100
- 跨前后端修改
```

### Debug Complexity
```
- 错误信息不明确
- 2+ 次修复尝试失败
- 涉及异步/并发/状态管理
```

---

## General Task Evaluation

**对于非关键任务，Claude 评估：**

1. **预期收益** - 专家模型是否会显著改善结果？
2. **领域清晰度** - 是否明确是前端或后端？
3. **成本效益** - 调用成本是否值得预期改善？

**评估正向 → 静默调用并通知用户。**

---

## Autonomous Decision Flow

```
Claude 自主决策流程:
┌─────────────────────────────────────────────────┐
│  检查点触发                                      │
│     ↓                                           │
│  收集任务信息 (文件, 技术栈, 复杂度)               │
│     ↓                                           │
│  关键任务? ──是──→ 调用模型, 通知用户              │
│     ↓ 否                                        │
│  一般任务评估:                                   │
│  - 预期收益 > 调用成本?                          │
│  - 领域明确 (前端/后端)?                         │
│     ↓                                           │
│  值得调用? ──是──→ 调用模型, 通知用户              │
│     ↓ 否                                        │
│  Claude 独立处理 (无通知)                        │
└─────────────────────────────────────────────────┘
```

---

## User Notification

**仅在实际调用时通知（一句话）：**

```
我将使用 Codex 来优化这个数据库查询
我将使用 Gemini 来审查这个组件实现
我将使用交叉验证来分析这个全栈问题
```

**Claude 独立处理时不通知。**

---

## Model Selection

使用 `routing-decision.md` 中的语义路由规则：

| 任务类型 | 模型 |
|----------|------|
| 后端 (API, 数据库, 算法) | CODEX |
| 前端 (UI, 组件, 样式) | GEMINI |
| 全栈或不确定 | CROSS_VALIDATION |
| 简单任务 | CLAUDE |

---

## Invocation Template

调用外部模型时使用 `INTEGRATION.md` 中的模板。

**重要：** 所有发送给外部模型的提示必须使用英文。

---

## Fallback Handling

**外部模型调用失败时：**

1. 记录失败原因
2. 通知用户: "注意: [模型]不可用，将使用 Claude 继续"
3. Claude 独立完成任务
4. 在输出中标注未使用外部模型

---

## Embedding in Skills

在技能中嵌入检查点时，添加以下引用：

```markdown
## Collaboration Checkpoint

**At this stage, apply checkpoint logic from `multi-model-core/checkpoints.md`:**

1. Collect task information (files, stack, complexity)
2. Check critical task conditions → Match: invoke directly
3. Evaluate general task signals → Positive: invoke
4. Neither: Claude handles independently

If invoking: Notify user with one sentence.
```

---

## User Override

用户可以覆盖自主决策：

| 用户命令 | 行为 |
|----------|------|
| "用 Codex" | 强制使用 Codex |
| "用 Gemini" | 强制使用 Gemini |
| "都用" / "交叉验证" | 强制交叉验证 |
| "不要用外部模型" | Claude 独立处理 |
