JSONArray roadFeatures;
JSONArray landFeatures;
JSONArray pointFeatures;
//Look at https://processing.org/reference/JSONObject.html for more info

void loadData(){
  /* Load and resize background image */
  background = loadImage("data/background.png");
  background.resize(width, height);
  
  /* Whole Area */
  roadFeatures = loadJSONObject("data/map/roads.geojson").getJSONArray("features");
  landFeatures = loadJSONObject("data/map/landcover.geojson").getJSONArray("features");
  pointFeatures = loadJSONObject("data/map/amenity_points.geojson").getJSONArray("features");
  
  println("There are :", roadFeatures.size(), "road features."); 
  println("There are :", landFeatures.size(), "land features."); 
  println("There are :", pointFeatures.size(), "amenity features."); 
}

void parseData(){
  parseFeatureData(roadFeatures);
  parseFeatureData(landFeatures);
  parseFeatureData(pointFeatures);
}

void parseFeatureData(JSONArray features){
  
  //Sort 3 types into our respective classes to draw
  for(int i = 0; i< features.size(); i++){
    //Idenitfy 3 main things; the properties, geometry, and type 
    String type = features.getJSONObject(i).getJSONObject("geometry").getString("type");
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    JSONObject properties =  features.getJSONObject(i).getJSONObject("properties");
    
    //Make POIs if it's a point
    if(type.equals("Point")){
      //create new POI
      float lat = geometry.getJSONArray("coordinates").getFloat(1);
      float lon = geometry.getJSONArray("coordinates").getFloat(0);
      POI poi = new POI(lat, lon);
      pois.add(poi);
    }
    
    //Polygons if polygon
    if(type.equals("Polygon")){
      ArrayList<PVector> coords = new ArrayList<PVector>();
      //get the coordinates and iterate through them
      JSONArray coordinates = geometry.getJSONArray("coordinates").getJSONArray(0);
      for(int j = 0; j<coordinates.size(); j++){
        float lat = coordinates.getJSONArray(j).getFloat(1);
        float lon = coordinates.getJSONArray(j).getFloat(0);
        //Make a PVector and add it
        PVector coordinate = new PVector(lat, lon);
        coords.add(coordinate);
      }
      //Create the Polygon with the coordinate PVectors
      Polygon poly = new Polygon(coords);
      polygons.add(poly);
    }
    
    //Way if a LineString
    if(type.equals("LineString")){
      ArrayList<PVector> coords = new ArrayList<PVector>();
      //get the coordinates and iterate through them
      JSONArray coordinates = geometry.getJSONArray("coordinates");
      for(int j = 0; j<coordinates.size(); j++){
        float lat = coordinates.getJSONArray(j).getFloat(1);
        float lon = coordinates.getJSONArray(j).getFloat(0);
        //Make a PVector and add it
        PVector coordinate = new PVector(lat, lon);
        coords.add(coordinate);
      }
      //Create the Way with the coordinate PVectors
      Way way = new Way(coords);
      ways.add(way);
    }
    
  }
}

void drawGISObjects() {
  /* Draw all polygons */ 
  for(int i = 0; i<polygons.size(); i++){
    polygons.get(i).draw();
  }
  
  /* Draw all the ways (roads, sidewalks, etc) */
  for(int i = 0; i<ways.size(); i++){
    ways.get(i).draw();
  }

  /* Draw all POIs */
  for(int i = 0; i<pois.size(); i++){
    pois.get(i).draw();
  }
}
