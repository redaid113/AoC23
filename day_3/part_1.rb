require_relative "../utils/part"
require_relative "../utils/grid"


module Day3
  class Part1  < Part

    def call
      @grid = Grid.new(file_lines: @file_lines, default: ".")

      sum = 0

      r = 0
      while r <= @grid.max_row
        c = 0
        while c <= @grid.max_col
          if is_number(@grid.get(r, c))
            num = read_number(r, c)
            if near_symbol(r, c, num.length)
              sum += num.to_i
            end
            c += num.length
          else
            c += 1
          end
        end
        r += 1
      end

      puts sum
    end

    def read_number(r, c)
      str = ""
      while is_number(@grid.get(r, c))
        str += @grid.get(r, c)
        c += 1
      end
      str
    end

    def near_symbol(row, col, len)
      return true if (col-1..col+len).any? { |i| is_symbol(@grid.get(row - 1, i)) }
      return true if is_symbol(@grid.get(row, col - 1))
      return true if is_symbol(@grid.get(row, col + len))
      return true if (col-1..col+len).any? { |i| is_symbol(@grid.get(row + 1, i)) }
      false
    end

    def is_symbol(char)
      char != "." && !is_number(char)
    end

    def is_number(char)
      char.match?(/[0-9]/)
    end

  end
end
