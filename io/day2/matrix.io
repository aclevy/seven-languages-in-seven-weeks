Range

Matrix := Object clone

Matrix dim := method(x, y, default,
  self array := (
    1 to(y) asList map(_,
      1 to(x) asList map(_, default)
    )
  )
)

Matrix get := method(x, y,
  self array at(y) at(x)
)

Matrix set := method(x, y, value,
  self array at(y) atPut(x, value)
)

Matrix height := method(self array size)

Matrix width  := method(self array map(size) max)

Matrix map := method(mapMethod,
  m := self clone
  m array := self array map(row,
    row map(value,
      mapMethod(value)
    )
  )
  return m
  // # Support mapping like this: grid map(*2) println
  // newMatrix := Matrix clone
  // newMatrix array := self array map(row,
  //   row map(value,
  //     call message argsEvaluatedIn(value)
  //   ) flatten
  // )
  // return newMatrix
)

Matrix transpose := method(
  g := self getSlot("get")
  m := self proto clone
  m dim(self height, self width)
  self array foreach(y, row,
    row foreach(x, value,
      m set(y, x, g(x, y))
    )
  )
  return m
)

dim := method(x, y, default,
  newList := Matrix clone
  newList dim(x, y, default)
  return newList
)

writeln("5x5 grid, (3,5)=8")
grid := dim(5, 5, 0)
grid set(0, 3, 8)
grid get(0, 3) println

writeln("\nmap(method(x, x*2))")
grid map(method(x, x*2)) array println

writeln("\ntranspose")
grid transpose array println
grid transpose get(3, 0) println
