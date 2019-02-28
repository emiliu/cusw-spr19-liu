color poi_fill = color(255, 99, 71);
color polygon_fill = color(32, 178, 170);
color road_color = color(100, 149, 237);

color stop_pos_color = color(255, 255, 0);
color station_color = color(0, 255, 255);
color platform_color = color(100, 100, 100);
color tree_color = color(0, 255, 0);

void drawInfo(){
  infoBox(new String[] {"Railways (r)", "Stations (s)", "Stops (s)", "Platforms (s)", "Trees (t)"},
          new color[] {road_color, station_color, stop_pos_color,
                       platform_color, tree_color}, 20, 20);
}

void infoBox(String[] labels, color[] colors, int x, int y) {
  fill(0);
  noStroke();
  rect(x, y, 105, 20*labels.length+10);
  textSize(16);
  for (int i = 0; i < labels.length; i++) {
    fill(colors[i]);
    text(labels[i], x+5, y+20*(i+1));
  }
}
