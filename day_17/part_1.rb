require_relative "../utils/part"
require 'fc'
require 'set'


module Day17
  class Part1 < Part
    Node = Struct.new(:current, :score, :direction, :path) do
      def <=>(other)
        self.score <=> other.score
      end

      def to_s
        "#{current} - #{score} - #{direction}"
      end
    end

    module Direction
      UP = 0
      RIGHT = 1
      DOWN = 2
      LEFT = 3
    end

    def call
      seen = Set[]

      queue = FastContainers::PriorityQueue.new(:min)

      score = 0
      next_nodes([0, 0], 0, Direction::DOWN).each do |cord|
        queue.push(cord, cord.score)
      end

      next_nodes([0, 0], 0, Direction::RIGHT).each do |cord|
        queue.push(cord, cord.score)
      end

      while node = queue.pop do
        key = [node.current, node.direction]
        next if seen.include?(key)
        seen << key

        break if node.current == [@grid.length - 1, @grid[0].length - 1]

        next_nodes(node.current, node.score, (node.direction + 1) % 4).each do |cord|
          queue.push(cord, cord.score)
        end
        next_nodes(node.current, node.score, (node.direction + 3) % 4).each do |cord|
          queue.push(cord, cord.score)
        end

      end

      puts node.score
    end

    def next_nodes(current, score, direction)
      next_cords(current, direction).map do |cord|
        score += @grid[cord[0]][cord[1]]
        Node.new(cord, score, direction)
      end
    end

    def next_cords(current, direction)
      (1..3).map do |i|
        case direction
        when Direction::RIGHT
         [current[0], current[1] + i]
        when Direction::LEFT
         [current[0], current[1] - i]
        when Direction::UP
         [current[0] - i, current[1]]
        when Direction::DOWN
         [current[0] + i, current[1]]
        end
      end.filter { |r, c| r >= 0 && c >= 0 && r < @grid.length && c < @grid[0].length }
    end


    def parse_input
      @grid = @file_lines.map{|line| line.split("").map(&:to_i)}
    end

  end
end
