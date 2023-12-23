require_relative "../utils/part"
require 'set'


module Day22
  class Part2 < Part
    class Brick
      attr_accessor :from, :to, :covered, :lowest, :highest, :is_on, :is_under
      def initialize(str)
        from, to = str.split("~")
        @from = from.split(",").map(&:to_i)
        @to = to.split(",").map(&:to_i)

        @lowest = @from[2]
        @highest = @to[2]

        @covered = []
        for x in @from[0]..@to[0]
          for y in @from[1]..@to[1]
            for z in @from[2]..@to[2]
              @covered << [x, y, z]
            end
          end
        end

        @lowest = @from[2]

        @is_on = []
        @is_under = []
      end

      def move_down
        @covered.each{|c| c[2] -= 1}
        @lowest -= 1
        @highest -= 1
      end

      def move_up
        @covered.each{|c| c[2] += 1}
        @lowest += 1
        @highest += 1
      end

      def collision(brick)
        return false if brick.lowest > @highest || brick.highest < @lowest
        @covered.any?{|c| brick.covered.any?{|c2| c == c2}}
      end

      def is_atop(brick)
        move_down
        on = collision(brick)
        move_up
        on
      end
    end


    def call
      @bricks = @bricks.sort{|a, b| a.lowest <=> b.lowest}

      make_em_fall

      @bricks = @bricks.sort{|a, b| a.lowest <=> b.lowest}

      who_is_touching_who



      out = []
      for i in 0..@bricks.length-1 do
        brick = @bricks[i]
        dropping = Set[i]
        queue = brick.is_under
        while queue.length > 0
          b = queue.shift
          if @bricks[b].is_on.all?{|c| dropping.include?(c)}
            dropping << b
            queue += @bricks[b].is_under
          end
        end
        out[i] = dropping.length - 1
      end

      puts out.sum
    end

    def who_is_touching_who
      for i in 1..@bricks.length-1 do
        for j in 0..i-1 do
          if @bricks[i].is_atop(@bricks[j])
            @bricks[i].is_on << j
            @bricks[j].is_under << i
          end
        end
      end
    end

    def make_em_fall
      @bricks.each_with_index do |brick, i|
        while brick.lowest > 1
          brick.move_down
          if (0..i-1).any?{|j| @bricks[j].collision(brick)}
            brick.move_up
            break
          end
        end
      end
    end

    def parse_input
      @bricks = @file_lines.map{|line| Brick.new(line)}
    end

  end
end
