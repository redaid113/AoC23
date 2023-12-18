require_relative "../utils/part"
require 'fc'
require 'set'


module Day18
  class Part1 < Part

    def call
      points = get_points

      area = tie_your_area(points)
      perimeter = @instructions.sum{|d| d[1]}
      inside_points = picks_inside(area, perimeter)

      puts perimeter + inside_points
    end

    def get_points
      points = []
      last = [0, 9]
      points << last
      @instructions.each do |direction, distance, colour|
        case direction
        when "U"
          last = [last[0], last[1] + distance]
        when "D"
            last = [last[0], last[1] - distance]
        when "L"
          last = [last[0] - distance, last[1]]
        when "R"
          last = [last[0] + distance, last[1]]
        end
        points << last
      end


      points
    end

    def picks_inside(area, outside)
      area + 1 - outside/2
    end

    def tie_your_area(points)
      sum = 0

      for i in 0..points.length - 2
        x1, y1 = points[i]
        x2, y2 = points[i + 1]
        sum += x1 * y2 - x2 * y1
      end

      (sum / 2).abs
    end


    def parse_input
      @instructions = @file_lines.map do |line|
        direction, distance, colour = line
          .tr('()', '')
          .split(" ")
        [direction, distance.to_i, colour]
      end
    end

  end
end
