# Detailed Routing Rules

## File Type Routing Table

### Gemini (Frontend Expert)

| Extension | Description | Confidence |
|-----------|-------------|------------|
| `.tsx` | React TypeScript components | High |
| `.jsx` | React JavaScript components | High |
| `.vue` | Vue single-file components | High |
| `.svelte` | Svelte components | High |
| `.astro` | Astro components | High |
| `.css` | Stylesheets | High |
| `.scss` | Sass styles | High |
| `.less` | Less styles | High |
| `.html` | HTML templates | Medium |
| `.ejs` | EJS templates | Medium |
| `.hbs` | Handlebars templates | Medium |

### Codex (Backend Expert)

| Extension | Description | Confidence |
|-----------|-------------|------------|
| `.go` | Go source code | High |
| `.py` | Python source code | High |
| `.java` | Java source code | High |
| `.rs` | Rust source code | High |
| `.rb` | Ruby source code | High |
| `.php` | PHP source code | High |
| `.sql` | SQL scripts | High |
| `.sh` | Shell scripts | High |
| `.c` | C source code | High |
| `.cpp` | C++ source code | High |
| `.cs` | C# source code | High |

### Context-Dependent

| Extension | Description | Decision Criteria |
|-----------|-------------|-------------------|
| `.ts` | TypeScript | Check directory and content: components→Gemini, services→Codex |
| `.js` | JavaScript | Check directory and content: frontend→Gemini, Node.js→Codex |
| `.json` | JSON config | Check purpose: package.json→context, API→Codex |
| `.yaml` | YAML config | Check purpose: CI/CD→Codex, frontend config→Gemini |
| `.md` | Markdown | Check content: API docs→Codex, component docs→Gemini |

## Directory Structure Routing Table

### Gemini Directory Patterns

```
*/components/*      # React/Vue component directories
*/pages/*           # Page directories
*/views/*           # View directories
*/layouts/*         # Layout directories
*/styles/*          # Style directories
*/css/*             # CSS directories
*/ui/*              # UI component directories
*/frontend/*        # Frontend directories
*/web/*             # Web directories
*/client/*          # Client directories
*/app/*             # App directories (need content context)
*/public/*          # Static asset directories
*/assets/*          # Asset directories
*/hooks/*           # React Hooks
*/contexts/*        # React Context
*/stores/*          # Frontend state management (e.g., Zustand)
```

### Codex Directory Patterns

```
*/server/*          # Server-side directories
*/api/*             # API directories
*/services/*        # Service directories
*/backend/*         # Backend directories
*/cmd/*             # Go command directories
*/internal/*        # Go internal packages
*/pkg/*             # Go public packages
*/lib/*             # Library directories
*/utils/*           # Utility directories (need content context)
*/middleware/*      # Middleware directories
*/handlers/*        # Handler directories
*/controllers/*     # Controller directories
*/models/*          # Data model directories
*/repositories/*    # Repository directories
*/database/*        # Database directories
*/migrations/*      # Database migrations
*/scripts/*         # Script directories
*/tests/*           # Test directories (need content context)
```

## Keyword Routing Table

### Gemini Keywords

**High Confidence**:
- UI, interface, user interface
- styles, CSS, Tailwind, styled-components
- component, Component, Widget
- layout, Layout, Grid, Flex
- animation, Animation, Transition, Motion
- responsive, Responsive, Mobile-first
- interaction, Interaction, Click, Hover
- user experience, UX, usability

**Medium Confidence**:
- form, Form, Input, Validation (frontend validation)
- state management, State, Redux, Zustand, Pinia
- routing, Router, Navigation (frontend routing)
- rendering, Render, Virtual DOM
- Hook, Effect, Ref

### Codex Keywords

**High Confidence**:
- API, REST, GraphQL, gRPC
- database, Database, SQL, ORM
- algorithm, Algorithm, sorting, searching
- performance, Performance, optimization, Benchmark
- concurrency, Concurrent, Goroutine, Thread
- security, Security, authentication, authorization, JWT
- backend, Backend, Server
- service, Service, Microservice

**Medium Confidence**:
- architecture, Architecture, design pattern
- cache, Cache, Redis, Memcached
- message queue, Queue, Kafka, RabbitMQ
- logging, Logging, monitoring, Metrics
- deployment, Deploy, Docker, Kubernetes
- testing, Test, unit test, integration test

## Comprehensive Decision Algorithm

```
function routeDecision(task):
    frontendScore = 0
    backendScore = 0

    # File type scoring
    for file in task.files:
        if file.ext in GEMINI_EXTENSIONS:
            frontendScore += 2
        elif file.ext in CODEX_EXTENSIONS:
            backendScore += 2
        elif file.ext in AMBIGUOUS_EXTENSIONS:
            # Requires further analysis
            pass

    # Directory scoring
    for dir in task.directories:
        if matchesPattern(dir, GEMINI_PATTERNS):
            frontendScore += 1.5
        elif matchesPattern(dir, CODEX_PATTERNS):
            backendScore += 1.5

    # Keyword scoring
    for keyword in task.keywords:
        if keyword in GEMINI_HIGH_KEYWORDS:
            frontendScore += 1.5
        elif keyword in GEMINI_MED_KEYWORDS:
            frontendScore += 0.8
        elif keyword in CODEX_HIGH_KEYWORDS:
            backendScore += 1.5
        elif keyword in CODEX_MED_KEYWORDS:
            backendScore += 0.8

    # Decision
    if frontendScore > 3 and backendScore > 3:
        return "CROSS_VALIDATION"
    elif frontendScore > backendScore + 1:
        return "GEMINI"
    elif backendScore > frontendScore + 1:
        return "CODEX"
    else:
        return "CLAUDE"  # Features unclear, Claude handles directly
```

## Special Scenario Handling

### Full-Stack Projects

When a project contains both frontend and backend code:
1. Determine based on the specific files involved in the current task
2. If the task spans frontend and backend, trigger cross-validation

### Monorepo

For monorepo projects:
1. Identify directory structures like `packages/`, `apps/`
2. Route based on sub-package name and content

### Mixed Tech Stack

For frameworks like Next.js (frontend + backend):
1. `pages/api/*` → Codex
2. `pages/*.tsx`, `components/*` → Gemini
3. Involves both → Cross-validation
