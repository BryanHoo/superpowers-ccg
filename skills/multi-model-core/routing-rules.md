# 路由规则详细定义

## 文件类型路由表

### Gemini（前端专家）

| 扩展名 | 说明 | 置信度 |
|--------|------|--------|
| `.tsx` | React TypeScript 组件 | 高 |
| `.jsx` | React JavaScript 组件 | 高 |
| `.vue` | Vue 单文件组件 | 高 |
| `.svelte` | Svelte 组件 | 高 |
| `.astro` | Astro 组件 | 高 |
| `.css` | 样式表 | 高 |
| `.scss` | Sass 样式 | 高 |
| `.less` | Less 样式 | 高 |
| `.html` | HTML 模板 | 中 |
| `.ejs` | EJS 模板 | 中 |
| `.hbs` | Handlebars 模板 | 中 |

### Codex（后端专家）

| 扩展名 | 说明 | 置信度 |
|--------|------|--------|
| `.go` | Go 源码 | 高 |
| `.py` | Python 源码 | 高 |
| `.java` | Java 源码 | 高 |
| `.rs` | Rust 源码 | 高 |
| `.rb` | Ruby 源码 | 高 |
| `.php` | PHP 源码 | 高 |
| `.sql` | SQL 脚本 | 高 |
| `.sh` | Shell 脚本 | 高 |
| `.c` | C 源码 | 高 |
| `.cpp` | C++ 源码 | 高 |
| `.cs` | C# 源码 | 高 |

### 需要上下文判断

| 扩展名 | 说明 | 判断依据 |
|--------|------|---------|
| `.ts` | TypeScript | 看目录和内容：组件→Gemini，服务→Codex |
| `.js` | JavaScript | 看目录和内容：前端→Gemini，Node.js→Codex |
| `.json` | JSON 配置 | 看用途：package.json→上下文，API→Codex |
| `.yaml` | YAML 配置 | 看用途：CI/CD→Codex，前端配置→Gemini |
| `.md` | Markdown | 看内容：API 文档→Codex，组件文档→Gemini |

## 目录结构路由表

### Gemini 目录模式

```
*/components/*      # React/Vue 组件目录
*/pages/*           # 页面目录
*/views/*           # 视图目录
*/layouts/*         # 布局目录
*/styles/*          # 样式目录
*/css/*             # CSS 目录
*/ui/*              # UI 组件目录
*/frontend/*        # 前端目录
*/web/*             # Web 目录
*/client/*          # 客户端目录
*/app/*             # 应用目录（需结合内容判断）
*/public/*          # 静态资源目录
*/assets/*          # 资源目录
*/hooks/*           # React Hooks
*/contexts/*        # React Context
*/stores/*          # 前端状态管理（如 Zustand）
```

### Codex 目录模式

```
*/server/*          # 服务端目录
*/api/*             # API 目录
*/services/*        # 服务目录
*/backend/*         # 后端目录
*/cmd/*             # Go 命令目录
*/internal/*        # Go 内部包
*/pkg/*             # Go 公共包
*/lib/*             # 库目录
*/utils/*           # 工具目录（需结合内容判断）
*/middleware/*      # 中间件目录
*/handlers/*        # 处理器目录
*/controllers/*     # 控制器目录
*/models/*          # 数据模型目录
*/repositories/*    # 数据仓库目录
*/database/*        # 数据库目录
*/migrations/*      # 数据库迁移
*/scripts/*         # 脚本目录
*/tests/*           # 测试目录（需结合内容判断）
```

## 关键词路由表

### Gemini 关键词

**高置信度**：
- UI、界面、用户界面
- 样式、CSS、Tailwind、styled-components
- 组件、Component、Widget
- 布局、Layout、Grid、Flex
- 动画、Animation、Transition、Motion
- 响应式、Responsive、Mobile-first
- 交互、Interaction、Click、Hover
- 用户体验、UX、可用性

**中置信度**：
- 表单、Form、Input、Validation（前端验证）
- 状态管理、State、Redux、Zustand、Pinia
- 路由、Router、Navigation（前端路由）
- 渲染、Render、Virtual DOM
- Hook、Effect、Ref

### Codex 关键词

**高置信度**：
- API、REST、GraphQL、gRPC
- 数据库、Database、SQL、ORM
- 算法、Algorithm、排序、搜索
- 性能、Performance、优化、Benchmark
- 并发、Concurrent、Goroutine、Thread
- 安全、Security、认证、授权、JWT
- 后端、Backend、Server
- 服务、Service、Microservice

**中置信度**：
- 架构、Architecture、设计模式
- 缓存、Cache、Redis、Memcached
- 消息队列、Queue、Kafka、RabbitMQ
- 日志、Logging、监控、Metrics
- 部署、Deploy、Docker、Kubernetes
- 测试、Test、单元测试、集成测试

## 综合判断算法

```
function routeDecision(task):
    frontendScore = 0
    backendScore = 0

    # 文件类型评分
    for file in task.files:
        if file.ext in GEMINI_EXTENSIONS:
            frontendScore += 2
        elif file.ext in CODEX_EXTENSIONS:
            backendScore += 2
        elif file.ext in AMBIGUOUS_EXTENSIONS:
            # 需要进一步分析
            pass

    # 目录评分
    for dir in task.directories:
        if matchesPattern(dir, GEMINI_PATTERNS):
            frontendScore += 1.5
        elif matchesPattern(dir, CODEX_PATTERNS):
            backendScore += 1.5

    # 关键词评分
    for keyword in task.keywords:
        if keyword in GEMINI_HIGH_KEYWORDS:
            frontendScore += 1.5
        elif keyword in GEMINI_MED_KEYWORDS:
            frontendScore += 0.8
        elif keyword in CODEX_HIGH_KEYWORDS:
            backendScore += 1.5
        elif keyword in CODEX_MED_KEYWORDS:
            backendScore += 0.8

    # 决策
    if frontendScore > 3 and backendScore > 3:
        return "CROSS_VALIDATION"
    elif frontendScore > backendScore + 1:
        return "GEMINI"
    elif backendScore > frontendScore + 1:
        return "CODEX"
    else:
        return "CLAUDE"  # 特征不明显，Claude 直接处理
```

## 特殊场景处理

### 全栈项目

当项目同时包含前后端代码时：
1. 根据当前任务涉及的具体文件判断
2. 如果任务跨越前后端，触发交叉验证

### Monorepo

对于 monorepo 项目：
1. 识别 `packages/`、`apps/` 等目录结构
2. 根据子包名称和内容判断路由

### 混合技术栈

如 Next.js（前后端一体）：
1. `pages/api/*` → Codex
2. `pages/*.tsx`、`components/*` → Gemini
3. 涉及两者 → 交叉验证
