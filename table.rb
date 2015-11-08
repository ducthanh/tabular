class Table
  attr_reader :rows, :headers

  def initialize(data = [], options = {})
    @headers = options[:headers] ? data.shift : []
    @rows = data
  end

  def add_row(new_row, pos = nil)
    pos ? @rows.insert(pos, new_row) : @rows << new_row
    # i = pos.nil? ? rows.length : pos
    # @rows.insert(i, new_row)
  end

  def delete_row(row)
    @rows.delete_at(row)
  end

  def [](row, col)
    col = column_index(col)
    rows[row][col]
  end

  def column_index(pos)
    i = @headers.index(pos)
    i.nil? ? pos : i
  end

  def row(i)
    rows[i]
  end

  #Array#map!
  def transform_row(pos, &block)
    @rows[pos].map!(&block)
  end

  def select_rows(&block)
    @rows.select!(&block)
  end

  def column(pos)
    i = column_index(pos)
    @rows.map { |row| row[i] }
  end

  def rename_column(old_name, new_name)
    i = @headers.index(old_name)
    @headers[i] = new_name
  end
end