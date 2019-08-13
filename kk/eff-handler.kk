effect amb {
  fun get() : string
}

fun func() : amb string {
  val suffix = get()
  "Hello, " + suffix
}

val my-handler = handler {
  return x -> println(x : string)
  get() -> resume("world")
}

fun main() {
  my-handler(func)
}
