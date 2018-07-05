class Polygon extends Brick {

  Polygon(int _id) {
    type = POLYGON;
    id = _id;
  }

  @ Override
  void run(Ball ball) {   
    isColliding = isCollidingWithBall(ball);
    
    if (isColliding) {
      return;
    }
    
    if (textureImage != null) {
      PVector min = new PVector(vertices.get(0).x, vertices.get(0).y);
      
      for (int i = 1; i < vertices.size(); i++) {
        min.x = min(min.x, vertices.get(i).x);
        min.y = min(min.y, vertices.get(i).y);
      }
      
      noStroke();
      textureWrap(REPEAT);
      beginShape();
      
      texture(textureImage);
      
      for (PVector v : vertices) {
        vertex(v.x, v.y, v.x - min.x, v.y - min.y);
      }
        
      endShape();
    }
    else {
      noStroke();    
      beginShape();
      fill(colorCode);
      
      for (PVector v : vertices) {
        vertex(v.x, v.y);
      }
  
      endShape();
    }
  }

  @ Override
  boolean isCollidingWithBall(Ball ball) {
    
    float radiusSquared = ball.diameter / 2 * ballDiameter / 2;

    PVector vertex = vertices.get(vertices.size() - 1);
    PVector circleCenter = ball.position;

    float nearestDistance = 3.40282347E+38;
    boolean nearestIsInside = false;
    int nearestVertex = -1;
    boolean lastIsInside = false;

    for (int i = 0; i < vertices.size(); i++)
    {
      PVector nextVertex = vertices.get(i);

      PVector axis = PVector.sub(circleCenter, vertex);

      float distance = axis.magSq() - radiusSquared;

      if (distance <= 0)
      {
        return true;
      }

      boolean isInside = false;

      PVector edge = PVector.sub(nextVertex, vertex);

      float edgeLengthSquared = edge.magSq();

      if (edgeLengthSquared != 0)
      {
        float dot = edge.dot(axis);

        if (dot >= 0 && dot <= edgeLengthSquared)
        {
          PVector projection = PVector.add(vertex, PVector.mult(edge, dot / edgeLengthSquared));

          axis = PVector.sub(projection, circleCenter);

          if (axis.magSq() <= radiusSquared)
          {
            return true;
          }
          else
          {
            if (edge.x > 0)
            {
              if (axis.y > 0)
              {
                return false;
              }
          }
          else if (edge.x < 0)
          {
            if (axis.y < 0)
            {
              return false;
            }
          }
          else if (edge.y > 0)
          {
            if (axis.x < 0)
            {
              return false;
            }
          }
          else
          {
            if (axis.x > 0)
            {
              return false;
            }
          }

          isInside = true;
        }
      }
    }

    if (distance < nearestDistance)
    {
      nearestDistance = distance;
      nearestIsInside = isInside || lastIsInside;
      nearestVertex = i;
    }

      vertex = nextVertex;
      lastIsInside = isInside;
    }

    if (nearestVertex == 0)
    {
      return nearestIsInside || lastIsInside;
    }
    else
    {
      return nearestIsInside;
    }
  }
}