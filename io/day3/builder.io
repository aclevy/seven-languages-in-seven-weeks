OperatorTable addAssignOperator(":", "atPutKeyValue")

XML := Object clone

XML curlyBrackets := method(
  attrs := XMLAttributes clone;

  call message arguments foreach(arg,
    # The book says this should be 'attrs doMessage(arg)' but that doesn't work.
    # Instead, I get a `Sequence does not respond to ':'` error.
    attrs doString(arg asString)
  )

  return attrs
)

XML forward := method(
  node := XMLNode named(call message name)

  # Evaluate our arguments into an empty list (we might pop one)
  args := List clone
  call message arguments foreach(arg, args append(self doMessage(arg)))

  # Support attribute syntax of `XML li({"foo": "bar"}, "child 1", "child 2")`
  if(args at(0) type == "XMLAttributes",
    node attributes := args removeAt(0))

  # Put the rest of our arguments into the node
  args foreach(arg,
    if(arg type == "XMLNode",
      node append(arg),
      node append(XMLText with(arg))
    )
  )

  return node
)

XMLAttributes := Map clone do(
  # Support for {"key": "value"} syntax
  atPutKeyValue := method(
    self atPut(
      call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
      call evalArgAt(1)
    )
  )

  # Render attributes as key="value"
  asString := method(
    if(self isEmpty, return nil)

    attributes := List clone
    self foreach(key, value,
      attributes append(
        key .. "=\"" .. value asString asMutable escape .. "\""
      )
    )
    attributes join(" ")
  )
)

XMLNode := List clone do(
  # Every XMLNode has a name and a set of attributes
  init := method(
    self name := nil
    self attributes := XMLAttributes clone
  )

  # Convenience method for `XMLNode named("div")`
  named := method(name,
    node := self clone
    node name := name
    return node
  )

  # Look pretty for the cameras
  println := method(self indented println)

  # Return <name attr1="value1" attr2="value2">
  openingTag := method(
    tagContents := List clone
    tagContents append(self name)
    if(self attributes != nil, tagContents append(self attributes asString))
    return "<" .. tagContents select(not isNil) join(" ") .. ">"
  )

  # Return </name>
  closingTag := method(
    return "</" .. self name .. ">"
  )

  # Return a string representation of the node
  indented := method(indentWith, indentLevel, newline,
    if(indentWith == nil, indentWith = "  ")
    if(indentLevel == nil, indentLevel = 0)
    if(newline == nil, newline = "\n")

    indentation := indentWith repeated(indentLevel)
    items := List with(indentation .. self openingTag)

    self foreach(item,
      items append(if(
          item hasSlot("indented"),
          item indented(indentWith, indentLevel + 1),
          indentation .. item asString
        )
      )
    )

    items append(indentation .. self closingTag)

    return items join(newline)
  )
)

# Wrap a text node so that we can indent its contents.
XMLText := Sequence clone do(
  with := method(value,
    obj := XMLText clone
    obj copy(value)
    obj
  )

  indented := method(indentWith, indentLevel,
    indentWith repeated(indentLevel) .. self
  )
)

dom := XML ul(
  {"class": "without-bullets"},
  li(
    p("First time!"),
    p("Second time!")
  ),
  li(
    div(
      {"class": "alert", "data-id": "1"},
      "Hey now."
    )
  )
)

dom println
