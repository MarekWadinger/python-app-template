"""Tests for the python_project_template application."""

import pytest

from python_project_template.main import main


def test_main_function() -> None:
    """Test that main function runs without error."""
    # This test just ensures the function doesn't raise an exception
    main()


def test_main_function_output(capsys: pytest.CaptureFixture[str]) -> None:
    """Test that main function produces expected output."""
    main()
    captured = capsys.readouterr()
    assert captured.out.strip() == "Hello from python-project-template!"
