require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = rand(0...array.length)
    left = []
    right = []
    [*0...pivot, *pivot + 1...array.length].each do |idx|
      p idx
      if array[idx] <= array[pivot]
        left << array[idx]
      else
        right << array[idx]
      end
    end
    QuickSort.sort1(left) + [array[pivot]] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)

  end

  def self.partition(array, start, length, &prc)
  end
end
