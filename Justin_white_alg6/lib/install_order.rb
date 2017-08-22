# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
  max_id = arr.flatten.max
  ids = (1..max_id).to_a

  vertices = {}
  arr.each do |file|
    vertices[file[0]] = Vertex.new(file[0]) unless vertices[file[0]]
    vertices[file[1]] = Vertex.new(file[1]) unless vertices[file[1]]
    Edge.new(vertices[file[1]], vertices[file[0]])
  end

  no_dependencies = []
  ids.each do |id|
    no_dependencies << id if vertices[id].nil?
  end

  no_dependencies + topological_sort(vertices.values).map { |value| value.value }

end
