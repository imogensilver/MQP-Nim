import ../imogen_sugar/type_sugar

proc DEC*(a: int): int =
  return a - 1
proc INC*(a: int): int =
  return a + 1

proc newFunction*[L, R](fxn: proc(a: L): R , energy_cost: float, name: string): Function[L, R] =
    Function[L, R](X: fxn, energy_cost: energy_cost, name: name)
