"""Tests for the python_app_template application."""

import importlib
import pkgutil
from collections.abc import Callable, Iterator

import pytest

import python_app_template
from python_app_template.main import main


def test_main_function() -> None:
    """Test that main function runs without error."""
    # This test just ensures the function doesn't raise an exception
    main()


def test_main_function_output(capsys: pytest.CaptureFixture[str]) -> None:
    """Test that main function produces expected output."""
    main()
    captured = capsys.readouterr()
    assert captured.out.strip() == "Hello from python-project-template!"


# Contract: every public function validates its arguments with pydantic. A new public
# function without @validated (from python_app_template._validation) fails here, by name.
def _public_functions() -> Iterator[tuple[str, Callable]]:
    for info in pkgutil.walk_packages(python_app_template.__path__, "python_app_template."):
        if info.name.rsplit(".", 1)[-1].startswith("_"):
            continue
        module = importlib.import_module(info.name)
        for name, obj in vars(module).items():
            if name.startswith("_") or isinstance(obj, type) or not callable(obj):
                continue
            if getattr(obj, "__module__", None) == module.__name__:  # defined here, not imported
                yield f"{info.name}.{name}", obj


PUBLIC_FUNCTIONS = dict(_public_functions())


def test_contract_sees_the_api() -> None:
    assert PUBLIC_FUNCTIONS, "function discovery found nothing; the contract would pass vacuously"


@pytest.mark.parametrize("name", sorted(PUBLIC_FUNCTIONS))
def test_public_function_is_validated(name: str) -> None:
    assert hasattr(PUBLIC_FUNCTIONS[name], "raw_function"), f"{name} is missing @validated"
