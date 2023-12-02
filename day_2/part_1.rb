require_relative "../utils/part"
require_relative "../utils/read_lines"


module Day2
  class Part1 < Part
    DiceSet = Struct.new(:red, :green, :blue)

    def call
      parse_input()
      target = DiceSet.new(12, 13, 14)
      sum = 0
      @games.each_with_index do |game, i|
        if game.all? { |set| set.red <= target.red && set.green <= target.green && set.blue <= target.blue }
          sum += i+1
        end
      end
      puts sum
    end

    def parse_input()
      @games = @file_lines.map do |line|
        parse_line(line)
      end
    end

    def parse_line(line)
      line.split(":")[1].strip.split("; ").map do |set|
        colours = DiceSet.new(0, 0, 0)
        set.split(", ").map do |colour|
          colour = colour.split(" ")
          colours[colour[1].to_sym] = colour[0].to_i
        end
        colours
      end
    end
  end
end
