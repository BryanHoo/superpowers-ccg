# Routing Decision Framework

## Overview

This framework guides Claude in making semantic routing decisions for multi-model task distribution. Claude analyzes task characteristics using reasoning to determine the optimal execution model.

**Purpose**: Enable intelligent, context-aware routing decisions that adapt to task nuances.

## When to Use

Invoke this framework when a skill needs to call external models (Codex/Gemini) via the MCP tools (`mcp__codex__codex`, `mcp__gemini__gemini`).

## Standard Information Set

Collect these inputs for decision-making:

1. **Task Description** - User's request in natural language
2. **File Information** - File paths and extensions involved
3. **Tech Stack** - Inferred from project files

## Analysis Dimensions

### 1. Task Essence

What problem is this task primarily solving?

**Consider:**
- Core objective: Fix bug, add feature, optimize performance, refactor code
- Domain focus: Data processing, user interface, business logic, infrastructure
- Primary skill required: Design thinking, algorithmic problem-solving, UI/UX implementation

### 2. Technical Domain

Does this task lean toward frontend (UI/interaction) or backend (logic/data)?

**Frontend Indicators:**
- UI components, layouts, visual design
- User interactions, event handling
- Styling, animations, responsive design
- Client-side state management
- Browser APIs, DOM manipulation

**Backend Indicators:**
- API endpoints, server logic
- Database operations, data models, ORM
- Algorithms, performance optimization
- Authentication, authorization, security
- Background jobs, message queues

### 3. Complexity & Uncertainty

Does this task involve multiple domains or uncertain factors?

**High Complexity Indicators:**
- Spans frontend and backend simultaneously
- Multiple possible root causes (debugging scenarios)
- Architectural design decisions affecting both layers
- Critical changes affecting core functionality
- Insufficient information to determine domain

**Low Complexity Indicators:**
- Single file change in a clear domain
- Well-defined scope
- Isolated component or function

## Decision Output

Based on the analysis, output:

```
**Routing Decision:** [GEMINI | CODEX | CROSS_VALIDATION | CLAUDE]
**Rationale:** [One sentence]
```

**Early exposure note:** If `Routing != CLAUDE`, apply `coordinating-multi-model-work/GATE.md` immediately (evidence or BLOCKED) before doing real work.

### Routing Targets

- **GEMINI** - Frontend expert for UI, components, styles, interactions
- **CODEX** - Backend expert for APIs, databases, algorithms, server-side logic
- **CROSS_VALIDATION** - Both models for full-stack tasks, architectural decisions, or high uncertainty
- **CLAUDE** - Simple tasks that don't require specialized external models

## Decision Guidelines

- Strong frontend signals and weak/no backend signals → GEMINI
- Strong backend signals and weak/no frontend signals → CODEX
- Strong signals in both domains OR high uncertainty OR architectural → CROSS_VALIDATION
- Simple task OR documentation OR trivial config → CLAUDE
- Ambiguous case → CROSS_VALIDATION (err on the side of getting multiple perspectives)

**Key Principle**: When in doubt, prefer CROSS_VALIDATION over guessing.

## Examples

### Example 1: Frontend Task

**Input:** "Add a dark mode toggle to the settings page"
**Files:** `src/components/Settings.tsx`, `src/styles/theme.css`

**Output:**
```
**Routing Decision:** GEMINI
**Rationale:** UI component and styling task with clear frontend domain signals
```

---

### Example 2: Backend Task

**Input:** "Optimize database query performance for user search"
**Files:** `server/api/users.go`, `server/db/queries.sql`

**Output:**
```
**Routing Decision:** CODEX
**Rationale:** Database query optimization with clear backend domain signals
```

---

### Example 3: Full-Stack Task

**Input:** "Implement real-time notification system"
**Files:** `server/websocket/hub.go`, `src/components/NotificationBell.tsx`

**Output:**
```
**Routing Decision:** CROSS_VALIDATION
**Rationale:** Spans backend WebSocket implementation and frontend UI component
```

---

### Example 4: Uncertain Debugging

**Input:** "Fix the authentication bug - users can't log in"
**Files:** Unknown (need investigation)

**Output:**
```
**Routing Decision:** CROSS_VALIDATION
**Rationale:** Authentication bug with unclear root cause requires multi-perspective diagnosis
```