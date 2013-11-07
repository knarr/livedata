import 'dart:html';
import 'graph.dart';

void main() {

  List<List> adj = [[1,0,0,1],
                    [0,1,1,1],
                    [0,0,1,0],
                    [1,1,0,0]];
  
  DirectedGraph graph = new DirectedGraph.fromMatrix(adj);
}
