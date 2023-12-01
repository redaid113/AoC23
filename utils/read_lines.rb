require_relative "./callable"

class ReadLines
  extend Callable

  def initialize(file_path:)
    @file = File.open(file_path)
  end

  def call
    file_data = @file.read
    file_data.strip!
    lines = file_data.split("\n")
  end
end
