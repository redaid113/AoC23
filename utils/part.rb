require_relative "./callable"


class Part
  extend Callable

  def initialize(file_path:)
    @file_path = file_path
    parse_file
    parse_input
  end

  def parse_file
    @file_lines = ReadLines.call(file_path: @file_path)
  end

  def parse_input
  end
end
