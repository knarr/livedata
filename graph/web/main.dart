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
  List<List> neig = [["A",["B","C"]],
                     ["B",["D","E"]],
                     ["C",["F","G"]],
                     ["F",["H","I"]],
                     ["G",["J","K"]],
                     ["a",["b","c","f"]],
                     ["c",["f","g","h","a"]]];
  
  List<List> edges = [["A","C"],
                      ["B","D"],
                      ["E","F"],
                      ["B","A"]];
  
  List<List> edge2 = [["A","B"],
                      ["A","C"],
                      ["B","D"],
                      ["B","E"],
                      ["C","D"],
                      ["D","E"],
                      ["C","B"],
                      ["A","D"]];

  //DirectedGraph graph = new VDirectedGraph.fromMatrix(adj3);
  graph = new VDirectedGraph.fromEdges(edge2);
  
  
  // Create Visualization
  graph.canvas = querySelector("#area"); // get the canvas from the html
  scheduleMicrotask(graph.display);
  
  querySelector("#node-add").onClick.listen(createNode);
  querySelector("#edge-add").onClick.listen(addEdge);
}

void createNode(MouseEvent event) {
  String name = querySelector("#node-name").value;
  if (name != "") {
    graph.addNode(name);
    name = "";
  }
  
}

void addEdge(MouseEvent event) {
  String name1 = querySelector("#edge-end-1").value;
  String name2 = querySelector("#edge-end-2").value;
  if (name1 != "" && name2 != "") {
    !graph.edgeExists(name1, name2) ? graph.addEdge(name1, name2) : graph.removeEdge(name1, name2);
    name1 = "";
    name2 = "";
  }
}
