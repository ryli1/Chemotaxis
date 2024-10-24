//Make sure speed is always an odd number

//add a timer that delays the coin spawns


Bacteria guy = new Bacteria(); //main
ArrayList <Bacteria> bacCopies = new ArrayList <Bacteria>(); //array of copies
ArrayList <Coin> coins = new ArrayList <Coin>();

int coinCount = 15;

void setup() {
  size(600, 800);
  background(0);
  //noCursor();
  bacCopies.add(new BacteriaCopy(9, 10, 15)); //Starter Clone, speed 9, size 10, range 15
  for (int i = 0; i < 5; i++) { 
    coins.add(new Coin(i)); //Start with 5 random coins
  }
}

void draw() {
  noStroke();
  fill(0);
  rect(0, 0, 600, 600);
  for (int i = 0; i < coins.size(); i++) {
    //coins.get(i).coinDelayTimer();
    coins.get(i).show();
    coins.get(i).checkCollision(guy.bacX, guy.bacY, guy.pickupRange);
    for (int j = 0; j < bacCopies.size(); j++) {
      coins.get(i).checkCollision(bacCopies.get(j).bacX, bacCopies.get(j).bacY, bacCopies.get(0).pickupRange);
    }
  }
  for (int i = 0; i < bacCopies.size(); i++) {
    bacCopies.get(i).show();
    bacCopies.get(i).walk();
  }
  guy.show();
  guy.walk();

  uiElements();
}

class Bacteria { //Main guy that is controlled
  int bacX, bacY;
  int speed, size, pickupRange;
  color bacColor;
  Bacteria() {
    bacX = 300;
    bacY = 300;
    bacColor = 255;
    //starting stats
    speed = 7; //do odd number so it can be split evenly
    size = 15;
    pickupRange = 20;
  }

