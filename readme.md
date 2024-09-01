# Graph Algorithms

This project implements various graph algorithms in Ruby, including Dijkstra's algorithm, eccentricity, radius, and diameter calculations.

## Installation

1. Clone the repository:

    ```sh
    git clone git@github.com:vhsalazar/graph_republic.git
    cd graph_republic
    ```

2. Install the dependencies using Bundler:
    ```sh
    bundle install
    ```

## Usage

### Graph Class

The `Graph` class provides methods to work with graphs, including generating connected graphs, finding shortest paths, and calculating graph properties.

#### Methods

- `edges(node = nil)`: Returns the edges of the graph. If a node is provided, returns the edges from that node.
- `dijkstra(start)`: Returns the shortest path from the start node to all other nodes using Dijkstra's algorithm.
- `self.generate_connected_graph(n, s)`: Generates a connected graph with `n` vertices and `s` edges.
- `eccentricity(vertex)`: Returns the eccentricity of a vertex.
- `radius`: Returns the radius of the graph.
- `diameter`: Returns the diameter of the graph.

### Example

```ruby
require './graph'

# Generate a connected graph with 5 vertices and 6 edges
graph = Graph.generate_connected_graph(5, 6)

# Print the graph
puts graph

# Find the shortest paths from vertex 1
distances = graph.dijkstra(1)
puts "Shortest paths from vertex 1: #{distances}"

# Calculate the eccentricity of vertex 1
eccentricity = graph.eccentricity(1)
puts "Eccentricity of vertex 1: #{eccentricity}"

# Calculate the radius of the graph
radius = graph.radius
puts "Radius of the graph: #{radius}"

# Calculate the diameter of the graph
diameter = graph.diameter
puts "Diameter of the graph: #{diameter}"
```

## Testing

Run the tests using RSpec:
```sh
bundle exec rspec
```

## Dependencies

- Ruby
- Bundler
- RSpec

