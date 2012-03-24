class Graph
    def initialize(graph={}, dir=false)
        @g = graph
        @directed = dir
        @nodes = Array.new
        if @g
            @nodes = @g.keys
        end
    end

    def addEdge(source, target)
        source = source.to_s
        target = target.to_s

        if (not @g.has_key?(source))
            @g[source] = Array.new
        end
        @g[source] << target

        if (not @directed)
            if (not @g.has_key?(target))
                @g[target] = Array.new
            end
            @g[target] << source
        end

        if (not @nodes.include?(source))
            @nodes << source
        end
        if (not @nodes.include?(target))
            @nodes << target
        end
    end

    def nodes
        @nodes
    end

    def getEdges(source)
        @g[source]
    end
end

if __FILE__ == $0
    g = Graph.new
    g.addEdge(1, 2)
    g.addEdge(1, 5)
    g.addEdge(2, 5)
    g.addEdge(2, 3)
    g.addEdge(3, 4)
    g.addEdge(5, 4)
    g.addEdge(4, 6)

    p g.nodes
    p g.getEdges("2")
end
