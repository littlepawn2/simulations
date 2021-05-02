import java.util.*;

Pendulum pendulum = new Pendulum(1, 3);
Pendulum pendulum2 = new Pendulum(4, 3);
PVector base = new PVector(400, 100);


void setup(){
  size(800, 600);
  
  stroke(255);
  strokeWeight(3);
  
  
}



void draw(){
  background(0);
  
  pendulum.drawPendulum(base);
  pendulum.simulatePendulum();
  
  pendulum2.drawPendulum(base);
  pendulum2.simulatePendulum();
  
  
}
