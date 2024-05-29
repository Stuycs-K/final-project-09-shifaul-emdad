char[] leftAlphabet = "HXUCZVAMDSLKPEFJRIGTWOBNYQ".toCharArray();
char[] rightAlphabet = "PTLNBQDEOYSFAVZKGJRIHWXUMC".toCharArray();
String message = "HELLO";  // Example message
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
    text("Step: " + step, 50, 530);
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
            processNextStep(message.charAt(step), leftAlphabet, rightAlphabet);
            step++;
        }
    }
}

void processNextStep(char currentChar, char[] leftAlphabet, char[] rightAlphabet) {
    int position = findPosition(leftAlphabet, currentChar);
    if (position != -1) {
        permuteAlphabets(leftAlphabet, rightAlphabet);
    }
}

int findPosition(char[] alphabet, char character) {
    for (int i = 0; i < alphabet.length; i++) {
        if (alphabet[i] == character) {
            return i;
        }
    }
    return -1; // character not found
}

void permuteAlphabets(char[] leftAlphabet, char[] rightAlphabet) {
    // Permute the left alphabet
    char firstLeft = leftAlphabet[0];
    System.arraycopy(leftAlphabet, 1, leftAlphabet, 0, leftAlphabet.length - 1);
    leftAlphabet[leftAlphabet.length - 1] = firstLeft;
    char tempLeft = leftAlphabet[1];
    System.arraycopy(leftAlphabet, 2, leftAlphabet, 1, 12);
    leftAlphabet[13] = tempLeft;

    // Permute the right alphabet
    char firstRight = rightAlphabet[0];
    System.arraycopy(rightAlphabet, 1, rightAlphabet, 0, rightAlphabet.length - 1);
    rightAlphabet[rightAlphabet.length - 1] = firstRight;
    char tempRight = rightAlphabet[1];
    System.arraycopy(rightAlphabet, 2, rightAlphabet, 1, 12);
    rightAlphabet[13] = tempRight;
}
