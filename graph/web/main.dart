import 'dart:html';
import 'graph.dart';
import 'vgraph.dart';
import 'dart:async';

VDirectedGraph graph;

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
  List<List> neig = [["A",["B","C",1,2,3,4,5]],
                     ["B",["D","E"]],
                     ["C",["F","G",3,5,9,10]],
                     ["F",["H","I"]],
                     ["G",["J","K"]],
                     ["a",["b","c","f"]],
                     ["c",["f","g","h","a"]]];
  
  List<List> edges = [["A","C"],
                      ["B","D"],
                      ["E","F"],
                      ["B","A"]];

  //DirectedGraph graph = new VDirectedGraph.fromMatrix(adj3);
  graph = new VDirectedGraph.fromNeighbours(neig);
  
  // Create Visualization
  graph.canvas = querySelector("#area"); // get the canvas from the html
  scheduleMicrotask(graph.display);
  
  querySelector("#node-add").onClick.listen(createNode);
}

void createNode(MouseEvent event) {
  String name = querySelector("#node-name").value;
  if (name != "") {
    graph.addNode(name);
    name = "";
  }
}
