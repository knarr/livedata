
import 'dart:async';
import 'dart:html';
import 'dart:math';


class VTree {
  // Containing canvas
  CanvasElement canvas;
  num width;
  num height;
  
  // Drawing properties
  String color = "orange";
  num x;
  num y;
  
  // Interface
  num value;
  VTree left;
  VTree right;
  
  VTree(this.value, this.left, this.right);
  
  void display() {
 /* Should be called after the canvas has been set.
  * Propagates visual data through children and begins animation.
  */
    
    // Measure the canvas element.
    Rectangle rect = canvas.parent.client;
    width = rect.width;
    height = rect.height;
    canvas.width = width;
    
    // begin animation loop
    window.requestAnimationFrame(draw);
  }

  void draw(num _) {
 /* Called by requestAnimationFrame or parent node.
  * Draws the current node and recurses on the children.
  */
    var context = canvas.context2D;
    // Draw the figure.
    context..lineWidth = 0.5
           ..fillStyle = color
           ..strokeStyle = color;
    
    context..beginPath()
           ..arc(width/2,height/2, 20, 0, PI*2, false)
           ..fill()
           ..closePath();
    
  }
}

void main() {
  CanvasElement canvas = query("#area");
  // Sample VTree for testing purposes
  VTree sample = new VTree(5, new VTree(6, null, null), null);
  sample.canvas = canvas;
  scheduleMicrotask(sample.display);
}

