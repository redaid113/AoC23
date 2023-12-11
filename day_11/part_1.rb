require_relative "../utils/part"

module Day11
  class Part1 < Part
    def call
      stars = get_stars

      sum = 0
      for i in 0..stars.length-2
        for j in i+1..stars.length-1
          sum += (stars[i][0] - stars[j][0]).abs + (stars[i][1] - stars[j][1]).abs
        end
      end
      puts sum
    end

    def get_stars
      h_space = get_horizontal_space
      v_space = get_vertical_space

      stars = []
      for r in 0..@input.length-1
        for c in 0..@input[0].length-1
          if @input[r][c] == "#"
            stars << [r + h_space.count{|s| s < r}, c + v_space.count{|s| s < c}]
          end
        end
      end
      stars
    end

    def get_vertical_space
      spaces = []

      for c in 0..@input[0].length-1
        all = true
        for r in 0..@input.length-1
            all &= @input[r][c] == "."
        end
        if all
          spaces << c
        end
      end

      spaces
    end

    def get_horizontal_space
      spaces = []
      @input.each_with_index do |line, index|
        if line.all?{|char| char == "."}
          spaces << index
        end
      end
      spaces
    end

    def parse_input
      @input = @file_lines.map{|line| line.chars}
    end

  end
end
