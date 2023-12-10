require_relative "../utils/grid"
require_relative "../utils/part"
require 'set'


module Day10
  class Part2 < Part

    def call
      navigate
      bigger
      fill_bigger_grid

      total = count_total
      outside = count_outside
      inside = total - outside

      puts inside
    end

    def navigate
      queue = [@start]
      visited = Set[[0, 1]]

      while queue.length > 0 do
        cur = queue.shift
        next if visited.include?(cur)
        visited.add(cur)

        queue.push([cur[0] - 1, cur[1]]) if can_go?(cur, :north) && can_come_from?([cur[0] - 1, cur[1]], :north)
        queue.push([cur[0] + 1, cur[1]]) if can_go?(cur, :south) && can_come_from?([cur[0] + 1, cur[1]], :south)
        queue.push([cur[0], cur[1] + 1]) if can_go?(cur, :east) && can_come_from?([cur[0], cur[1] + 1], :east)
        queue.push([cur[0], cur[1] - 1]) if can_go?(cur, :west) && can_come_from?([cur[0], cur[1] - 1], :west)
      end

      for r in @grid.min_row..@grid.max_row do
        for c in @grid.min_col..@grid.max_col do
          @grid.set(r, c, ".") if !visited.include?([r, c])
        end
      end
    end

    def count_outside
      queue = [[-1, -1]]
      visited = Set[]

      ct = 0
      while queue.length > 0
        cur = queue.shift
        char = @grid.get(cur[0], cur[1])
        next if visited.include?(cur) || ![".", ","].include?(char)
        visited.add(cur)

        ct += 1 if @grid.get(cur[0], cur[1]) == "."
        queue.push([cur[0] - 1, cur[1]])
        queue.push([cur[0] + 1, cur[1]])
        queue.push([cur[0], cur[1] - 1])
        queue.push([cur[0], cur[1] + 1])

      end
      ct
    end

    def count_total
      ct = 0
      for r in @grid.min_row..@grid.max_row do
        for c in @grid.min_col..@grid.max_col do
          ct += 1 if @grid.get(r, c) == '.'
        end
      end
      ct
    end

    def bigger
      big_grid = Grid.new(file_lines: [""], default: "X")

      for r in @grid.min_row..@grid.max_row do
        for c in @grid.min_col..@grid.max_col do
          big_grid.set(r * 2, c * 2, @grid.get(r, c))
        end
      end

      row = big_grid.max_row + 1
      col = big_grid.max_col + 1

      for c in -1..col do
        big_grid.set(-1, c, ",")
        big_grid.set(row, c, ",")
      end

      for r in -1..row do
        big_grid.set(r, -1, ",")
        big_grid.set(r, col, ",")
      end

      @grid = big_grid
    end

    def fill_bigger_grid
      for r in @grid.min_row..@grid.max_row do
        for c in @grid.min_col..@grid.max_col do
          char = @grid.get(r, c)
          next if char != "X"

          if can_go?([r - 1, c], :south) && can_go?([r+1, c], :north)
            @grid.set(r, c, "|")
            next
          end
          if can_go?([r, c-1], :east) && can_go?([r, c+1], :west)
            @grid.set(r, c, "-")
            next
          end
          @grid.set(r, c, ",")
        end
      end
    end


    def can_come_from?(point, direction)
      @chars[@grid.get(point[0], point[1])].include?(@inverse[direction])
    end

    def can_go?(point, direction)
      @chars[@grid.get(point[0], point[1])].include?(direction)
    end


    def parse_input
      @inverse = {
        north: :south,
        south: :north,
        east: :west,
        west: :east,
      }

      @chars = {
        "." => [],
        "," => [],
        "X" => [],
        "|" => [:north, :south],
        "-" => [:east, :west],
        "L" => [:north, :east],
        "J" => [:north, :west],
        "7" => [:south, :west],
        "F" => [:south, :east],
      }

      @grid = Grid.new(file_lines: @file_lines,default: ".")


      for r in @grid.min_row..@grid.max_row do
        for c in @grid.min_col..@grid.max_col do
          next if @grid.get(r, c) != "S"
          @start = [r, c]
        end
      end

      temp = []
      temp.push(:north) if can_come_from?([@start[0] - 1, @start[1]], :north)
      temp.push(:south) if can_come_from?([@start[0] + 1, @start[1]], :south)
      temp.push(:east) if can_come_from?([@start[0], @start[1] + 1], :east)
      temp.push(:west) if can_come_from?([@start[0], @start[1] - 1], :west)

      c = @chars.select{|k, v| v == temp}.keys.first
      @grid.set(@start[0], @start[1], c)
    end

  end
end
