template `>>>`*(a: untyped): untyped =
  echo a
template `>>\`*(a: untyped): untyped =
  >>> a
  echo "\n"

template `>@>`*[T](a: seq[T]): untyped =
  for x in a:
    echo x
template `>@\`*[T](a: seq[T]): untyped =
  >@> a
  echo "\n"

template `.=`*[T](a: var T, b: proc(a: T): T): untyped =
  a = b(a)

proc `...`*(a, b: int): seq[int] =
  for i in a..b:
    result.add(i)
