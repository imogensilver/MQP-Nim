type
  Literal*[T] = object
    X*: T
    energy*: float
    preference_table*: seq[float]
    path*: seq[string]
type
  Function*[L, X] = object
    X*: proc(a: L): X {.noSideEffect.}
    energy_cost*: float
    name*: string
