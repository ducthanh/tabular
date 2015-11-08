require 'test/unit'
require 'contest'
require 'pry'



class TableTest < Test::Unit::TestCase
  setup do
    @data = [
        ["name",   "age", "occupation"  ],
        ["Tom",     32,   "engineer"    ],
        ["Beth",    12,   "student"     ],
        ["George",  45,   "photographer"],
        ["Laura",   23,   "aviator"     ],
        ["Marilyn", 84,   "retiree"     ]]
  end

  test "can be initialized empty" do
    table = Table.new
    assert_equal [], table.rows
  end

  test "row can be appended after empty initialization" do
    table = Table.new
    table.add_row([1,2,3])
    assert_equal [[1,2,3]], table.rows
  end

  test "can be initialize with two dimensional array" do
    table = Table.new(@data)
    assert_equal @data, table.rows
  end

  test "first row considered column names, if indicated" do
    table = Table.new(@data.dup, :headers => true)
    assert_equal @data[1..-1], table.rows
    assert_equal @data[0], table.headers
  end

  test "first row represent column names" do
    table = Table.new(@data, :headers => true)
    assert_equal ["name",   "age", "occupation"  ], table.headers
  end

  test "cell can be referred to by column name and row index" do
    table = Table.new(@data, :headers => true)
    assert_equal "Beth", table[1, "name"]
  end

  test "cell can be referred to by column index and row index" do
    table = Table.new(@data, :headers => true)
    assert_equal "Beth", table[1, 0]
  end
end

class Table
  attr_reader :rows, :headers

  def initialize(data = [], options = {})
    @headers = options[:headers] ? data.shift : []
    @rows = data
  end

  def add_row(row)
    @rows << row
  end

  def [](row, col)
    col = column_index(col)
    rows[row][col]
  end

  def column_index(pos)
    i = headers.index(pos)
    i.nil? ? pos : i
  end
end