# Documentation

## Docs layout

| Folder | Contains |
|--------|----------|
| `docs/00_adr/` | Architecture decision records, `NNNNNN-title.md` |
| `docs/01_implementation_plans/` | Implementation plans, `NNNNNN-title.md` |
| `docs/02_change_plans/` | Change plans and their `NNNNNN-title-report.md` files |
| `docs/03_test_plans/` | Test plans (bullet lists of planned tests) |

## Numbering

- Six-digit zero-padded number + kebab-case slug.
- Independent sequence per folder.
- A completion report reuses its change plan's number.
- Rejected revision snapshots are named `NNNNNN-title.revN.md` in the same
  folder.

## Update obligations

Always update:

- Change plans when planning changes
- Completion reports after implementing
- README when functionality changes
- `.agents/architecture.md` when structure changes
- `.agents/context.md` freely, at any time
- Configuration docs when configuration changes

## Never update without asking

- User code
- Dependencies
- Anything inside `.agents/` except `context.md`, `skills/MANIFEST.md`, and
  new files the user asked to add
