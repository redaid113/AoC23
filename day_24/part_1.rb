require_relative "../utils/part"
require 'set'

module Day24
  class Part1 < Part
    # Area = Range.new(7, 27)
    Area = Range.new(200000000000000, 400000000000000)

    class Hailstone
      attr_reader :point, :velocity, :slope, :b
      def initialize(str)
        cords, velocity = str.split(" @ ")
        @point = cords.split(", ").map(&:to_f)
        @velocity = velocity.split(", ").map(&:to_f)

        @slope = @velocity[1] / @velocity[0]
        @b = @point[1] - @slope * @point[0]
      end

      def will_collide(hailstone)
        crash_location = collision(hailstone)
        return false if crash_location.nil?
        Area.include?(crash_location[0]) && Area.include?(crash_location[1])
      end

      def collision(hailstone)
        return nil if @slope == hailstone.slope
        x = (hailstone.b - @b) / (@slope - hailstone.slope)
        y = @slope * x + @b

        t1 = (x - @point[0]) / @velocity[0]
        t2 = (x - hailstone.point[0]) / hailstone.velocity[0]
        return nil if t1 < 0 || t2 < 0

        [x, y]
      end

    end

    def call
      ct = 0

      for i in 0..@hailstones.length - 1 do
        for j in i + 1..@hailstones.length - 1 do
          ct += 1 if @hailstones[i].will_collide(@hailstones[j])
        end
      end
      puts ct
    end




    def parse_input
      @hailstones = @file_lines.map{|line| Hailstone.new(line)}
    end
  end
end
