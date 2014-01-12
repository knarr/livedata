// file: examples.dart
// contains: Example graphs used by the demo

part of demo;

//======================================================
// Example Graph Representations
//======================================================
// adj*  : Adjacency matrix form, use: new VDirectedGraph.fromMatrix(adj*);
// neig* : Neighbor list form,    use: new VDirectedGraph.fromNeighbors(neig*);
// edge* : Edge list form,        use: new VDirectedGraph.fromEdges(edge*);

Map<String,List<List>> examples = {
  "adj1":
   [[1,0,0,0,0],
    [0,0,1,0,0],
    [0,0,0,1,0],
    [0,0,0,0,1],
    [1,0,0,0,0]],

  "adj2": 
  [[1,1,1,0,1,0,1,0], 
   [0,1,1,1,0,1,0,1],
   [1,0,1,1,1,0,1,0],
   [0,1,0,1,1,1,0,1],
   [1,0,1,0,1,1,1,0],
   [0,1,0,1,0,1,1,1],
   [1,0,1,0,1,0,1,1],
   [1,1,0,1,0,1,0,1]],

  "adj3":
  [[0, 1, 0],
   [1, 0, 1],
   [1, 0, 0]],

  "neig1":
  [["A",["B","C"]],
   ["B",["D","E"]],
   ["C",["F","G"]],
   ["F",["H","I"]],
   ["G",["J","K"]],
   ["a",["b","c","f"]],
   ["c",["f","g","h","a"]]],
   
  "edge1":
   [["A","C"],
    ["B","D"],
    ["E","F"],
    ["B","A"]],

  "edge2":
   [["A","B"],
    ["A","C"],
    ["B","D"],
    ["B","E"],
    ["C","D"],
    ["D","E"],
    ["C","B"],
    ["A","D"]]
};