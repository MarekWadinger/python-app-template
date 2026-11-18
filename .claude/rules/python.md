---
paths:
  - "**/*.py"
---

# Python Standards

ruff and ty enforce most of the standard; this file adds what they can't see. FastAPI and SQLModel projects also follow `~/.claude/rules/fastapi.md`.

## Tools

- uv for everything; never pip, poetry or requirements.txt.
- ruff and ty pass with zero findings (ty with `--error-on-warning`). Fix the code, don't silence the tool: a suppression names its code and the reason (`# noqa: S603 - fixed argv`).
- The tool config (ruff, ty, pytest, coverage, deptry) is in this repo's [`pyproject.toml`](../../pyproject.toml) and [`.pre-commit-config.yaml`](../../.pre-commit-config.yaml); repos created from the template copy it from <https://github.com/MarekWadinger/python-app-template>.

## What the tools can't check

- **Types carry meaning.** No bare `dict`, `list[dict]` or `Any`: a `TypedDict` for data crossing a boundary (JSON, API documents, tool results), a frozen dataclass inside, `Literal` for a closed set of strings. Python 3.12 syntax, no `from __future__ import annotations`.
- **A function never silently ignores an input:** reject combinations it can't honour. (Keyword-only past 3 parameters is enforced by ruff.)
- **Errors are types.** Raise the package's own exception with a message saying what to do next; subclass it when callers branch, never branch on `str(e)`. Wrap infrastructure errors (`CalledProcessError`, `OSError`, HTTP) at the boundary.
- **No silent fallbacks.** `.get(key, default)` on data you require hides a broken input: index it or validate it.
- **Money is `Decimal`** with an explicit `rounding=`, never `float`. One value, one format.
- **Don't repeat yourself.** Reuse the helper that exists before building the same dict, string or check by hand again.
- **Sync by default**; `async` only where the framework is async.

## Packages

Stdlib first; add a dependency only when it removes real code. One tool per job:

| Need | Use | Instead of |
| --- | --- | --- |
| Type checking | `ty` | `mypy` |
| Formatting | `ruff format` | `black` |
| Security lint | ruff's `S` rules | `bandit` |
| HTTP | `urllib.request` for a few calls, `httpx` beyond that (5 s default timeout) | `requests` (no timeout), `aiohttp` |
| Validation | `pydantic` | |
| Settings | `tomllib` for a config file, `pydantic-settings` for env-driven apps (it reads `.env`) | `python-dotenv` called directly |
| Web API | `fastapi` | `flask` |
| Logging | `logfire` | |
| Time zones | `zoneinfo` | `pytz` (wrong offsets via `tzinfo=`) |
| Dependency check | `deptry`, run by pre-commit and the lint target: flags imports not declared in [`pyproject.toml`](../../pyproject.toml), and declared packages never imported | |

**Pydantic** validates data you don't control, at the boundary where it enters: an external API's response, a file someone else writes, input no framework has validated yet. One model per document kind, so a changed shape fails there, naming the field. Third-party data uses `extra="ignore"` (tolerate new fields); your own config uses `extra="forbid"` (catch typos). `TypeAdapter` over a `TypedDict` keeps one definition for ty and runtime. Not for data you build yourself (outgoing payloads, internal values): types and tests cover that.
