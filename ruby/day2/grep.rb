# Performs a pattern search across a named file
class Search
  def initialize(pattern, filename)
    @pattern = pattern
    @filename = filename
  end

  # Yield each line, plus a line number
  def each_with_line_number
    File.open(@filename) do |file|
      file.each_line.each_with_index do |line, index|
        yield [line, index + 1] if line =~ /#{@pattern}/
      end
    end
  end
end

# Searches a set of files and prints results to stdout
class Grepper
  def search_and_print(pattern, filenames)
    filenames.each do |filename|
      Search.new(pattern, filename).each_with_line_number do |line, ln|
        output ln, line, (filename unless filenames.size == 1)
      end
    end
  end

  def main(args = ARGV)
    pattern, *filenames = args
    search_and_print(pattern, expand_filenames(filenames))
  end

  private

  # Support wildcard expansion on Windows
  def expand_filenames(filenames)
    if windows?
      filenames.inject([]) { |fns, pattern| fns + Dir[pattern] }
    else
      filenames
    end
  end

  def windows?
    RUBY_PLATFORM =~ /win32/ || RUBY_PLATFORM =~ /mingw/
  end

  def output(line_number, line, filename = nil)
    filename_prefix = "#{filename}:" if filename
    puts "#{filename_prefix}#{line_number}:#{line}"
  end
end

Grepper.new.main
