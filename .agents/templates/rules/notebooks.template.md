# Notebook Rules (local)

Generated at init. Project-specific. Keep under 12,000 characters.

## Cell structure

1. Parameters cell (first cell, tagged for the notebook runner)
2. Setup cell (root + helpers import)
3. Framework setup cell (e.g. Django setup)
4. Business logic cells

## Display rules

- Use display helpers for section headers and tables, not print or logger.
- All display output is captured by the notebook runner for artifacts.

## Importability

Notebooks contain wiring only. Extract reusable logic into importable modules
and test by importing them (see `.agents/rules/modularity.md` and
`.agents/rules/tests.md`).

## Error handling

Wrap blocks that can crash in try/catch. Provide fallbacks.
