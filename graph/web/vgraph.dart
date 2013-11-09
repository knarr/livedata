import 'dart:html';
import 'dart:math';
import 'graph.dart';
import 'dart:collection';


// should probably implement positions differently so that this isn't necessary...
num dist(List p1, List p2) => sqrt(pow(p1[0]-p2[0], 2) + pow(p1[1]-p2[1],2));

class VDirectedGraph extends DirectedGraph {
  CanvasElement canvas; // Canvas to draw to
  HashMap positions = new HashMap(); 
  final int XMIN = 25;
  int XMAX;
  final int YMIN = 25;
  int YMAX;
  
  VDirectedGraph.fromMatrix(List<List> adj): super.fromMatrix(adj);
  VDirectedGraph.fromNeighbours(List<List> neig): super.fromNeighbours(neig);
  
  // Called after canvas has been set.
  // Initializes the position of each node and begins drawing.
  // If canvas is not set throws Exception.
  void display() {
    if (canvas != null) { // make sure we have a canvas
      
      // Random Number Generator to produce initial variation
      var rng = new Random();
      YMAX = canvas.parent.clientHeight-25;
      XMAX = canvas.parent.clientWidth-25;
      for (var node in this) {
        // give a position to each node
        // positions currently stored as a 2-element list
        positions[node] = [canvas.parent.client.width/2 + rng.nextDouble(),
                           canvas.parent.client.height/2 + rng.nextDouble()];
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
        int equilibrium = (dGraph[first].contains(second)) ? 100 : 300;
        // all nodes repel each other
        num distance = dist(positions[first], positions[second])+0.001;
        num dx = (positions[first][0] - positions[second][0])/distance*(equilibrium - distance)/2;
        num dy = (positions[first][1] - positions[second][1])/distance*(equilibrium - distance)/2;
        positions[first][0] += dx/10;
        positions[first][1] += dy/10;
        positions[second][0] -= dx/10;
        positions[second][1] -= dy/10;
        
        //buffered screen-edge collision prevention
        if (positions[first][0] > XMAX) positions[first][0] = XMAX;
        if (positions[first][0] < XMIN) positions[first][0] = XMIN;
        if (positions[first][1] > YMAX) positions[first][1] = YMAX;
        if (positions[first][1] < YMIN) positions[first][1] = YMIN;
        if (positions[second][0] > XMAX) positions[second][0] = XMAX;
        if (positions[second][0] < XMIN) positions[second][0] = XMIN;
        if (positions[second][1] > YMAX) positions[second][1] = YMAX;
        if (positions[second][1] < YMIN) positions[second][1] = YMIN;
      }
    }
    var context = canvas.context2D;
    clearCanvas(context, 
        canvas.parent.client.width,
        canvas.parent.client.height); // clear the canvas
    draw(context); // draw the nodes
    requestUpdate();
  }
  
  // clears the canvas so that the graph can be redrawn.
  void clearCanvas(CanvasRenderingContext2D context, int width, int height) {
    context.clearRect(0, 0, width, height);
  }
  
  // Draws the graph onto the canvas
  void draw(CanvasRenderingContext2D context) {
    
    context..lineWidth = 1
           ..strokeStyle = "black"
           ..font = "16px sans-serif"
           ..textAlign = "center";
    for (var node in this) {
      for (var edge in dGraph[node]) {
        context..beginPath()
               ..moveTo(positions[node][0], positions[node][1])
               ..lineTo(positions[edge][0], positions[edge][1])
               ..stroke()
               ..closePath();
      }
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
