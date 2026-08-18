# Scripts

Reusable action sequences become parametrized scripts in
`.agents/commands/scripts/`. The agents create and maintain them.

## Two-times rule

If the agent runs the same sequence of actions twice, the third time it must
first script it into `commands/scripts/` and wire the script into the matching
command file (or create a new command file).

## Location and naming

- All scripts in `.agents/commands/scripts/`, lowercase kebab-case.
- Cross-platform: prefer Python (one file for both OSes). Otherwise ship a
  `.sh` and a `.ps1` pair with identical behavior and arguments.

## Parameterization

- Parameters come from CLI arguments first, env vars second. Never hardcode
  project paths.
- Every script starts with a header comment block: name, purpose, usage,
  example, created, params.

## Invocation wrappers (mandatory)

Command files invoke scripts only through these wrappers:

- Windows `.ps1`:
  `powershell -NoProfile -ExecutionPolicy Bypass -File .agents/commands/scripts/<script>.ps1 <args>`
- POSIX `.sh`:
  `bash .agents/commands/scripts/<script>.sh <args>`
- Python:
  `python .agents/commands/scripts/<script>.py <args>`, with venv discovery:
  check `VIRTUAL_ENV`, then `./.venv/Scripts/python.exe` (Windows) or
  `./.venv/bin/python` (POSIX), then system `python3`/`py`. Each Python script
  accepts `--python <path>` as an override.

## Behavior

- Scripts are idempotent.
- Scripts fail loudly: non-zero exit on failure, clear message on stderr.
- A new script is presented as a one-line notice, not a gate:
  "Saved scripts/name.sh (usage: ...)". The user may review the library
  anytime with `/code-review commands/scripts/`.
- Scripts that encode project knowledge are committed with the repo.
