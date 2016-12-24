Snake snek = new Snake();
int scl = 10;
int countFood = 5;
PVector[] food = new PVector[countFood];

void setup(){
  size(600, 600);
  frameRate(10);
  foodLocation();
}

void foodLocation() {
  int cols = floor(width/scl);
  int rows = floor(height/scl);
  for(int i=0; i< countFood; i++) {
    food[i] = new PVector (floor(random(cols)),floor(random(rows)));
    food[i].mult(scl);
  }
  
  
}

void draw() {
  colorMode(HSB, 255);
  background(51);
  noStroke();
  snek.update();
  snek.show();
  snek.eat();
  fill(255, 0, 100);
  for(int i=0; i< countFood; i++) {
    rect(food[i].x, food[i].y, scl, scl);
  }
}

void keyPressed() {
  if(key == CODED && keyCode == UP ) {
    snek.direction(0, -1);
  } else if(key == CODED && keyCode == DOWN ) {
    snek.direction(0, 1);
  } else if(key == CODED && keyCode == LEFT ) {
    snek.direction(-1, 0);
  } else if(key == CODED && keyCode == RIGHT ) {
    snek.direction(1, 0);
  }
}

class Snake {
  float x = 0;
  float y = 0;
  float xspeed = 1;
  float yspeed = 0;
  ArrayList<PVector> tail = new ArrayList<PVector>();
  boolean alive=true;
  int q =0;
  
  void update() {

    if(!alive) return;
    for(int i=0; i< tail.size() -1; i++) {
      tail.set(i, tail.get(i+1));
    }
    if(!tail.isEmpty()) tail.set(tail.size() -1, new PVector(x,y));
    x += xspeed*scl;
    y += yspeed*scl;
    if(x < 0) x =  width-scl;
    if(y < 0) y =  height-scl;
    if(x > (width-scl)) x=0;
    if(y > (height-scl)) y=0;
    for(int i=0; i< tail.size() -1; i++) {
      PVector tailBit =tail.get(i);
      if(x==tailBit.x && y==tailBit.y){
        alive=false;
      }
    }
  }
  
  void show() {
    q++;
    fill(q/3.0 % 360, 255, 255);
    drawPart(x,y,scl);
    for(int i=0; i< tail.size(); i++) {
      PVector tailSegment = tail.get(i);
      fill((q+i)/3.0 % 360, 255, 255);
      drawPart(tailSegment.x,tailSegment.y,scl);
    }
  }
  
  void drawPart(float x,float y,float scl){
    rect(x,y,scl,scl);
    if(!alive){
      stroke(0);
      line(x,y, x+scl, y+scl);
      line(x+scl, y, x, y+scl);
      noStroke();
    }
  }
  
  void direction(float xdir, float ydir) {
    xspeed = xdir;
    yspeed = ydir;
  }
  
  void eat() {
    for(int i=0; i< countFood; i++) {
      if(x == food[i].x && y == food[i].y) {
        int cols = floor(width/scl);
        int rows = floor(height/scl);
        food[i] = new PVector (floor(random(cols)),floor(random(rows)));
        food[i].mult(scl);
        tail.add(new PVector(x,y));
      }
    }
  }
}