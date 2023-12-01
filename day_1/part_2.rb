require_relative "../utils/part"
require_relative "../utils/read_lines"

module Day1
  class Part2 < Part

    def call
      lines = ReadLines.call(file_path: @file_path)
      numbers = {
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five": 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine": 9
      }

      line_numbers = lines.map do |line|

        min_i = line.length+1
        min = 0
        max_i = -1
        max = 0

        numbers.each do |str, num|
          str = str.to_s
          num = num.to_i

          first = line.index(str)
          if first != nil && first < min_i
            min_i = first
            min = num
          end

          last = line.rindex(str)
          if last != nil && last > max_i
            max_i = last
            max = num
          end
        end

        "#{min}#{max}".to_i
      end


      puts line_numbers.sum
    end
  end
end
