/* int x = (int)(mouseX - mouseX % 10);
 int y = (int)(mouseY - mouseY % 10);
 rounds current mouse coordinates to nearest 10 */
/* overloaded constructor
 constructors with different parameters
 use get() for checking collisions
 */

//make a game with upgrades

// use 'extends' to make copies


Bacteria guy = new Bacteria(); //main
Bacteria[] bacCopies = new Bacteria[100]; //array of copies

Coin[] coins = new Coin[10];

void setup() {
  size(600, 800);
  background(0);
  for(int i = 0; i < coins.length; i++){
    coins[i] = new Coin(i); 
  }
}

void draw() {
  uiElements();
  noStroke();
  fill(0);
  rect(0, 0, 600, 600);
  for(Coin i : coins){
    i.show(); 
  }
  guy.show();
  guy.walk();

}

class Bacteria { //Main guy that is controlled
  int bacX, bacY;
  int speed, size, pickupRange;
  Bacteria() {
    bacX = 300;
    bacY = 300;
    //starting stats
    speed = 5; 
    size = 10;
    pickupRange = 5;
  }

  void show() {
    fill(255);
    ellipse(bacX, bacY, size, size);
  }

  void walk() {
    //biased walking
    if (mouseX > bacX) {
      bacX += (int)(Math.random()*speed)-1;
    } else {
      bacX -= (int)(Math.random()*speed)-1;
    }
    if (mouseY > bacY) {
      bacY += (int)(Math.random()*speed)-1;
    } else {
      bacY -= (int)(Math.random()*speed)-1;
    }

    //limit how far it goes
    if (bacY >= 600) {
      bacY = 600;
    }
  }
}

class Coin { //coins to collect
  int x, y;
  int coinIndex;
  Coin(int argIndex) {
    x = (int)(Math.random()*600);
    y = (int)(Math.random()*600);
    coinIndex = argIndex;
  }
  void show() {
    fill(#C9AB00);
    ellipse(x, y, 20, 25);
    fill(#F0E802);
    ellipse(x-4, y, 20, 25);
  }
  void checkCollision(int argX, int argY) {
    if(dist(x, y, argX, argY) < 10) { //if bacteria is close enough to coin
      
    }
    
  }
}

void uiElements() {
  fill(255, 255, 255);
  rect(0, 600, 600, 200);
}
