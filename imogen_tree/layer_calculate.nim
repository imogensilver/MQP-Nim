import ../imogen_sugar/type_sugar

proc litsXfxns*[L, E](lits: seq[Literal[L]], fxns: openarray[Function[L, E]]): seq[Literal[E]] {.noSideEffect.} =
  for i, fxn in fxns.pairs:
    for lit in lits.filter(
      proc (lit: Literal[L]): bool {.noSideEffect.} =
        lit.energy * lit.preference_table[i] > fxn.energy_cost):
      result.add(Literal[E](X: fxn.X(lit.X),
                            energy: lit.energy * lit.preference_table[i],
                            preference_table: lit.preference_table,
                            path: lit.path & fxn.name))

iterator energized_pairs[T](a: var seq[Literal[T]]): (int, var Literal[T]) {.noSideEffect.} =
  for index, item in a.mpairs:
    if(item.energy != -1):
      yield (index, item)

iterator diag_from[T](a: var seq[Literal[T]], b: int): var Literal[T] {.noSideEffect.} =
  var i = b + 1
  while i < a.len:
    yield a[i]
    i.inc

proc literalEquality*[A](a,b: Literal[A]): bool =
  a.X == b.X

proc detectAndMerge*[T](lits: seq[Literal[T]]): seq[Literal[T]] {.noSideEffect.} =
  var mlits = lits
  for i, lit1 in mlits.energized_pairs:
    for lit2 in mlits.diag_from(i): #maybe for lit2 in mlits[i..^0]
      if(literalEquality(lit1, lit2)):
        lit1.energy += lit2.energy
        lit2.energy = -1
    result.add(lit1)

proc testTreeToDepth*[T](lits: seq[Literal[T]],
                        fxns: seq[Function[T, T]],
                        depth: int,
                        withMerge: bool = true,
                        successPredicate: proc(a: Literal[T]): bool): seq[Literal[T]] {.noSideEffect.} =
  var successes = lits.filter(successPredicate)
  if successes.len != 0 or depth == 0:
    return successes
  else:
    var newPool = litsXfxns(lits, fxns)
    if withMerge:
      newPool .= detectAndMerge
    else:
      return testTreeToDepth(newPool, fxns, depth - 1, withMerge, successPredicate)

proc testTreeToDepth*[T](lits: seq[Literal[T]],
                        fxns: seq[Function[T, T]],
                        depth: int,
                        withMerge: bool = true): seq[Literal[T]] {.noSideEffect.} =
  if depth == 0:
    return lits
  else:
    var newPool = litsXfxns(lits, fxns)
    if withMerge:
      newPool .= detectAndMerge
    else:
      return testTreeToDepth(newPool, fxns, depth - 1, withMerge)
