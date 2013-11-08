import 'dart:collection';
import 'dart:html';
import 'dart:math';

class DirectedGraph extends IterableBase{
  final HashMap dGraph = new HashMap();
  
  // Constructors
  // Creates a graph from a given adjacency matrix
  DirectedGraph.fromMatrix(List<List> adj) {
    // add each edge node
    int height = adj.length;
    for (var i = 0; i < height; i++) {
      if (adj[i].length != height) {
        throw new ArgumentError("Adjacency matrix must be square.");
      }
      this.addNode(i);
    }
    // add each edge
    for (var i = 0; i < adj.length; i++) {
      for (var j = 0; j < adj[i].length; j++) {
        addEdge(i, j);
      }
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

class VDirectedGraph extends DirectedGraph {
  CanvasElement canvas; // Canvas to draw to
  HashMap positions = new HashMap();
  
  VDirectedGraph.fromMatrix(List<List> adj): super.fromMatrix(adj);
  
  // Called after canvas has been set.
  // Initializes the position of each node and begins drawing.
  // If canvas is not set throws Exception.
  void display() {
    if (canvas != null) { // make sure we have a canvas
      for (var node in this) {
        // give a position to each node
        // positions currently stored as a 2-element list
        positions[node] = [canvas.parent.client.width/2,
                           canvas.parent.client.height/2];
      }
      requestUpdate(); // Begin updating the display
    } else {
      throw new Exception("Canvas needed to display on");
    }
  }
  
  void requestUpdate() {
    window.requestAnimationFrame(update);
  }
  
  void update(num _) {
    for (var first in this) {
      // Adjust the position of each node
      for (var second in this) {
        
      }
    }
    draw(); // draw the nodes
    requestUpdate();
  }
  
  void draw() {
    var context = canvas.context2D;
    context..lineWidth = 1
           ..strokeStyle = "black"
           ..font = "16px sans-serif"
           ..textAlign = "center";
    for (var node in this) {
      // draw each node in the graph
      context..fillStyle = "purple"
             ..beginPath()
             ..arc(positions[node][0], positions[node][1],
                   20, 0, PI*2, false)
             ..fill()
             ..stroke()
             ..closePath();
      // Label each node
      context..fillStyle = "white"
             ..beginPath()
             ..fillText(node.toString(),positions[node][0], positions[node][1] + 6)
             ..closePath();
    }
  }
}
