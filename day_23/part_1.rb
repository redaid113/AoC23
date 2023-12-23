require_relative "../utils/part"
require 'set'

module Day23
  class Part1 < Part
    Path = Struct.new(:current, :score, :seen)

    def call
      queue = []

      queue << Path.new(@start, -1, Set[])

      paths = []

      while queue.length > 0 do
        path = queue.pop
        if path.current == @end
          paths << path
        end

        r, c = path.current
        next if @grid[r][c] == "#"

        path.score += 1

        case @grid[r][c]
        when ">"
          next if path.seen.include?([r, c+1])
          path.seen << [r, c+1]
          path.current = [r, c+1]
          queue.push(path)
        when "<"
          next if path.seen.include?([r, c-1])
          path.seen << [r, c-1]
          path.current = [r, c-1]
          queue.push(path)
        when "^"
          next if path.seen.include?([r-1, c])
          path.seen << [r-1, c]
          path.current = [r-1, c]
          queue.push(path)
        when "v"
          next if path.seen.include?([r+1, c])
          path.seen << [r+1, c]
          path.current = [r+1, c]
          queue.push(path)
        when "."
          neighbors(r, c).each do |cord|
            next if path.seen.include?(cord)
            set = path.seen.dup
            set << cord
            queue.push(Path.new(cord, path.score, set))
          end
        end
      end

      puts paths.max_by(&:score).score
    end

    def neighbors(r, c)
      [
        [r + 1, c],
        [r - 1, c],
        [r, c + 1],
        [r, c - 1]
    ].select do |l|
      l[0] >= 0 && l[1] >= 0 && l[0] < @grid.length && l[1] < @grid[0].length
    end.select do |l|
        @grid[l[0]][l[1]] != "#"
      end
    end


    def parse_input
      @grid = @file_lines.map{|line| line.split("")}
      @start = [0, 1]
      @end = [@grid.length - 1, @grid[0].length - 2]
    end

  end
end
