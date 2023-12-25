require_relative "../utils/part"
require 'set'

module Day25
  class Part1 < Part

    def call
      vertices = @graph.keys
      matrix = []
      for i in 0..vertices.length - 1
        matrix[i] = []
        for j in 0..vertices.length - 1
          matrix[i] << 0
        end
      end
      for i in 0..vertices.length - 1
        edges = @graph[vertices[i]]
        for edge in edges
          matrix[i][vertices.index(edge)] = 1
        end
      end


      min, best = min_cut(matrix)

      puts best.length * (vertices.length - best.length)
    end

    # Stoer–Wagner
    def min_cut(matrix)
      min_cut = Float::INFINITY
      best = []
      n = matrix.length
      co = []

      for i in 0..n - 1
        co[i] = [i]
      end

      for ph in 1..n-1
        w = matrix[0].dup
        s = 0
        t = 0
        for it in 0..n-ph-1
          w[t] = -Float::INFINITY
          s = t
          t = w.each_with_index.max[1]
          for i in 0..n-1
            w[i] += matrix[t][i]
          end
        end

        if min_cut > w[t] - matrix[t][t]
          min_cut = w[t] - matrix[t][t]
          best = co[t].dup
          if min_cut == 3
            return [min_cut, best]
          end
        end

        co[s] += co[t]

        for i in 0..n-1
          matrix[s][i] += matrix[t][i]
        end

        for i in 0..n-1
          matrix[i][s] = matrix[s][i]
        end
        matrix[0][t] = -Float::INFINITY
      end

      [min_cut, best]
    end



    def parse_input
      @graph = {}
      @file_lines.each do |line|
        key, targets = line.split(": ")
        @graph[key] ||= []
        targets.split(" ").each do |target|
          @graph[target] ||= []
          @graph[target] << key
          @graph[key] << target
        end

      end

    end
  end
end
