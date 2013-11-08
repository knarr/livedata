import 'dart:html';
import 'graph.dart';
import 'dart:async';

void main() {

  List<List> adj = [[1,0,0,1],
                    [0,1,1,1],
                    [0,0,1,0],
                    [1,1,0,0]];

  DirectedGraph graph = new VDirectedGraph.fromMatrix(adj);
  
  // Create Visualization
  graph.canvas = query("#area"); // get the canvas from the html
  scheduleMicrotask(graph.display);
}
