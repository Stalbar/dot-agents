# Docker Project Rules (local)

Generated at init. Project-specific. Keep under 12,000 characters.

## Dual configuration requirement

When making Docker-related changes (environment variables, service
configuration, healthchecks, volumes), apply changes to BOTH:

1. `{{COMPOSE_FILE}}` - local development
2. `{{INFRA_FILE}}` - deployment

This keeps local development and deployment environments in sync.

### Checklist

- [ ] Change applied to `{{COMPOSE_FILE}}`
- [ ] Change applied to `{{INFRA_FILE}}`
- [ ] Docs updated

## Execution consistency

Scripts that run in local containers must execute the same way in the
deployment environment: same entrypoint behavior, same script paths, same
order of operations.

## Notes

- Follow `.agents/rules/docker.md` for image building.
- {{DOCKER_NOTES}}
