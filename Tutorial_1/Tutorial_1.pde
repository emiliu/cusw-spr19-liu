ArrayList<Person> people;
ArrayList<Connection> frands;

// Runs once
void setup() {
  size(800, 600);
  initialize();
}

void initialize() {
  people = new ArrayList<Person>();
  frands = new ArrayList<Connection>();
  for (int i = 0; i < 10; i++) {
    Person p = new Person("Person "+i, str(int(random(1, 5))));
    p.randomLocation();
    people.add(p);
  }
  
  // who are frands?
  for (Person origin : people) {
    for (Person destination : people) {
      // is person referencing themself?
      if (!origin.name.equals(destination.name)) {
        // are origin and dest same year?
        if (origin.year.equals(destination.year)) {
          frands.add(new Connection(origin, destination, "frands"));
        }
      }
    }
  }
  
  println(frands.size());
}

// Runs 
void draw() {
  background(0);
  //fill(255);
  //ellipse(mouseX, mouseY, 50, 50*mouseY/100);
  
  // draw people
  for (Person person : people) {
    person.update();
    person.drawPerson();
  }
  
  // draw connections
  for (Connection connection : frands) {
    connection.draw();
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

void keyPressed() {
  initialize();
}
