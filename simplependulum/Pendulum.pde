
class Pendulum{
  
  int len;
  int mass;
  
  
  float angle;
  float vAngle = 0;
  float aAngle = 0;
  
  Pendulum(int ilen, int imass){
    len = ilen * 100;
    mass = imass;
    angle = PI/4;
  }
  
  void drawPendulum(PVector base){
    PVector arm = PVector.fromAngle(angle+PI/2).mult(len);
    PVector pos = PVector.add(arm, base);
    
    line(base.x, base.y, pos.x, pos.y);
    fill(255, 0, 0);
    circle(pos.x, pos.y, 50);
  }
  
  void movePendulum(){
    vAngle += aAngle;
    angle += vAngle;
  }
  
  void simulatePendulum(){
    
    //find force of grav
    float gravForce = mass * 9.8;
    //find magnitude of force perpendicular to arm
    float penForce = gravForce * sin(angle);
    //calculate radial acceleration
    float radAcc = penForce/mass;
    //convert to rad/frame & adjust direction
    aAngle = (float) ( Math.sqrt( abs(radAcc/(len/100)) ) )/60;
    if(radAcc != 0) {
      aAngle = aAngle * -(radAcc/abs(radAcc));
    } else {
      aAngle = 0;
    }
    
    movePendulum();
  }
  
  
}
