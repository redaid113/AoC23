require_relative "../utils/part"

module Day13
  class Part2 < Part
    def call
      rows = 0
      columns = 0

      @patterns.each do |pattern|
        rows_num, columns_num = fold(pattern)
        rows += rows_num
        columns += columns_num
      end

      puts rows * 100 + columns
    end


    def fold(pattern)
      [rows_above_fold(pattern), columns_left_of_fold(pattern)]
    end

    def rows_above_fold(pattern)
      for i in 1..(pattern.length - 1)
        err = 0
        for r in 1..i do
          for c in 0..(pattern[0].length - 1) do
            break if i-r < 0 || i+r-1 >= pattern.length
            err += 1 if pattern[i - r][c] != pattern[i + r-1][c]
          end
        end

        return i if err == 1
      end
      0
    end

    def columns_left_of_fold(pattern)
      for i in 1..(pattern[0].length - 1)
        err = 0
        for c in 1..i do
          for r in 0..(pattern.length - 1) do
            break if i-c < 0 || i+c-1 >= pattern[0].length
            err += 1 if pattern[r][i-c] != pattern[r][i + c - 1]
          end
        end

        return i if err == 1
      end
      0
    end

    def column(pattern, c)
      pattern.map{|row| row[c]}
    end

    def parse_file
      file_data = File.open(@file_path).read
      file_data.strip!
      @patterns = file_data.split("\n\n").map do |pattern|
        pattern.split("\n").map{|line| line.chars()}
      end
    end

  end
end
