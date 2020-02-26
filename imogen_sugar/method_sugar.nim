template `.=`*[T](a: var T, b: proc(a: T): T): untyped =
  a = b(a)
