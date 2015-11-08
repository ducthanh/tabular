require_relative 'table'
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

  context "row manipulations " do
    setup do
      @table = Table.new(@data, :headers => true)
    end

    test "can retrieve a row" do
      assert_equal ["George", 45, "photographer"], @table.row(2)
    end

    test "can insert a row at any position" do
      @table.add_row(["Jane", 19, "shop assistant"], 1)
      assert_equal ["Jane", 19, "shop assistant"], @table.row(1)
    end

    test "can delete a row" do
      to_be_delete = @table.row(2)
      @table.delete_row(2)
      assert_not_equal to_be_delete, @table.row(2)
    end

    test "tranform row cells" do
      @table.transform_row(0) do |cell|
        cell.is_a?(String) ? cell.upcase : cell
      end
      assert_equal ["TOM", 32, "ENGINEER"], @table.row(0)
    end

    test "reduce the rows to those that meet a particular condition" do
      @table.select_rows do |row|
        row[1] < 30
      end
      assert !@table.rows.include?(["George", 45,"photographer"])
    end
  end

  context "column manipulations" do
    setup do
      @table = Table.new(@data, :headers => true)
    end

    test "can access a column by its name" do
      assert_equal ["Tom", "Beth", "George", "Laura", "Marilyn"],
                   @table.column("name")
    end

    test "can access a column by its index" do
      assert_equal ["Tom", "Beth", "George", "Laura", "Marilyn"],
                   @table.column(0)
    end

    test "can rename a columb" do
      @table.rename_column("name", "first name")
      assert_equal ["first name", "age", "occupation"], @table.headers
    end
  end
end

