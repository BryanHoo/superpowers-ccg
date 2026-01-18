# Routing Decision Framework

## Overview

This framework guides Claude in making semantic routing decisions for multi-model task distribution. Instead of relying on hardcoded scoring algorithms, Claude analyzes task characteristics using reasoning to determine the optimal execution model.

**Purpose**: Enable intelligent, context-aware routing decisions that adapt to task nuances rather than rigid rule-based scoring.

## When to Use

Invoke this framework when a skill needs to call external models (Codex/Gemini) via codeagent-wrapper. Before making the call, analyze the task using the dimensions below.

**Trigger Points**:
- Before executing any implementation task
- During debugging and root cause analysis
- When generating tests or verification plans
- Before code review or design validation
- During plan execution with multi-step tasks

## Standard Information Set

Collect these inputs for decision-making:

1. **Task Description** - User's request in natural language
   - What is the user asking for?
   - What problem needs to be solved?
   - What is the expected outcome?

2. **File Information** - File paths and extensions involved in the task
   - Which files will be created or modified?
   - What are the file extensions?
   - What directories are they in?

3. **Tech Stack** - Inferred from project files
   - Check `package.json`, `go.mod`, `requirements.txt`, etc.
   - Identify frameworks (React, Vue, Django, Express, etc.)
   - Determine frontend vs backend technologies

## Analysis Dimensions

### 1. Task Essence

**Question:** What problem is this task primarily solving?

**Consider:**
- **Core objective**: Fix bug, add feature, optimize performance, refactor code, design architecture
- **Domain focus**: Data processing, user interface, business logic, infrastructure, integration
- **Primary skill required**: Design thinking, algorithmic problem-solving, UI/UX implementation, system integration

**Examples:**
- "Add dark mode toggle" → UI feature implementation
- "Optimize database queries" → Performance optimization
- "Implement authentication" → Security and business logic
- "Fix rendering bug" → UI debugging

### 2. Technical Domain

**Question:** Does this task lean toward frontend (UI/interaction) or backend (logic/data)?

**Frontend Indicators:**
- UI components, layouts, visual design
- User interactions, event handling
- Styling, animations, responsive design
- Client-side state management (Redux, Zustand, Pinia)
- Browser APIs, DOM manipulation
- Accessibility (a11y) concerns
- Frontend routing and navigation
- Component composition and props

**Backend Indicators:**
- API endpoints, server logic
- Database operations, data models, ORM
- Algorithms, performance optimization
- Authentication, authorization, security
- Background jobs, message queues
- Server-side infrastructure
- Caching strategies
- Data validation and business rules

