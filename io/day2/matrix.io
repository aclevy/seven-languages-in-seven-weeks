Range

Matrix := Object clone
Matrix cellSeparator := " "
Matrix println := method(self array println)

Matrix arrange := method(x, y, default,
  self array := (
    1 to(y) asList map(_,
      1 to(x) asList map(_, default)
    )
  )
)

Matrix dim := method(x, y, default,
  matrix := Matrix clone
  matrix arrange(x, y, default)
  return matrix
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

Matrix foreach := method(toCall,
  self array foreach(rowIndex, row,
    row foreach(cellIndex, cell,
      toCall(cellIndex, rowIndex, cell)
    )
  )
)

Matrix transpose := method(
  g := self getSlot("get")
  m := self proto clone
  m arrange(self height, self width)
  self array foreach(y, row,
    row foreach(x, value,
      m set(y, x, g(x, y))
    )
  )
  return m
)

Matrix toFile := method(filename,
  f := File with(filename)
  f remove
  f openForUpdating
  self array foreach(row,
    row foreach(cell,
      f write(cell asString, self cellSeparator)
    )
    f write("\n")
  )
  f close
)

Matrix fromFile := method(filename,
  lines := File with(filename) openForReading readLines
  height := lines size
  width := lines map(split size) max
  matrix := Matrix dim(width, height)
  matrix fromArray(lines map(split map(asNumber)))
  return matrix
)

Matrix fromArray := method(other,
  other foreach(y, row,
    row foreach(x, cell,
      self set(x, y, cell)
    )
  )
)

Matrix setSlot("==", method(other,
  return self array == other array
))

matrixTest := method(
  writeln("5x5 grid, (3,5)=8")
  grid := Matrix dim(5, 5, 0)
  grid set(0, 3, 8)
  if(grid get(0, 3) == 8,
    writeln("Grid get/set test passed!"),
    writeln("Grid get/set test FAILED."))

  writeln("\nmap(method(x, x*2))")
  grid2x := grid map(method(x, x*2))
  grid2x println
  if(grid2x get(0, 3) == grid get(0, 3) * 2,
    writeln("Grid map test passed!"),
    writeln("Grid map test FAILED."))

  writeln("\ntranspose")
  gridtx := grid transpose
  gridtx println
  if(gridtx get(3, 0) == grid get(0, 3) and
     gridtx get(0, 3) == grid get(3, 0),
    writeln("Grid transpose test passed!"),
    writeln("Grid transpose test FAILED."))

  writeln("\nequality (==) operator")
  if(grid == Matrix dim(5, 5, 1),
    writeln("grid == Matrix dim FAILED."),
    if(grid != grid,
      writeln("grid != grid FAILED."),
      writeln("grid ==, grid != passed!")
    )
  )
)

matrixFileTest := method(
  grid := Matrix dim(5, 5, 0)
  grid set(1, 1, 2)
  grid set(2, 2, 4)
  grid set(3, 3, 6)
  grid set(4, 4, 8)

  writeln("\ngrid toFile, Matrix fromFile")
  grid println
  grid toFile("test.iomatrix")
  otherGrid := Matrix fromFile("test.iomatrix")
  otherGrid println
  if(grid == otherGrid,
    writeln("File test passed!"),
    writeln("File test FAILED."))
)

matrixTest
matrixFileTest
