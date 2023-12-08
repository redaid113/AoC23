require_relative "../utils/part"

module Day8
  class Part2 < Part
    def call

      cur_list = @locations.each_key.filter{|k| match?(k, "A")}

      after_steps = @locations.each_key.reduce({}) do |after_steps, cur|
        after_steps[cur] = step(cur)
        after_steps
      end

      offset_period = cur_list.map do |cur|
        offset = 0
        while !match?(cur, "Z")
          cur = after_steps[cur]
          offset += @instructions.length
        end

        offset
      end

      puts offset_period.reduce(:lcm)
    end

    def step(cur)
      @instructions.each do |i|
        cur = @locations[cur][i]
      end
      return cur
    end

    def match?(cur, char)
      cur[-1] == char
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
