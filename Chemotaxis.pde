/* int x = (int)(mouseX - mouseX % 10);
 int y = (int)(mouseY - mouseY % 10);
 rounds current mouse coordinates to nearest 10 */
/* overloaded constructor
 constructors with different parameters
 use get() for checking collisions
 */

//make a game with upgrades

// use 'extends' to make copies


Bacteria guy = new Bacteria();


void setup() {
  size(600, 800);
  background(0);
}

void draw() {
  uiElements();
  noStroke();
  fill(0);
  rect(0, 0, 600, 600);
  guy.show();
  guy.walk();
}

class Bacteria {
  int bacX, bacY;
  int speed, size, pickupRange;
  Bacteria() {
    bacX = 300;
    bacY = 300;
    //starting stats
    speed = 3;
    size = 10;
    pickupRange = 5;
  }

  void show() {
    fill(255);
    ellipse(bacX, bacY, size, size);
  }

  void walk() {
    bacX += (int)(Math.random()*speed)-1;
    bacY += (int)(Math.random()*speed)-1;
  }
}

void uiElements() {
  fill(255, 255, 255);
  rect(0, 600, 600, 200);
}
