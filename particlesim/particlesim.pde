import java.util.*;

List<Ball> balls = new ArrayList();

void setup(){
  size(1000, 1000);
  
  for (int i=0; i<10; i++){
    balls.add(new Ball());
  }
}


void draw(){
  background(0);
  
  for(Ball ball : balls){
    ball.drawBall();
    ball.applyForce(new PVector(0, 9.8));
    ball.wallHit();
    for(int i=0; i<balls.size(); i++){
      if(balls.get(i) != ball){
        ball.collision(balls.get(i));
      }
    }
    ball.move();
  }
  //for(int i=0; i<balls.size()-1; i++){
  //  for(int j=i+1; j<balls.size(); j++){
  //    balls.get(i).collision(balls.get(j));
  //  }
  //}
  
  
}
