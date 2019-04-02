class Wanderer extends Person {
  Node start;
  Node end;
  
  Wanderer(float x, float y, int rad, float maxS, Node start) {
    r = rad;
    tolerance *= r;
    maxspeed = maxS;
    maxforce = 0.2;
    this.start = start;
    int index = int(random(start.adj_ID.size()));
    this.end = network.nodes.get(start.adj_ID.get(index));
    
    float jitterX = random(-tolerance, tolerance);
    float jitterY = random(-tolerance, tolerance);
    location = new PVector(x + jitterX, y + jitterY);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    
  }
  
  void update(ArrayList<PVector> others, boolean collisionDetection) {
    
    // Apply Repelling Force
    PVector separateForce = separate(others);
    if (collisionDetection) {
      separateForce.mult(3);
      acceleration.add(separateForce);
    }
    
    // Apply Seek Force
    PVector waypoint = end.loc;
    float jitterX = random(-tolerance, tolerance);
    float jitterY = random(-tolerance, tolerance);
    PVector direction = new PVector(waypoint.x + jitterX, waypoint.y + jitterY);
    PVector seekForce = seek(direction);
    seekForce.mult(1);
    acceleration.add(seekForce);
    
    // Update velocity
    velocity.add(acceleration);
    
    // Rest if by a bench
    if (benches.seated(this)) {
      velocity.limit(0.01);
    }
    
    // Update Location
    location.add(new PVector(velocity.x, velocity.y));
        
    // Limit speed
    velocity.limit(maxspeed);
      
    // Reset acceleration to 0 each cycle
    acceleration.mult(0);
    
    // Checks if Agents reached current waypoint
    //
    float prox = sqrt( sq(location.x - waypoint.x) + sq(location.y - waypoint.y) );
    if (prox < 3 && end.adj_ID.size() > 0) {
      start = end;
      int index = int(random(end.adj_ID.size()));
      end = network.nodes.get(end.adj_ID.get(index));
    }
  }
  
}

class Benches {
  ArrayList<Bench> benches;
  Benches() {
    benches = new ArrayList<Bench>();
  }
  void add(float x, float y) {
    benches.add(new Bench(x, y));
  }
  boolean seated(Person p) {
    if (benches.size() < 1) return false;
    for (Bench b : benches) {
      if (sqrt(sq(b.loc.x - p.location.x) + sq(b.loc.y - p.location.y)) < b.radius) {
        return true;
      }
    }
    return false;
  }
  void draw() {
    for (Bench b : benches) b.draw();
  }
}

class Bench {
  PVector loc;
  float radius;
  
  Bench(float x, float y) {
    loc = new PVector(x, y);
    radius = 40;
  }
  
  void draw() {
    noStroke();
    fill(0);
    ellipse(loc.x, loc.y, radius, radius);
  }
}
