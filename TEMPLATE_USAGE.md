# Template Usage Instructions

This file contains the original template usage instructions that were removed from README.md after initialization.

## Template Features

- 🐍 **Modern Python**: Uses Python 3.12+ with `uv` for fast dependency management
- 🎨 **Code Quality**: Pre-configured with Black, isort, flake8, and mypy
- 🔒 **Security**: Integrated security scanning with bandit and safety
- 🧪 **Testing**: pytest with coverage reporting
- 🪝 **Pre-commit Hooks**: Automated code formatting and linting
- 🚀 **CI/CD**: GitHub Actions workflows for testing, linting, and releases
- 🖥️ **Application-first**: Oriented for apps runnable via CLI
- 🛠️ **Easy Setup**: Automated project initialization with `just`

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
just build         # Build distribution (optional)
just check         # Run all checks (lint, test, security)
```

## Template Workflow

### For Template Users

1. **Create repository** from this template on GitHub
2. **Clone** your new repository
3. **Run `just init`** to customize placeholders
4. **Start developing** your project

### Development Workflow

1. **Make changes** to your code
2. **Pre-commit hooks** automatically run on commit
3. **GitHub Actions** run on push/PR
4. **Release** by creating a git tag

## Pre-commit Hooks

The template includes pre-commit hooks for:

- Code formatting (Black, isort)
- Linting (flake8, mypy)
- Security scanning (bandit)
- Dependency vulnerability checks (safety)
- Conventional commit messages

## CI/CD Pipeline

### Continuous Integration

- **Lint**: Code formatting and style checks
- **Security**: Vulnerability scanning
- **Test**: Unit tests with coverage
- **Build**: Package building verification

### Release (optional)

- GitHub release creation

## Configuration

### Python Version

Update `.python-version` to change the Python version used.

### Dependencies

Add runtime dependencies to `pyproject.toml`:

```toml
dependencies = [
    "requests>=2.31.0",
    "click>=8.0.0",
]
```

### Development Dependencies

Add development dependencies to the appropriate dependency groups in `pyproject.toml`.
