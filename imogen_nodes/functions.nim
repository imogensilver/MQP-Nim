import ../imogen_sugar/type_sugar

proc DEC*(a: int): int {.noSideEffect.} =
  return a - 1
proc INC*(a: int): int {.noSideEffect.} =
  return a + 1

proc toFunction*[L, R](fxn: proc(a: L): R {.noSideEffect.}): Function[L, R] =
    Function[L, R](X: fxn, energy_cost: 1.float, name: fxn.repr)
