class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.each_with_index.map { |el, i| el.hash << i}.reduce(:+).hash
  end
end

class String
  def hash
    self.chars.each_with_index.map { |let, i| let.ord.hash << i}.reduce(:+).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sort.hash
  end
end
