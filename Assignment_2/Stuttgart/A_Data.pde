JSONArray stationsJSON;
JSONArray railwaysJSON;
JSONArray treesJSON;
//Look at https://processing.org/reference/JSONObject.html for more info

void loadData(){
  background = loadImage("data/background.png");
  background.resize(width, height);
  
  stationsJSON = loadJSONObject("data/map/stations.geojson").getJSONArray("features");
  railwaysJSON = loadJSONObject("data/map/railways.geojson").getJSONArray("features");
  treesJSON = loadJSONObject("data/map/trees.geojson").getJSONArray("features");
}

void parseData(){
  for (int i = 0; i < stationsJSON.size(); i++) {
    // identify properties, geometry, and type
    JSONObject geometry = getGeometry(stationsJSON, i);
    String type = geometry.getString("type");
    JSONObject properties = getProperties(stationsJSON, i);
    
    String pub_trans = properties.getString("public_transport");
    println(pub_trans);
    if (pub_trans != null && type.equals("Point")) {
      POI station = createPOI(geometry.getJSONArray("coordinates"));
      station.type = pub_trans;
      stations.add(station);
    }
  }
  
  for (int i = 0; i < railwaysJSON.size(); i++) {
    JSONObject geometry = getGeometry(railwaysJSON, i);
    String type = geometry.getString("type");
    
    if (type.equals("LineString")) {
      Way railway = createWay(geometry.getJSONArray("coordinates"));
      railways.add(railway);
    }
  }
  
  for (int i = 0; i < treesJSON.size(); i++) {
    JSONObject geometry = getGeometry(treesJSON, i);
    String type = geometry.getString("type");
    if (type.equals("Point")) {
      POI tree = createPOI(geometry.getJSONArray("coordinates"));
      tree.type = "tree";
      trees.add(tree);
    }
  }
    
}

JSONObject getGeometry(JSONArray jsonArr, int i) {
  return jsonArr.getJSONObject(i).getJSONObject("geometry");
}

JSONObject getProperties(JSONArray jsonArr, int i) {
  return jsonArr.getJSONObject(i).getJSONObject("properties");
}

POI createPOI(JSONArray coordinates) {
  // make POI
  float lat = coordinates.getFloat(1);
  float lon = coordinates.getFloat(0);
  return new POI(lat, lon);
}

Way createWay(JSONArray coordinates) {
  ArrayList<PVector> coords = new ArrayList<PVector>();
  for (int j = 0; j < coordinates.size(); j++) {
    float lat = coordinates.getJSONArray(j).getFloat(1);
    float lon = coordinates.getJSONArray(j).getFloat(0);
    // make a pvector
    PVector coordinate = new PVector(lat, lon);
    coords.add(coordinate);
  }
  return new Way(coords);
}

Polygon createPoly(JSONArray coordinates) {
  ArrayList<PVector> coords = new ArrayList<PVector>();
  //JSONArray coordinates = geometry.getJSONArray("coordinates").getJSONArray(0);
  for (int j = 0; j < coordinates.size(); j++) {
    float lat = coordinates.getJSONArray(j).getFloat(1);
    float lon = coordinates.getJSONArray(j).getFloat(0);
    PVector coordinate = new PVector(lat, lon);
    coords.add(coordinate);
  }
  return new Polygon(coords);
}
