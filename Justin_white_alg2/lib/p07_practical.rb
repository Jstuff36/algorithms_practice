require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  my_hash_map = HashMap.new
  string.chars.each do |let|
    if my_hash_map.include?(let)
      my_hash_map.delete(let)
    else
      my_hash_map.set(let, nil)
    end
  end

  return false if my_hash_map.count > 1
  true
end
