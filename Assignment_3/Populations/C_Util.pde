color title_color = color(247, 255, 247);
color title_fill = color(41, 47, 54, 150);
String ages[] = {"Under 29 years", "30-59 years", "60+ years"};

void drawInfo(){
  infoBox(new String[] {"Age Group", ages[ageDisplay]},
          new color[] {title_color, title_color}, width - 160, height - 50);
  //fill(title_fill);
  //rect(10, height - 55, 450, 45);
  fill(title_color);
  textSize(30);
  text("New Jersey School Districts", 20, height - 20);
}

void infoBox(String[] labels, color[] colors, int x, int y) {
  //fill(title_fill);
  noStroke();
  //rect(x, y, 110, 20*labels.length+10);
  textSize(16);
  for (int i = 0; i < labels.length; i++) {
    fill(colors[i]);
    text(labels[i], x+5, y+20*(i+1));
  }
}

void keyPressed(){
  if (key == 119) ageDisplay = (ageDisplay + 1) % numAgeGroups;
  if (key == 115) ageDisplay = (ageDisplay - 1) % numAgeGroups;
  println(ageDisplay);
}
