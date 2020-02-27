import ../imogen_sugar/type

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

## UNIFORM DISTRIBUTION GENERATOR FOR INITIAL PREFERENCE TABLES
proc genUniformDist*(a: int): seq[float] =
  let bin: float = 1.0 / a.float
  for _ in 1..a:
    result.add(bin)

## PROBLEM SET GENERATOR FROM X AND FUNCTION CREATES X AND Y PAIRINGS
proc genProblemSet*[X, Y](x: seq[X], relation: proc(a: X): Y): seq[(X, Y)] =
  for instance in x:
    result.add((instance, instance.relation))
