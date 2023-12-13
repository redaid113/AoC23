require_relative "../utils/part"

module Day12
  class Part1 < Part
    def call
      puts @input.map{|springs, target| ga(springs, target)}.sum
    end

    def ga(springs, target, len=0, cur=0)
      for i in len..springs.length-1 do
        if springs[i] == "#"
          cur += 1
          return 0 if target.length == 0 || cur > target[0]
        elsif springs[i] == "." && cur > 0
          return 0 if target[0] != cur
          target.shift
          cur = 0
        elsif springs[i] == "?"
          copy = springs.dup
          copy[i] = "#"
          with_hash = ga(copy, target.dup, i, cur)

          copy[i] = "."
          with_space = ga(copy, target.dup, i, cur)

          return with_hash + with_space
        end
      end

      if target.length == 0 && cur == 0
        return 1
      end

      return target.length == 1 && cur == target[0] ? 1 : 0
    end

    def parse_input
      @input = @file_lines.map do |line|
        springs, target = line.split(" ")
        [springs.chars, target.split(",").map(&:to_i)]
      end
    end

  end
end
