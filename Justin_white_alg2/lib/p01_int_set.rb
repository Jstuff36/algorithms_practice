class MaxIntSet

  attr_reader :max
  attr_accessor :store

  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def insert(num)
    is_valid?(num)
    store[num] = true
  end

  def remove(num)
    store[num] = false
  end

  def include?(num)
    store[num] === true
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num > max || num < 0
  end

  def validate!(num)
  end
end


class IntSet

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count == num_buckets
    self[num] << num
    @count += 1
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
    end
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    old_store.flatten.each do |el|
      self.insert(el)
    end
  end

end
