import ../imogen_sugar/type_sugar

proc newLiteral*[T](X: T, energy: float, preference_table: seq[float], path: string): Literal[T] =
  Literal[T](X: X, energy: energy, preference_table: preference_table, path: @[path])

proc genUniformDist*(a: int): seq[float] =
  let bin: float = 1.0 / a.float
  for _ in 1..a:
    result.add(bin)

proc genProblemSet*[X, Y](x: seq[X], relation: proc(a: X): Y): seq[(X, Y)] =
  for instance in x:
    result.add((instance, instance.relation))
