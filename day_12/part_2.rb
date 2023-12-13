require_relative "../utils/part"

module Day12
  class Part2 < Part
    def call
      @input.map! do |springs, target|
        @cache = {}
        ga(springs, target)
      end
      puts @input.sum
    end

    def ga(springs, target, len=0, cur=0)
      key = [target.join(""), len, cur].join("|")
      return @cache[key] if @cache.key?(key)

      for i in len..springs.length-1 do
        if springs[i] == "#"
          cur += 1
          return 0 if target.length == 0 || cur > target[0]
        elsif springs[i] == "." && cur > 0
          return 0 if target[0] != cur
          target.shift
          cur = 0
        elsif springs[i] == "?"
          with_hash = ga(springs, target.dup, i+1, cur+1)
          @cache[[target.join(""), i+1, cur+1].join("|")] = with_hash

          with_space = 0
          if cur == 0
            with_space = ga(springs, target.dup, i+1, cur)
            @cache[[target.join(""), i+1, cur].join("|")] = with_space
          elsif target[0] == cur
            target.shift
            with_space = ga(springs, target.dup, i+1, 0)
            @cache[[target.join(""), i+1, 0].join("|")] = with_space
          end

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
        springs = [springs, springs, springs, springs, springs].join("?")
        target = [target, target, target, target, target].join(",")
        [springs.chars, target.split(",").map(&:to_i)]
      end
    end

  end
end
