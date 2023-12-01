require_relative "../utils/part"
require_relative "../utils/read_lines"

module Day1
  class Part1 < Part

    def call
      lines = ReadLines.call(file_path: @file_path)

      line_numbers = lines.map do |line|
        nums = line.split("").filter{ |c| c.match?(/[0-9]/) }
        nums[0] + nums.last
      end

      puts line_numbers.map { |d| d.to_i }.sum
    end
  end
end
