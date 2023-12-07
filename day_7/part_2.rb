require_relative "../utils/part"

module Day7
  class Part2 < Part

    def call
      min, max = quadratic_formula(1, -@time, @distance)
      num = (max-1).ceil - (min + 1).floor + 1

      puts num
    end

    def quadratic_formula(a, b, c)
      q = Math.sqrt(b**2 - 4*a*c)
      return [(-b - q) / (2*a), (-b + q) / (2*a)]
    end



    def parse_input
      @time = @file_lines[0].scan(/\d+/).join("").to_i
      @distance = @file_lines[1].scan(/\d+/).join("").to_i
    end

  end
end
