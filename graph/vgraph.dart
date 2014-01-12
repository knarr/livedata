// file: vgraph.dart
// contains: VDirectedGraph

library vgraph;

import 'dart:math';
import 'dart:html';
import 'dart:collection';

import 'graph.dart';

// should probably implement positions differently so that this isn't necessary...
num dist(List p1, List p2) => sqrt(pow(p1[0]-p2[0], 2) + pow(p1[1]-p2[1],2));

class VDirectedGraph extends DirectedGraph {
  final int CONNECTEDEQUILIBRIUM = 100;
  final int FREEEQUILIBRIUM = 300;
  
  bool open = false; // Is the graph currently displaying
  
  CanvasElement canvas; // Canvas to draw to
  HashMap positions = new HashMap(); 
  num scaleFactor = 1; // used for scaling the canvas
  
  
  VDirectedGraph.fromMatrix(List<List> adj): super.fromMatrix(adj);
  VDirectedGraph.fromNeighbors(List<List> neig): super.fromNeighbors(neig);
  VDirectedGraph.fromEdges(List<List> edges): super.fromEdges(edges);
  
  // Overwrite DirectedGraph.addNode so that the position can be added
  HashMap addNode(var node) {
    super.addNode(node);
    if (!positions.containsKey(node)) {
      var rng = new Random();
      if (canvas != null) {
        positions[node] = [canvas.client.width/2 + rng.nextDouble(),
                           canvas.client.height/2 + rng.nextDouble()];
      } else {
        positions[node] = [rng.nextDouble(), rng.nextDouble()];
      }
    }
  }
  
  // Begin displaying on the given canvas
  void display(canvas) {
    open = true;
    scaleFactor = 1;
    this.canvas = canvas; // keep a reference to the canvas
    canvas.context2D.save();
    // Random Number Generator to produce initial variation
    var rng = new Random();
    for (var node in this) {
      // give a position to each node
      // positions currently stored as a 2-element list
      positions[node] = [canvas.client.width/2 + rng.nextDouble(),
                         canvas.client.height/2 + rng.nextDouble()];
    }
    requestUpdate(); // Begin updating the display
  }
  
  // Stop displaying this graph
  void close() {
    open = false;
    canvas.context2D.restore();
  }
  
  void requestUpdate() {
    window.requestAnimationFrame(update);
  }
  
  void update(num _) {
    if (!open) return; // don't update
    for (var first in this) {
      // Adjust the position of each node
      for (var second in this) {
        int equilibrium = (dGraph[first].contains(second)) ? CONNECTEDEQUILIBRIUM : FREEEQUILIBRIUM;
        // all nodes repel each other
        num distance = dist(positions[first], positions[second])+0.001;
        num dx = (positions[first][0] - positions[second][0])/distance*(equilibrium - distance)/2;
        num dy = (positions[first][1] - positions[second][1])/distance*(equilibrium - distance)/2;
        positions[first][0] += dx/10;
        positions[first][1] += dy/10;
        positions[second][0] -= dx/10;
        positions[second][1] -= dy/10;
      }
    }
    var context = canvas.context2D;
    clearCanvas(context); // clear the canvas
    scale(context); // Scale the canvas to include all the nodes
    drawEdges(context); // Draw the edges first so that the nodes overlay
    drawNodes(context); // Draw the nodes
    requestUpdate();
  }
  
  // clears the canvas so that the graph can be redrawn.
  void clearCanvas(CanvasRenderingContext2D context) {
    num width = canvas.width*scaleFactor*1.2;
    num height = canvas.height*scaleFactor*1.2;
    context.clearRect(-100, -100, width+100, height+100);
  }
  
  // Scales the canvas so that all nodes will be visible
  void scale(CanvasRenderingContext2D context) {
    num left = canvas.width;
    num right = 0;
    num up = 0;
    num down = canvas.height;
    for (var node in this) {
      left = min(left, positions[node][0]);
      right = max(right, positions[node][0]);
      up = min(up, positions[node][1]);
      down = max(down, positions[node][1]);
    }
    num newsf = max((right - left + 120)/canvas.height,
                  (down - up + 120)/canvas.width);
    context.translate(canvas.width/2, canvas.height/2);
    context.scale(scaleFactor/newsf, scaleFactor/newsf);
    context.translate(-canvas.width/2, -canvas.height/2);
    scaleFactor = newsf;
  }
  
  void unscale(CanvasRenderingContext2D context) {
    context.translate(canvas.width/2, canvas.height/2);
    context.scale(1/scaleFactor, 1/scaleFactor);
    context.translate(-canvas.width/2, -canvas.height/2);
  }
  
  // Draws the edges to the given context
  void drawEdges(CanvasRenderingContext2D context) {
    context..lineWidth = 3
           ..strokeStyle = "black";
    for (var node in this) {
      for (var edge in edgesFrom(node)) {
        context..beginPath()
               ..moveTo(positions[node][0], positions[node][1])
               ..lineTo(positions[edge][0], positions[edge][1])
               ..stroke()
               ..closePath();
      }
    }
  }
  
  // Draws the graph onto the canvas
  void drawNodes(CanvasRenderingContext2D context) {
    
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
