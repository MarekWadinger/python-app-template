# Task runner for python-project-template
# Requires `just` (https://github.com/casey/just) and `uv`

# Use bash for interactive prompts and bashisms
set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default:
    @just --list

help:
    @just --list

init:
    @echo "🚀 Initializing Python project from template..."
    @echo ""
    @read -p "Project name (snake_case): " PROJECT_NAME; \
    if [[ -z "$PROJECT_NAME" ]]; then \
        echo -e "\033[1;31m\033[1merror\033[0m\033[1m:\033[0m \033[1mProject name cannot be empty.\033[0m"; \
        exit 1; \
    fi; \
    read -p "Project description (default: none): " PROJECT_DESC; \
    read -p "Python version (default: 3.12): " PYTHON_VER; \
    PYTHON_VER=${PYTHON_VER:-3.12}; \
    read -p "Author name (default: none): " AUTHOR_NAME; \
    read -p "Author email (default: none): " AUTHOR_EMAIL; \
    read -p "GitHub username: " GITHUB_USER; \
    if [[ -z "$GITHUB_USER" ]]; then \
        echo -e "\033[1;31m\033[1merror\033[0m\033[1m:\033[0m \033[1mGitHub username cannot be empty.\033[0m"; \
        exit 1; \
    fi; \
    echo ""; \
    echo "📝 Updating project files..."; \
    PROJECT_MODULE=`echo "$PROJECT_NAME" | tr '-' '_'`; \
    for file in pyproject.toml README.md src/python_app_template/__init__.py src/python_app_template/main.py tests/test_python_app_template.py .github/workflows/*.yml .github/ISSUE_TEMPLATE/*.md .github/pull_request_template.md; do \
        if [ -f "$file" ]; then \
            echo "Updating $file..."; \
            sed -i.bak "s|python-project-template|$PROJECT_NAME|g" "$file"; \
            sed -i.bak "s|Your Name|$AUTHOR_NAME|g" "$file"; \
            sed -i.bak "s|your.email@example.com|$AUTHOR_EMAIL|g" "$file"; \
            sed -i.bak "s|yourusername|$GITHUB_USER|g" "$file"; \
            sed -i.bak "s|A comprehensive Python project template with pre-commit, CI/CD, and automated setup|$PROJECT_DESC|g" "$file"; \
            sed -i.bak "s|python_app_template|$PROJECT_MODULE|g" "$file"; \
            rm "$file.bak"; \
        fi; \
    done; \
    echo "$PYTHON_VER" > .python-version; \
    echo "📝 Cleaning up README.md..."; \
    sed -i.bak '/<!-- TEMPLATE_USAGE_START -->/,/<!-- TEMPLATE_USAGE_END -->/d' README.md; \
    sed -i.bak 's/<!-- PROJECT_README_START -->//g' README.md; \
    sed -i.bak 's/<!-- PROJECT_README_END -->//g' README.md; \
    rm README.md.bak; \
    rm -f TEMPLATE_USAGE.md; \
    if [ "$PROJECT_MODULE" != "python_app_template" ]; then \
        echo "📁 Renaming module directories..."; \
        mv src/python_app_template src/$PROJECT_MODULE; \
        mv tests/test_python_app_template.py tests/test_$PROJECT_MODULE.py; \
    fi; \
    echo ""; \
    echo "✅ Project initialized successfully!"; \
    echo ""; \
    echo "Next steps:"; \
    echo "1. just dev-install"; \
    echo "2. just install-hooks"; \
    echo "3. Start coding!"
    git add .
    git commit -m 'chore: initialize project from template'

install:
    @echo "📦 Installing project dependencies..."
    uv sync

dev-install:
    @echo "🛠️  Installing development dependencies..."
    uv sync --all-groups

install-hooks:
    @echo "🪝 Installing pre-commit hooks..."
    uv run --group dev pre-commit install

test:
    @echo "🧪 Running tests..."
    uv run --group test pytest

test-cov:
    @echo "🧪 Running tests with coverage..."
    uv run --group test pytest --cov=src --cov-report=term --cov-report=html --cov-report=xml

lint:
    @echo "🔍 Running linting..."
    uv run --group format ruff check .

typecheck:
    @echo "🔎 Running type checks..."
    uv run --group lint ty check . --ignore unresolved-import

format:
    @echo "🎨 Formatting code..."
    uv run --group format ruff format .
    uv run --group format ruff check --fix .

security:
    @echo "🔒 Running security checks..."
    uv run --group security bandit -r src/ -f json -o bandit-report.json
    uv run --group security safety scan

clean:
    @echo "🧹 Cleaning build artifacts..."
    rm -rf build/
    rm -rf dist/
    rm -rf *.egg-info/
    rm -rf .coverage
    rm -rf htmlcov/
    rm -rf .pytest_cache/
    rm -rf .mypy_cache/
    rm -rf .ruff_cache/
    rm -f coverage.xml
    rm -f bandit-report.json
    find . -type d -name __pycache__ -delete
    find . -type f -name "*.pyc" -delete

build:
    @echo "🏗️  Building package..."
    uv build

bump:
    @echo "🔼 Bumping version..."
    uv run --group dev cz bump

changelog:
    @echo "📜 Generating changelog (dry run)..."
    uv run --group dev cz changelog --dry-run

alias validate := check

check:
    just lint
    just typecheck
    just test
    just security
