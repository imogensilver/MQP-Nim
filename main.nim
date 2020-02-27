import imogen_sugar/syntax
import imogen_sugar/type

import framework/atoms
import framework/tree

import math

const
  depth = 10
  initial_functions = @[newFunction(DEC, 1.float, "DEC"),
                        newFunction(INC, 1.float, "INC")]
  initial_energy = (initial_functions.len ^ depth).float
  initial_preference_table = genUniformDist(initial_functions.len)
  ZERO = newLiteral(0.int, initial_energy, initial_preference_table, "0")
  initial_problem_set = genProblemSet(0...10, proc(a: int): int = return a ^ 2)
##RUNNING TEST

# for x, y in initial_problem_set.items:
#   >>> (x, y)
#   let initial_literals = @[ZERO, newLiteral(x, initial_energy, initial_preference_table, "X[" & $x & "]")]
#   >>> testTreeToDepth(initial_literals,
#                     initial_functions,
#                     max_depth,
#                     true,
#                     proc (a: Literal[type x]): bool =
#                       a.X == y)
const
  x = 3
  y = 9
  initial_literals = @[ZERO, newLiteral(x, initial_energy, initial_preference_table, "X[" & $x & "]")]

discard testTreeToDepth(initial_literals,
                    initial_functions,
                    8,
                    true)
