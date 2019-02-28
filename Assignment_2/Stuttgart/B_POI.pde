class POI{
  // coordinate
  PVector coord;
  
  // lat, lon values
  float lat;
  float lon;
  
  // type -- may use later
  String type;
  
  POI(float _lat, float _lon) {
    lat = _lat;
    lon = _lon;
    coord = new PVector(lat, lon);
    type = "";
  }
  
  void draw() {
    PVector screenLocation = map.getScreenLocation(coord);
    switch (type) {
      case "station":
      fill(station_color);
      break;
      case "stop_position":
      fill(stop_pos_color);
      break;
      case "platform":
      fill(platform_color);
      break;
      case "tree":
      fill(tree_color);
      break;
      default:
      fill(poi_fill);
    }
    noStroke();
    ellipse(screenLocation.x, screenLocation.y, 10, 10);
  }
}
