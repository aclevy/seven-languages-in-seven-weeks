List avg := method(self sum / self size)

list(1,2,3,4,5,6,7) avg println
list("a", 3, 5) avg println # => raises an exception
list() avg println # => raises an exception
