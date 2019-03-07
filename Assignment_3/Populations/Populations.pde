MercatorMap map;
ArrayList<Polygon> shapes;
int ageDisplay;
final int numAgeGroups = 3;

void setup() {
  size(1000, 650);
  map = new MercatorMap(width, height, 41.327, 38.981, -76.580, -72.713, 0);
  shapes = new ArrayList<Polygon>();
  loadData();
  parseNodes();
  parseAttributes();
}

void draw() {
  //ArrayList<Polygon> ageGroup = ageGroups.get(ageDisplay);
  background(0);
  //for (int i = 0; i < shapes.size()/10; i++) {
  //  Polygon poly = shapes.get(i);
  //  poly.draw();
  //}
  for (Polygon poly : shapes) poly.draw();
  //image(ageGroups.get(ageDisplay), 0, 0);
  drawInfo();
}
