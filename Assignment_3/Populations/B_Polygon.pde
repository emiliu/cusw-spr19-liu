class Polygon{
  //Shape, coordinates, and color variables
  PShape[] ps;
  ArrayList<PVector>coordinates;
  color[] fills;
  int[] pops;
  float area;
  String name;

  //Empty constructor
  Polygon(){
    coordinates = new ArrayList<PVector>();
  }
  
  //Constructor with coordinates
  Polygon(ArrayList<PVector> coords){
    coordinates = coords;
    fills = new color[numAgeGroups];
    for (int i = 0; i < numAgeGroups; i++) {
      fills[i] = color(0, 255, 255);
    }
    pops = new int[numAgeGroups];
    ps = new PShape[numAgeGroups];
    name = "";
  }
  
  //Making the shape to draw
  void makeShapes(){
    for (int j = 0; j < numAgeGroups; j++) {
      PShape p = createShape();
      p.beginShape();
      p.fill(fills[ageDisplay]);
      p.stroke(0);
      for(int i = 0; i<coordinates.size(); i++){
          PVector screenLocation = map.getScreenLocation(coordinates.get(i));
          p.vertex(screenLocation.x, screenLocation.y);
      }
      p.endShape();
      ps[j] = p;
    }
  }

  //Drawing shape
  void draw(){
    shape(ps[ageDisplay], 0, 0);
  }
}
