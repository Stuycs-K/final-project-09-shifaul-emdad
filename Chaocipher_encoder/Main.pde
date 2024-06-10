// Define the alphabets and plaintext
String L_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String R_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String plainText = "HELLO";

// Variables to store the ciphertext and encryption states
String cipherText = "";
ArrayList<State> states = new ArrayList<State>();
int currentStateIndex = 0;

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);
  textSize(16);

  // Encrypt the plaintext
  cipherText = exec(plainText, true);

  noLoop();
}

void draw() {
  background(255);

  // Display original plaintext
  fill(0);
  text("Original Plaintext: " + plainText, width / 2, 50);

  // If current state index is less than plaintext length, display current ciphertext
  if (currentStateIndex < plainText.length()) {
    text("Current Ciphertext: " + cipherText.substring(0, currentStateIndex + 1), width / 2, 100);
  }
  // Otherwise, display full ciphertext
  else {
    text("Ciphertext: " + cipherText, width / 2, 100);
  }

  // If current state index is less than the size of encryption states, continue displaying encryption process
  if (currentStateIndex < states.size()) {
    State s = states.get(currentStateIndex);
    text("Encrypting letter: " + s.letter, width / 2, 200);
    drawDisks(s.left, s.right, s.matchIndex, 300);
  }
  // Otherwise, display completion message
  else {
    text("JOB DONE", width / 2, 200);
  }
}
