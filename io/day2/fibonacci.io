fibonacci := method(n,
  if(n <= 2, 1, fibonacci(n-1) + fibonacci(n-2)))

for(n, 1, 10, 1, (
  writeln("fibonacci(", n, ") = ", fibonacci(n))
))
