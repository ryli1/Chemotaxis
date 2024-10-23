/* int x = (int)(mouseX - mouseX % 10);
 int y = (int)(mouseY - mouseY % 10);
 rounds current mouse coordinates to nearest 10 */
/* overloaded constructor
 constructors with different parameters
 use get() for checking collisions
*/

// use 'extends' to make copies

//add a timer that delays the coin spawns


Bacteria guy = new Bacteria(); //main
ArrayList <Bacteria> bacCopies; //array of copies

ArrayList <Coin> coins = new ArrayList <Coin>();

int coinCount = 0;

void setup() {
  size(600, 800);
  background(0);
  for(int i = 0; i < 5; i++){
    coins.add(new Coin(i));
  }
}

void draw() {
  uiElements();
  noStroke();
  fill(0);
  rect(0, 0, 600, 600);
  for(int i = 0; i < coins.size(); i++){
    coins.get(i).show();
    coins.get(i).checkCollision(guy.bacX, guy.bacY);
  }
  //System.out.println(coins);
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
  int index;
  Coin(int index) {
    x = (int)(Math.random()*600);
    y = (int)(Math.random()*600);
    this.index = index;
  }
  void show() {
    fill(#C9AB00);
    ellipse(x, y, 20, 25);
    fill(#F0E802);
    ellipse(x-4, y, 20, 25);
  }
  void checkCollision(int argX, int argY) {
    if(dist(x, y, argX, argY) < 12) { //if bacteria is close enough to coin
      if(index >= coins.size()) {
        index--;
      }
      coins.set(index, new Coin(index)); //replace the collided coin with a new one in a random spot
      coinCount++; //add to coin count
      System.out.println(coins);
    }
  }
}

void uiElements() {
  fill(255, 255, 255);
  rect(0, 600, 600, 200);
  fill(0);
  text("Coins: " + coinCount, 10, 620);
}
