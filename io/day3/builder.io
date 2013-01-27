XML := Object clone

XMLTree := List clone

XMLTree wrap := method(content,
  if(content type == self type, content, self with(content))
)

XML forward := method(
  items := XMLTree with("<" .. call message name .. ">")
  call message arguments foreach(argument,
    content := self doMessage(argument)
    items append(XMLTree wrap(content))
  )
  items append("</" .. call message name .. ">")
  return items
)

XMLTree indented := method(indentWith, indentLevel,
  if(indentWith == nil, indentWith = "  ")
  if(indentLevel == nil, indentLevel = 0)

  retval := ""
  indentation := indentWith repeated(indentLevel)

  self foreach(item,
    retval := retval .. (
      if(
        item type == "XMLTree",
        item indented(indentWith, indentLevel + 1),
        indentation .. item .. "\n"
      )
    )
  )

  return retval
)

XMLTree println := method(self indented println)

dom := XML ul(
  li(
    p("First time!"),
    p("Second time!")
  ),
  li(
    div("Hey now.")
  )
)

dom println
