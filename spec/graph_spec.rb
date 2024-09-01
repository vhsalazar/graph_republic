require 'rspec'
require_relative '../graph'

RSpec.describe Graph do
  let(:graph) { Graph.new({ 1 => { 2 => 1, 3 => 4 }, 2 => { 3 => 2 }, 3 => { 4 => 7 }, 4 => { 1 => 3 } }) }

  describe '#vertices' do
    it 'returns the vertices of the graph' do
      expect(graph.vertices).to eq([1, 2, 3, 4])
    end
  end

  describe '#edges' do
    it 'returns the edges of a node' do
      expect(graph.edges(1)).to eq({ 2 => 1, 3 => 4 })
    end
  end

  describe '#dijkstra' do
    it 'returns the shortest path from a node to all other nodes' do
      expect(graph.dijkstra(1)).to eq({ 1 => 0, 2 => 1, 3 => 3, 4 => 10 })
      expect(graph.dijkstra(2)).to eq({ 2 => 0, 3 => 2, 4 => 9, 1 => 12 })
      expect(graph.dijkstra(3)).to eq({ 3 => 0, 4 => 7, 1 => 10, 2 => 11 })
      expect(graph.dijkstra(4)).to eq({ 4 => 0, 1 => 3, 2 => 4, 3 => 6 })
    end
  end

  describe '#eccentricity' do
    it 'returns the eccentricity of a node' do
      expect(graph.eccentricity(1)).to eq(10)
      expect(graph.eccentricity(2)).to eq(12)
      expect(graph.eccentricity(3)).to eq(11)
      expect(graph.eccentricity(4)).to eq(6)
    end
  end

  describe '#radius' do
    it 'returns the radius of the graph' do
      expect(graph.radius).to eq(6)
    end
  end

  describe '#diameter' do
    it 'returns the diameter of the graph' do
      expect(graph.diameter).to eq(12)
    end
  end

  describe '.generate_connected_graph' do
    subject { described_class.generate_connected_graph(vertices, edges) }

    let(:vertices) { 7 }
    let(:edges) { 12 }

    it 'returns a Graph object' do
      expect(subject).to be_a(Graph)
    end

    it 'generates a connected graph with n vertices ' do
      expect(subject.vertices.size).to eq(vertices)
    end

    it 'generates a connected graph with `s` edges' do
      expect(subject.edges.size).to eq(edges)
    end

    context 'when the number of edges is less than vertices - 1' do
      let(:edges) { 5 }

      it 'raises an error ' do
        expect { subject }.to raise_error(ArgumentError, 'Number of edges must be at least 6')
      end
    end
  end
end