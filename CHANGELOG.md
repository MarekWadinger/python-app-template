# Changelog

This changelog is maintained automatically by [commitizen](https://commitizen-tools.github.io/commitizen/) on version bumps.

## v0.2.5 (2026-06-12)

### Fix

- **justfile**: regenerate lockfile and squeeze README blanks in init (#11)

## v0.2.4 (2026-06-12)

### Fix

- **pre-commit**: stop passing filenames to the ty pre-push hook (#10)

## v0.2.3 (2026-06-12)

### Fix

- replace safety with pip-audit and upgrade vulnerable lockfile pins (#9)

## v0.2.2 (2026-06-12)

### Fix

- make just init reset version/changelog and repair PyPI publish trigger (#8)

## v0.2.1 (2026-06-12)

### Fix

- pass uv dependency groups to tool invocations in justfile and Makefile (#7)

## v0.2.0 (2026-06-12)

### Feat

- add Makefile with auto-documented targets (#4)
- **justfile**: split lint/typecheck, add bump, changelog, clean recipes (#2)
- configure commitizen, ruff, and build system in pyproject (#5)
- commit initialization of project
- initial project structure with essentials

### Fix

- **tests**: update module name in test file to match application name
- **justfile**: wrong access to variables

### Refactor

- validate name and github user not empty
- update project template to python_app_template
