# Docker

Principles and patterns for fast and effective image building.

## 1. Core rule

Only rebuild what changed. Everything else must be cached.

## 2. Always use BuildKit

```bash
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
```

Why: smarter caching, cache mounts, parallel steps.

## 3. Use multi-stage builds

```dockerfile
FROM python:3.11-slim AS builder
FROM python:3.11-slim AS runtime
```

Builder: compilers, headers, heavy installs. Runtime: only what is needed to
run. Never ship the builder.

## 4. Install dependencies before copying code

Bad:

```dockerfile
COPY . .
RUN pip install -r requirements.txt
```

Good:

```dockerfile
COPY requirements.txt .
RUN pip install ...
COPY . .
```

Why: code changes often, dependencies do not. Keeps cache valid.

## 5. Use `pip install --prefix` in builder

```dockerfile
RUN pip install --prefix=/install -r requirements.txt
```

Installs into `/install`, does not modify Python, pure file staging.

## 6. Copy prefix into `/usr/local` in runtime

```dockerfile
COPY --from=builder /install /usr/local
```

Why: Python already looks in `/usr/local`. No PYTHONPATH hacks, no virtualenv
needed, clean boundary between build and runtime.

## 7. Keep system packages out of runtime

```dockerfile
FROM python:3.11-slim AS builder
RUN apt-get update && apt-get install -y build-essential
```

Never install compilers or headers in runtime.

## 8. Prefer slim language images

Use `python:x.y-slim`, `node:x-slim`, `golang:x`. Avoid `ubuntu` unless
strictly required.

## 9. Add `.dockerignore`

Always. Typical: `.git`, `.venv`, `node_modules`, `__pycache__`, `data`,
`*.log`. Why: smaller build context, faster COPY, less cache invalidation.

## 10. Use cache mounts for package managers

```dockerfile
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install -r requirements.txt
```

Big speedup on rebuilds.

## 11. Separate dev, test, prod via targets

```dockerfile
FROM runtime AS dev
FROM runtime AS test
FROM runtime AS prod
```

```bash
docker build --target dev  -t app-dev .
docker build --target prod -t app-prod .
```

Rules: prod must NOT depend on dev. Dev/test tools never leak into prod.

## 12. `--target` builds the dependency graph, not file order

```bash
docker build --target prod .
```

Builds only: builder, runtime, prod. Skips dev, test, lint.

## 13. Mount code for local development

```yaml
volumes:
  - .:/app
```

Avoid rebuilds. Rebuild only when dependencies change.

## 14. Prebuild heavy base images if needed

```dockerfile
FROM python:3.11-slim AS base
RUN pip install numpy torch pandas
```

Then reuse `FROM base`. Useful for slow machines.

## 15. Docker images are not virtual machines

Do not: install shells for comfort, run system services, mutate runtime state.
Images should be deterministic, minimal, disposable.

## 16. Mental model

Builder = kitchen. Runtime = plate. Only the food goes to the plate.

## 17. One-line summary

Fast Docker builds come from multi-stage design, strict separation of
concerns, minimal base images, aggressive caching, and building only what the
target needs.

## Agent prompt

When writing Dockerfiles or Docker build instructions, follow the rules above
strictly. Optimize for fast rebuilds, small images, and weak local machines.
Be explicit and minimal. Prefer correctness over convenience. Never include
unnecessary layers or tools. Do not start docker compose files with a
`version:` key. It is deprecated.
