require_relative "../utils/part"
require 'set'


module Day21
  class Part1 < Part

    def call
      number = 64
      target = (@start.sum + number) % 2
      puts bfs(@start, 64).filter{|node| node.sum % 2 == target}.length
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
