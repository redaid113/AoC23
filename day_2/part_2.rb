require_relative "../utils/part"
require_relative "../utils/read_lines"


module Day2
  class Part2  < Part
    DiceSet = Struct.new(:red, :green, :blue)

    def call
      target = DiceSet.new(12, 13, 14)
      sum = 0
      @games.each do |game|
        max_set = DiceSet.new(0, 0, 0)
        game.each do |set|
          max_set.red = [max_set.red, set.red].max
          max_set.green = [max_set.green, set.green].max
          max_set.blue = [max_set.blue, set.blue].max
        end
        sum += max_set.red * max_set.green * max_set.blue
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
