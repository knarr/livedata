
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
    
    if (left != null) { 
      left.canvas = canvas;
      left.y = y + 40;
      left.x = x - 70;
      left.display();
    }
    if (right != null) {
      right.canvas = canvas;
      right.y = y + 40;
      right.x = x + 70;
      right.display();
    }
    
    
    
    // begin animation loop
    window.requestAnimationFrame(draw);
  }

  void draw(num _) {
 /* Called by requestAnimationFrame or parent node.
  * Draws the current node and recurses on the children.
  */
    var context = canvas.context2D;
    context..lineWidth = 1
           ..strokeStyle = "black";
    
    if (left != null) { 
      context..beginPath()
             ..moveTo(x, y)
             ..lineTo(left.x, left.y)
             ..stroke()
             ..closePath();
      left.draw(_);
    }
    if (right != null) {
      context..beginPath()
             ..moveTo(x, y)
             ..lineTo(right.x, right.y)
             ..stroke()
             ..closePath();

      right.draw(_);
    }
    
    // Draw the figure.
    context..lineWidth = 0.5
           ..fillStyle = color
           ..textAlign = "center";
    
    context..beginPath()
           ..arc(x,y, 20, 0, PI*2, false)
           ..fill()
           ..closePath();
    
    context..fillStyle = "black"
           ..font = "16px sans-serif";
    context..beginPath()
           ..fillText(value.toString(), x, y+6)
           ..fill()
           ..closePath();
    
    
  }
}

void main() {
  CanvasElement canvas = query("#area");
  
  // Sample VTree for testing purposes
  VTree sample = new VTree(5, new VTree(6, new VTree(7, null, null), null), new VTree(4, null, null));
  
  
  sample.canvas = canvas;
  sample.x = canvas.parent.client.width/2;
  sample.y = 0.15*canvas.parent.client.height;
  scheduleMicrotask(sample.display);
}

