require_relative "../utils/part"
require 'set'

module Day23
  class Part2 < Part
    Node = Struct.new(:cord, :edges)
    Edge = Struct.new(:cord, :weight)


    def call
       build_graph
       trancate_graph
       puts longest_path(@graph[@start], Set[])
    end


    def longest_path(edge, seen)
      return 0 if edge.cord == @end

      @graph[edge.cord].edges.map do |e|
        next(-1) if seen.include?(e.cord)
        seen << e.cord
        dist = longest_path(e, seen)
        seen.delete(e.cord)
        next(-1) if dist == -1
        dist + e.weight
      end.max
    end

    def build_graph
      graph = {}

      for r in 0..@grid.length - 1 do
        for c in 0..@grid[0].length - 1 do
          next if @grid[r][c] == "#"
          node = Node.new([r, c], [])
          graph[[r, c]] = node
          neighbors(r, c).each do |cord|
            node.edges << Edge.new(cord, 1)
          end
        end
      end

      @graph = graph
    end

    def trancate_graph
      @graph.each do |cord, node|
        if node.edges.length == 2
          a = @graph[node.edges[0].cord]
          b = @graph[node.edges[1].cord]
          new_weight = node.edges[0].weight + node.edges[1].weight

          a.edges.delete_if{|e| e.cord == cord}
          a.edges << Edge.new(b.cord, new_weight)
          b.edges.delete_if{|e| e.cord == cord}
          b.edges << Edge.new(a.cord, new_weight)
        end
      end

      new_graph = {}
      @graph.each do |cord, node|
        new_graph[cord] = node if node.edges.length != 2
      end
      @graph = new_graph
    end


    def neighbors(r, c)
      [
        [r + 1, c],
        [r - 1, c],
        [r, c + 1],
        [r, c - 1]
    ].select do |l|
      l[0] >= 0 && l[1] >= 0 && l[0] < @grid.length && l[1] < @grid[0].length
    end.select do |l|
        @grid[l[0]][l[1]] != "#"
      end
    end


    def parse_input
      @grid = @file_lines.map{|line| line.split("")}
      @start = [0, 1]
      @end = [@grid.length - 1, @grid[0].length - 2]
    end

  end
end
