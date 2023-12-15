require_relative "../utils/part"

module Day15
  class Part2 < Part
    def call
      boxes = []
      for i in 0..255
        boxes[i] = []
      end

      @steps.each do |step|
        plus_steps = step.split("=")
        if plus_steps.length == 1
          label = step.split("-")[0]
          box_id = hash(label)
          found = boxes[box_id].find{|items| items[0] == label}
          boxes[box_id].delete(found)
        else
          label, lens = plus_steps
          box_id = hash(label)

          found = boxes[box_id].find{|items| items[0] == label}
          if found
            found[1] = lens
          else
            boxes[box_id].push([label, lens])
          end
        end
      end

      sum = 0
      for i in 0..255
        next if boxes[i].length == 0
        for j in 0..boxes[i].length-1
          sum += (i+1) * (j + 1) * boxes[i][j][1].to_i
        end
      end

      puts sum
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
