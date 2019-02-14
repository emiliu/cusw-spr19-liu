ArrayList<Person> people;

// Runs once
void setup() {
  size(800, 600);
  people = new ArrayList<Person>();
  for (int i = 0; i < 10; i++) {
    Person p = new Person("Person "+i, str(random(1, 5)));
    p.randomLocation();
    people.add(p);
  }
}

// Runs 
void draw() {
  background(0);
  //fill(255);
  //ellipse(mouseX, mouseY, 50, 50*mouseY/100);
  
  for (Person person : people) {
    person.update();
    person.drawPerson();
  }
}

void mousePressed() {
  for (Person person : people) {
    if (person.checkSelection()) break;
  }
}

void mouseReleased() {
  for (Person person : people) {
    person.locked = false;
  }
}
