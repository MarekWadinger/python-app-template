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
git clone <your-template-repo-url> my-new-project
cd my-new-project
```

### 2. Initialize the Project

Run the initialization script to customize the template using [`just`](https://github.com/casey/just):

```bash
just init
```

The initialization will prompt you for:

- Project name (snake_case)
- Project description
- Python version (default: 3.12)
- Author name and email
- GitHub username

This will automatically replace all placeholder values throughout the project files.

### 3. Set Up Development Environment

```bash
# Install dependencies
just dev-install

# Install pre-commit hooks
just install-hooks
```

### 4. Start Coding

Your project is ready! The template includes:

- A basic `main.py` with proper type hints
- Example tests
- Pre-configured tools for code quality

## Template Features

- 🐍 **Modern Python**: Uses Python 3.12+ with `uv` for fast dependency management
- 🎨 **Code Quality**: Pre-configured with Black, isort, flake8, and mypy
- 🔒 **Security**: Integrated security scanning with bandit and safety
- 🧪 **Testing**: pytest with coverage reporting
- 🪝 **Pre-commit Hooks**: Automated code formatting and linting
- 🚀 **CI/CD**: GitHub Actions workflows for testing, linting, and releases
- 📦 **Packaging**: Modern packaging with hatchling
- 🛠️ **Easy Setup**: Automated project initialization with Just

## Template Commands

Run `just --list` to see all available commands:

```bash
just help          # Show available commands
just init          # Initialize new project from template
just install       # Install project dependencies
just dev-install   # Install development dependencies
just install-hooks # Install pre-commit hooks
just test          # Run tests
just test-cov      # Run tests with coverage
just lint          # Run linting
just format        # Format code
just security      # Run security checks
just clean         # Clean build artifacts
just build         # Build package
just check         # Run all checks (lint, test, security)
```

<!-- TEMPLATE_USAGE_END -->

<!-- PROJECT_README_START -->
# python-project-template

A comprehensive Python app template with pre-commit, CI/CD, and automated setup.

[![Quality and Tests](https://github.com/yourusername/python-project-template/actions/workflows/ci.yml/badge.svg)](https://github.com/yourusername/python-project-template/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/yourusername/python-project-template/branch/main/graph/badge.svg)](https://codecov.io/gh/yourusername/python-project-template)

## 🚀 Quickstart

Run the application locally:

```bash
uv sync --all-groups
uv run main.py
```

## 🛠 Setup

Requires Python 3.12 or higher.

### From Source with UV

```bash
git clone https://github.com/yourusername/python-project-template.git
cd python-project-template
uv sync --all-groups
```

### Development Workflow

```bash
just install-hooks
just check
```

## 🔧 Features

### Core Functionality

- **Modern Python**: Built with Python 3.12+ and modern tooling
- **Type Safety**: Full type hints throughout the codebase
- **Testing**: Pytest-based test suite
- **CLI-first**: Runs as an application from the command line

### Development Tools

- **Code Quality**: Pre-configured with Black, isort, flake8, and mypy
- **Security**: Integrated security scanning with bandit and safety
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

The test suite includes:

- Unit tests for all modules
- Integration tests
- Performance benchmarks
- Type checking validation

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

- **Variable Naming**: Use snake_case for variables, PascalCase for classes
- **Function Naming**: Use descriptive names, avoid abbreviations
- **Docstrings**: Use Google-style docstrings for all functions and classes
- **Type Hints**: Always include type hints for function parameters and return values
- **Line Length**: Maximum 88 characters per line
- **Conventional Commits**: Use conventional commit format for all commits

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
<!--
## 📚 Citation

If you use this software in your research, please cite:

```bibtex
@software{python_project_template,
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
<!-- PROJECT_README_END -->
