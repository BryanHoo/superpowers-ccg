---
name: brainstorming
description: "You MUST use this before any creative work - creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements and design before implementation."
---

# Brainstorming Ideas Into Designs

## Overview

Help turn ideas into fully formed designs and specs through natural collaborative dialogue.

Start by understanding the current project context, then ask questions one at a time to refine the idea. Once you understand what you're building, present the design in small sections (200-300 words), checking after each section whether it looks right so far.

## The Process

**Understanding the idea:**
- Check out the current project state first (files, docs, recent commits)
- Ask questions one at a time to refine the idea
- Prefer multiple choice questions when possible, but open-ended is fine too
- Only one question per message - if a topic needs more exploration, break it into multiple questions
- Focus on understanding: purpose, constraints, success criteria

**Exploring approaches:**
- Propose 2-3 different approaches with trade-offs
- Present options conversationally with your recommendation and reasoning
- Lead with your recommended option and explain why

**Presenting the design:**
- Once you believe you understand what you're building, present the design
- Break it into sections of 200-300 words
- Ask after each section whether it looks right so far
- Cover: architecture, components, data flow, error handling, testing
- Be ready to go back and clarify if something doesn't make sense

## After the Design

**Documentation:**
- Write the validated design to `docs/plans/YYYY-MM-DD-<topic>-design.md`
- Use elements-of-style:writing-clearly-and-concisely skill if available
- Commit the design document to git

**Implementation (if continuing):**
- Ask: "Ready to set up for implementation?"
- Use superpowers:using-git-worktrees to create isolated workspace
- Use superpowers:writing-plans to create detailed implementation plan

## Key Principles

- **One question at a time** - Don't overwhelm with multiple questions
- **Multiple choice preferred** - Easier to answer than open-ended when possible
- **YAGNI ruthlessly** - Remove unnecessary features from all designs
- **Explore alternatives** - Always propose 2-3 approaches before settling
- **Incremental validation** - Present design in sections, validate each
- **Be flexible** - Go back and clarify when something doesn't make sense

## Multi-Model Design Validation

**Related skill:** superpowers:multi-model-core

**When to trigger:** Claude 智能判断以下情况时触发多模型验证：
- 设计涉及前后端架构决策
- 需要评估多种技术方案
- 关键设计需要多视角验证

**How to use:**

在 "Exploring approaches" 阶段，对于涉及前后端的设计方案：

```bash
# 并行获取专业视角

# Codex（后端架构视角）
codeagent-wrapper --backend codex - "$PWD" <<'EOF'
## 设计方案
[方案描述]

## 请从后端架构角度评估
1. 架构合理性和可扩展性
2. 数据模型和 API 设计
3. 性能和安全考虑
4. 技术选型建议

## 期望输出
- 方案评估（优势/风险）
- 改进建议
EOF

# Gemini（前端架构视角）
codeagent-wrapper --backend gemini - "$PWD" <<'EOF'
## 设计方案
[方案描述]

## 请从前端架构角度评估
1. 组件结构和状态管理
2. 用户体验和交互设计
3. 性能和可访问性
4. 技术选型建议

## 期望输出
- 方案评估（优势/风险）
- 改进建议
EOF
```

**Result integration:**

```markdown
## 多模型设计评估

### Codex 评估（后端视角）
[Codex 的评估结果]

### Gemini 评估（前端视角）
[Gemini 的评估结果]

### 综合建议
- **一致认可**: [两者都认可的设计点]
- **需要权衡**: [存在不同意见的地方]
- **最终方案**: [Claude 综合后的推荐方案]
```

**Fallback:** 如果 codeagent-wrapper 不可用，继续使用 Claude 独立评估。
