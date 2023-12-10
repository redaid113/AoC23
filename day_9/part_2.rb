require_relative "../utils/part"

module Day9
  class Part2 < Part
    def call
      puts @inputs.map(&method(:lagrange)).sum
    end

    def lagrange(points)
      points.reverse!
      target_x = points.length
      points.each_with_index.sum do |y, x|
        numberator = 1
        denominator = 1
        for j in 0..target_x-1
          next if j == x

          numberator *= target_x - j
          denominator *= x - j
        end

        y * numberator / denominator
      end
    end

    def parse_input
      @inputs = @file_lines.map{|line| line.split(" ").map(&:to_i)}
    end

  end
end
