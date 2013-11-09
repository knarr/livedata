import 'dart:html';
import 'graph.dart';
import 'vgraph.dart';
import 'dart:async';

void main() {
  // example graphs
  List<List> adj = [[1,0,0,0,0],
                    [0,0,1,0,0],
                    [0,0,0,1,0],
                    [0,0,0,0,1],
                    [1,0,0,0,0]];
  List<List> adj2 = [[1,1,1,0,1,0,1,0], 
                     [0,1,1,1,0,1,0,1],
                     [1,0,1,1,1,0,1,0],
                     [0,1,0,1,1,1,0,1],
                     [1,0,1,0,1,1,1,0],
                     [0,1,0,1,0,1,1,1],
                     [1,0,1,0,1,0,1,1],
                     [1,1,0,1,0,1,0,1]];
  List<List> adj3 = [[0, 1, 0],
                     [1, 0, 1],
                     [1, 0, 0]];
  List<List> neig = [["A",["B","C"]],
                     ["B",["D","E"]],
                     ["C",["F","G"]],
                     ["F",["H","I"]]];
  
  List<List> edges = [["A","C"],
                      ["B","D"],
                      ["E","F"],
                      ["B","A"]];

  //DirectedGraph graph = new VDirectedGraph.fromMatrix(adj3);
  DirectedGraph graph = new VDirectedGraph.fromNeighbours(neig);
  
  // Create Visualization
  graph.canvas = query("#area"); // get the canvas from the html
  scheduleMicrotask(graph.display);
}
