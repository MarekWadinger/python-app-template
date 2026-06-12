# Load .env (single source of truth for all config)
-include .env
export

# Bash for interactive prompts and bashisms in `init`
SHELL := /bin/bash

.DEFAULT_GOAL := help

.PHONY: help install lint format typecheck test test-cov security validate \
        bump pre-commit build clean

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-18s\033[0m %s\n", $$1, $$2}'

# >>> TEMPLATE INIT >>>
# This whole block is removed automatically after `make init` runs.

.PHONY: init

init: ## Initialize a new project from this template
	@echo "🚀 Initializing Python project from template..."
	@echo ""
	@read -p "Project name (snake_case): " PROJECT_NAME; \
	if [[ -z "$$PROJECT_NAME" ]]; then \
		echo -e "\033[1;31m\033[1merror\033[0m\033[1m:\033[0m \033[1mProject name cannot be empty.\033[0m"; \
		exit 1; \
	fi; \
	read -p "Project description (default: none): " PROJECT_DESC; \
	read -p "Python version (default: 3.12): " PYTHON_VER; \
	PYTHON_VER=$${PYTHON_VER:-3.12}; \
	read -p "Author name (default: none): " AUTHOR_NAME; \
	read -p "Author email (default: none): " AUTHOR_EMAIL; \
	read -p "GitHub username: " GITHUB_USER; \
	if [[ -z "$$GITHUB_USER" ]]; then \
		echo -e "\033[1;31m\033[1merror\033[0m\033[1m:\033[0m \033[1mGitHub username cannot be empty.\033[0m"; \
		exit 1; \
	fi; \
	echo ""; \
	echo "📝 Updating project files..."; \
	PROJECT_MODULE=`echo "$$PROJECT_NAME" | tr '-' '_'`; \
	for file in pyproject.toml README.md src/python_app_template/__init__.py src/python_app_template/main.py tests/__init__.py tests/test_python_app_template.py .github/workflows/*.yml .github/ISSUE_TEMPLATE/*.md .github/pull_request_template.md; do \
		if [ -f "$$file" ]; then \
			echo "Updating $$file..."; \
			sed -i.bak "s|python-project-template|$$PROJECT_NAME|g" "$$file"; \
			sed -i.bak "s|Your Name|$$AUTHOR_NAME|g" "$$file"; \
			sed -i.bak "s|your.email@example.com|$$AUTHOR_EMAIL|g" "$$file"; \
			sed -i.bak "s|yourusername|$$GITHUB_USER|g" "$$file"; \
			sed -i.bak "s|A comprehensive Python project template with pre-commit, CI/CD, and automated setup|$$PROJECT_DESC|g" "$$file"; \
			sed -i.bak "s|python_app_template|$$PROJECT_MODULE|g" "$$file"; \
			rm "$$file.bak"; \
		fi; \
	done; \
	echo "$$PYTHON_VER" > .python-version; \
	echo "📝 Resetting version and changelog..."; \
	sed -i.bak 's|^version = ".*"|version = "0.1.0"|' pyproject.toml; \
	rm pyproject.toml.bak; \
	sed -i.bak 's|^__version__ = ".*"|__version__ = "0.1.0"|' src/python_app_template/__init__.py; \
	rm src/python_app_template/__init__.py.bak; \
	printf '# Changelog\n\nThis changelog is maintained automatically by [commitizen](https://commitizen-tools.github.io/commitizen/) on version bumps.\n' > CHANGELOG.md; \
	echo "📝 Cleaning up README.md..."; \
	sed -i.bak '/<!-- TEMPLATE_USAGE_START -->/,/<!-- TEMPLATE_USAGE_END -->/d' README.md; \
	sed -i.bak 's/<!-- PROJECT_README_START -->//g' README.md; \
	sed -i.bak 's/<!-- PROJECT_README_END -->//g' README.md; \
	rm README.md.bak; \
	cat -s README.md > README.md.tmp && mv README.md.tmp README.md; \
	rm -f TEMPLATE_USAGE.md; \
	if [ "$$PROJECT_MODULE" != "python_app_template" ]; then \
		echo "📁 Renaming module directories..."; \
		mv src/python_app_template src/$$PROJECT_MODULE; \
		mv tests/test_python_app_template.py tests/test_$$PROJECT_MODULE.py; \
	fi; \
	echo "🔒 Regenerating lockfile for the renamed project..."; \
	uv lock; \
	echo ""; \
	echo "🧰 Selecting task runner..."; \
	if command -v just >/dev/null 2>&1; then \
		echo "'just' is available — keeping justfile, removing Makefile."; \
		rm -f Makefile; \
		sed -i.bak '/^# >>> TEMPLATE INIT >>>/,/^# <<< TEMPLATE INIT <<</d' justfile; \
		rm -f justfile.bak; \
		echo ""; \
		echo "✅ Project initialized successfully!"; \
		echo ""; \
		echo "Next steps:"; \
		echo "1. just dev-install"; \
		echo "2. just install-hooks"; \
		echo "3. Start coding!"; \
	else \
		echo "'just' not found — keeping Makefile, removing justfile."; \
		rm -f justfile; \
		sed -i.bak '/^# >>> TEMPLATE INIT >>>/,/^# <<< TEMPLATE INIT <<</d' Makefile; \
		rm -f Makefile.bak; \
		sed -i.bak -e 's|just dev-install|make install|g' -e 's|just install-hooks|make install|g' -e 's|just check|make validate|g' -e 's|just |make |g' README.md; \
		rm -f README.md.bak; \
		sed -i.bak -e '/- name: Install just/,+1d' -e 's|run: just |run: make |g' .github/workflows/ci.yml; \
		rm -f .github/workflows/ci.yml.bak; \
		echo ""; \
		echo "✅ Project initialized successfully!"; \
		echo ""; \
		echo "Next steps:"; \
		echo "1. make install"; \
		echo "2. Start coding!"; \
	fi
	git add -A
	git commit -m 'chore: initialize project from template'

# <<< TEMPLATE INIT <<<

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

security: ## Run security scans (bandit + pip-audit)
	uv run --group security bandit -r src/
	uv run --group security pip-audit --skip-editable

# ─── Validation ───────────────────────────────────────────

validate: lint typecheck test security ## Run all checks (lint + typecheck + test + security)
	@echo "All checks passed."

pre-commit: ## Run pre-commit hooks on all files
	uv run --group dev pre-commit run --all-files

# ─── Release ──────────────────────────────────────────────

build: ## Build the package
	uv build

bump: ## Bump version and update changelog with commitizen
	uv run --group dev cz bump

# ─── Cleanup ──────────────────────────────────────────────

clean: ## Remove generated files and caches
	rm -rf .pytest_cache .ruff_cache htmlcov dist build .coverage .coverage.*
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name '*.egg-info' -exec rm -rf {} + 2>/dev/null || true
