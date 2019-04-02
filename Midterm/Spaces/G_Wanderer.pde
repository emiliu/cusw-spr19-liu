class Wanderer extends Person {
  Node start;
  Node end;
  Graph graph;
  
  Wanderer(float x, float y, int rad, float maxS, Graph g, Node start) {
    r = rad;
    tolerance *= r;
    maxspeed = maxS;
    maxforce = 0.2;
    graph = g;
    this.start = start;
    int index = int(random(start.adj_ID.size()));
    this.end = g.nodes.get(start.adj_ID.get(index));
    
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
      end = graph.nodes.get(end.adj_ID.get(index));
    }
  }
  
}