**Ambiguous Cases (Require Deeper Analysis):**
- Full-stack integration (API + component)
- Configuration files (depends on context)
- Testing (depends on what's being tested)
- Utilities (depends on usage context)
- TypeScript/JavaScript files (check directory and imports)

### 3. Complexity & Uncertainty

**Question:** Does this task involve multiple domains or uncertain factors?

**High Complexity Indicators:**
- Spans frontend and backend simultaneously
- Multiple possible root causes (debugging scenarios)
- Architectural design decisions affecting both layers
- Critical changes affecting core functionality
- Insufficient information to determine domain
- Integration between multiple systems
- Data flow across layers (client → server → database)

**Low Complexity Indicators:**
- Single file change in a clear domain
- Well-defined scope (e.g., "fix typo", "update color")
- Isolated component or function
- Documentation or simple configuration updates

## Decision Output

Based on the analysis, output:

```
**Routing Decision:** [GEMINI | CODEX | CROSS_VALIDATION | CLAUDE]
**Rationale:** [One sentence explaining the decision based on analysis]
```

### Routing Targets

- **GEMINI** - Frontend expert for UI, components, styles, interactions, client-side logic
- **CODEX** - Backend expert for APIs, databases, algorithms, performance, server-side logic
- **CROSS_VALIDATION** - Both models for full-stack tasks, architectural decisions, or high uncertainty
- **CLAUDE** - Simple tasks that don't require specialized external models (docs, configs, simple edits)

## Decision Logic

Apply this reasoning framework:

```
1. Analyze Task Essence:
   - What is the core problem?
   - What domain does it primarily affect?

2. Evaluate Technical Domain:
   - Count frontend indicators vs backend indicators
   - Check file paths and extensions
   - Review task keywords and description

3. Assess Complexity:
   - Does it span multiple domains?
   - Is the root cause uncertain?
   - Are there multiple perspectives needed?

4. Make Decision:
   IF (strong frontend signals AND weak/no backend signals):
       → GEMINI

   ELSE IF (strong backend signals AND weak/no frontend signals):
       → CODEX

   ELSE IF (strong signals in both domains OR high uncertainty OR architectural):
       → CROSS_VALIDATION

   ELSE IF (simple task OR documentation OR trivial config):
       → CLAUDE

   ELSE (ambiguous case):
       → CROSS_VALIDATION (err on the side of getting multiple perspectives)
```

**Key Principle**: When in doubt, prefer CROSS_VALIDATION over guessing. Multiple perspectives are better than potentially wrong routing.

## User Notification

After making the decision, notify the user with this format:

```
我将使用 [模型名] 来 [处理任务类型]
```

**Examples:**
- "我将使用 Codex 来分析这个 API 性能问题"
- "我将使用 Gemini 来优化这个组件的样式"
- "我将使用交叉验证来评估这个全栈架构设计"
- "我将使用 Codex 来实现数据库查询优化"
- "我将使用 Gemini 来创建响应式布局"

**Principles:**
- Keep it brief and informative (one sentence)
- Don't show detailed reasoning process to user
- Don't interrupt the workflow with excessive explanation
- Use Chinese for user-facing notifications
- Clearly state which model and what task type

## Reference Knowledge

While making decisions, you can reference `routing-rules.md` for:
- File extension categorization
- Directory structure patterns
- Keyword associations
- Scoring heuristics (as reference, not strict rules)

However, these are **reference knowledge** only, not strict rules. Your semantic understanding and reasoning should guide the final decision. The old scoring algorithm is provided for context, but you should use judgment rather than calculating scores.

## Examples

### Example 1: Clear Frontend Task

**Input:**
- Task: "Add a dark mode toggle to the settings page"
- Files: `src/components/Settings.tsx`, `src/styles/theme.css`
- Tech Stack: React, TypeScript

**Analysis:**
1. **Task Essence**: Adding UI component and styling for user preference
2. **Technical Domain**:
   - Frontend indicators: Component file (.tsx), styling (.css), UI feature
   - Backend indicators: None
   - Verdict: Strong frontend
3. **Complexity**: Single domain, straightforward feature addition

**Output:**
```
**Routing Decision:** GEMINI
**Rationale:** UI component and styling task with clear frontend domain signals
```

**Notification:** "我将使用 Gemini 来实现设置页面的暗黑模式切换"

---

### Example 2: Clear Backend Task

**Input:**
- Task: "Optimize database query performance for user search"
- Files: `server/api/users.go`, `server/db/queries.sql`
- Tech Stack: Go, PostgreSQL

**Analysis:**
1. **Task Essence**: Performance optimization for data retrieval
2. **Technical Domain**:
   - Frontend indicators: None
   - Backend indicators: Database queries, API logic, Go server code
   - Verdict: Strong backend
3. **Complexity**: Single domain, technical optimization

**Output:**
```
**Routing Decision:** CODEX
**Rationale:** Database query optimization with clear backend domain signals
```

**Notification:** "我将使用 Codex 来优化用户搜索的数据库查询性能"

---

### Example 3: Full-Stack Task

**Input:**
- Task: "Implement real-time notification system"
- Files: `server/api/notifications.go`, `src/components/NotificationBell.tsx`, `server/websocket/hub.go`
- Tech Stack: Go, React, WebSockets

**Analysis:**
1. **Task Essence**: Real-time communication feature spanning multiple layers
2. **Technical Domain**:
   - Frontend indicators: React component, UI bell icon, client-side updates
   - Backend indicators: WebSocket server, Go API, notification hub
   - Verdict: Both frontend and backend strongly involved
3. **Complexity**: Multi-domain, requires coordination between layers

**Output:**
```
**Routing Decision:** CROSS_VALIDATION
**Rationale:** Spans backend WebSocket implementation and frontend UI component, requires coordination between both layers
```

**Notification:** "我将使用交叉验证来实现实时通知系统"

---

### Example 4: Uncertain Case - Bug Diagnosis

**Input:**
- Task: "Fix the authentication bug - users can't log in"
- Files: Unknown (need investigation)
- Tech Stack: Full-stack Next.js app (React frontend + API routes backend)

**Analysis:**
1. **Task Essence**: Bug fixing with unclear root cause
2. **Technical Domain**:
   - Frontend indicators: Could be login form, client-side validation, cookies
   - Backend indicators: Could be API auth logic, session management, database
   - Verdict: Uncertain - could be either or both
3. **Complexity**: High uncertainty, multiple possible root causes, need investigation

**Output:**
```
**Routing Decision:** CROSS_VALIDATION
**Rationale:** Authentication bug with unclear root cause requires multi-perspective diagnosis
```

**Notification:** "我将使用交叉验证来诊断认证问题"

---

### Example 5: Simple Task

**Input:**
- Task: "Fix typo in README documentation"
- Files: `README.md`
- Tech Stack: N/A

**Analysis:**
1. **Task Essence**: Documentation correction
2. **Technical Domain**:
   - Frontend indicators: None
   - Backend indicators: None
   - Verdict: Non-technical, documentation only
3. **Complexity**: Very low, simple text edit

**Output:**
```
**Routing Decision:** CLAUDE
**Rationale:** Simple documentation edit that doesn't require specialized model expertise
```

**Notification:** (None - Claude handles directly without external model call)

---

### Example 6: Ambiguous TypeScript File

**Input:**
- Task: "Add validation to user input"
- Files: `src/utils/validators.ts`
- Tech Stack: Next.js (full-stack)

**Analysis:**
1. **Task Essence**: Input validation logic
2. **Technical Domain**:
   - Need to check: Is this client-side form validation or server-side API validation?
   - File location: `src/utils/` could be shared utilities
   - Context needed: Look at imports and usage
   - Verdict: Ambiguous - depends on usage context
3. **Complexity**: Moderate - need to understand validation purpose

**Decision Process:**
- If file contains DOM-related imports → Frontend validation → GEMINI
- If file contains API/database-related imports → Backend validation → CODEX
- If used in both contexts → CROSS_VALIDATION
- Cannot determine → CROSS_VALIDATION (default for ambiguous cases)

**Output** (assuming cannot determine from context):
```
**Routing Decision:** CROSS_VALIDATION
**Rationale:** Validation logic in shared utilities with ambiguous usage context
```

**Notification:** "我将使用交叉验证来实现输入验证逻辑"

---

### Example 7: Architectural Design Task

**Input:**
- Task: "Design the architecture for a new e-commerce checkout flow"
- Files: To be determined
- Tech Stack: React frontend, Node.js backend, PostgreSQL

**Analysis:**
1. **Task Essence**: Architectural design spanning multiple layers
2. **Technical Domain**:
   - Frontend indicators: UI flow, checkout pages, payment forms
   - Backend indicators: Payment processing, order management, inventory
   - Verdict: Both domains heavily involved
3. **Complexity**: High - architectural decisions affecting entire system

**Output:**
```
**Routing Decision:** CROSS_VALIDATION
**Rationale:** Architectural design spanning frontend UI flow and backend payment processing requires both perspectives
```

**Notification:** "我将使用交叉验证来设计电商结账流程架构"

---

### Example 8: Test Generation

**Input:**
- Task: "Generate unit tests for the UserProfile component"
- Files: `src/components/UserProfile.test.tsx` (to create)
- Testing: `src/components/UserProfile.tsx` (existing)
- Tech Stack: React, Jest, React Testing Library

**Analysis:**
1. **Task Essence**: Test generation for UI component
2. **Technical Domain**:
   - What's being tested: React component (frontend)
   - Test type: Unit tests for UI rendering and interactions
   - Verdict: Frontend testing
3. **Complexity**: Single domain, component-focused

**Output:**
```
**Routing Decision:** GEMINI
**Rationale:** Generating tests for React component using frontend testing frameworks
```

**Notification:** "我将使用 Gemini 来生成 UserProfile 组件的单元测试"

## Integration with Skills

Skills that reference this framework:

- `debugging-systematically` - Root cause analysis and multi-perspective debugging
- `brainstorming` - Design evaluation and solution exploration
- `writing-plans` - Technical proposal design and task planning
- `executing-plans` - Implementation routing for plan tasks
- `developing-with-subagents` - Subtask distribution to specialized agents
- `requesting-code-review` - Cross-review and validation strategy
- `test-driven-development` - Test generation routing
- `verifying-before-completion` - Verification strategy routing

Each skill should:
1. Collect the standard information set
2. Apply the analysis dimensions
3. Make a routing decision with rationale
4. Notify the user
5. Execute the task using the chosen model(s)

## Fallback Handling

If codeagent-wrapper is not available or invocation fails:

1. **Log the failure reason** for debugging
2. **Fall back to Claude** handling the task independently
3. **Note in the output** that external models were not used
4. **Proceed with best effort** using Claude's capabilities

**Example fallback message:**
```
注意: 外部模型不可用,将使用 Claude 直接处理此任务
```

## Best Practices

1. **Always collect complete information** before making a decision
2. **Prefer CROSS_VALIDATION** when uncertain - multiple perspectives reduce risk
3. **Keep user notifications brief** - don't overwhelm with technical details
4. **Use routing-rules.md as reference** but don't blindly follow scoring
5. **Consider the task holistically** - file extensions alone are not enough
6. **Think about the actual work** - what expertise is truly needed?
7. **When debugging**, prefer CROSS_VALIDATION unless root cause is clearly isolated
8. **For architecture**, almost always use CROSS_VALIDATION
9. **For simple tasks**, don't over-engineer - Claude is often sufficient

## Anti-Patterns to Avoid

❌ **Don't**: Route based solely on file extension
✅ **Do**: Analyze the actual task and required expertise

❌ **Don't**: Use hardcoded scoring algorithms mechanically
✅ **Do**: Apply semantic reasoning to understand task needs

❌ **Don't**: Route everything to CROSS_VALIDATION "to be safe"
✅ **Do**: Use CROSS_VALIDATION when genuinely beneficial (multi-domain, uncertain, critical)

❌ **Don't**: Skip user notification
✅ **Do**: Always inform user of routing decision (except for CLAUDE fallback)

❌ **Don't**: Ignore project context and tech stack
✅ **Do**: Understand the technology being used and what expertise it requires

## Evolution and Refinement

This framework should evolve based on:
- Actual routing outcomes and their effectiveness
- User feedback on routing decisions
- New patterns discovered in real-world usage
- Model capability updates (if Gemini/Codex strengths change)

Periodically review routing decisions and refine the framework to improve accuracy and user experience.
