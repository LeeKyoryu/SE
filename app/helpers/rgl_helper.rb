require 'rgl/adjacency'

module RglHelper

  def lvl(lv)
    case lv
    when 1
      return RGL::AdjacencyGraph[1,4 ,1,5 ,2,3, 2,5, 3,4]
    when 2
      return RGL::AdjacencyGraph[1,2 ,1,4 ,1,5 ,2,3, 2,4, 2,5, 3,4]
    when 3
      return RGL::AdjacencyGraph[1,2 ,1,4 ,1,5 ,2,3, 2,6, 2,5, 3,6 ,3,7 ,4,5 ,5,6 ,6,7]
    when 4
      return RGL::AdjacencyGraph[1,4 ,1,6 ,2,3 ,2,4, 3,4, 4,5 ,4,6 ,4,7 ,5,6]
    when 5
      return RGL::AdjacencyGraph[1,3 ,1,4 ,2,3, 2,5, 3,4, 3,5 ,4,5 ,4,6 ,4,7 ,5,7 ,6,7 ,7,8 ,7,9 ,9,8]
    when 6
      return RGL::AdjacencyGraph[1,2 ,1,4 ,1,5, 1,6, 1,7, 2,3 ,3,6 ,4,5 ,4,6 ,4,7 ,5,6 ,5,7]
    when 7
      return RGL::AdjacencyGraph[1,2, 1,6, 1,7, 1,8, 2,3 ,2,4 ,2,7 ,3,5 ,3,6 ,3,9 ,4,5 ,4,8 ,4,9 ,5,6 ,5,9 ,6,9 ,7,8 ,7,9 ,8,9]
    else
      return RGL::AdjacencyGraph[]
    end
  end

  def vertices(lv)
    lvl(lv).vertices.length
  end

  def edges(lv)
    lvl(lv).edges.length
  end

end
