import ../imogen_sugar/syntax

import types

import sequtils
import algorithm

proc skew(a: seq[float], i: int): seq[float] =
  const skew_amt = 0.1
  let sub_amt = skew_amt / (a.len - 1).float
  for ii, e in a.pairs:
    let e_adjusted =
      if i == ii:
        e + skew_amt
      else:
        e - sub_amt

    if e_adjusted > 1.0:
      return a
    else:
      result.add(e_adjusted)

proc litsXfxns*[L, E](lits: seq[Literal[L]], fxns: openarray[Function[L, E]]): seq[Literal[E]] =
  for i, fxn in fxns.pairs:
    for lit in lits.filter(
      proc (lit: Literal[L]): bool =
        lit.energy * lit.preference_table[i] > fxn.energy_cost):
      result.add(Literal[E](X: fxn.X(lit.X),
                            energy: lit.energy * lit.preference_table[i],
                            preference_table: lit.preference_table.skew(i),
                            path: lit.path & fxn.name))

proc literalEquality*[A](a,b: Literal[A]): bool =
  a.X == b.X

proc detectAndMerge[T](lits: seq[Literal[T]]): seq[Literal[T]] =
  var mlits = lits
  mlits.sort(proc(a, b: Literal[T]): int = cmp(a.energy, b.energy), Descending)
  var energy_pool: float = 0.float
  for i, lit1 in mlits.energized_pairs:
    for lit2 in mlits >.. i:
      if(literalEquality(lit1, lit2)):
        energy_pool += lit2.energy;
        lit2.energy = -1
    result.add(lit1)
  let energy_portion: float = energy_pool / result.len.float
  result.apply(proc(a: var Literal[T]) = a.energy += energy_portion)

proc testTreeToDepth*[T](lits: seq[Literal[T]],
                        fxns: seq[Function[T, T]],
                        depth: int,
                        withMerge: bool = true,
                        successPredicate: proc(a: Literal[T]): bool): seq[Literal[T]]  =
  var successes = lits.filter(successPredicate)
  if successes.len != 0 or depth == 0:
    return successes
  else:
    var newPool = litsXfxns(lits, fxns)
    if withMerge:
      newPool .= detectAndMerge
    return testTreeToDepth(newPool, fxns, depth - 1, withMerge, successPredicate)

proc testTreeToDepth*[T](lits: seq[Literal[T]],
                        fxns: seq[Function[T, T]],
                        depth: int,
                        withMerge: bool = true): seq[Literal[T]] {.deprecated.} =
  if depth == 0:
    return lits
  else:
    var newPool = litsXfxns(lits, fxns)
    if withMerge:
      newPool .= detectAndMerge
    return testTreeToDepth(newPool, fxns, depth - 1, withMerge)
