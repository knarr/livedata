import 'dart:collection';

class DirectedGraph extends IterableBase {
  final HashMap<Object, HashSet> dGraph = new HashMap();
  
  // Constructors
  // Creates a graph from a given adjacency matrix
  DirectedGraph.fromMatrix(List<List> adj) {
    // add each edge node
    int height = adj.length;
    for (int i = 0; i < height; i++) {
      if (adj[i].length != height) {
        throw new ArgumentError("Adjacency matrix must be square.");
      }
      addNode(i);
    }
    // add each edge
    for (var i = 0; i < adj.length; i++) {
      for (var j = 0; j < adj[i].length; j++) {
        if (adj[i][j] != 0) {
          addEdge(i, j);
        }
      }
    }
  }
  // Creates a graph from a list of vertices and edges which it connects to
  DirectedGraph.fromNeighbours(List<List> nodes) {
    for (List pair in nodes) {
      addNode(pair[0]);
      for (var neighbour in pair[1]) {
       if (!dGraph.containsKey(neighbour)) addNode(neighbour);
       addEdge(pair[0], neighbour);
      }
    }
  }
  // Creates a graph from a list of edge pairs of nodes
  DirectedGraph.fromEdges(List<List> edges) {
    // First add all the nodes
    for (List edge in edges) {
      addNode(edge[0]);
      addNode(edge[1]);
    }
    for (List edge in edges) {
      addEdge(edge[0],edge[1]);
    }
  }
  
  // Adds a new node to the graph.
  // If the node already exists the graph is unchanged.
  HashMap addNode(var node) {
    if (!dGraph.containsKey(node)) {
      dGraph[node] = new HashSet();
    }
  }
  
  // Adds an arc from the start node to the dest node.
  // If the arc already exists the graph is unchanged.
  // If either endpoint does not exist throws a NoSuchElementException
  HashMap addEdge(var start, var dest) {
    if (dGraph.containsKey(start) && dGraph.containsKey(dest)) {
      dGraph[start].add(dest);
    } else {
      throw new NoSuchElementException("Both nodes must be in the graph.");
    }
  }
  
  // Removes an arc between the start node to the dest node.
  // If the arc does not exist then returns the Hashmap unchanged.
  // If either endpoint does not exist throws a NoSuchElementException.
  HashMap removeEdge(var start, var dest) {
    if (dGraph.containsKey(start) && dGraph.containsKey(dest)) {
      dGraph[start].remove(dest);
    } else {
      throw new NoSuchElementException("Both nodes must be in the graph.");
    }
  }
  
  // Returns whether an arc exists from the start node to the end node.
  // If either endpoint does not exist throws a NoSuchElementExcpetion.
  bool edgeExists(var start, var end) {
    if (dGraph.containsKey(start) && dGraph.containsKey(end)) {
      return dGraph[start].contains(end);
    } else {
      throw new NoSuchElementException("Both nodes must be in the graph.");
    }
  }
  
  // Given a set of nodes in the graph; returns the nodes accessable from that node.
  // If the node does no exist throws a NoSuchElementException.
  HashSet edgesFrom(var node) {
    final HashSet arcs = dGraph[node];
    if (arcs == null) {
      throw new NoSuchElementException("Source node does not exist.");
    } else {
      return arcs;
    }
  }
  
  // Returns the iterator over the nodes in the graph.
  Iterator get iterator => dGraph.keys.iterator;
  // Returns the number of nodes in the graph
  int get length => dGraph.length;
}
