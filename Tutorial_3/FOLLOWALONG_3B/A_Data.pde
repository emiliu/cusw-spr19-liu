Table CountyBoundary;
Table CensusData;
Table CensusBlocks;


void loadData(){
  CountyBoundary = loadTable("data/FloridaNodes.csv", "header");
  CensusBlocks = loadTable("data/CensusNodes.csv", "header");
  CensusData = loadTable("data/CensusAttrs.csv", "header");
  println("Data Loaded");
}

void parseData(){
  ArrayList<PVector> coords = new ArrayList<PVector>();
  for (int i = 0; i < CountyBoundary.getRowCount(); i++) {
    float lat = float(CountyBoundary.getString(i, 2));
    float lon = float(CountyBoundary.getString(i, 1));
    coords.add(new PVector(lat, lon));
  }
  county = new Polygon(coords);
  county.outline = true;
  county.makeShape();
  
  // now we can parse the population polygons
  int prevId = 0;
  coords = new ArrayList<PVector>();
  for (int i = 0; i < CensusBlocks.getRowCount(); i++) {
    int shapeId = int(CensusBlocks.getString(i, 0));
    if (shapeId != prevId) {
      if (coords.size() > 0) {
        Polygon poly = new Polygon(coords);
        poly.id = shapeId;
        CensusPolygons.add(poly);
      }
      // reset and clear
      coords = new ArrayList<PVector>();
      prevId = shapeId;
    } else {
      float lat = float(CensusBlocks.getString(i, 2));
      float lon = float(CensusBlocks.getString(i, 1));
      coords.add(new PVector(lat, lon));
    }
  }
  
  // add an attribute
  for (int i = 0; i < CensusPolygons.size(); i++) {
    CensusPolygons.get(i).score = CensusData.getFloat(i, "B19113");
    CensusPolygons.get(i).colorByScore();
    CensusPolygons.get(i).makeShape();
  }
  println("Data Parsed");
}
