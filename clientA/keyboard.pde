
void keyPressed() {
  println(key);
  //if (keyCode == 68){
  //  mode = 1;
  //  println(keyCode);
  //}
  //else if(keyCode == 83){
  //  mode = 2;
  //}

  switch(mode) {
  case 0:
    if (keyCode == 68) //d=68
      mode = 1;
    if (keyCode == 83) //s=83
      mode = 2;
    break;

  case 1:
    mode = 2;
    break;

  case 2:
    if (keyCode == 65) { //a=65 
      //createRoom;
      mode = 3;
      r = int(random(10000, 99999));
      roomId = str(r);  // ""+int
      println(r);
      roleId=1;
    }
    if (keyCode == 87) //w=65 join room
    {
      roleId =2;
      mode = 4;
    }
    break;

  case 3:
    break;
  case 4:
    if (keyCode == 10) {
      roomId = myTextfield.getText() ;
      sendToServer("action", "role2join");
    }
    break;
  case 6:
    String mInput="";
    mInput += key;
    mInput = mInput.toUpperCase();
    if (stage1CharList.indexOf(mInput)>-1) {
      myText+=mInput;
    }

    break;
  case 8:
    if (myText.length()==myQ.length())break;

    String newInput="";
    //myQ.charAt(myText.length())
    newInput += key;

    newInput = newInput.toUpperCase();
    //"abc"
    //"ab"
    if (newInput.charAt(0)==myQ.charAt(myText.length())) {
      myText += newInput;
    }
    break;
  case 9:
    if (key =='x' || key =='X') {
      mode =0;
    }
    break;
  };
};
