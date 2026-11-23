# Cross-Model Review Prompt Template

Copy this prompt to have another model (or fresh session) review an artifact cold:

---

You are reviewing `<artifact-path>` for a project governed by `.agents/`.
Read the artifact and evaluate it against standard engineering criteria:
1. Correctness & logic edge cases
2. Security & credential safety
3. Architectural simplicity (YAGNI, standard library first)
4. Modularity & call-graph reachability

Return your verdict and issues grouped by severity. Do not modify any files.

```markdown
## Verdict: approve | approve-with-changes | reject

## Critical Issues
- [Blocking defects or security risks]

## Major Issues
- [Design compromises or missing tests]

## Minor Issues
- [Style, naming, or documentation improvements]
```
