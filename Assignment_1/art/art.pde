float x, y, r, g, b, size;

void setup() {
  size(640, 360);
  background(0);
}

void draw() {
  x = random(width);
  y = random(height);
  noStroke();
  r = map(x, 0, width, 0, 255);
  g = map(y, 0, height, 0, 255);
  b = map(mouseX, 0, width, 0, 255);
  size = map(mouseY, 0, height, 1, 45);
  fill(r, g, b, 150);
  ellipse(x, y, size, size);
  if (keyPressed) {
    background(0);
  }
}
