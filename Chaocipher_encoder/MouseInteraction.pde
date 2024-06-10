// Function to proceed to the next state on mouse click
void mousePressed() {
  if (currentStateIndex < states.size()) {
    currentStateIndex++;
    redraw();
  }
}
