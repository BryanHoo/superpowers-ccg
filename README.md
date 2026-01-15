# Superpowers-CCG

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

### 1. 安装 Superpowers 插件

**Claude Code（通过 Plugin Marketplace）**

```bash
# 注册 marketplace
/plugin marketplace add obra/superpowers-marketplace

# 安装插件
/plugin install superpowers@superpowers-marketplace
```

### 2. 安装 codeagent-wrapper（多模型支持）

codeagent-wrapper 是调用 Codex 和 Gemini 的核心组件。

```bash
# 创建目录
mkdir -p ~/.claude/bin

# 复制对应平台的二进制（以 macOS ARM64 为例）
cp bin/codeagent-wrapper-darwin-arm64 ~/.claude/bin/codeagent-wrapper

# 添加执行权限
chmod +x ~/.claude/bin/codeagent-wrapper

# 验证安装
~/.claude/bin/codeagent-wrapper --help
```

**平台二进制列表：**
- macOS Intel: `bin/codeagent-wrapper-darwin-amd64`
- macOS Apple Silicon: `bin/codeagent-wrapper-darwin-arm64`
- Linux x64: `bin/codeagent-wrapper-linux-amd64`
- Linux ARM64: `bin/codeagent-wrapper-linux-arm64`
- Windows x64: `bin/codeagent-wrapper-windows-amd64.exe`
- Windows ARM64: `bin/codeagent-wrapper-windows-arm64.exe`

### 3. 安装外部模型 CLI（可选）

多模型功能需要对应的 CLI 工具：

**Codex CLI（后端任务）**
```bash
# 参考 OpenAI Codex CLI 安装文档
npm install -g @openai/codex
```

**Gemini CLI（前端任务）**
```bash
# 参考 Google Gemini CLI 安装文档
npm install -g @google/gemini-cli
```

### 4. 验证安装

```bash
# 检查 superpowers 命令
/help
# 应该看到 /superpowers:brainstorm 等命令

# 检查 codeagent-wrapper
~/.claude/bin/codeagent-wrapper --version

# 测试多模型调用（可选）
~/.claude/bin/codeagent-wrapper --backend codex - "$PWD" <<< "echo hello"
```

## Codex / OpenCode 安装

### Codex

```
Fetch and follow instructions from https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.codex/INSTALL.md
```

**详细文档:** [docs/README.codex.md](docs/README.codex.md)

### OpenCode

```
Fetch and follow instructions from https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.opencode/INSTALL.md
```

**详细文档:** [docs/README.opencode.md](docs/README.opencode.md)

## 基本工作流

1. **brainstorming** - 在写代码前激活。通过提问提炼想法，探索替代方案，分段展示设计供验证。保存设计文档。

2. **using-git-worktrees** - 设计批准后激活。创建隔离的工作空间和新分支，运行项目设置，验证测试基线。

3. **writing-plans** - 有了批准的设计后激活。将工作分解为小任务（每个 2-5 分钟）。每个任务都有精确的文件路径、完整代码和验证步骤。**支持 Model hint 标注**，指定任务路由到哪个模型。

4. **subagent-driven-development** 或 **executing-plans** - 有了计划后激活。每个任务分发给新的 subagent，进行两阶段审查（规格合规性 + 代码质量），或分批执行并设置人工检查点。**自动路由任务到 Codex/Gemini**。

5. **test-driven-development** - 实施期间激活。强制执行 RED-GREEN-REFACTOR：写失败的测试，看它失败，写最小代码，看它通过，提交。**支持按技术栈路由测试生成**。

6. **requesting-code-review** - 任务之间激活。根据计划审查，按严重程度报告问题。**支持双模型交叉审查**。

7. **finishing-a-development-branch** - 任务完成时激活。验证测试，展示选项（合并/PR/保留/丢弃），清理 worktree。

**Agent 在任何任务前都会检查相关 skills。** 这是强制性工作流，不是建议。

## 多模型能力

### multi-model-core

核心模块，提供自动路由和交叉验证能力：

**路由规则：**
- 根据文件类型（`.tsx` → Gemini，`.go` → Codex）
- 根据目录结构（`components/` → Gemini，`server/` → Codex）
- 根据任务关键词（UI/样式 → Gemini，API/数据库 → Codex）

**交叉验证触发：**
- 全栈问题（前后端交互）
- 高不确定性（多种可能原因）
- 设计决策（架构选择）
- 复杂 bug（难以定位）

### 增强的 Skills

| Skill | 多模型能力 |
|-------|-----------|
| systematic-debugging | 交叉验证诊断 |
| brainstorming | 多模型设计评估 |
| writing-plans | 任务路由标注 |
| executing-plans | 自动路由执行 |
| subagent-driven-development | 多模型任务分发 |
| requesting-code-review | 双模型代码审查 |
| test-driven-development | 测试生成路由 |
| verification-before-completion | 交叉验证确认 |

## Skills 库

### 测试
- **test-driven-development** - RED-GREEN-REFACTOR 循环（包含测试反模式参考）

### 调试
- **systematic-debugging** - 4 阶段根因分析流程（包含 root-cause-tracing、defense-in-depth、condition-based-waiting 技术）
- **verification-before-completion** - 确保问题真正修复

### 协作
- **brainstorming** - 苏格拉底式设计提炼
- **writing-plans** - 详细实施计划
- **executing-plans** - 分批执行带检查点
- **dispatching-parallel-agents** - 并发 subagent 工作流
- **requesting-code-review** - 预审查清单
- **receiving-code-review** - 响应反馈
- **using-git-worktrees** - 并行开发分支
- **finishing-a-development-branch** - 合并/PR 决策工作流
- **subagent-driven-development** - 快速迭代带两阶段审查

### 多模型
- **multi-model-core** - 多模型调用核心（路由规则、交叉验证、提示词模板）

### 元技能
- **writing-skills** - 按最佳实践创建新 skills
- **using-superpowers** - skills 系统介绍

## 设计理念

- **测试驱动开发** - 始终先写测试
- **系统化优于临时** - 流程优于猜测
- **降低复杂度** - 简单性是首要目标
- **证据优于声明** - 验证后再宣布成功
- **多模型协作** - 专业模型处理专业任务

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
/plugin update superpowers
```

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

- **Issues**: https://github.com/obra/superpowers/issues
- **Marketplace**: https://github.com/obra/superpowers-marketplace

## 致谢

- [obra/superpowers](https://github.com/obra/superpowers) - 原始 Superpowers 项目
- [ccg-workflow](https://github.com/anthropics/ccg-workflow) - codeagent-wrapper
