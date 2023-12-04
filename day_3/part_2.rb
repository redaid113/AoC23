require_relative "../utils/part"
require_relative "../utils/grid"


module Day3
  class Part2  < Part

    def call
      @grid = Grid.new(file_lines: @file_lines, default: ".")

      gears = {}


      r = 0
      while r <= @grid.max_row
        c = 0
        while c <= @grid.max_col
          if is_number(@grid.get(r, c))
            num = read_number(r, c)
            gear = gear_position(r, c, num.length)
            if gear != nil
              gears[gear] ||= []
              gears[gear].push num.to_i
            end

            c += num.length
          else
            c += 1
          end
        end
        r += 1
      end

      puts gears.values.filter! { |nums| nums.length == 2 }.sum{ |nums| nums.reduce(:*) }
    end

    def read_number(r, c)
      str = ""
      while is_number(@grid.get(r, c))
        str += @grid.get(r, c)
        c += 1
      end
      str
    end

    def gear_position(row, col, len)
      return "#{row},#{col-1}" if is_gear(@grid.get(row, col - 1))
      return "#{row},#{col+len}" if is_gear(@grid.get(row, col + len))

      for i in (col-1..col+len) do
        return "#{row-1},#{i}" if is_gear(@grid.get(row - 1, i))
        return "#{row+1},#{i}" if is_gear(@grid.get(row + 1, i))
      end

      return nil
    end

    def is_gear(char)
      char == "*"
    end

    def is_number(char)
      char.match?(/[0-9]/)
    end

  end
end
