# Load .env (single source of truth for all config)
-include .env
export

.DEFAULT_GOAL := help

.PHONY: help install lint format typecheck test test-cov security validate \
        bump pre-commit clean

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-18s\033[0m %s\n", $$1, $$2}'

# ─── Install ──────────────────────────────────────────────

install: ## Install all dependencies and pre-commit hooks
	uv sync --all-groups
	uv run pre-commit install --install-hooks

# ─── Linting & Formatting ────────────────────────────────

lint: ## Run ruff linter (check only)
	uv run --group format ruff check .

format: ## Auto-fix formatting with ruff
	uv run --group format ruff format .
	uv run --group format ruff check --fix .

# ─── Type Checking ────────────────────────────────────────

typecheck: ## Run ty type checker
	uv run --group lint ty check . --ignore unresolved-import

# ─── Testing ──────────────────────────────────────────────

test: ## Run pytest (all tests)
	uv run --group test pytest

test-cov: ## Run pytest with coverage report
	uv run --group test pytest --cov=src --cov-report=term --cov-report=html --cov-report=xml

# ─── Security ─────────────────────────────────────────────

security: ## Run security scans (bandit + safety)
	uv run --group security bandit -r src/
	uv run --group security safety scan || true

# ─── Validation ───────────────────────────────────────────

validate: lint typecheck test security ## Run all checks (lint + typecheck + test + security)
	@echo "All checks passed."

pre-commit: ## Run pre-commit hooks on all files
	uv run --group dev pre-commit run --all-files

# ─── Release ──────────────────────────────────────────────

bump: ## Bump version and update changelog with commitizen
	uv run --group dev cz bump

# ─── Cleanup ──────────────────────────────────────────────

clean: ## Remove generated files and caches
	rm -rf .pytest_cache .ruff_cache htmlcov dist build .coverage .coverage.*
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name '*.egg-info' -exec rm -rf {} + 2>/dev/null || true
