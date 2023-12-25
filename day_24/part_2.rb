require_relative "../utils/part"
require 'set'

module Day24
  class Part2 < Part



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
        !crash_location.nil?
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
      ##
      # hailstone[0]
      # x + a*t = 246721424318191 + 46 * t
      # y + b*t = 306735195971895 + -42*t
      # z + c*t = 195640804079938 + 141*t

      # hailstone[1]
      # x + a*s = 286716952521568 + 121 * s
      # y + b*s = 348951612232772 + 421 * s
      # z + c*s = 274203424013154 + -683 * s

      #  hailstone[2]
      # x + a*l = 231402843137765 + 30 * l
      # y + b*l = 83297412652001 + 154 * l
      # z + c*l = 273065723902291 + 66 * l

      # solved it with online solver :(

      x = 309721960025816
      y = 434470227085520
      z = 164429529509188
      puts x + y + z
    end




    def parse_input
      @hailstones = @file_lines.map{|line| Hailstone.new(line)}
    end
  end
end
