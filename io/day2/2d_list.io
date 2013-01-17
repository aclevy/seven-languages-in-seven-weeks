Range

TwoDimList := Object clone

TwoDimList dim := method(x, y,
  self array := (
    1 to(y) asList map(
      1 to(x) asList map(nil)
    )
  )
)

TwoDimList get := method(x, y,
  self array at(y) at(x)
)

TwoDimList set := method(x, y, value,
  self array at(y) atPut(x, value)
)

dim := method(x, y,
  newList := TwoDimList clone
  newList dim(x, y)
  return newList
)

grid := dim(10, 10)
grid set(3, 5, "hello, gridworld!")
grid get(3, 5) println
