import types

### FUNCTIONS
## TRIGGERS
proc DEC*(a: int): int =
  return a - 1
proc INC*(a: int): int =
  return a + 1
## CONSTRUCTOR
proc newFunction*[L, R](fxn: proc(a: L): R , energy_cost: float, name: string): Function[L, R] =
    Function[L, R](X: fxn, energy_cost: energy_cost, name: name)
template newFunction*[L, R](fxn: untyped, energy_cost: float): Function[L, R] =
  newFunction(fxn, energy_cost, $fxn)

### LITERALS
## CONSTRUCTOR
proc newLiteral*[T](X: T, energy: float, preference_table: seq[float], path: string): Literal[T] =
  Literal[T](X: X, energy: energy, preference_table: preference_table, path: @[path])
