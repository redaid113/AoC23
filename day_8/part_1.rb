require_relative "../utils/part"

module Day8
  class Part1 < Part
    def call
      ct = 0

      cur =  "AAA"
      while cur != "ZZZ"
        @instructions.each do |i|
          cur = @locations[cur][i]
        end
        ct += 1
      end

      puts ct * @instructions.length
    end



    def parse_input
      @instructions = @file_lines.shift().each_char.map{|c| c == 'R'? 1 : 0}
      @file_lines.shift()

      @locations = @file_lines.reduce({}) do |locations, line|
        key, values_str = line.split(" = (")
        locations[key] = values_str.sub(")", "").split(", ");
        locations
      end
    end

  end
end
