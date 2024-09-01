class Graph

  def initialize(graph = {})
    self.graph = graph
  end

  # Returns the vertices of the graph
  # @return [Array]
  def vertices
    graph.keys
  end

  # Returns the edges of the graph
  # @param node [Integer] the node to get the edges from
  def edges(node = nil)
    return graph.values.flatten(1) unless node

    graph[node]
  end

  # Returns the shortest path from a node to all other nodes
  # @param node [Integer] the node to get the neighbors from
  # @return a [Hash with the distances to each node
  def dijkstra(start)
    distances = Hash.new(Float::INFINITY)
    distances[start] = 0
    visited = []

    loop do
      # Find the unvisited node with the smallest distance
      current_node = nil
      distances.each do |node, dist|
        next if visited.include?(node)
        current_node = node if current_node.nil? || dist < distances[current_node]
      end

      break if current_node.nil? # No more nodes to visit

      visited << current_node

      # Update distances for its neighbors
      graph[current_node].each do |neighbor, weight|
        new_distance = distances[current_node] + weight
        distances[neighbor] = new_distance if new_distance < distances[neighbor]
      end
    end

    distances
  end


  # Generates a connected graph with n vertices and s edges
  # @param n [Integer] the number of vertices
  # @param s [Integer] the number of edges
  # @return [Graph]
  def self.generate_connected_graph(n, s)
    raise ArgumentError, "Number of edges must be at least #{n - 1}" if s < n - 1

    graph = {}
    (1..n).each { |i| graph[i] = [] }

    # Step 1: Create a simple connected graph
    (2..n).each { |i| graph[i - 1] << i }

    # Step 2: Add additional edges
    edges = (1..n).to_a.combination(2).to_a
    edges -= graph.flat_map { |k, v| v.map { |u| [k, u] } }

    edges.sample(s - (n - 1)).each { |u, v| graph[u] << v }

    # add random weigth
    graph = graph.transform_values { |v| v.map { |e| [e, rand(10) * 2] } }

    self.new(graph)
  end

  # Returns the eccentricity of a vertex
  # @param vertex [Integer] the vertex to get the eccentricity from
  # @return [Integer]
  def eccentricity(vertex)
    distances = dijkstra(vertex).except(vertex)
    distances.values.max
  end

  # Returns the radius of the graph
  # @return [Integer]
  def radius
    graph.keys.map { |vertex| eccentricity(vertex) }.compact.min
  end

  # Returns the diameter of the graph
  # @return [Integer]
  def diameter
    graph.keys.map { |vertex| eccentricity(vertex) }.compact.max
  end

  def to_s
    graph.inspect
  end

  attr_accessor :graph
end
