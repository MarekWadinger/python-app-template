# Task runner for python-project-template
# Requires `just` (https://github.com/casey/just) and `uv`

default:
    @just --list

help:
    @just --list

init:
    @echo "🚀 Initializing Python project from template..."
    @echo ""
    @read -p "Project name (snake_case): " PROJECT_NAME; \
    read -p "Project description: " PROJECT_DESC; \
    read -p "Python version (default: 3.12): " PYTHON_VER; \
    PYTHON_VER=$${PYTHON_VER:-3.12}; \
    read -p "Author name: " AUTHOR_NAME; \
    read -p "Author email: " AUTHOR_EMAIL; \
    read -p "GitHub username: " GITHUB_USER; \
    echo ""; \
    echo "📝 Updating project files..."; \
    PROJECT_MODULE=`echo "$$PROJECT_NAME" | tr '-' '_'`; \
    for file in pyproject.toml README.md src/python_app_template/__init__.py src/python_app_template/main.py tests/test_python_app_template.py .github/workflows/*.yml .github/ISSUE_TEMPLATE/*.md .github/pull_request_template.md; do \
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
    echo "📝 Cleaning up README.md..."; \
    sed -i.bak '/<!-- TEMPLATE_USAGE_START -->/,/<!-- TEMPLATE_USAGE_END -->/d' README.md; \
    sed -i.bak 's/<!-- PROJECT_README_START -->//g' README.md; \
    sed -i.bak 's/<!-- PROJECT_README_END -->//g' README.md; \
    rm README.md.bak; \
    rm -f TEMPLATE_USAGE.md; \
    if [ "$$PROJECT_MODULE" != "python_app_template" ]; then \
        echo "📁 Renaming module directories..."; \
        mv src/python_app_template src/$$PROJECT_MODULE; \
        mv tests/test_python_app_template.py tests/test_$$PROJECT_MODULE.py; \
    fi; \
    echo ""; \
    echo "✅ Project initialized successfully!"; \
    echo ""; \
    echo "Next steps:"; \
    echo "1. just dev-install"; \
    echo "2. just install-hooks"; \
    echo "3. Start coding!"

install:
    @echo "📦 Installing project dependencies..."
    uv sync

dev-install:
    @echo "🛠️  Installing development dependencies..."
    uv sync --all-groups

install-hooks:
    @echo "🪝 Installing pre-commit hooks..."
    uv run pre-commit install

test:
    @echo "🧪 Running tests..."
    uv run pytest

test-cov:
    @echo "🧪 Running tests with coverage..."
    uv run pytest --cov=src --cov-report=term --cov-report=html --cov-report=xml

lint:
    @echo "🔍 Running linting..."
    uv run ty check .

format:
    @echo "🎨 Formatting code..."
    uv run ruff format .

security:
    @echo "🔒 Running security checks..."
    uv run bandit -r src/ -f json -o bandit-report.json
    uv run safety scan

clean:
    @echo "🧹 Cleaning build artifacts..."
    rm -rf build/
    rm -rf dist/
    rm -rf *.egg-info/
    rm -rf .coverage
    rm -rf htmlcov/
    rm -rf .pytest_cache/
    rm -rf .mypy_cache/
    find . -type d -name __pycache__ -delete
    find . -type f -name "*.pyc" -delete

build:
    @echo "🏗️  Building package..."
    uv build

check:
    just lint
    just test
    just security
