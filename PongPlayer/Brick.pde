static final int POLYGON = 0;

abstract class Brick {

  int type;
  int id;
  
  int colorCode;
  PImage textureImage;
  
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  
  boolean isColliding;
  
  abstract void run(Ball ball);
    
  abstract boolean isCollidingWithBall(Ball ball);
}