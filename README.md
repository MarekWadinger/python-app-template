# python-project-template

<!-- TEMPLATE_USAGE_START -->
🚀 **Python Project Template** - A comprehensive template with pre-commit hooks, CI/CD workflows, and automated setup using modern Python tooling.

## Template Usage Instructions

### 1. Create a New Repository

#### Option A: Use GitHub Template (Recommended)

1. Go to this repository on GitHub
2. Click "Use this template" → "Create a new repository"
3. Clone your new repository locally

#### Option B: Clone Template

```bash
PROJECT=my-new-project
git clone <your-template-repo-url> $PROJECT
cd $PROJECT
```

### 2. Initialize the Project

Run the initialization script to customize the template (works with plain `make`, or with [`just`](https://github.com/casey/just) if you have it):

```bash
make init   # or: just init
```

The initialization will prompt you for:

- Project name (snake_case)
- Project description
- Python version (default: 3.12)
- Author name and email
- GitHub username

This will automatically replace all placeholder values throughout the project files.

At the end, init picks a single task runner for your project: if `just` is installed, the `justfile` is kept and the `Makefile` is removed; otherwise the `Makefile` is kept and the `justfile` is removed. The `init` recipe itself is stripped from whichever file remains.

For each of `python.md` and `python-tests.md` that exists in `~/.claude/rules/`, init deletes the repo's copy in `.claude/rules/`, so Claude Code loads it once, from your global rules.

### 3. Set Up Development Environment

```bash
# If `just` was kept
just dev-install
just install-hooks

# If the Makefile was kept
make install
```

### 4. Start Coding

Your project is ready! The template includes:

- A basic `src/python_app_template/main.py` with proper type hints
- Example tests
- Pre-configured tools for code quality

## Template Features

- 🐍 **Modern Python**: Uses Python 3.12+ with `uv` for fast dependency management
- 🎨 **Code Quality**: Pre-configured with ruff (lint + format), ty (type checking) and deptry (imports match declared dependencies)
- ✅ **Runtime Validation**: Public functions validate their arguments with pydantic (`@validated`); a contract test fails on any public function without it
- 🔒 **Security**: ruff's `S` rules check the code, pip-audit checks dependencies for known vulnerabilities
- 🔄 **Dependency Updates**: Dependabot keeps actions, pre-commit hooks and `uv.lock` current
- 🧪 **Testing**: pytest with coverage reporting
- 🪝 **Pre-commit Hooks**: Automated code formatting and linting
- 🚀 **CI/CD**: GitHub Actions workflows for testing, linting, and releases
- 📦 **Packaging**: Modern packaging with hatchling
- 🛠️ **Easy Setup**: Automated project initialization with Just

## Template Commands

Run `just --list` to see all available commands:

```bash
make init          # Initialize new project from template (or: just init)
just help          # Show available commands
just install       # Install project dependencies
just dev-install   # Install development dependencies
just install-hooks # Install pre-commit hooks
just test          # Run tests
just test-cov      # Run tests with coverage
just lint          # Run linting (ruff + deptry)
just format        # Format code
just security      # Run security checks
just clean         # Clean build artifacts
just build         # Build package
just check         # Run all checks (lint, test, security)
```

<!-- TEMPLATE_USAGE_END -->

<!-- PROJECT_README_START -->

A comprehensive Python app template with pre-commit, CI/CD, and automated setup.

[![Quality and Tests](https://github.com/yourusername/python-project-template/actions/workflows/ci.yml/badge.svg)](https://github.com/yourusername/python-project-template/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/yourusername/python-project-template/branch/main/graph/badge.svg)](https://codecov.io/gh/yourusername/python-project-template)

## 🚀 Quickstart

Run the application locally:

```bash
uv sync
uv run python -m python_app_template.main
```

## 🛠 Setup

Requires Python 3.12 or higher.

### From Source with UV

```bash
git clone https://github.com/yourusername/python-project-template.git
cd python-project-template
uv sync
```

### Development Workflow

```bash
just install-hooks
just check
```

## 🔧 Features

### Core Functionality

- **Modern Python**: Built with Python 3.12+ and modern tooling
- **Type Safety**: Full type hints throughout the codebase, validated at runtime by pydantic (`@validated` from `_validation.py`)
- **Testing**: Pytest-based test suite
- **CLI-first**: Runs as an application from the command line

### Development Tools

- **Code Quality**: Pre-configured with ruff (lint + format), ty (type checking) and deptry (imports match declared dependencies)
- **Security**: ruff's `S` rules check the code, pip-audit checks dependencies for known vulnerabilities
- **Pre-commit Hooks**: Automated code formatting and linting
- **CI/CD**: GitHub Actions workflows for testing, linting, and releases

## 📖 Documentation

## 🧪 Testing

Run the full test suite:

```bash
just test
```

Run tests with coverage:

```bash
just test-cov
```

A plain run never rewrites a test. When an [inline-snapshot](https://15r10nk.github.io/inline-snapshot/) value changes on purpose, rewrite it and review the diff:

```bash
uv run pytest --inline-snapshot=fix
```

The test suite includes:

- A contract test that fails on any public function without `@validated`
- A property test with [hypothesis](https://hypothesis.readthedocs.io/) and a snapshot test with inline-snapshot

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

1. Fork the repository
1. Create a feature branch (`git checkout -b feature/amazing-feature`)
1. Install development dependencies (`just dev-install`)
1. Install pre-commit hooks (`just install-hooks`)
1. Make your changes
1. Run tests (`just test`)
1. Run linting (`just lint`)
1. Commit your changes (`git commit -m 'feat: add amazing feature'`)
1. Push to the branch (`git push origin feature/amazing-feature`)
1. Open a Pull Request

### Code Style

The Python standard lives in [.claude/rules/python.md](.claude/rules/python.md): which tools enforce it, what they can't check, which packages to use.
The test standard lives in [.claude/rules/python-tests.md](.claude/rules/python-tests.md).

- **Variable Naming**: Use snake_case for variables, PascalCase for classes
- **Function Naming**: Use descriptive names, avoid abbreviations
- **Docstrings**: Use Google-style docstrings for all functions and classes
- **Type Hints**: Always include type hints for function parameters and return values
- **Line Length**: Maximum 120 characters per line (ruff)
- **Conventional Commits**: Use conventional commit format for all commits

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
<!--
## 📚 Citation

If you use this software in your research, please cite:

```bibtex
@software{python_app_template,
  title = {python-project-template: A comprehensive Python project template},
  author = {Your Name},
  url = {https://github.com/yourusername/python-project-template},
  year = {2024}
}
```
-->

## 📞 Support

If you encounter any issues or have questions:

- Open an [issue](https://github.com/yourusername/python-project-template/issues) on GitHub
- Check the existing documentation and examples
- Review the test cases for usage patterns
