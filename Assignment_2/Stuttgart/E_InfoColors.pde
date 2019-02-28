color poi_fill = color(255, 99, 71);
color polygon_fill = color(32, 178, 170);
color road_color = color(237, 255, 236);
color stop_pos_color = color(78, 205, 196);
color station_color = color(255, 107, 107);
color platform_color = color(255, 230, 109);
color tree_color = color(97, 231, 134);
color title_color = color(247, 255, 247);
color title_fill = color(41, 47, 54, 150);

void drawInfo(){
  infoBox(new String[] {"Railways (r)", "Stations (s)", "Stops (s)", "Platforms (s)", "Trees (t)"},
          new color[] {road_color, station_color, stop_pos_color,
                       platform_color, tree_color}, width - 130, height - 130);
  fill(title_fill);
  rect(10, height - 55, 470, 45);
  fill(title_color);
  textSize(30);
  text("Vaihingen (Stuttgart, Germany)", 20, height - 20);
}

void infoBox(String[] labels, color[] colors, int x, int y) {
  fill(0);
  noStroke();
  rect(x, y, 110, 20*labels.length+10);
  textSize(16);
  for (int i = 0; i < labels.length; i++) {
    fill(colors[i]);
    text(labels[i], x+5, y+20*(i+1));
  }
}
