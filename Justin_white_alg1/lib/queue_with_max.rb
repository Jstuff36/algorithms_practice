# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max_queue = RingBuffer.new
  end

  def enqueue(val)
    store.unshift(val)
    if max_queue.empty?
      max_queue.unshift(val)
    else
      i = max_queue.length
      while i > 0
        if  max_queue[i] < val
          max_queue.pop
        end
        i -= 1
      end
      max_queue.unshift(val)
    end
  end

  def dequeue
    # on if the front of the dequeue is equal to the front... on the SO post
    store.shift
  end

  def max
    @max_queue[0]
  end

  def length
    store.length
  end

end
