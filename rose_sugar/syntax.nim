import ../framework/types

#[
+ - * \ / < > = @ $ ~ & % ! ? ^ . |
]#

### PRINTERS
template `>>>`*(a: untyped): untyped =
  echo a
template `>>\`*(a: untyped): untyped =
  >>> a
  echo ""

template `>@>`*[T](a: seq[T]): untyped =
  for x in a:
    echo x
template `>@\`*[T](a: seq[T]): untyped =
  >@> a
  echo ""

### METHOD EQUALS CRUNCH
template `.=`*[T](a: var T, b: proc(a: T): T): untyped =
  a = b(a)

### RANGE OPERATOR
proc `...`*(a, b: int): seq[int] =
  for i in a..b:
    result.add(i)


### ITERATORS
iterator energized_pairs*[T](a: seq[Literal[T]]): (int, Literal[T]) =
  for index, item in a.pairs:
    if(item.energy != -1):
      yield (index, item)

iterator menergized_pairs*[T](a: var seq[Literal[T]]): (int, var Literal[T]) =
  for index, item in a.mpairs:
    if(item.energy != -1):
      yield (index, item)

iterator `>..`*[T]( b: var seq[Literal[T]], a: int): var Literal[T] =
  var i = a + 1
  while i < b.len:
    yield b[i]
    i.inc
