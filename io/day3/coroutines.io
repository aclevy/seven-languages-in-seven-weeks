Person := Object clone

Person name := "Anonymous"
Person named := method(name,
  person := self clone
  person name := name
  return person
)

Person say := method(statement,
  writeln(self name, " said: ", statement)
)

vizzini := Person named("Vizzini")
vizzini talk := method(
  say("Fezzik, are there rocks ahead?")
  yield
  say("No more rhymes now, I mean it.")
  yield
)

fezzik := Person named("Fezzik")
fezzik rhyme := method(
  yield
  say("If there are, we'll all be dead.")
  yield
  say("Anybody want a peanut?")
)

vizzini @@talk
fezzik @@rhyme

slower := Object clone
faster := Object clone
slower start := method(wait(3); writeln("Slowly"))
faster start := method(wait(1); writeln("Quickly"))
slower @@start
faster @@start
wait(5)
