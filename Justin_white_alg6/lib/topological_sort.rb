require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  queue = []
  sorted = []
  vertices.each do |vertice|
    queue << vertice if vertice.in_edges.empty?
  end
  until queue.empty?
    current = queue.shift
    sorted << current
    until current.out_edges.empty?
      edge = current.out_edges.pop
      queue.push(edge.to_vertex) if edge.to_vertex.in_edges.length == 1
      edge.destroy!
    end
    # edges.each {|edge| edge.destroy! }
  end
  return [] unless sorted.length == vertices.length
  sorted
end
