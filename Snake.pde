import java.util.*;

ArrayList<Integer> xpos = new ArrayList<Integer>(),ypos = new ArrayList<Integer>();

int dir=2;
int frameIncrementer=10;
int[]dx = {0,0,1,-1,0}, dy={1,-1,0,0,0}; // Down Up Right Left
int score=0;
int highscore=0;
int foodX, foodY;
boolean rasp=false;
int safe=1;
Random rand= new Random();
PImage apple,raspberry;
void init(){
  xpos.add(5);
  ypos.add(5);
  initFood();
}

void initFood(){
   safe=1;
   int chance = rand.nextInt(100);
   if(chance<=4){
     rasp=true;
   }else{
     rasp=false;
   }
   while(safe==1){
    foodX=rand.nextInt(30);
    foodY=rand.nextInt(30);
    int k=0;
    for(int i=0;i<xpos.size();i++){
      if(xpos.get(i) == foodX && ypos.get(i) == foodY){
         k=1;
      }
    }
    if(k != 1) safe=0;
  }
}
int time=millis();
void del(int t){
  int temp_time = millis();
  while(millis() - temp_time <= t);
}
void setup(){
  size(600,600);
  xpos.add(5);
  ypos.add(5);
  apple = loadImage("apple.png");
  raspberry=loadImage("raspberry.png");
  initFood();

}
boolean dead=false;

void draw(){
  if(!dead){

    background(255);
    if(rasp) image(raspberry,foodX*20,foodY*20,20,20);
    else image(apple,foodX*20,foodY*20,20,20);
    fill(255,0,0);
    fill(0);
    fill(0,0,255);
    for(int i=0;i<xpos.size();i++){
      rect(xpos.get(i)*20,ypos.get(i)*20,20,20);
    }
    fill(0);
    textSize(12);
    text("Score: ",17,height-16);
    text(score,55,height-16);
    
    if(millis()>time+100){
      xpos.add(0,xpos.get(0)+dx[dir]);
      ypos.add(0,ypos.get(0)+dy[dir]);
      if(xpos.get(0) == foodX && ypos.get(0) == foodY){
            score+=5;
            if(rasp) score+=15;
            initFood();
      }else{
          xpos.remove(xpos.size()-1);
          ypos.remove(ypos.size()-1);
      }
      time=millis();
    }
    
    if(xpos.get(0)>=30 || xpos.get(0)<0 || ypos.get(0)<0 || ypos.get(0)>=31){
      dead=true;
      if(highscore<score) highscore=score;
      score=0;
      xpos.clear();
      ypos.clear();
      fill(0);
      textSize(32);
      textAlign(CENTER);
      text("You died. Press space to restart", 300, 300);
      text("Highscore:",300,340);
      text(highscore,300,380);
      println("You died");
    }else{
      for(int i=1;i<xpos.size();i++){
        if(xpos.get(i) == xpos.get(0) && ypos.get(i) == ypos.get(0)){
          if(highscore<score) highscore=score;
          score=0;
          dead=true;
          xpos.clear();
          ypos.clear();
          fill(0);
          textSize(32);
          textAlign(CENTER);
          text("You died. Press space to restart", 300, 300);
          text("Highscore:",300,340);
          text(highscore,300,380);
          println("You died");
        }
      }
    }
  }
}
void keyPressed(){
    if(key == CODED){
    if((keyCode == LEFT) && dir != 2) {dir=3;} // Left
    else if((keyCode == RIGHT) && dir != 3) {dir=2;} // Right
    else if((keyCode == UP) && dir != 0) {dir=1;} // Right
    else if((keyCode == DOWN) && dir != 1) {dir=0;} // Right
    }else if(key == ' ' && dead){
    init();
    dir=2;              
    dead=false;
  }
}

//Framecount
/*
    if(frameCount%(frameIncrementer-(score/100)) == 0 && dead==false){
      xpos.add(0,xpos.get(0)+dx[dir]);
      ypos.add(0,ypos.get(0)+dy[dir]);
      if(xpos.get(0) == foodX && ypos.get(0) == foodY){
            score+=5;
            if(rasp) score+=15;
            initFood();
      }else{
          xpos.remove(xpos.size()-1);
          ypos.remove(ypos.size()-1);
      }
    }
    */
