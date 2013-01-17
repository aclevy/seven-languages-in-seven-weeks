# Run through a few numbers and print the division results
printRatio := method(
  for(i, 0, 5, 1,
    writeln("15/", i, " = ", 15/i)
  )
)
printRatio

# Capture the old division and redefine the new division
Number setSlot("divide", Number getSlot("/"))
Number setSlot("/", method(divisor,
  if(divisor == 0, 0, self divide(divisor))
))

writeln("Redefined '/'")

# Test again
printRatio
