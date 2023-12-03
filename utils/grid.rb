class Grid
  attr_accessor :min_row, :min_col, :max_row, :max_col

  def initialize(file_lines:, default: nil)
    @grid = {}
    file_lines.each_with_index do |line, row|
      line.split("").each_with_index do |char, column|
        @grid[row] ||= {}
        @grid[row][column] = char
      end

      @min_row  = 0
      @min_col = 0
      @max_row = file_lines.length - 1
      @max_col = file_lines[0].length - 1
    end

    @default = default
  end

  def get(row, column)
    return @grid[row][column] if @grid[row] && @grid[row][column]
    @default
  end

  def set(row, column, value)
    @grid[row] ||= {}
    @grid[row][column] = value

    @min_row = [row, @min_row].min
    @max_row = [row, @min_row].max
    @min_col = [column, @min_col].min
    @max_col = [column, @max_col].max
  end


end
