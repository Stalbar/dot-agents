# API Endpoints and Documentation Rules (local)

Generated at init. Project-specific. Keep under 12,000 characters.

## Framework

{{API_FRAMEWORK}} with {{API_DOCS_TOOL}}.

## Required decorators/annotations

Every API endpoint must have, in this order:

1. OpenAPI documentation annotation
2. HTTP method annotation
3. Permission annotation (if not the framework default)

## OpenAPI documentation

Required: tags, summary, description, responses. Optional: examples,
parameters, request body.

## Tags

Define tags in the central settings before using them in endpoints.

## Validation commands

```bash
{{SCHEMA_VALIDATE_CMD}}
```

## Documentation URLs

{{API_DOCS_URLS}}
