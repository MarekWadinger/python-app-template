"""Main module for the python-project-template application."""

from python_app_template._validation import validated


@validated
def main() -> None:
    """Print a greeting message."""
    print("Hello from python-project-template!")


if __name__ == "__main__":
    main()
