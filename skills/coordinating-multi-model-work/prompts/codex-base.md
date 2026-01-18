# Codex Base Prompt Template

> **IMPORTANT**: All prompts sent to Codex must be in English. This ensures standardized and efficient multi-model collaboration.

## General Analysis Template

```
## Task Background
{task_context}

## Analysis Requirements
Please analyze from a backend/system architecture perspective.

## Focus Areas
1. **Code Logic** - Algorithm correctness, boundary condition handling
2. **Data Flow** - How data flows through the system
3. **Performance** - Time complexity, space complexity, potential bottlenecks
4. **Security** - Input validation, access control, data protection
5. **Maintainability** - Code structure, error handling, logging

## Output Format
### Analysis Conclusion
[Main findings and conclusions]

### Issue List
1. [Issue description] - [Severity: High/Medium/Low]
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

## Error Message
{error_message}

## Please Analyze
1. What is the root cause of the problem?
2. Why does this problem occur?
3. How to fix it?
4. How to prevent similar issues from happening again?

## Output Format
### Root Cause Analysis
[Root cause of the problem]

### Causation Chain
1. [Direct cause]
2. [Indirect cause]
3. [Root cause]

### Fix Solution
```diff
- [Original code]
+ [Fixed code]
```

### Prevention Measures
[Suggestions to prevent similar issues]
```

## Code Review Template

```
## Review Scope
{files_to_review}

## Change Summary
{change_summary}

## Please Review From the Following Perspectives

### 1. Correctness
- Is the logic correct?
- Are boundary conditions handled?
- Is error handling comprehensive?

### 2. Performance
- Are there any performance issues?
- Are database queries optimized?
- Are there any unnecessary computations?

### 3. Security
- Are there any security vulnerabilities?
- Is input validated?
- Is sensitive data protected?

### 4. Maintainability
- Is the code clear?
- Is naming reasonable?
- Does it comply with project standards?

## Output Format
### Review Conclusion
[Overall assessment: Approved/Needs Changes/Needs Rewrite]

### Issue List
| File | Line | Issue | Severity | Suggestion |
|------|------|-------|----------|------------|
| ... | ... | ... | ... | ... |

### Strengths
[Areas where the code excels]

### Improvement Suggestions
[Specific improvement suggestions]
```

## Design Evaluation Template

```
## Design Proposal
{design_proposal}

## Technical Constraints
{constraints}

## Please Evaluate

### 1. Architecture Reasonableness
- Is component division reasonable?
- Are dependencies clear?
- Does it follow design principles?

### 2. Scalability
- Is it easy to extend?
- Does it support future requirements?
- Is it over-designed?

### 3. Reliability
- Failure handling mechanisms?
- Data consistency guarantees?
- Monitoring and alerts?

### 4. Implementation Feasibility
- Technical challenges?
- Dependency risks?
- Implementation suggestions?

## Output Format
### Evaluation Conclusion
[Overall assessment]

### Strengths
1. [Strength 1]
2. [Strength 2]

### Risks
1. [Risk 1] - [Mitigation measures]
2. [Risk 2] - [Mitigation measures]

### Improvement Suggestions
[Specific suggestions]
```

## Test Generation Template

```
## Code to Test
{code_to_test}

## Test Requirements
- Test framework: {test_framework}
- Coverage target: {coverage_target}

## Please Generate Test Cases

### Coverage Scope
1. Normal path testing
2. Boundary condition testing
3. Error handling testing
4. Performance testing (if applicable)

## Output Format
### Test Cases
```{language}
// Test code
```

### Test Description
| Test Name | Test Purpose | Expected Result |
|-----------|--------------|-----------------|
| ... | ... | ... |

### Coverage Analysis
[Scenarios covered by tests and scenarios not covered]
```
