require_relative "../utils/grid"
require_relative "../utils/part"
require 'set'


module Day10
  class Part1 < Part


    def call
      queue = [[@start, 0]]
      visited = Set[[0, 1]]

      max = 0
      while queue.length > 0 do
        cur, ct = queue.shift
        next if visited.include?(cur)
        visited.add(cur)

        max = [max, ct].max

        ct += 1
        queue.push([[cur[0] - 1, cur[1]], ct]) if can_go?(cur, :north) && can_come_from?([cur[0] - 1, cur[1]], :north)
        queue.push([[cur[0] + 1, cur[1]], ct]) if can_go?(cur, :south) && can_come_from?([cur[0] + 1, cur[1]], :south)
        queue.push([[cur[0], cur[1] + 1], ct]) if can_go?(cur, :east) && can_come_from?([cur[0], cur[1] + 1], :east)
        queue.push([[cur[0], cur[1] - 1], ct]) if can_go?(cur, :west) && can_come_from?([cur[0], cur[1] - 1], :west)
      end

      puts max
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
