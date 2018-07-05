class BrickFactory {

  Brick CreateTriangle(float x1, float y1, float x2, float y2, float x3, float y3, int _id, color col) {
    
    Brick triangle = new Polygon(_id);
    
    triangle.colorCode = col;
    
    triangle.vertices.add(new PVector(x1, y1));
    triangle.vertices.add(new PVector(x2, y2));
    triangle.vertices.add(new PVector(x3, y3));
  
    return triangle;
  }
  
  Brick CreateTriangle(float x1, float y1, float x2, float y2, float x3, float y3, int _id, PImage _textureImage) {
    
    Brick triangle = new Polygon(_id);
    
    triangle.textureImage = _textureImage;
    
    triangle.vertices.add(new PVector(x1, y1));
    triangle.vertices.add(new PVector(x2, y2));
    triangle.vertices.add(new PVector(x3, y3));
  
    return triangle;
  }
  
  Brick CreateRectangle(float x, float y, float width, float height, int _id, color col) {
    
    Brick rectangle = new Polygon(_id);
    
    rectangle.colorCode = col;
    
    rectangle.vertices.add(new PVector(x, y));
    rectangle.vertices.add(new PVector(x + width, y));
    rectangle.vertices.add(new PVector(x + width, y + height));
    rectangle.vertices.add(new PVector(x, y + height));
  
    return rectangle;
  }
  
  Brick CreateRectangle(float x, float y, float width, float height, int _id, PImage _textureImage) {
    
    Brick rectangle = new Polygon(_id);
    
    rectangle.textureImage = _textureImage;
    
    rectangle.vertices.add(new PVector(x, y));
    rectangle.vertices.add(new PVector(x + width, y));
    rectangle.vertices.add(new PVector(x + width, y + height));
    rectangle.vertices.add(new PVector(x, y + height));
  
    return rectangle;
  }
  
  Brick CreateQuad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, int _id, color col) {
    
    Brick quad = new Polygon(_id);
    
    quad.colorCode = col;
    
    quad.vertices.add(new PVector(x1, y1));
    quad.vertices.add(new PVector(x2, y2));
    quad.vertices.add(new PVector(x3, y3));
    quad.vertices.add(new PVector(x4, y4));
  
    return quad;
  }
  
  Brick CreateQuad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, int _id, PImage _textureImage) {
    
    Brick quad = new Polygon(_id);
    
    quad.textureImage = _textureImage;
    
    quad.vertices.add(new PVector(x1, y1));
    quad.vertices.add(new PVector(x2, y2));
    quad.vertices.add(new PVector(x3, y3));
    quad.vertices.add(new PVector(x4, y4));
  
    return quad;
  }
  
  Brick CreateCircle(float x, float y, float diameter, int _id, color col) {
    
    Brick circle = new Polygon(_id);
    
    circle.colorCode = col;

    int numParts = 40;
    float theta = TWO_PI / numParts;
    
    for (int i = 0; i < numParts; i++) {
      float angle = theta * i;
      circle.vertices.add(new PVector(x + cos(angle) * diameter / 2, y + sin(angle) * diameter / 2));     
    }
    
    return circle;
  }
  
  Brick CreateCircle(float x, float y, float diameter, int _id, PImage _textureImage) {
    
    Brick circle = new Polygon(_id);
    
    circle.textureImage = _textureImage;

    int numParts = 40;
    float theta = TWO_PI / numParts;
    
    for (int i = 0; i < numParts; i++) {
      float angle = theta * i;
      circle.vertices.add(new PVector(x + cos(angle) * diameter / 2, y + sin(angle) * diameter / 2));     
    }
    
    return circle;
  }
  
  Brick CreateFromMessage(OscMessage message) {
    
    int type = message.get(2).intValue();
    int id = message.get(3).intValue();
    color col = message.get(4).intValue();
  
    Brick brick = null;
    
    if (type == POLYGON) {
      brick = new Polygon(id);
    }
    
    brick.colorCode = col;
    
    int count = message.get(5).intValue();
    
    for (int j = 0; j < count; j++) {
      PVector vertex = new PVector();
      
      vertex.x = message.get(6).floatValue();
      vertex.y = message.get(7).floatValue();
      vertex.z = message.get(8).floatValue();
      
      brick.vertices.add(vertex);
    }
    /*
    int width = message.get(9).intValue();
    int height = message.get(10).intValue();
    
    if (width > 0 && height > 0) {
      brick.textureImage = createImage(width, height, ARGB);
      brick.textureImage.loadPixels();
      
      for (int k = 0; k < width * height; k++) {
        brick.textureImage.pixels[k] = message.get(11+k).intValue();
      }
      
      brick.textureImage.updatePixels();
    }*/
   
    return brick;
  }
}
