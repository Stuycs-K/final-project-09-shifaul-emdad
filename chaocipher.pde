// Define the alphabets and plaintext
String L_ALPHABET = "ABCDEFGHIJKLMNOPQURSTUVWXYZ";
String R_ALPHABET = "ABCDEFGHIJKLMNOPQURSTUVWXYZ";
String plainText = "HELLO";

// Variables to store the ciphertext, recovered text, and encryption states
String cipherText = "";
String recoveredText = "";
ArrayList<State> states = new ArrayList<State>();
int currentStateIndex = 0;

// State class to represent the encryption states
class State {
  char letter;
  String left;
  String right;
  boolean isEncrypt;
  int matchIndex;
  
  // Constructor
  State(char letter, String left, String right, boolean isEncrypt, int matchIndex) {
    this.letter = letter;
    this.left = left;
    this.right = right;
    this.isEncrypt = isEncrypt;
    this.matchIndex = matchIndex;
  }
}

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);
  textSize(16);
  
  // Encrypt the plaintext and recover the ciphertext
  cipherText = exec(plainText, true);
  recoveredText = exec(cipherText, false);
  
  noLoop();
}

void draw() {
  background(255);
  
  // Display original plaintext
  fill(0);
  text("Original Plaintext: " + plainText, width / 2, 50);
  
  // If current state index is less than plaintext length, display current ciphertext and plaintext
  if (currentStateIndex < plainText.length()) {
    text("Current Ciphertext: " + cipherText.substring(0, currentStateIndex), width / 2, 100);
    text("Current Plaintext: " + recoveredText.substring(0, currentStateIndex), width / 2, 150);
  } 
  // Otherwise, display full ciphertext and recovered plaintext
  else {
    text("Ciphertext: " + cipherText, width / 2, 100);
    text("Recovered Plaintext: " + recoveredText, width / 2, 150);
  }
  
  // If current state index is less than the size of encryption states, continue displaying encryption process
  if (currentStateIndex < states.size()) {
    State s = states.get(currentStateIndex);
    text(s.isEncrypt ? "Encrypting letter: " + s.letter : "Decrypting letter: " + s.letter, width / 2, 200);
    drawDisks(s.left, s.right, s.matchIndex, 300);
  } 
  // Otherwise, display completion message
  else {
    text("JOB DONE", width / 2,200);
  }
}

// Function to draw disks representing alphabets
void drawDisks(String leftAlphabet, String rightAlphabet, int matchIndex, float centerY) {
  float diskRadius = 100;
  float centerX = width / 2;
  
  drawDisk(leftAlphabet, centerX - 150, centerY, diskRadius, matchIndex, true);
  drawDisk(rightAlphabet, centerX + 150, centerY, diskRadius, matchIndex, false);
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
    if (isLeft && i == matchIndex) {
      fill(255, 0, 0); // Red for the matching left letter
    } else if (!isLeft && i == matchIndex) {
      fill(0, 0, 255); // Blue for the matching right letter
    } else {
      fill(0);
    }
    text(alphabet.charAt(i), 0, 0);
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

// Function to perform encryption/decryption
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
    
    states.add(new State(text.charAt(i), new String(left), new String(right), isEncrypt, index));
    
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

// Function to proceed to the next state on mouse click
void mousePressed() {
  if (currentStateIndex < states.size()) {
    currentStateIndex++;
    redraw();
  }
}
