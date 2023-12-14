require_relative "../utils/part"

module Day14
  class Part2 < Part
    def call
      loop_da_loop

      puts score
    end

    def loop_da_loop
      target = 1000000000
      cache = {}
      cache[key] = key

      ct = 0
      while ct < target
        cycle
        ct += 1
        break if cache.has_key?(key)
        cache[key] = ct
      end

      for i in 1..((target - cache[key]) % (ct - cache[key]))
        cycle
      end
    end

    def key
      @grid.map{|row| row.join("")}.join("")
    end

    def cycle
      north
      west
      south
      east
    end

    def north
      rocks = []
      for r in 0..(@grid.length - 1)
        for c in 0..(@grid[0].length - 1)
          rocks << [r, c] if @grid[r][c] == "O"
        end
      end

      rocks.each do |r, c|
        @grid[r][c] = "."

        for i in 1..r
          break if @grid[r - 1][c] != "."
          r -= 1
        end


        @grid[r][c] = "O"
      end
    end

    def south
      rocks = []
      for r in 0..(@grid.length - 1)
        for c in 0..(@grid[0].length - 1)
          rocks << [@grid.length - 1 - r, c] if @grid[@grid.length - 1 - r][c] == "O"
        end
      end

      rocks.each do |r, c|
        @grid[r][c] = "."

        for i in 1..(@grid.length - r - 1)
          break if @grid[r + 1][c] != "."
          r += 1
        end

        @grid[r][c] = "O"
      end
    end

    def east
      rocks = []
      for c in 0..(@grid[0].length - 1)
        for r in 0..(@grid.length - 1)
          rocks << [r, @grid[0].length - 1 - c] if @grid[r][@grid[0].length - 1 - c] == "O"
        end
      end

      rocks.each do |r, c|
        @grid[r][c] = "."

        for i in 1..(@grid[0].length - c - 1)
          break if @grid[r][c + 1] != "."
          c += 1
        end

        @grid[r][c] = "O"
      end
    end

    def west
      rocks = []
      for c in 0..(@grid[0].length - 1)
        for r in 0..(@grid.length - 1)
          rocks << [r, c] if @grid[r][c] == "O"
        end
      end

      rocks.each do |r, c|
        @grid[r][c] = "."

        for i in 1..c
          break if @grid[r][c - 1] != "."
          c -= 1
        end

        @grid[r][c] = "O"
      end
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
    end

  end
end
