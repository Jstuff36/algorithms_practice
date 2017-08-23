class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = Hash.new{ [] }
    @frog_cache.merge!(
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [2, 1], [1, 2], [3]]
    )
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    @blair_cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + ((n - 1) * 2) - 1
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)[n]
  end

  def frog_cache_builder(n)
    cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [2, 1], [1, 2], [3]]
    }

    4.upto(n) do |step|
      cache[step] = []
      1.upto(3) do |step_size|
        cache[step] += cache[step - step_size].map do |el|
          el + [step_size]
        end
      end
    end
    cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
    @frog_cache[n]
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if !@frog_cache[n].empty?
    1.upto(3) do |step_size|
      @frog_cache[n] += frog_hops_top_down(n - step_size).map do |arr|
        arr + [step_size]
      end
    end
  end

  def super_frog_hops(n, k)
    cache = { 1 => [[1]] }
    2.upto(n) do |step|
      cache[step] = []
      1.upto([step, k].min) do |num_to_add|
        if step == num_to_add
          cache[step] += [[step]]
        else
          cache[step] += cache[step - num_to_add].map do |el|
            el + [num_to_add]
          end
        end
      end
    end
    cache[n]
  end

  def knapsack(weights, values, capacity)
    
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
