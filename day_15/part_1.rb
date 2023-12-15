require_relative "../utils/part"

module Day15
  class Part1 < Part
    def call
      puts @steps.sum{|step| hash(step)}
    end

    def hash(str)
      value = 0
      str.each_byte do |c|
        value += c
        value *= 17
        value %= 256
      end
      value
    end




    def parse_input
      @steps = @file_lines[0].split(",")
    end

  end
end
