---
paths:
  - "**/tests/**"
  - "**/test_*.py"
  - "**/conftest.py"
---

# Python Test Standards

Tests also follow [python.md](python.md). The pytest, coverage and inline-snapshot config is in the repo's [`pyproject.toml`](../../pyproject.toml).

- **Tools:** `pytest` and `pytest-cov`; `pytest-asyncio` with `@pytest.mark.asyncio` for async code.
- **Names:** `tests/test_<module>.py`, and `test_<what>_<condition>_<expected>()` for functions.
- **Setup:** `@pytest.fixture` for shared setup, `@pytest.mark.parametrize` for multiple inputs.
- **Mocks:** mock external services, not databases: integration tests use a real test database.
- **Property tests:** `hypothesis` for parsers, money and date math. State the property; it generates the edge cases and shrinks a failure to the smallest one.
- **Snapshot tests:** `inline-snapshot` for structured output such as parsed documents, reports and errors. A plain run only reports a changed snapshot; `--inline-snapshot=fix` rewrites the expected value in the test, and you review it in the diff.
