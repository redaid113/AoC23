require_relative "../utils/part"


module Day4
  class Part2 < Part

    def call
      sum = @games.length
      cache = {}

      @games.reverse().each_with_index.map do |(target, current), i|
        won = current.select { |n| target.include?(n) }.length
        cache[i] = won
        (1..won).each do |j|
          cache[i] += cache[i-j] if i-j >= 0
        end
        sum += cache[i]
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
