# Superpowers-CCG

中文 | [English](README.md)

Superpowers-CCG 是 [obra/superpowers](https://github.com/obra/superpowers) 的增强版本/变体：保留“skills 驱动开发工作流”，并加入 **CCG 多模型协作**——由 Claude 负责编排，在需要时把任务路由给 **Codex MCP**（后端）与 **Gemini MCP**（前端），复杂场景可进行交叉验证。

## 你会得到什么

- **CCG 多模型路由**：后端交给 Codex、前端交给 Gemini；不确定/高影响场景可用 **CROSS_VALIDATION**。
- **MCP 工具集成**：外部模型调用通过 MCP tools 完成：`@backend`、`@frontend`。
- **协作检查点**：在关键 skills 中嵌入 CP1/CP2/CP3 检查点，用于决定何时调用外部模型并沉淀证据。

## 快速开始（OpenCode）

### 前置条件

- 已安装 OpenCode

### 安装

1）克隆本仓库

```bash
git clone https://github.com/BryanHoo/superpowers-ccg.git
cd superpowers-ccg
```

2）一键安装

macOS/Linux/WSL：

```bash
bash ./install-opencode.sh
```

Windows：

```powershell
PowerShell -ExecutionPolicy Bypass -File .\install-opencode.ps1
```

说明：本仓库只覆盖 OpenCode 安装与使用，MCP 配置不是安装所必需。

3）本仓库是什么（以及不是什么）

本仓库是 OpenCode 的 installer 源码包，并不是 per-project `.opencode/*` 自动发现的示例。要使用它，请运行 `install-opencode.sh` 或 `install-opencode.ps1`，它们会把文件复制到 `~/.config/opencode`。

4）Skills 位置

仓库内：`skills/`。
安装后：`~/.config/opencode/skills/`。

### Repo 路径 vs 安装后路径

| 类型     | Repo 路径   | 安装后路径                     |
| -------- | ----------- | ------------------------------ |
| Skills   | `skills/`   | `~/.config/opencode/skills/`   |
| Commands | `commands/` | `~/.config/opencode/commands/` |
| Agents   | `agents/`   | `~/.config/opencode/agents/`   |

## 按任务选择模型（建议）

| 任务类型                    | 推荐路由         | 原因                   |
| --------------------------- | ---------------- | ---------------------- |
| 后端（API、DB、鉴权、性能） | CODEX            | 更擅长后端 patch 建议  |
| 前端（UI、组件、样式）      | GEMINI           | 更擅长 UI 细节与组件化 |
| 全栈/不确定/高影响改动      | CROSS_VALIDATION | 双模型复核，提高覆盖率 |
| 文档/小改动                 | CLAUDE           | 成本更低且足够         |

路由与检查点规则参考：`skills/superpowers-ccg-coordinating-multi-model-work/`。

## 与原版 Superpowers（obra/superpowers）的差异

- **内置多模型路由**：通过 MCP tools（`@backend`、`@frontend`）调用外部模型。
- **CP 检查点机制**：CP1/CP2/CP3 用于证据驱动协作与 Fail-Closed 约束。
- **Skills 集合调整**：新增/改名以适配 CCG 协作流程。
- **安装源不同**：从 `https://github.com/BryanHoo/superpowers-ccg` 安装。

## 更新

通过拉取仓库最新更新：

```bash
git pull origin main
```

## 许可证

MIT License - 详见 `LICENSE`。

## 支持

- Issues: https://github.com/BryanHoo/superpowers-ccg/issues

## 致谢

- [obra/superpowers](https://github.com/obra/superpowers) - 原始 Superpowers 项目
- [fengshao1227/ccg-workflow](https://github.com/fengshao1227/ccg-workflow) - CCG 工作流
