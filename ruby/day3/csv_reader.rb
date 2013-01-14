class String
  # Convert a "CamelCaseFileName" to "camel_case_file_name"
  def to_filename(extension = 'csv')
    # make a copy of self, then manipulate it
    self.dup.tap do |fn|
      # make the first character lowercase
      fn[0] = fn[0].downcase unless fn[0].nil?
      # separate words with underscores
      ('A'..'Z').each do |char|
        fn.gsub! /#{char}/, "_#{char.downcase}"
      end
      # replace "_csv" at the end with ".csv"
      quoted_ext = Regexp.quote(extension)
      fn.gsub! /_#{quoted_ext}$/, ".#{extension}"
      # add ".csv" if it isn't there already
      fn << ".#{extension}" unless fn =~ /\.#{quoted_ext}$/
    end
  end

  # Convert a string (" Header 1 ") to a method symbol (:header_1)
  def to_method
    self.strip.downcase.gsub(/ +/, '_').to_sym
  end
end

# Represents a single row of data from a CSV file.
class CsvRow
  include Enumerable
  attr_reader :headers, :data

  def initialize(headers, data)
    @headers = headers
    @data = data
  end

  def each(&block)
    data.each(&block)
  end

  def method_missing(method, *args)
    headers.each_with_index do |header, index|
      if method == header.to_method
        return data[index]
      end
    end

    super
  end
end

module ActsAsCsvReader
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv_reader
      include InstanceMethods
    end
  end

  module InstanceMethods
    include Enumerable

    def read(filename = nil)
      @_read ||= begin # only read once
        filename ||= self.class.name.to_filename
        File.open(filename) do |file|
          @headers = file.gets.chomp.split(',')
          file.each do |line|
            @contents ||= []
            @contents << line.chomp.split(',')
          end
        end
      end
    end

    def headers
      read
      @headers
    end

    def contents
      read
      @contents
    end

    def each
      contents.each do |data|
        yield CsvRow.new(headers, data)
      end
    end
  end
end

class TestCsv
  include ActsAsCsvReader
  acts_as_csv_reader
end

require 'test/unit'
class ActsAsCsvReaderTest < Test::Unit::TestCase
  def setup
    @test = TestCsv.new
  end

  def test_headers
    assert_equal ["header1", "Header2", "Header 3"], @test.headers
  end

  def test_read_contents
    expected = [
      ['a1', 'a2', 'a3'],
      ['b1', 'b2', 'b3'],
      ['c1', 'c2', 'c3'],
      [' spaced1', '  spaced2', '   spaced3'],
    ]
    assert_equal expected, @test.contents
  end

  def test_read_each_row
    rows = @test.to_a
    rows.each do |row|
      assert_equal CsvRow, row.class
    end
  end

  def test_method_accessors
    rows = @test.to_a
    assert_equal 'a1', rows.first.header1
    assert_equal 'a2', rows.first.header2
    assert_equal 'a3', rows.first.header_3
    assert_equal ' spaced1', rows.last.header1
    assert_equal '  spaced2', rows.last.header2
    assert_equal '   spaced3', rows.last.header_3
  end
end
