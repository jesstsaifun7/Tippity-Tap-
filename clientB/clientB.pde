import websockets.*;

WebsocketClient wsc;

import controlP5.*;

ControlP5 cp5;
Textfield myTextfield;

String roomId="roomId";
int mode = 0;
String stage1CharList="ENITRLSAU";
String stage2CharList="ODYCHGMPB";
String stage3CharList="KVWFZXQJ";
int roleId = 0; // create  1  join 2
String myText = "";
String myQ = "";

int role1Score = 0;
int role2Score = 0;



public void RoomId(String theValue) {
  println("### got an event from RoomId : "+theValue);
}


void setup() {
  surface.setLocation(1100, 10);

  cp5 = new ControlP5(this);

  size(1024, 768);
  myTextfield = cp5.addTextfield("", width/2, height/2+100, 100, 20);
  myTextfield.setAutoClear(false);
  myTextfield.setSize(300, 40);
  PFont font = createFont("arial", 30);
  myTextfield.setFont(font);
  myTextfield.hide();
  myTextfield.setFocus(true);
  
  myTextfield.setPosition(390,450);
  myTextfield.setColorBackground(#888888);
  myTextfield.setColorValue(#ececec); //font color
  myTextfield.setColorForeground(#888888);
  myTextfield.setColorActive(#888888);


  //wsc= new WebsocketClient(this, "ws://localhost:8425/group4");
  wsc= new WebsocketClient(this, "ws://172.105.226.140:8425/group4");

  fill(30);
}

int r = 0;

void draw() {
  background(250);
  if (mode == 0) {
     text("Tippity-Tap!", 400, 300, width/2, height/2);
    text("Press D to Enter Game Description ", 250, 400, width/2, height/2);
    text("Press S to Start Game", 350, 500, width/2, height/2+50);
    textSize(30);
    fill(30);
  } 
  if (mode == 1) {
    textSize(25);
    text("Descriptions", 450, 80, width/2, height/2);
    text("For every game, there are two parts.", 70, 150, width, height/2);
    text("First part:", 70, 200, width, height/2);
    text("Make the challenge for your opponent by typing assigned characters ", 70, 250, width, height/2);
    text("as fast as you can.", 70, 300, width, height/2);

    text("*If you type the characters that are not assigned, they would not show up.", 70, 350, width, height/2);
    text("Second part:", 70, 420, width, height/2);
    text("Type according to the challenge your opponent made for you.", 70, 470, width, height/2);
    text("For every game, there are two parts.", 70, 520, width, height/2);

    text("Press S to Start Game", 400, 580, width/2, height/2);
  }

  if (mode == 2) {
    text("Press A to Build a Room", 350, 300, width/2, height/2);
    text("Press W to Enter Room Number", 300, 400, width/2, height/2+50);
  };

  if (mode == 3) { // run 
    text(""+r,500,300, width/2, height/2);
    text("Waiting for Your Opponent...",350,400, width/2, height/2+50);
  };

  //boolean inputMode4 = false;
  if (mode == 4) {
    //text("Press A to Build a Room", 350, 100, width/2, height/2);
    text("Type the Room Number and Press Enter", 250, 350, width, height/2+50); //width/2
    textSize(30);
    myTextfield.show();
    myTextfield.setFocus(true);
    
  }
  if (mode ==5) {
    if (millis()-countdownTimer > 1000) {
      countdownTimer=millis();
      countdown -- ;
    }
    if (countdown==0) {
      mode = 6;
      countdownTimer=millis();
      countdown =15;
    }
    text(countdown, width/2, 200);

    text("Please Type Below Characters", 315, 50, width/2, height/2);
    text("ENITRLSAU", 440, 120, width/2, height/2);
    //text(stage1CharList, 250, 200, width/2, height/2+50);
  }
  if (mode ==6) {
    if (millis()-countdownTimer > 1000) {
      countdownTimer=millis();
      countdown -- ;
    }
    if (countdown==0) {
      sendToServer("myText", myText);
      countdownTimer=millis();
      countdown = 3;
      mode = 7;
      myText = "";
    }

    text(countdown, width/2, 200);

    text("Please Type Below Characters", 315, 50, width/2, height/2);
    text("ENITRLSAU", 440, 120, width/2, height/2);
    //text(stage1CharList, 250, 200, width/2, height/2+50);

    noFill();
    rect(200, 230, 680, 500);
    text(showText(myText), 220, 270);
  }
  if (mode ==7) {
    if (millis()-countdownTimer > 1000) {
      countdownTimer=millis();
      countdown -- ;
    }
    if (countdown==0) {
      countdownTimer=millis();
      countdown =15;
      mode = 8;
    }
    text(countdown, width/2, 200);

    text("please type QQQ  Characters", 315, 50, width/2, height/2);
    text(stage1CharList, 440, 120, width/2, height/2+50);
  }

  if (mode == 8) {  
    if (millis()-countdownTimer > 1000) {
      countdownTimer=millis();
      countdown -- ;
    }
    if (countdown==0) {
      int myScore =  (myText.length()*100 / myQ.length()*100)/100 ;
      sendToServer("myScore", str(myScore));

      countdownTimer=millis();
      countdown = 3;
      mode = 9;
      myText = "";
    }
    text(countdown, width/2, 200);
    text("please type below Characters", 315, 100, width/2, height/2);
    text(showQQQ(myQ), 200, 250, width/1.5, height/2+50);
    noFill();
    rect(200, 400, 680, 500);
    text(showText(myText), 230, 450);
  }

  if (mode == 9) {

    if (roleId==1) {
      text("Your score is "+role1Score, width/2, height/2-50);

      if (role1Score>=role2Score)
        text("WIN!!!", width/2, height/2);
      else
        text("Lose!!!", width/2, height/2);
    }

    if (roleId==2) {
      text("Your score is "+role2Score, width/2, height/2-50);
      if (role1Score < role2Score)
        text("WIN!!!", width/2, height/2);
      else
        text("Lose!!!", width/2, height/2);
    }
    text("Press X return to begin!", width/2, height/2+50);
  }


  //text("B mode:"+mode, 10, 60);
  //text("role:"+roleId, 10, 120);
  //text("roomId:"+roomId, 10, 180);

  //text("role1Score:"+role1Score, 10, 240);
  //text("role2Score:"+role2Score, 10, 300);
}

String showText(String mTxt) {
  String newTxt = "";
  for (int i = 1; i<=mTxt.length(); i++) {
    newTxt += mTxt.charAt(i-1);
    if (i%30 ==0) {
      newTxt +="\n";
    }
  }
  return newTxt;
} 


String showQQQ(String mTxt) {
  String newTxt = "";
  for (int i = 1; i<=mTxt.length(); i++) {
    newTxt += mTxt.charAt(i-1);
    if (i%100 ==0) {
      newTxt +="\n";
    }
  }
  return newTxt;
} 
