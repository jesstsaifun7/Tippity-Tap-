class TextBox{
    TextBox(int x, int y, int boxWidth, int boxHeight){
        this.x = x;
        this.y = y;
        this.boxWidth = boxWidth;
        this.boxHeight = boxHeight;
    }


    void draw(){
        drawBox();
        drawText();
        getUserInput();
    }


    void drawBox(){
        stroke(205);
        fill(205);
        rect(x, y, boxWidth, boxHeight);
    }

    void drawText(){
        textAlign(LEFT, CENTER);
        textSize(30);
        fill(30);
        text(textValue + getCursor(), x + 5, y + boxHeight/2);
    }

    void getUserInput(){
        if(!keyPressed){
            keyReleased = true;
            keyCounter = 0;
            previousKeyCounter = 0;
        }
        if (keyPressed && c != key){
            keyCounter = millis();

            c = key;

            if (c == BACKSPACE) textValue = "";
            else if (c >= ' ') textValue += str(c);
            if (textValue.length() > textLimit) textValue = "";

            previousKeyCounter = keyCounter;
            keyReleased = false;
        }

    }

    String getCursor() {
      return hovering() && (frameCount>>4 & 1) == 0 ? "|" : "";
    }

    boolean hovering(){
        return mouseX >= x && mouseX <= x + boxWidth && mouseY >= y && mouseY <= y + boxHeight;
    }

    private int x, y, boxWidth, boxHeight, textLimit = 40;
    private float currentValue, keyCounter, previousKeyCounter;
    private String textValue;
    private char keyInput, c;
    private boolean keyReleased;
}
