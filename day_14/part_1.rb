require_relative "../utils/part"

module Day14
  class Part1 < Part
    def call
      @rocks.each do |rock|
        r, c = rock
        @grid[rock[0]][rock[1]] = "."

        for i in 1..r
          break if @grid[r - 1][c] != "."
          r -= 1
        end


        @grid[r][c] = "O"
        rock[0] = 0
        rock[1] = c
      end

      puts score
    end

    def score
      sum = 0
      for r in 0..(@grid.length - 1)
        sum += (@grid.length - r) * @grid[r].count("O")
      end

      sum
    end


    def parse_input
      @grid = @file_lines.map{|line| line.split("")}
      @rocks = []
      for r in 0..(@grid.length - 1)
        for c in 0..(@grid[0].length - 1)
          @rocks << [r, c] if @grid[r][c] == "O"
        end
      end
    end

  end
end
