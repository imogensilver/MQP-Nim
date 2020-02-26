import imogen_sugar/print_sugar
import imogen_sugar/method_sugar
import imogen_sugar/type_sugar

import imogen_nodes/functions
import imogen_nodes/literals

import math

const initial_energy = 500.float
const initial_functions = @[DEC.toFunction, INC.toFunction]
const initial_preference_table = genUniformDist(initial_functions.len)
const ZERO = newLiteral(0.int, initial_energy, initial_preference_table)

##RUNNING TEST
const (x_set, y_set) = genProblemSet(0...10, proc(a: int): int = return a ^ 2)

for x in x_set:
  const initial_literals = @[ZERO, newLiteral(x, initial_energy, initial_preference_table)]
  
