ArrayList<Polygon> polygons;

class Polygon{
  PShape p;
  ArrayList<PVector> coordinates;
  
  Polygon() {
    coordinates = new ArrayList<PVector>();
  }
  
  Polygon(ArrayList<PVector> coords) {
    coordinates = coords;
    makeShape();
  }
  
  void makeShape() {
    p = createShape();
    p.beginShape();
    p.fill(polygon_fill);
    p.strokeWeight(.5);
    p.stroke(255);
    for (PVector coord : coordinates) {
      PVector screenLocation = map.getScreenLocation(coord);
      p.vertex(screenLocation.x, screenLocation.y);
    }
    p.endShape();
  }
  
  void draw() {
    shape(p, 0, 0);
  }
}
