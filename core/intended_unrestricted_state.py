from dataclasses import dataclass
from typing import Any


@dataclass(frozen=True)
class IntendedUnrestrictedState:
    encoded: int
    payload: Any

    def __post_init__(self) -> None:
        if not isinstance(self.encoded, int):
            raise TypeError("encoded must be int")
        if not 0 <= self.encoded < 256:
            raise ValueError("encoded must satisfy 0 <= encoded < 256")


def to_product_form(state: IntendedUnrestrictedState) -> tuple[int, Any]:
    if not isinstance(state, IntendedUnrestrictedState):
        raise TypeError("state must be IntendedUnrestrictedState")
    return (state.encoded, state.payload)


def from_product_form(product: tuple[int, Any]) -> IntendedUnrestrictedState:
    if not isinstance(product, tuple) or len(product) != 2:
        raise TypeError("product must be a pair")
    encoded, payload = product
    return IntendedUnrestrictedState(encoded=encoded, payload=payload)
