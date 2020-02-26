template `.=`*[T](a: var T, b: proc(a: T): T): untyped =
  a = b(a)

proc `...`*(a, b: int): seq[int] =
  for i in a..b:
    result.add(i)
