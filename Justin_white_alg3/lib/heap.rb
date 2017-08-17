class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    store.length
  end

  def extract
    store[0], store[-1] = store[-1], store[0]
    popped = store.pop
    @store = BinaryMinHeap.heapify_down(store, 0, &prc)
    popped
  end

  def peek
    store[0]
  end

  def push(val)
    store.push(val)
    @store = BinaryMinHeap.heapify_up(store, count - 1, &prc)
  end

  public

  def self.child_indices(len, parent_index)
    left = 2 * parent_index + 1
    right = 2 * parent_index + 2
    if left >= len
      nil
    elsif right >= len
      [left]
    else
      [left, right]
    end
  end

  def self.parent_index(child_index)
    parent_index = (child_index - 1) / 2
    raise "root has no parent" if parent_index < 0
    parent_index
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|el, el2| el <=> el2 }
    need_to_swap = true
    while need_to_swap
      child_indices = BinaryMinHeap.child_indices(len, parent_idx)
      need_to_swap = false
      # check if node has child indices
      if child_indices
        smallest_swap_val_idx = child_indices[0]
        # find if left or right indices (if it exist) is smaller
        if child_indices[1] && prc.call(array[child_indices[0]], array[child_indices[1]]) >= 0
          smallest_swap_val_idx = child_indices[1]
        end

        # determine if the parent node is larger than its child node
        if prc.call(array[parent_idx], array[smallest_swap_val_idx]) >= 0
          array[parent_idx], array[smallest_swap_val_idx] = array[smallest_swap_val_idx], array[parent_idx]
          need_to_swap = true
          parent_idx = smallest_swap_val_idx
        end
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el, el2| el <=> el2 }
    need_to_swap = true
    while need_to_swap
      need_to_swap = false
      begin
        parent_idx = BinaryMinHeap.parent_index(child_idx)
      rescue
        break
      end
      if prc.call(array[parent_idx], array[child_idx]) >= 0
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
        # node at idx 0 will have no parent and error will be thrown
        need_to_swap = true
        child_idx = parent_idx
      end
    end
    array
  end
end
