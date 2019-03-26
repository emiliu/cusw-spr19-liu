MercatorMap map;
PImage background;

ArrayList<POI> pois;
ArrayList<Way> ways;
ArrayList<Polygon> polygons;

void setup() {
  size(900, 650);
  map = new MercatorMap(width, height, 42.36229, 42.35743, -71.09485, -71.08395, 0);
  loadData();
}

void draw() {
  background(0);
  
  image(background, 0, 0);
}
