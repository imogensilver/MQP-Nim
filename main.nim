import imogen_sugar/print_sugar
import imogen_sugar/method_sugar
import imogen_sugar/type_sugar

import imogen_nodes/functions
import imogen_nodes/literals

import imogen_tree/layer_calculate

import math

const
  initial_energy = 5000.float
  initial_functions = @[newFunction(DEC, 1.float, "DEC"),
                        newFunction(INC, 1.float, "INC")]
  initial_preference_table = genUniformDist(initial_functions.len)
  ZERO = newLiteral(0.int, initial_energy, initial_preference_table, "0")
  initial_problem_set = genProblemSet(0...10, proc(a: int): int = return a ^ 2)
  max_depth = log(initial_energy, initial_functions.len.float).int
##RUNNING TEST

for x, y in initial_problem_set.items:
  >>> (x, y)
  let initial_literals = @[ZERO, newLiteral(x, initial_energy, initial_preference_table, "X[" & $x & "]")]
  >>> testTreeToDepth(initial_literals,
                    initial_functions,
                    max_depth,
                    true,
                    proc (a: Literal[type x]): bool =
                      a.X == y)
