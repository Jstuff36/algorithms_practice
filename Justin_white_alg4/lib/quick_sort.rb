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
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return if length <= 1
    pivot = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot - start, &prc)
    QuickSort.sort2!(array,pivot + 1,length - pivot - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    pivot_idx = start
    ((start + 1)...(length + start)).each do |idx|
      if prc.call(array[idx], array[start]) <= 0
        pivot_idx += 1
        array[pivot_idx], array[idx] = array[idx], array[pivot_idx]
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end
end
