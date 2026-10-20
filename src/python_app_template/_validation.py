"""Shared pydantic validation for the public API.

Every public function in the package is wrapped with ``validated`` (enforced by the contract
test in tests/). Arguments are checked against their annotations on each call; arbitrary types
(DataFrames, arrays, fitted models) are only isinstance-checked, never copied.
"""

from pathlib import Path
from typing import Annotated

from pydantic import AfterValidator, ConfigDict, Field, validate_call

validated = validate_call(config=ConfigDict(arbitrary_types_allowed=True))

Fraction = Annotated[float, Field(ge=0, le=1)]
"""Share in [0, 1]."""

OpenFraction = Annotated[float, Field(gt=0, lt=1)]
"""Share in (0, 1), e.g. a train split."""

NonNegative = Annotated[float | int, Field(ge=0)]
"""Count or threshold >= 0; ints stay ints."""


def _existing_file(path: str | Path) -> str | Path:
    if not Path(path).is_file():
        raise ValueError(f"file not found: {path}")
    return path


ExistingFile = Annotated[str | Path, AfterValidator(_existing_file)]
"""Path to an existing file; unlike pydantic's FilePath it keeps the caller's str/Path type."""
