require_relative "../utils/part"


module Day4
  class Part1 < Part

    def call
      sum = 0
      @games.map do |target, current|
        won = current.select { |n| target.include?(n) }.length
        sum += 2 ** (won-1) if won > 0
      end
      puts sum
    end

    def parse_input
      @games = @file_lines.map do |line|
        target, current = line.split(": ")[1].split(" | ")
        target = target.split(" ").map(&:to_i)
        current = current.split(" ").map(&:to_i)
        [target, current]
      end
    end

  end
end
