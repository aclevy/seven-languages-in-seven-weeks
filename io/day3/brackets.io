# List syntax using brackets
squareBrackets := method(
  items := list()
  call message arguments foreach(arg,
    items append(self doMessage(arg))
  )
  return items
)

# Test:
testList := [1, 2, 3, [4, 5, 6], "Seven"]
if(testList map(type) == ["Number", "Number", "Number", "List", "Sequence"],
  writeln("Brackets test passed!"),
  writeln("Brackets test FAILED.\n", testList, "\n", testList map(type)))
