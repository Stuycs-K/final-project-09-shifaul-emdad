char[] leftAlphabet = "ABCDEFGHIJKLMNXPQRSTUVWXYZ".toCharArray();
char[] rightAlphabet = "NMLKJIHGFEDCBAXYZQRSTUVWOPQ".toCharArray();

void setup() {
    size(800, 600); // Set the window size
}

void draw() {
    background(255); // Clear the screen with a white background
    drawAlphabets(leftAlphabet, rightAlphabet);
}

void drawAlphabets(char[] leftAlphabet, char[] rightAlphabet) {
    textSize(16);
    fill(0);
    for (int i = 0; i < leftAlphabet.length; i++) {
        text(leftAlphabet[i], 50, 50 + i * 20); // Draw left 
        text(rightAlphabet[i], 150, 50 + i * 20); // Draw right 
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
    // Permutation logic here 
}

char encryptChar(char[] leftAlphabet, char[] rightAlphabet, char plainChar) {
    int position = findPosition(leftAlphabet, plainChar);
    char cipherChar = rightAlphabet[position];
    permuteAlphabets(leftAlphabet, rightAlphabet);
    return cipherChar;
}

char decryptChar(char[] leftAlphabet, char[] rightAlphabet, char cipherChar) {
    int position = findPosition(rightAlphabet, cipherChar);
    char plainChar = leftAlphabet[position];
    permuteAlphabets(leftAlphabet, rightAlphabet);
    return plainChar;
}
