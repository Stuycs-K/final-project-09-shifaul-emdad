// State class to represent the decryption states
class State {
  char letter;
  String left;
  String right;
  boolean isDecrypt;
  int matchIndex;
 
  // Constructor
  State(char letter, String left, String right, boolean isDecrypt, int matchIndex) {
    this.letter = letter;
    this.left = left;
    this.right = right;
    this.isDecrypt = isDecrypt;
    this.matchIndex = matchIndex;
  }
}
