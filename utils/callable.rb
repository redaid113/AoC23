module Callable
  def call(*args, **kwargs, &block)
    self.new(*args, **kwargs).call(&block)
  end
end
