String L_ALPHABET = "HXUCZVAMDSLKPEFJRIGTWOBNYQ";
String R_ALPHABET = "PTLNBQDEOYSFAVZKGJRIHWXUMC";
String plainText = "WHATISGOINGON";
String cipherText = "";
String recoveredText = "";

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);
  textSize(16);
  
  cipherText = exec(plainText, true);
  recoveredText = exec(cipherText, false);
  
  noLoop(); // Draw once
}

void draw() {
  background(255);
  
  fill(0);
  text("Original Plaintext: " + plainText, width / 2, 50);
  text("Ciphertext: " + cipherText, width / 2, 100);
  text("Recovered Plaintext: " + recoveredText, width / 2, 150);
  
  // Display the disks
  drawDisks(L_ALPHABET, R_ALPHABET);
}

void drawDisks(String leftAlphabet, String rightAlphabet) {
  float diskRadius = 200;
  float centerX = width / 2;
  float centerY = height / 2 + 100;
  
  drawDisk(leftAlphabet, centerX - 250, centerY, diskRadius);
  drawDisk(rightAlphabet, centerX + 250, centerY, diskRadius);
}

void drawDisk(String alphabet, float centerX, float centerY, float radius) {
  fill(200);
  ellipse(centerX, centerY, radius * 2, radius * 2);
  
  fill(0);
  for (int i = 0; i < alphabet.length(); i++) {
    float angle = TWO_PI / alphabet.length() * i;
    float x = centerX + cos(angle) * (radius - 20);
    float y = centerY + sin(angle) * (radius - 20);
    text(alphabet.charAt(i), x, y);
  }
}

int indexOf(char[] a, char c) {
  for (int i = 0; i < a.length; ++i) {
    if (a[i] == c) {
      return i;
    }
  }
  return -1;
}

String exec(String text, boolean isEncrypt) {
  char[] left = L_ALPHABET.toCharArray();
  char[] right = R_ALPHABET.toCharArray();
  char[] eText = new char[text.length()];
  char[] temp = new char[26];
  
  for (int i = 0; i < text.length(); ++i) {
    int index;
    if (isEncrypt) {
      index = indexOf(right, text.charAt(i));
      eText[i] = left[index];
    } else {
      index = indexOf(left, text.charAt(i));
      eText[i] = right[index];
    }
    if (i == text.length() - 1) {
      break;
    }
    
    // permute left
    for (int j = index; j < 26; j++) temp[j - index] = left[j];
    for (int j = 0; j < index; j++) temp[26 - index + j] = left[j];
    char store = temp[1];
    for (int j = 2; j < 14; j++) temp[j - 1] = temp[j];
    temp[13] = store;
    left = temp.clone();
    
    // permute right
    for (int j = index; j < 26; j++) temp[j - index] = right[j];
    for (int j = 0; j < index; j++) temp[26 - index + j] = right[j];
    store = temp[0];
    for (int j = 1; j < 26; j++) temp[j - 1] = temp[j];
    temp[25] = store;
    store = temp[2];
    for (int j = 3; j < 14; j++) temp[j - 1] = temp[j];
    temp[13] = store;
    right = temp.clone();
  }
  
  return new String(eText);
}
