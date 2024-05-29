char[] leftAlphabet = "ABCDEFGHIJKLMNXPQRSTUVWXYZ".toCharArray();
char[] rightAlphabet = "NMLKJIHGFEDCBAXYZQRSTUVWOPQ".toCharArray();

int findPosition(char[] alphabet, char character) {
    for (int i = 0; i < alphabet.length; i++) {
        if (alphabet[i] == character) {
            return i;
        }
    }
    return -1; // character not found
}
