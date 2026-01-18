# Gemini Base Prompt Template

> **IMPORTANT**: All prompts sent to Gemini must be in English. This ensures standardized and efficient multi-model collaboration.

## General Analysis Template

```
## Task Background
{task_context}

## Analysis Requirements
Please analyze from a frontend/user experience perspective.

## Focus Areas
1. **Component Structure** - Component division, reusability, composition patterns
2. **User Experience** - Interaction fluidity, timely feedback, usability
3. **Visual Design** - Layout reasonableness, style consistency, responsive adaptation
4. **Performance** - Rendering performance, load speed, resource optimization
5. **Accessibility** - Keyboard navigation, screen reader support, color contrast

## Output Format
### Analysis Conclusion
[Main findings and conclusions]

### Issue List
1. [Issue description] - [Impact Level: High/Medium/Low]
2. ...

### Recommended Solutions
[Specific improvement suggestions]
```

## Debugging Analysis Template

```
## Problem Description
{bug_description}

## Related Code
{code_context}

## User Feedback/Error Manifestation
{user_feedback}

## Please Analyze
1. What is the manifestation of the problem?
2. What are the possible causes?
3. How to reproduce the problem?
4. How to fix it?

## Output Format
### Problem Location
[Which component/module the problem appears in]

### Possible Causes
1. [Cause 1] - [Likelihood: High/Medium/Low]
2. [Cause 2] - [Likelihood: High/Medium/Low]

### Reproduction Steps
1. [Step 1]
2. [Step 2]
3. [Expected result vs Actual result]

### Fix Solution
```diff
- [Original code]
+ [Fixed code]
```

### User Experience Improvement
[How user experience improves after the fix]
```

## Code Review Template

```
## Review Scope
{files_to_review}

## Change Summary
{change_summary}

## Please Review From the Following Perspectives

### 1. Component Design
- Is component responsibility single?
- Is it easy to reuse?
- Is Props design reasonable?

### 2. User Experience
- Is interaction smooth?
- Is loading state handled?
- Is error state user-friendly?

### 3. Style Quality
- Does it comply with design standards?
- Is responsive design comprehensive?
- Are there any style conflicts?

### 4. Performance
- Are there any unnecessary re-renders?
- Is memo/useMemo used correctly?
- Is resource loading optimized?

### 5. Accessibility
- Semantic HTML?
- ARIA attributes?
- Keyboard operable?

## Output Format
### Review Conclusion
[Overall assessment: Approved/Needs Changes/Needs Rewrite]

### Issue List
| File | Line | Issue | Type | Suggestion |
|------|------|-------|------|------------|
| ... | ... | ... | UX/Performance/Accessibility | ... |

### Strengths
[Areas where the code excels]

### Improvement Suggestions
[Specific improvement suggestions]
```

## UI Design Evaluation Template

```
## Design Proposal
{design_proposal}

## Design Constraints
{constraints}

## Please Evaluate

### 1. Visual Hierarchy
- Is information hierarchy clear?
- Are key points highlighted?
- Is visual guidance reasonable?

### 2. Interaction Design
- Is the operation flow smooth?
- Is feedback timely?
- Does it align with user mental models?

### 3. Responsive Design
- Is adaptation at each breakpoint reasonable?
- Touch device experience?
- Content priority?

### 4. Consistency
- Does it comply with the design system?
- Is component usage consistent?
- Are interaction patterns unified?

## Output Format
### Evaluation Conclusion
[Overall assessment]

### Strengths
1. [Strength 1]
2. [Strength 2]

### Issues
1. [Issue 1] - [Improvement suggestion]
2. [Issue 2] - [Improvement suggestion]

### Design Suggestions
[Specific design improvement suggestions, may include sketch descriptions]
```

## Component Development Template

```
## Component Requirements
{component_requirements}

## Design Mockup/Prototype
{design_reference}

## Tech Stack
- Framework: {framework}
- Styling approach: {styling}
- State management: {state_management}

## Please Implement

### Requirements
1. Clear component structure, single responsibility
2. Complete Props types with default values
3. Styles support customization and theming
4. Handle loading, error, and empty states
5. Support keyboard operation and screen readers

## Output Format
### Component Code
```{framework}
// Component implementation
```

### Usage Example
```{framework}
// Usage example
```

### Props Documentation
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| ... | ... | ... | ... |

### Accessibility Notes
[Accessibility features of the component]
```

## Test Generation Template

```
## Component to Test
{component_code}

## Test Requirements
- Test framework: {test_framework}
- Coverage target: {coverage_target}

## Please Generate Test Cases

### Coverage Scope
1. Rendering tests - Component renders correctly
2. Interaction tests - User action responses
3. State tests - State changes correctly
4. Boundary tests - Exceptional input handling
5. Accessibility tests - a11y compliance

## Output Format
### Test Cases
```{language}
// Test code
```

### Test Description
| Test Name | Test Purpose | User Scenario |
|-----------|--------------|---------------|
| ... | ... | ... |

### Coverage Analysis
[Scenarios covered by tests and recommended additional tests]
```
