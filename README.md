# Superpowers-CCG

[中文](README-zh.md) | English

Superpowers-CCG is a fork/enhanced variant of [obra/superpowers](https://github.com/obra/superpowers). It keeps the same skills-driven workflow, and adds **CCG multi-model collaboration**: Claude orchestrates, and can route to **Codex MCP** (backend) and **Gemini MCP** (frontend) with optional cross-validation.

## What You Get

- **Multi-model routing (CCG)**: route tasks to Codex (backend) / Gemini (frontend), or use **CROSS_VALIDATION** when uncertain.
- **MCP tool integration**: external calls go through MCP tools: `@backend`, `@frontend`.
- **Collaboration checkpoints**: CP1/CP2/CP3 checkpoints embedded in key skills to decide when to call external models.

## Quick Start (OpenCode)

### Prerequisites

- OpenCode installed

### Install

1. Clone this repository

```bash
git clone https://github.com/BryanHoo/superpowers-ccg.git
cd superpowers-ccg
```

2. One-click install

macOS/Linux/WSL:

```bash
bash ./install-opencode.sh
```

Windows:

```powershell
PowerShell -ExecutionPolicy Bypass -File .\install-opencode.ps1
```

Note: This repository documents OpenCode-only setup. MCP configuration is not required for installation.

3. What this repository is (and is not)

This repository is the installer source bundle for OpenCode, not a per-project `.opencode/*` auto-discovery example. To use it, run `install-opencode.sh` or `install-opencode.ps1`, which copies files into `~/.config/opencode`.

4. Skills location

In the repo: `skills/`.
After install: `~/.config/opencode/skills/`.

### Repo paths vs Installed paths

| Type     | Repo path   | Installed path                 |
| -------- | ----------- | ------------------------------ |
| Skills   | `skills/`   | `~/.config/opencode/skills/`   |
| Commands | `commands/` | `~/.config/opencode/commands/` |
| Agents   | `agents/`   | `~/.config/opencode/agents/`   |

## Model Selection (Recommended)

| Task type                          | Recommended routing | Why                                    |
| ---------------------------------- | ------------------- | -------------------------------------- |
| Backend (APIs, DB, auth, perf)     | CODEX               | strongest backend patch suggestions    |
| Frontend (UI/components/styles)    | GEMINI              | strongest UI-centric patch suggestions |
| Full-stack / unclear / high impact | CROSS_VALIDATION    | catch misses via dual review           |
| Docs / simple edits                | CLAUDE              | fastest and sufficient                 |

The routing/checkpoint rules live in `skills/superpowers-ccg-coordinating-multi-model-work/`.

## Differences vs Superpowers (obra/superpowers)

- **Built-in multi-model routing** via MCP tools (`@backend`, `@frontend`).
- **CP checkpoints** (CP1/CP2/CP3) added to enforce evidence-driven collaboration.
- **Skill set changes** (additions/renames) for the CCG workflow.
- **Different marketplace source**: install from `https://github.com/BryanHoo/superpowers-ccg`.

## Update

Update by pulling the latest changes from the repository:

```bash
git pull origin main
```

## License

MIT License - see `LICENSE`.

## Support

- Issues: https://github.com/BryanHoo/superpowers-ccg/issues

## Acknowledgments

- [obra/superpowers](https://github.com/obra/superpowers) - Original Superpowers project
- [fengshao1227/ccg-workflow](https://github.com/fengshao1227/ccg-workflow) - CCG workflow
- [GuDaStudio/geminimcp](https://github.com/GuDaStudio/geminimcp) - Gemini MCP
- [GuDaStudio/codexmcp](https://github.com/GuDaStudio/codexmcp) - Codex MCP