  void show() {
    fill(bacColor);
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

class BacteriaCopy extends Bacteria {
  BacteriaCopy(int speed, int size, int pickupRange) {
    this.speed = speed; //do odd number so it can be split evenly
    this.size = size;
    this.pickupRange = pickupRange;
    bacX = guy.bacX;
    bacY = guy.bacY;
    bacColor = color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
  }
  void walk() {
    //unbiased walking
    bacX += (int)((Math.random()*speed)-(speed/2));  
    
    bacY += (int)((Math.random()*speed)-(speed/2));

    //limit how far it goes
    if (bacY >= 600) {
      bacY = 600;
    }
    if (bacY <= 0) {
      bacY = 0;
    }
    if (bacX >= 600) { 
      bacX = 600;
    }
    if (bacX <= 0) {
      bacX = 0;
    }
  }
}

class Coin { //coins to collect
  int x, y;
  int index;
  int timer = 100;
  Coin(int index) {
    x = (int)(Math.random()*600);
    y = (int)(Math.random()*600);
    this.index = index;
  }
  Coin(int index, int x, int y) {
    this.x = x;
    this.y = y;
    this.index = index;
  }
  void show() {
    fill(#C9AB00);
    ellipse(x, y, 15, 17.5);
    fill(#F0E802);
    ellipse(x-4, y, 15, 17.5);
    fill(#C9AB00);
    rect(x-5, y-4, 2, 8);
  }
  void checkCollision(int argX, int argY, int range) {
    if (dist(x, y, argX, argY) < range) { //if bacteria is close enough to coin
      if (index >= coins.size()) {
        index--; //move the index to make up for the missing one
      }
      //coins.set(index, new Coin(index, -100, -100)); //replace the collided coin with a new one in an unreachable spot
      coins.set(index, new Coin(index));
      coinCount++; //add to coin count
    }
  }
  /*void coinDelayTimer() { //Delays when the coin appears again after collecting one
   timer--;
   for (int i = 0; i < coins.size(); i++) {
   if (timer <= 0 && coins.get(i).x < 0) {
   //Move the unreachable coin to a reachable spot
   coins.get(i).x = (int)(Math.random()*600);
   coins.get(i).y = (int)(Math.random()*600);
   timer = 100;
   }
   }
   }*/
}



class Button {
  int x, y, cost;
  String buttonType;
  Boolean hovered = false;

  Button(int x, int y, String buttonType, int cost) {
    this.x = x;
    this.y = y;
    this.buttonType = buttonType;
    this.cost = cost;
    show();
    checkPressed();
  }
  void show() {
    strokeWeight(2);
    if (mouseX < x+150 && mouseX > x && mouseY < y+50 && mouseY > y) { 
      fill(#F0D01B);
      hovered = true;
    } else {
      fill(#FFE75D);
      hovered = false;
    }
    pushMatrix();
    rect(x, y, 150, 50, 15); //width 150, height 50
    fill(0);
    textSize(15);
    text("Cost: " + cost + " Coins", x+20, y+30);
    popMatrix();
    textSize(12);
  }
  void checkPressed() {
    if (hovered && mousePressed && coinCount >= cost) {
      if (buttonType == "Speed") {
        guy.speed += 2; //add 2 so the number stays odd
      }
      if (buttonType == "Size") {
        guy.pickupRange += 1;
        guy.size += 2;
      }
      if (buttonType == "Coin") {
        coins.add(new Coin(coins.size())); //add a new coin in a new spot
      }
      coinCount -= cost;
      cost++;
    }
  }
}

class CopyButton extends Button {
  CopyButton(int x, int y, String buttonType, int cost) {
    super(x, y, buttonType, cost);
  }
  void show() {
    if (mouseX < x+150 && mouseX > x && mouseY < y+50 && mouseY > y) { 
      fill(#50C13B);
      hovered = true;
    } else {
      fill(#75FA5B);
      hovered = false;
    }
    pushMatrix();
    rect(x, y, 150, 50, 15); //width 150, height 50
    fill(0);
    textSize(15);
    text("Cost: " + cost + " Coins", x+20, y+30);
    popMatrix();
    textSize(12);
  }
  void checkPressed() {
    if (hovered && mousePressed && coinCount >= cost) {
      if (buttonType == "Speed") {
        for (int i = 0; i < bacCopies.size(); i++) {
          bacCopies.get(i).speed += 2; 
        }
      }
      if (buttonType == "Size") {
        for (int i = 0; i < bacCopies.size(); i++) {
          bacCopies.get(i).pickupRange += 1;
          bacCopies.get(i).size += 2;
        }
      }
      if (buttonType == "Copy") {
        //Create a new copy with the same stats as the first copy
        bacCopies.add(new BacteriaCopy(bacCopies.get(0).speed, bacCopies.get(0).size, bacCopies.get(0).pickupRange));
      }
      coinCount -= cost;  
      cost++;
    }
  }
}

Button speedButton;
Button sizeButton;
CopyButton cloneButton;

CopyButton copySpeedButton;
CopyButton copySizeButton;
Button coinButton;

void uiElements() {
  fill(255, 255, 255);
  rect(0, 600, 600, 200);
  fill(0);
  textSize(15);
  text("Coins: " + coinCount, 10, 620);
  stroke(0);
  textSize(12);
  text("Upgrade Speed", 60, 645);
  speedButton = new Button(55, 650, "Speed", 3);

  text("Upgrade Size", 230, 645);
  sizeButton = new Button(225, 650, "Size", 3);

  text("Increase Amount of Coins", 400, 645);
  coinButton = new Button(395, 650, "Coin", 3);

  text("Upgrade Speed of Clones", 60, 735);
  copySpeedButton = new CopyButton(55, 740, "Speed", 2);

  text("Upgrade Size of Clones", 230, 735);
  copySizeButton = new CopyButton(225, 740, "Size", 2);

  text("Duplicate", 400, 735);
  cloneButton = new CopyButton(395, 740, "Copy", 1);
}


/* int x = (int)(mouseX - mouseX % 10);
 int y = (int)(mouseY - mouseY % 10);
 rounds current mouse coordinates to nearest 10 */
