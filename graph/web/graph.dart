import 'dart:collection';

class DirectedGraph extends IterableBase{
  final HashMap dGraph = new HashMap();
  
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
