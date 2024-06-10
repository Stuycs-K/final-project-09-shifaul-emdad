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
