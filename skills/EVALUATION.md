# Skills 评估场景

按 Anthropic 最佳实践，使用评估场景验证 skills 有效性。

## 评估格式

```json
{
  "skill": "skill-name",
  "query": "用户请求",
  "context": "可选的上下文文件",
  "expected_behavior": [
    "预期行为 1",
    "预期行为 2"
  ]
}
```

## 核心工作流 Skills

### test-driven-development

```json
{
  "skill": "test-driven-development",
  "query": "帮我添加一个验证邮箱格式的函数",
  "expected_behavior": [
    "在写实现代码前，先写失败的测试",
    "运行测试确认失败，显示失败原因",
    "写最小代码让测试通过",
    "运行测试确认通过",
    "不添加超出测试范围的功能"
  ]
}
```

```json
{
  "skill": "test-driven-development",
  "query": "这个函数有bug，帮我修复",
  "context": "src/utils/parser.ts",
  "expected_behavior": [
    "先写重现 bug 的失败测试",
    "确认测试失败且失败原因正确",
    "修复代码",
    "确认测试通过"
  ]
}
```

### debugging-systematically

```json
{
  "skill": "debugging-systematically",
  "query": "测试失败了，帮我看看",
  "context": "npm test 输出显示 3 个测试失败",
  "expected_behavior": [
    "Phase 1: 仔细阅读错误信息，不立即提出修复",
    "尝试复现问题",
    "检查最近的代码变更",
    "Phase 2: 找到类似的正常工作代码进行对比",
    "Phase 3: 形成单一假设并最小化测试",
    "Phase 4: 写失败测试后再修复"
  ]
}
```

```json
{
  "skill": "debugging-systematically",
  "query": "构建失败，错误信息看不懂",
  "expected_behavior": [
    "不直接猜测修复方案",
    "仔细阅读完整错误信息和堆栈",
    "如果涉及多组件系统，添加诊断日志定位问题层",
    "形成假设后再提出修复"
  ]
}
```

### verifying-before-completion

```json
{
  "skill": "verifying-before-completion",
  "query": "帮我修复这个 bug 然后提交",
  "expected_behavior": [
    "修复后运行测试命令",
    "显示测试输出证明通过",
    "只有看到通过证据后才声称'修复完成'",
    "不使用'应该可以了'、'应该通过了'等模糊表述"
  ]
}
```

### brainstorming

```json
{
  "skill": "brainstorming",
  "query": "我想添加用户认证功能",
  "expected_behavior": [
    "先了解项目现状（文件、文档、最近提交）",
    "一次只问一个问题",
    "优先使用选择题",
    "提出 2-3 种不同方案并说明权衡",
    "设计分段呈现，每段后确认"
  ]
}
```

### executing-plans

```json
{
  "skill": "executing-plans",
  "query": "执行 docs/plans/feature.md 这个计划",
  "expected_behavior": [
    "先阅读计划并批判性审查",
    "有疑问时先提出，不直接开始",
    "使用清单跟踪进度",
    "每批完成后报告并等待反馈",
    "不跳过计划中的验证步骤"
  ]
}
```

### developing-with-subagents

```json
{
  "skill": "developing-with-subagents",
  "query": "用子代理方式执行这个计划",
  "context": "docs/plans/feature.md",
  "expected_behavior": [
    "一次性读取计划并提取所有任务",
    "为每个任务派遣独立子代理",
    "子代理有问题时先回答再继续",
    "先 spec review 再 code quality review",
    "reviewer 发现问题时循环修复直到通过"
  ]
}
```

## 辅助 Skills

### using-git-worktrees

```json
{
  "skill": "using-git-worktrees",
  "query": "帮我创建一个隔离的工作空间开发新功能",
  "expected_behavior": [
    "检查现有 .worktrees 或 worktrees 目录",
    "验证目录是否被 gitignore",
    "如未忽略，添加到 .gitignore 并提交",
    "创建 worktree 后运行项目设置",
    "运行测试验证干净基线"
  ]
}
```

### finishing-development-branches

```json
{
  "skill": "finishing-development-branches",
  "query": "开发完成了，帮我处理分支",
  "expected_behavior": [
    "先运行测试验证通过",
    "测试失败时不提供完成选项",
    "提供精确的 4 个选项",
    "选择丢弃时要求输入确认",
    "正确清理 worktree"
  ]
}
```

### dispatching-parallel-agents

```json
{
  "skill": "dispatching-parallel-agents",
  "query": "有 5 个测试文件失败，帮我修复",
  "expected_behavior": [
    "识别失败是否独立",
    "如果独立，按问题域分组",
    "并行派遣多个代理",
    "每个代理有明确范围和约束",
    "汇总结果并验证无冲突"
  ]
}
```

## 运行评估

1. 在没有 skill 的情况下运行查询，记录行为
2. 启用 skill 后运行同样查询
3. 对比行为是否匹配 expected_behavior
4. 记录差异并迭代改进 skill
