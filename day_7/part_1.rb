require_relative "../utils/part"

module Day7
  class Part1 < Part

    def call
      nums = @races.map do |time, distance|
        min, max = quadratic_formula(1, -time, distance)
        (max-1).ceil - (min + 1).floor + 1
      end

      puts nums.reduce(:*)
    end

    def quadratic_formula(a, b, c)
      q = Math.sqrt(b**2 - 4*a*c)
      return [(-b - q) / (2*a), (-b + q) / (2*a)]
    end



    def parse_input
      times = @file_lines[0].scan(/\d+/).map(&:to_i)
      distances = @file_lines[1].scan(/\d+/).map(&:to_i)
      @races = times.zip(distances)
    end

  end
end
