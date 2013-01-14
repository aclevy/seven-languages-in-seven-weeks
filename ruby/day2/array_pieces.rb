# Print the contents of an array of sixteen numbers,
# four numbers at a time, using just each.
the_array = (1..16).to_a
the_pieces = []
the_array.each do |i|
  the_pieces << i
  if the_pieces.size == 4
    puts the_pieces
    the_pieces = []
  end
end

# Now, do the same with each_slice in Enumerable.
the_array.each_slice(4) do |the_pieces|
  puts the_pieces
end
