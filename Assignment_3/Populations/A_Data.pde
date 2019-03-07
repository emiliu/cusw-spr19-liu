Table nodes, attributes;
void loadData(){
  nodes = loadTable("data/nj-sc-nodes.csv", "header");
  attributes = loadTable("data/nj-sc-attr.csv", "header");
  println("Data Loaded");
}

void parseAttributes(){
  String[] ageIds = { "DP0010002", "DP0010003", "DP0010004", "DP0010005",
                      "DP0010006", "DP0010007", "DP0010008", "DP0010009",
                      "DP0010010", "DP0010011", "DP0010012", "DP0010013",
                      "DP0010014", "DP0010015", "DP0010016", "DP0010017",
                      "DP0010018", "DP0010019" };
  for (int i = 0; i < shapes.size(); i++) {
    Polygon dist = shapes.get(i);
    dist.name = attributes.getString(i, "NAME10");
    dist.area = attributes.getFloat(i, "Shape_Area");
    for (int j = 0; j < numAgeGroups; j++) {
      dist.pops[j] = 0;
      for (int k = 0; k < 6; k++) {
        dist.pops[j] += attributes.getInt(i, ageIds[6*j+k]);
      }
      dist.fills[j] = lerpColor(color(0,50,0), color(0,255,0), dist.pops[j]/500);
      //(dist.pops[j] / dist.area)/2000000);
    }
    dist.makeShapes();
  }
  println("parsed attributes");
}

void parseNodes(){
  int previd = 0;
  ArrayList<PVector> coords = new ArrayList<PVector>();
  for(int i = 0; i<nodes.getRowCount(); i++){
    int shapeid = int(nodes.getString(i, 0));
       if(shapeid != previd){
         if(coords.size() > 0){
           Polygon poly = new Polygon(coords);
           shapes.add(poly);
         }
         //clear coords
         coords = new ArrayList<PVector>();
         //reset variable
         previd = shapeid;
       }
       if(shapeid == previd){
         float lat = float(nodes.getString(i, 2));
         float lon = float(nodes.getString(i, 1));
         coords.add(new PVector(lat, lon));
       }
  }
  println(shapes.size(), "shapes parsed");
}
