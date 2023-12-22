require_relative "../utils/part"
require 'set'


module Day21
  class Part2 < Part

    def call

      n = 202300
      odd = (n + 1) * (n + 1)
      even = n * n


      visited =  bfs(@start, @grid.length + @grid[0].length)

      odd_grids = visited.filter{|v| v.sum % 2 == 1}.length
      even_grids = visited.filter{|v| v.sum % 2 == 0}.length


      dist = visited.map{|v| [(v[0] - @start[0]).abs, (v[1] - @start[1]).abs]}
      even_corners = dist.filter{|v| v.sum % 2 == 0 && v.sum > 65}.length
      odd_corners = dist.filter{|v| v.sum % 2 == 1 && v.sum > 65}.length

      puts odd * odd_grids + even * even_grids - (n+1) * odd_corners + n * even_corners;
    end

    def bfs(from, steps)
      visited = Set[]
      queue = Set[from]

      for i in 0..steps do
        new_queue = Set[]
        queue.each do |node|
          next if visited.include?(node)
          visited << node
          new_queue += neighbors(node).filter{|n| !visited.include?(n)}
        end
        queue = new_queue
        break if queue.length == 0
    end

      visited
    end

    def neighbors(node)
      r, c = node
      [[r+1, c], [r-1, c], [r, c+1], [r, c-1]]
        .filter{|r, c| r >= 0 && c >= 0 && r < @grid.length && c < @grid[0].length}
        .filter{|r, c| @grid[r][c] != "#"}
    end

    def parse_input
      @grid = @file_lines.map{|line| line.split("")}
      @grid.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          if cell == "S"
            @start = [y, x]
            @grid[y][x] = "."
          end
        end
      end
    end

  end
end
