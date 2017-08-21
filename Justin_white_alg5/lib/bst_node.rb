class BSTNode

  attr_accessor :left, :right, :value, :parent

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end

end
