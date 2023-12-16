require_relative "../utils/part"

module Day16
  class Part1 < Part
    def call
      @seen = {}

      run_beam(0, 0, :right)

      ct = 0
      for r in 0..@grid.length-1 do
        for c in 0..@grid[r].length-1 do
          ct += 1 if @seen[[r, c]]
        end
      end

      puts ct
    end

    def run_beam(x, y, direction)
      return if x < 0 || y < 0 || x >= @grid.length || y >= @grid[x].length
      return if @seen[[x, y]]&.include?(direction)
      @seen[[x, y]] ||= []
      @seen[[x, y]] << direction

      if @grid[x][y] == "."
        run_beam(x, y+1, :right) if direction == :right
        run_beam(x, y-1, :left) if direction == :left
        run_beam(x+1, y, :down) if direction == :down
        run_beam(x-1, y, :up) if direction == :up
      elsif @grid[x][y] == "|"
        run_beam(x+1, y, :down) if direction != :up
        run_beam(x-1, y, :up) if direction != :down
      elsif @grid[x][y] == "-"
        run_beam(x, y+1, :right) if direction != :left
        run_beam(x, y-1, :left) if direction != :right
      elsif @grid[x][y] == "/"
        run_beam(x-1, y, :up) if direction == :right
        run_beam(x+1, y, :down) if direction == :left
        run_beam(x, y-1, :left) if direction == :down
        run_beam(x, y+1, :right) if direction == :up
      elsif @grid[x][y] == "\\"
        run_beam(x+1, y, :down) if direction == :right
        run_beam(x-1, y, :up) if direction == :left
        run_beam(x, y+1, :right) if direction == :down
        run_beam(x, y-1, :left) if direction == :up
      end
    end




    def parse_input
      @grid = @file_lines.map{|line| line.split("")}
    end
  end
end
