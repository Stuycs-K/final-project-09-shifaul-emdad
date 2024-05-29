char[] leftAlphabet = "HXUCZVAMDSLKPEFJRIGTWOBNYQ".toCharArray();
char[] rightAlphabet = "PTLNBQDEOYSFAVZKGJRIHWXUMC".toCharArray();
String message = "HELLO";  // Example message
String encryptedMessage = "";
int step = 0;

void setup() {
    size(800, 600); 
    textSize(16);
}

void draw() {
    background(255);
    drawAlphabets(leftAlphabet, rightAlphabet);
    fill(0);
    text("Message: " + message, 50, 500);
    text("Encrypted Message: " + encryptedMessage, 50, 530);
    text("Step: " + step, 50, 560);
    drawButtons();
}

void drawAlphabets(char[] leftAlphabet, char[] rightAlphabet) {
    fill(0);
    text("Left Alphabet", 50, 30);
    text("Right Alphabet", 400, 30);
    for (int i = 0; i < leftAlphabet.length; i++) {
        text(leftAlphabet[i], 50, 60 + i * 20); // Draw left alphabet
        text(rightAlphabet[i], 400, 60 + i * 20); // Draw right alphabet
    }
}

void drawButtons() {
    fill(150);
    rect(50, 550, 100, 30);
    fill(0);
    text("Next Step", 60, 570);
}

void mousePressed() {
    if (mouseX > 50 && mouseX < 150 && mouseY > 550 && mouseY < 580) {
        if (step < message.length()) {
            char encryptedChar = processNextStep(message.charAt(step), leftAlphabet, rightAlphabet);
            encryptedMessage += encryptedChar;
            step++;
        }
    }
}

char processNextStep(char currentChar, char[] leftAlphabet, char[] rightAlphabet) {
    int position = findPosition(leftAlphabet, currentChar);
    if (position != -1) {
        char encryptedChar = rightAlphabet[position];
        permuteAlphabets(leftAlphabet, rightAlphabet, position);
        return encryptedChar;
    }
    return currentChar; // If character not found, return it as is
}

int findPosition(char[] alphabet, char character) {
    for (int i = 0; i < alphabet.length; i++) {
        if (alphabet[i] == character) {
            return i;
        }
    }
    return -1; // character not found
}

void permuteAlphabets(char[] leftAlphabet, char[] rightAlphabet, int position) {
    // Rotate the left alphabet based on the position
    rotateArray(leftAlphabet, position + 1);
    // Rotate the right alphabet based on the position
    rotateArray(rightAlphabet, position);

    // Move the left character at (position + 1) to the end and rotate the rest
    moveCharAndRotate(leftAlphabet, position + 1);
    // Move the right character at (position) to the end and rotate the rest
    moveCharAndRotate(rightAlphabet, position);
}

void rotateArray(char[] array, int positions) {
    for (int i = 0; i < positions; i++) {
        char first = array[0];
        System.arraycopy(array, 1, array, 0, array.length - 1);
        array[array.length - 1] = first;
    }
}

void moveCharAndRotate(char[] array, int position) {
    char temp = array[position];
    System.arraycopy(array, position + 1, array, position, array.length - position - 1);
    array[array.length - 1] = temp;
}
