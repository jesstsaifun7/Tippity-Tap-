// get server message

// role1, role2  a  creater , b joiner
int countdown = 3;
int countdownTimer = 0;

void webSocketEvent(String msg) {
  println("role1 get");
  println("from server:"+msg);
  printArray(msg.split(","));

  // my room id
  if (msg.indexOf("roomId:"+roomId)>-1) {


    // from server:roomId:38986,roleId:role1,type,myScore,data,100
    // from server:roomId:38986,roleId:role2,type,myScore,data,100
    //from server:roomId:46354,roleId:role2,type,myScore,data,9


    if (msg.indexOf("roleId:role1,type,myScore,data")>-1) {
      role1Score = parseInt(msg.split(",")[5]);
    }
    if (msg.indexOf("roleId:role2,type,myScore,data")>-1) {
      role2Score = parseInt(msg.split(",")[5]);
    }

    if (msg.indexOf("myText") >-1  &&  msg.indexOf("roleId:role2") >-1) {
      myQ = msg.split(",")[5];
      //countdownTimer=millis();
      //countdown = 3;
      println("role1 get:"+myQ);
      // from server:roomId:57392,roleId:role2,type,myText,data,NNNNNN
    }

    if (mode==3 && msg.indexOf("role2")>-1 && msg.indexOf("role2join")>-1) {
      mode = 5;
      sendToServer("action", "role2begin");
      countdown = 3;
      countdownTimer = millis();
    }
    if (mode==4 && msg.indexOf("role1")>-1 && msg.indexOf("role2begin")>-1) {
      mode = 5;
      countdown = 3;
      countdownTimer = millis();
    }
  }
}

void sendToServer(String type, String data) {
  wsc.sendMessage("roomId:"+roomId+",roleId:role"+roleId+",type,"+type+",data,"+data);
}
