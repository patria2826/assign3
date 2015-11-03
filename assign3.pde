int bgx, gamestate, life, gsec, enemystate;
float px, py, gx, gy, eX, eY;
PImage start1, start2, end1, end2, bg1, bg2, enemy, player, hp, gift;
final int GAMESTART=0, GAMEPLAY=1, GAMEWIN=2, GAMEOVER=3, eA=4, eB=5, eC=6;
boolean upPressed = false, downPressed = false, leftPressed = false, rightPressed = false;
void setup () {
  size(640, 480) ;
  background(255);
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  bg1 = loadImage("img/bg1.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  bg2 = loadImage("img/bg2.png");
  ///HP///
  hp = loadImage("img/hp.png");
  life = 70;
  ///ENEMY///
  enemy = loadImage("img/enemy.png");
  eX = -60;
  eY = floor(random(1,420)); 
  enemystate = eC;
  ///PLAYER///
  player = loadImage("img/fighter.png");
  px = 590;
  py = 240;
  ///GIFT///
  gift = loadImage("img/treasure.png");
  gx=floor(random(0,600)); 
  gy=floor(random(1,439)); 
  gamestate = GAMESTART;
}

void draw() {
  switch (gamestate) {
    //~~**GAMESTART**~~//
    case GAMESTART:
    image(start2,0,0);
    if(mousePressed) {
      gamestate = GAMEPLAY;}else {
        if(mouseX >= width/3 && mouseX <= 2*width/3 && mouseY >=380 && mouseY <=415) {
          image(start1,0,0);
        }
  }
  break;
    //~~**GAMEPLAY**~~//
    case GAMEPLAY:
    ///BACKGROUND///
    image(bg1, bgx, 0); image(bg2, bgx-640, 0); image(bg1, bgx-1280, 0);
    bgx += 1;
    bgx %= 1280;

    ///GIFT///
    image(gift, gx, gy);
    gsec++;
    if(gsec % 180 == 0) {
      gx=floor(random(0,600));
      gy=floor(random(0,440));
      
    }
    ///Enemy///
    switch(enemystate){
    case(eC):  
    int eCS = 0;
    for(eCS = 0; eCS < 5; eCS++) {
      image(enemy, eX-eCS*65, eY);
      eX++;
      if(eX >= 965) {
        enemystate = eB;
        eX = -60;
        eY = floor(random(1,155));
        }
        
    }
    break;
    case(eB):
    int eBS = 0;
    for(eBS = 0; eBS < 5; eBS++) {
      image(enemy, eX-eBS*65, eY+eBS*65);
      eX++;
      if(eY > 155) {eY = 150;}
      if(eX >= 965) {
      enemystate = eA;
      eX = -60;
      eY =floor(random(125,285));
      }
    }
    break;
    case(eA):
    int eAS = 0;
    for(eAS = 0; eAS < 5; eAS++) {
      if(eY < 120) {eY = 125;}
      if(eY > 290) {eY = 285;}
      if(eAS == 0) {image(enemy, eX, eY);}
      if(eAS == 1) {image(enemy, eX-65, eY+60); image(enemy, eX-65, eY-60);}
      if(eAS == 2) {image(enemy, eX-130, eY+120); image(enemy, eX-130, eY-120);}
      if(eAS == 3) {image(enemy, eX-195, eY+60); image(enemy, eX-195, eY-60);}
      if(eAS == 4) {image(enemy, eX-260, eY);}
      eX++;
      if(eX >= 965) {
        enemystate = eC;
        eX = -60;
        eY = floor(random(1,420));
      
    }
    }
    break;
    }
   
    
    ///PLAYER///
    image(player, px, py);
    if(upPressed == true) { py -= 5; }
    if(downPressed == true) { py += 5; }
    if(leftPressed == true) { px -= 5; }
    if(rightPressed == true) { px += 5; }
    if(px <= 0) { px = 0; }; if(px >= 590) { px = 590; };
    if(py <= 0) { py = 0; }; if(py >= 430) { py = 430; };
 
      //GOT GIFT//
      if(px <= gx + 40 && px >= gx - 20 && py <= gy + 40 && py >= gy - 20) {
      image(gift, gx, gy);
      gx=floor(random(0,600));
      gy=floor(random(0,440));
      gsec = 0;
      gsec++;
      if(gsec % 180 == 0) {
      gx=floor(random(0,600));
      gy=floor(random(0,440));
    }
      life += 20;
      if(life > 220) {
        life = 220;
      }
    }
      /*//GOT HIT//
      if(px <= eX + 32 && px >= eX - 32 && py <= eY + 32 && py >= eY - 32) {
      image(enemy, eX, eY);
      eX = -50; 
      eX = floor(random(1,439));
      life -= 40;
      if(life < 30) {
        life = 30;
      }
    }*/
      
      //DEAD//
      if(life == 30) {
        gamestate = GAMEOVER;
        life = 70;
        eX = -50;
        eY = floor(random(1,430));
        px = 590;
        py = 240;
        gsec = 0;
        /*box=-60;*/
      }
      
        ///HP///
        colorMode(HSB,128,60,30);
        strokeWeight(20);
        stroke(180, 280, 30);
        line(30,32,life,32);
        image(hp, 20, 20);
    
      break;
      //~~**GAMEOVER**~~//
      case GAMEOVER:
      image(end2,0,0);
      if(mousePressed) {
      gamestate = GAMEPLAY;}else {
        if(mouseX >= width/3 && mouseX <= 2*width/3 && mouseY >=315 && mouseY <=350) {
          image(end1,0,0);
        }
  }
  break;
    
}
}
  void keyPressed() {
    if(key == CODED) {
      switch(keyCode) {
        case UP:
        upPressed = true;
        break;
        case DOWN:
        downPressed = true;
        break;
        case LEFT:
        leftPressed = true;
        break;
        case RIGHT:
        rightPressed = true;
        break;
      }
    }
  }
   void keyReleased() {
     if(key == CODED) {
      switch(keyCode) {
        case UP:
        upPressed = false;
        break;
        case DOWN:
        downPressed = false;
        break;
        case LEFT:
        leftPressed = false;
        break;
        case RIGHT:
        rightPressed = false;
        break;
      }
    }
   }
