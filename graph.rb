require 'rgl/adjacency'

g = RGL::AdjacencyGraph[1,2 ,2,3 ,2,4, 4,5, 6,4, 1,6]
g.remove_edge 4,5

puts g.edges
