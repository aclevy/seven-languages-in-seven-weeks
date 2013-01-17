the_array := list(
  list(1, 2, 0, 4, 2, 1, 3, 9, 5, 1),
  list(3, 1, 5, 3, 0, 1, 1, 2, 9, 4)
)

sum_2d := method(arrays, arrays map(sum) sum)

writeln("Sum should be: ", (1+2+0+4+2+1+3+9+5+1+
                            3+1+5+3+0+1+1+2+9+4))
writeln("Sum of array = ", sum_2d(the_array))

# Every object implements rsum (recursive sum) with identity
Object rsum := method(self)
# Lists implement rsum by mapping over their items
List rsum := method(self map(rsum) sum)
# See that this works...
writeln("the_array rsum = ", the_array rsum)

# Alternatively, we can do this without futzing with Object.
# This is less intrusive, and still lets other prototypes
# carry their own implementations of rsum if they need to.
Object removeSlot("rsum")
List rsum := method(
  self map(item,
    if(item hasSlot("rsum"), item rsum, item)
  ) sum
)
