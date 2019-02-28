JSONObject example;
JSONArray features;
JSONObject wholeArea;
//Look at https://processing.org/reference/JSONObject.html for more info

void loadData(){
  background = loadImage("data/background.png");
  background.resize(width, height);
  
  // large example
  wholeArea = loadJSONObject("data/wholeArea.json");
  features = wholeArea.getJSONArray("features");
  
  // small example
  //example = loadJSONObject("data/example.json");
  //features = example.getJSONArray("features");
  
  println("There are", features.size(), "features");
}

void parseData(){
  for (int i = 0; i < features.size(); i++) {
    // identify properties, geometry, and type
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    String type = geometry.getString("type");
    JSONObject properties = features.getJSONObject(i).getJSONObject("properties");
    
    // identify more information
    String dataAmenity = properties.getJSONObject("tags").getString("amenity");
    String amenity = "";
    if (dataAmenity != null) amenity = dataAmenity;
    
    // make POIs
    if (type.equals("Point")) {
      // create a new POI
      JSONArray coord = geometry.getJSONArray("coordinates");
      float lat = coord.getFloat(1);
      float lon = coord.getFloat(0);
      
      POI poi = new POI(lat, lon);
      poi.type = amenity;
      if (amenity.equals("atm")) poi.ATM = true;
      pois.add(poi);
    }
    
    // make polygons
    if (type.equals("Polygon")) {
      // make a new polygon
      ArrayList<PVector> coords = new ArrayList<PVector>();
      JSONArray coordinates = geometry.getJSONArray("coordinates").getJSONArray(0);
      for (int j = 0; j < coordinates.size(); j++) {
        float lat = coordinates.getJSONArray(j).getFloat(1);
        float lon = coordinates.getJSONArray(j).getFloat(0);
        PVector coordinate = new PVector(lat, lon);
        coords.add(coordinate);
      }
      Polygon poly = new Polygon(coords);
      polygons.add(poly);
    }
    
    // make roads/ways
    if (type.equals("LineString")) {
      ArrayList<PVector> coords = new ArrayList<PVector>();
      JSONArray coordinates = geometry.getJSONArray("coordinates");
      for (int j = 0; j < coordinates.size(); j++) {
        float lat = coordinates.getJSONArray(j).getFloat(1);
        float lon = coordinates.getJSONArray(j).getFloat(0);
        // make a pvector
        PVector coordinate = new PVector(lat, lon);
        coords.add(coordinate);
      }
      Way way = new Way(coords);
      ways.add(way);
    }
  }
}
