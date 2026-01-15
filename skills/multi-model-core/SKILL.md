---
name: multi-model-core
description: 多模型调用核心模块 - 提供 Codex/Gemini 自动路由和交叉验证能力
---

# 多模型调用核心模块

## 概述

本模块为 superpowers skills 提供多模型调用能力，通过 codeagent-wrapper 调用 Codex（后端专家）和 Gemini（前端专家）。

**核心特性**：
- **自动路由** - 根据任务特征智能选择模型
- **交叉验证** - 复杂场景双模型验证
- **无缝集成** - 其他 skills 按需引用

## 前置条件

使用多模型功能前，需要安装 codeagent-wrapper：

**方式一：通过 ccg-workflow 安装（推荐）**

```bash
npx ccg-workflow
```

**方式二：手动安装**

```bash
# 创建目录
mkdir -p ~/.claude/bin

# 下载对应平台的二进制（以 macOS ARM64 为例）
curl -L https://github.com/anthropics/ccg-workflow/releases/latest/download/codeagent-wrapper-darwin-arm64 \
  -o ~/.claude/bin/codeagent-wrapper

# 添加执行权限
chmod +x ~/.claude/bin/codeagent-wrapper
```

**验证安装：**

```bash
~/.claude/bin/codeagent-wrapper --help
```

**外部模型 CLI（可选）：**
- Codex CLI: `npm install -g @openai/codex`
- Gemini CLI: `npm install -g @google/gemini-cli`

## 使用方式

### 1. 判断是否需要外部模型

在 skill 执行过程中，遇到以下情况时考虑调用外部模型：

- 需要深度分析特定技术栈代码
- 需要专业领域的设计建议
- 需要多角度验证方案或诊断

### 2. 路由判断

综合以下因素判断路由目标：

| 因素 | Gemini（前端） | Codex（后端） |
|------|---------------|---------------|
| **文件类型** | `.tsx`, `.vue`, `.css`, `.scss`, `.html`, `.svelte` | `.go`, `.py`, `.java`, `.rs`, `.sql`, `.sh` |
| **目录** | `components/`, `pages/`, `styles/`, `ui/`, `frontend/` | `server/`, `api/`, `services/`, `backend/`, `cmd/` |
| **关键词** | UI, 样式, 组件, 布局, 动画, 响应式, 交互 | API, 数据库, 算法, 性能, 并发, 安全, 架构 |

**决策矩阵**：
```
                前端特征强    前端特征弱
               ┌────────────┬────────────┐
后端特征强     │  交叉验证   │   Codex    │
               ├────────────┼────────────┤
后端特征弱     │   Gemini   │   Claude   │
               └────────────┴────────────┘
```

### 3. 交叉验证触发

以下情况智能触发交叉验证：

1. **全栈问题** - 同时涉及前端和后端
2. **高不确定性** - 多种可能原因，难以确定
3. **设计决策** - 需要评估多种架构方案
4. **复杂 bug** - 难以定位，需要多角度分析
5. **关键修改** - 影响核心功能的变更

### 4. 调用执行

#### 单模型调用

```bash
codeagent-wrapper --backend <codex|gemini> - "$PWD" <<'EOF'
# 任务背景
[提供必要的上下文]

# 具体任务
[清晰描述需要完成的任务]

# 期望输出
[说明期望的输出格式]
EOF
```

#### 交叉验证调用

并行调用两个模型，分别从不同视角分析：

**Codex 任务**（后端视角）：
```bash
codeagent-wrapper --backend codex - "$PWD" <<'EOF'
请从后端/逻辑角度分析：
[具体问题描述]

重点关注：
- API 设计和实现
- 数据流和状态管理
- 性能和安全性
EOF
```

**Gemini 任务**（前端视角）：
```bash
codeagent-wrapper --backend gemini - "$PWD" <<'EOF'
请从前端/UI 角度分析：
[具体问题描述]

重点关注：
- 组件结构和渲染
- 用户交互和体验
- 样式和响应式设计
EOF
```

### 5. 结果整合

#### 单模型结果

直接采纳模型输出，Claude 验证合理性后继续流程。

#### 交叉验证结果

```markdown
## 交叉验证结果

### Codex 分析（后端视角）
[Codex 的分析结果]

### Gemini 分析（前端视角）
[Gemini 的分析结果]

### 综合结论
- **一致点**: [两者一致的结论]
- **分歧点**: [存在分歧的地方]
- **最终建议**: [Claude 综合判断后的建议]
```

## 降级处理

如果 codeagent-wrapper 不可用或调用失败：

1. 记录调用失败原因
2. 回退到 Claude 独立处理
3. 在输出中说明未使用外部模型

## 注意事项

1. **超时控制** - 外部调用默认超时 7200 秒，可通过 `CODEX_TIMEOUT` 环境变量调整
2. **结果验证** - Claude 应验证外部模型返回结果的合理性
3. **隐私考虑** - 敏感代码谨慎发送给外部模型
4. **成本意识** - 避免不必要的外部调用，简单任务 Claude 直接处理

## 与其他 Skills 的集成

本模块被以下 skills 引用：

| Skill | 应用场景 |
|-------|---------|
| `systematic-debugging` | 根因分析时双模型交叉诊断 |
| `brainstorming` | 方案评估时多视角验证 |
| `writing-plans` | 技术方案设计时专业模型辅助 |
| `executing-plans` | 实施阶段按任务类型路由 |
| `subagent-driven-development` | 子任务按前后端分发 |
| `requesting-code-review` | 双模型交叉审查 |
| `test-driven-development` | 测试生成按技术栈路由 |
| `verification-before-completion` | 验证阶段交叉确认 |

## 快速参考

```
需要外部模型？
     │
     ├─ 前端任务 → Gemini
     ├─ 后端任务 → Codex
     ├─ 全栈/复杂 → 交叉验证
     └─ 简单任务 → Claude 直接处理
```
