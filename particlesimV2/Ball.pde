
class Ball{
  PVector pos;
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  
  int rad;
  float area;
  
  Ball(PVector ipos, int irad){
    pos = ipos;
    rad = irad;
    
    area = PI * (rad * rad);
  }
  
  Ball(){
    this(new PVector(random(200, 800), random(200, 800)), (int) random(30, 30));
    vel = new PVector(random(-10, 10), random(-5, 5));
  }
  
  void drawBall(){
   fill(255, 0, 0);
   circle(pos.x, pos.y, rad*2); 
  }
  
  boolean isCollide(Ball ball){
    if( PVector.dist(pos, ball.pos) <= (rad + ball.rad)){
      return true;
    }
    return false;
  }
  
  boolean isWall(){
    if ((pos.x + rad > 1000) || (pos.x - rad < 0) || (pos.y + rad > 900) || (pos.y - rad < 0)){
      return true;
    }
    return false;
  }
  
  void move(){
    print(acc);
    vel.add(acc);
    pos.add(vel);
    
    vel.mult(0.99);
    acc.mult(0);
  }
  
  void wallHit(){
    float slowFactor = 0.9;
    if (pos.x + rad > 1000){
      pos.x = 1000 - rad;
      vel.x = -vel.x;
      vel.mult(slowFactor);
    } else if (pos.x - rad < 0){
      pos.x = rad;
      vel.x = -vel.x;
      vel.mult(slowFactor);
    }
    if (pos.y + rad > 900){
      pos.y = 900 - rad;
      vel.y = -vel.y;
      vel.mult(slowFactor);
    } else if (pos.y - rad < 0){
      pos.y = rad;
      vel.y = -vel.y;
      vel.mult(slowFactor);
    }
  }
  
  void applyForce(PVector force){
    acc.add(PVector.div(force, area));
  }
  
  PVector findNormal(){
    //finds force req to stop ball
    return PVector.mult(acc, -1);
  }
  
  //void collision(Ball ball){
  //  if (isCollide(ball)){
      
  //    //find line of collision
  //    PVector collisionLine = PVector.sub(this.pos, ball.pos);
      
  //    //set positions
  //    float posDifference = rad + ball.rad - PVector.dist(this.pos, ball.pos);
  //    pos.add(collisionLine.setMag(posDifference));
      
  //    //swap for perpendicular vector
  //    collisionLine.normalize();
  //    PVector collisionNormal = new PVector(collisionLine.y, collisionLine.x);
      
  //    vel = PVector.sub(vel, PVector.mult(collisionNormal, PVector.dot(vel, collisionNormal)));
  //    ball.vel = PVector.sub(ball.vel, PVector.mult(collisionNormal, PVector.dot(ball.vel, collisionNormal))).mult(-1);
      
  //    //set velocity to correct mag
  //    vel.setMag( ((area-ball.area)/(area+ball.area)) * vel.mag() + ((2*ball.area)/(area+ball.area)) * ball.vel.mag() );
  //    ball.vel.setMag( ((2*area)/(area+ball.area)) * vel.mag() + ((ball.area-area)/(area+ball.area)) * ball.vel.mag() );
      
  //    //add positions (to not "collide" twice)
  //    pos.add(vel);
  //    ball.pos.add(ball.vel);
      
  //  }
    
  //}
  
  void collision(Ball ball){
    if (isCollide(ball)){
      
      //find line of collision
      PVector collisionLine = PVector.sub(this.pos, ball.pos);
      
      //set positions
      float posDifference = rad + ball.rad - PVector.dist(this.pos, ball.pos);
      pos.add(collisionLine.setMag(posDifference));
      
      //swap for perpendicular vector
      collisionLine.normalize();
      PVector collisionNormal = new PVector(collisionLine.y, collisionLine.x);

      //project vectors onto collisionLine and normalLine
      PVector thisNormalComponent = PVector.mult(collisionNormal, (PVector.dot(vel, collisionNormal) / PVector.dot(vel, vel)));
      PVector thisOrthoComponent = PVector.sub(vel, thisNormalComponent);
      
      PVector ballNormalComponent = PVector.mult(collisionNormal, (PVector.dot(ball.vel, collisionNormal) / PVector.dot(ball.vel, ball.vel)));
      PVector ballOrthoComponent = PVector.sub(ball.vel, ballNormalComponent);
      
      //add vectors for new velocities
      vel = PVector.add(thisNormalComponent, ballOrthoComponent);
      ball.vel = PVector.add(ballNormalComponent, thisOrthoComponent);
      
      //add positions (to not "collide" twice)
      pos.add(vel);
      ball.pos.add(ball.vel);
      
    }
    
  }
  
 
  
}
