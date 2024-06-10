// Function to draw disks representing alphabets
void drawDisks(String leftAlphabet, String rightAlphabet, int matchIndex, float centerY) {
  float diskRadius = 100;
  float centerX = width / 2;
 
  drawDisk(rightAlphabet, centerX - 150, centerY, diskRadius, matchIndex, false); // Right disk on left
  drawDisk(leftAlphabet, centerX + 150, centerY, diskRadius, matchIndex, true); // Left disk on right
}

// Function to draw individual disks
void drawDisk(String alphabet, float centerX, float centerY, float radius, int matchIndex, boolean isLeft) {
  fill(200);
  ellipse(centerX, centerY, radius * 2, radius * 2);
 
  // Display top and bottom indicators
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(12);
  text("zenith", centerX, centerY - radius - 10); // Top indicator (zenith)
  text("nadir", centerX, centerY + radius + 10); // Bottom indicator (nadir)
  textSize(16);
 
  // Display letters around the disk
  for (int i = 0; i < alphabet.length(); i++) {
    float angle = TWO_PI / alphabet.length() * i - HALF_PI; // Adjusting angle to start from top
    float x = centerX + cos(angle) * (radius - 20);
    float y = centerY + sin(angle) * (radius - 20);
    pushMatrix();
    translate(x, y);
    rotate(angle + HALF_PI);
    if (isLeft) {
      if (i == matchIndex) {
        fill(255, 0, 0); // Red for the matching left letter
      } else {
        fill(0);
      }
      text(alphabet.charAt(i), 0, 0); // Display left alphabet normally
    } else {
      if (i == (26 - matchIndex)) {
        fill(0, 0, 255); // Blue for the matching right letter counting backwards
      } else {
        fill(0);
      }
      text(alphabet.charAt((26 - i) % 26), 0, 0); // Display right alphabet in reverse with 'A' at the top
    }
    popMatrix();
  }
}

// Function to find index of a character in an array
int indexOf(char[] a, char c) {
  for (int i = 0; i < a.length; ++i) {
    if (a[i] == c) {
      return i;
    }
  }
  return -1;
}

// Function to perform decryption
String exec(String text, boolean isDecrypt) {
  char[] left = L_ALPHABET.toCharArray();
  char[] right = R_ALPHABET.toCharArray();
  char[] dText = new char[text.length()];
  char[] temp = new char[26];
 
  for (int i = 0; i < text.length(); ++i) {
    int index = 0; // Initialize index here
    if (!isDecrypt) {
      index = indexOf(left, text.charAt(i));
      dText[i] = right[index];
    }
   
    states.add(new State(text.charAt(i), new String(left), new String(right), isDecrypt, index));
   
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
 
  return new String(dText);
}
