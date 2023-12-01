require_relative "./utils/callable"

class Run
  extend Callable
  def initialize(day:, part1:, part2:, file_path:)
    @day = day
    @part1 = part1
    @part2 = part2
    @file_path = file_path
  end

  def call
    if @part1
      run_part 1
    end

    if @part2
      run_part 2
    end
    puts
  end

  def run_part(part)
    puts
    puts "========================"
    puts "Running #{@day}/part_#{part}.rb"
    puts "========================"

    require_relative("#{@day}/part_#{part}.rb")
    eval("#{@day.sub("_", "").capitalize}::Part#{part}.call(file_path: '#{@file_path}')")
  end
end
