// Define the alphabets and ciphertext
String L_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String R_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String cipherText = "HDJHI"; // Encrypted version of "HELLO"

// Variables to store the plaintext and decryption states
String decryptedText = "";
ArrayList<State> states = new ArrayList<State>();
int currentStateIndex = 0;

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);
  textSize(16);
 
  // Decrypt the ciphertext
  decryptedText = exec(cipherText, false);
 
  noLoop();
}

void draw() {
  background(255);
 
  // Display ciphertext
  fill(0);
  text("Ciphertext: " + cipherText, width / 2, 50);
 
  // Display current decryption progress
  if (currentStateIndex < cipherText.length()) {
    text("Current decryption: " + decryptedText.substring(0, currentStateIndex + 1), width / 2, 100);
  }
  // Otherwise, display full decrypted text
  else {
    text("Decrypted text: " + decryptedText, width / 2, 100);
  }
 
  // If current state index is less than the size of decryption states, continue displaying decryption process
  if (currentStateIndex < states.size()) {
    State s = states.get(currentStateIndex);
    text("Decrypting letter: " + s.letter, width / 2, 200);
    drawDisks(s.left, s.right, s.matchIndex, 300);
  }
  // Otherwise, display completion message
  else {
    text("JOB DONE", width / 2, 200);
  }
}
