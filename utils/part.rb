require_relative "./callable"


class Part
  extend Callable

  def initialize(file_path:)
    @file_path = file_path
  end
end
