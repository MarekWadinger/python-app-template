"""Main module for the python-project-template application."""

import sys

from python_app_template._validation import validated


@validated
def main() -> None:
    """Print a greeting message."""
    sys.stdout.write("Hello from python-project-template!\n")


if __name__ == "__main__":
    main()
