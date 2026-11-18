"""Tests for the python_app_template application."""

import importlib
import pkgutil
from collections.abc import Callable, Iterator

import pytest
from hypothesis import given
from hypothesis import strategies as st
from inline_snapshot import snapshot
from pydantic import TypeAdapter, ValidationError

import python_app_template
from python_app_template._validation import Fraction, NonNegative
from python_app_template.main import main


def test_main_no_args_runs_without_error() -> None:
    main()


def test_main_no_args_prints_greeting(capsys: pytest.CaptureFixture[str]) -> None:
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


def test_public_function_discovery_in_package_finds_functions() -> None:
    assert PUBLIC_FUNCTIONS, "function discovery found nothing; the contract would pass vacuously"


@pytest.mark.parametrize("name", sorted(PUBLIC_FUNCTIONS))
def test_public_function_each_discovered_has_validated(name: str) -> None:
    assert hasattr(PUBLIC_FUNCTIONS[name], "raw_function"), f"{name} is missing @validated"


@given(st.integers(min_value=0) | st.floats(min_value=0))
def test_non_negative_number_at_least_zero_keeps_value_and_type(value: float) -> None:
    result = TypeAdapter(NonNegative).validate_python(value)
    assert result == value
    assert type(result) is type(value)


@given(st.integers(max_value=-1) | st.floats(max_value=-0.0, exclude_max=True))
def test_non_negative_number_below_zero_raises(value: float) -> None:
    with pytest.raises(ValidationError):
        TypeAdapter(NonNegative).validate_python(value)


def test_fraction_above_one_error_names_the_bound() -> None:
    with pytest.raises(ValidationError) as excinfo:
        TypeAdapter(Fraction).validate_python(1.5)
    assert excinfo.value.errors(include_url=False) == snapshot(
        [
            {
                "type": "less_than_equal",
                "loc": (),
                "msg": "Input should be less than or equal to 1",
                "input": 1.5,
                "ctx": {"le": 1.0},
            }
        ]
    )
