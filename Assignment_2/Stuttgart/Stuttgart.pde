//First make a blank map 
MercatorMap map;
PImage background;
ArrayList<POI> stations;
ArrayList<Way> railways;
ArrayList<POI> trees;
boolean stationShow, railwayShow, treeShow, infoShow;

void setup(){
  size(1000, 650);
  
  //Intiailize your data structures early in setup 
  map = new MercatorMap(width, height, 48.73194, 48.72760, 9.11437, 9.12527, 0);
  stations = new ArrayList<POI>();
  railways = new ArrayList<Way>();
  trees = new ArrayList<POI>();
  loadData();
  parseData();
}

void draw(){
  image(background, 0, 0);
  fill(0, 120);
  rect(0, 0, width, height);
  
  if (railwayShow) {
    for (Way w : railways) {
      w.draw();
    }
  }
  
  if (treeShow) {
    for (POI p : trees) {
      p.draw();
    }
  }
  
  if (stationShow) {
    for (POI p : stations) {
      p.draw();
    }
  }
  
  if (infoShow) {
    drawInfo();
  }
  
  noStroke();
}

void keyPressed() {
  if (key == 105) infoShow = !infoShow; // i
  if (key == 114) railwayShow = !railwayShow; // r
  if (key == 115) stationShow = !stationShow; // s
  if (key == 116) treeShow = !treeShow; // t
}
