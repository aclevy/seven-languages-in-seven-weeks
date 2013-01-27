rightAnswer := Random value(0, 100) round
maximumGuesses := 10
lastDelta := nil
stdio := File standardInput

maximumGuesses repeat(guesses,
  guess := "" asNumber
  while(guess isNan,
    guess := stdio readLine("Guess a number between 0 and 100: ") asNumber
  )

  if(
    guess == rightAnswer or guesses == maximumGuesses - 1,
    break
  )

  delta := (guess - rightAnswer) abs

  writeln(if(delta < 5, "You're hot!",
    if(delta < 10, "Getting warm!",
      if(delta < 20, "Tepid...",
        if(delta < 30, "Cold.",
          "Brrr... freezing!"
        )
      )
    )
  ))

  if(
    lastDelta != nil,
    writeln(if(lastDelta > delta, "You're closer than last time.",
      if(lastDelta == delta, "You might have this one dialed in.",
        if(lastDelta < delta, "You're getting colder.")
      )
    ))
  )

  lastDelta := delta

  writeln("You have ", maximumGuesses - (guesses + 1), " more tries. Guess again!\n")
)

if(guess == rightAnswer,
  writeln("You got it!"),
  writeln("No, sorry, the answer was ", rightAnswer, ".")
)
