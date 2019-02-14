// This Person class will represent people in our class

class Person {
  
  String name;
  String year;
  PVector screenLocation;
  boolean locked; // Am I editing my person location
  
  Person(String _name, String _year) {
    name = _name;
    year = _year;
    screenLocation = new PVector(width/2, height/2);
  }
  
  void randomLocation() {
    screenLocation = new PVector(random(width), random(height));
  }
  
  // see if my mouse cursor is near my person
  boolean hoverEvent() {
    float xDistance = abs(mouseX - screenLocation.x);
    float yDistance = abs(mouseY - screenLocation.y);
    return xDistance <= 15 && yDistance <= 15;
  }
  
  // is my person selected by the mouse
  boolean checkSelection() {
    locked = hoverEvent();
    return locked;
  }
  
  // update person location if locked
  void update() {
    if (locked) {
      screenLocation = new PVector(mouseX, mouseY);
    }
  }
  
  void drawPerson() {
    noStroke(); // no circle outline
    if (hoverEvent()) {
      fill(#ffff00);
    } else {
      fill(255);
    }
    
    ellipse(screenLocation.x, screenLocation.y, 30, 30);
    
    text(name + "\n Year " + year, screenLocation.x+10, screenLocation.y+10);
  }
  
}
