// file: demo.dart
// contains: Demo

library demo;

import 'dart:html';

import 'graph/vgraph.dart';

part 'examples.dart'; // A bunch of example graph represenations


class Demo {
  // Runs a graph visualization demo, managing the scene with reference to a html gui
  
  int interval = 20; // millisecond delay between screen updates
  VDirectedGraph graph; // The Visual directed graph we are currently displaying
  CanvasElement canvas; // The canvas we are displaying on
  
  // Construct a demo on the given canvas, starting with the example "startid"
  Demo(String startid, this.canvas) {
    loadGraph(startid); // load the graph from the examples
    graph.display(canvas); // tell the graph to start displaying on the canvas
  }
  
  // Load a graph from the examples by id
  bool loadGraph(String id) {
    if (!examples.containsKey(id)) return false; // The example was not found
    
    // Load the graph based on starting prefix
    if (id.startsWith("adj"))
      graph = new VDirectedGraph.fromMatrix(examples[id]);
    else if (id.startsWith("neig"))
      graph = new VDirectedGraph.fromNeighbors(examples[id]);
    else if (id.startsWith("edge"))
      graph = new VDirectedGraph.fromEdges(examples[id]);
    else
      return false; // Indeterminant data type
    
    return true; // We made it!
  }
}

// The main function, called when index.html is loaded
void main() {
  // Create a new demo displaying on the canvas #area
  new Demo("neig1",querySelector("#area"));
}
