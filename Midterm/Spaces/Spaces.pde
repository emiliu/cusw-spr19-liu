/*  PATHFINDER AND NETWORK ALGORITHMS
 *  Ira Winder, ira@mit.edu
 *  Nina Lutz, nlutz@mit.edu
 *  Coded w/ Processing 3 (Java)
 *
 *  The Main Tab "Tutorial_3A_Agents" shows an example implementation of 
 *  algorithms useful for finding shortest pathes snapped to a gridded or OSM-based 
 *  network. Explore the various tabs to see how they work.
 *
 *  CLASSES CONTAINED:
 *
 *    Pathfinder() - Method to calculate shortest path between to nodes in a graph/network
 *    Graph() - Network of nodes and wighted edges
 *    Node() - Fundamental building block of Graph()
 *    ObstacleCourse() - Contains multiple Obstacles; Allows editing, saving, and loading of configuration
 *    Obstacle() - 2D polygon that can detect overlap events
 *    MercatorMap() - translate lat-lon to screen coordinates
 *    
 *    Standard GIS shapes:
 *    POI() - i.e. points, representing points of interest, etc
 *    Way() - i.e. lines, representing streets, paths, etc
 *    Polygons() - representing buildings, parcels, etc
 *
 *  FUNDAMENTAL OUTPUT: 
 *
 *    ArrayList<PVector> shortestPath = Pathfinder.findPath(PVector A, PVector B, boolean enable)
 *
 *  CLASS DEPENDENCY TREE: 
 *
 *
 *     POI() / Way()  ->  Node()  ->      Graph()        ->      Pathfinder()  ->  OUTPUT: ArrayList<PVector> shortestPath
 *
 *                                            ^                                        |
 *                                            |                                        v
 *
 *     Polygon()  ->  Obstacle()  ->  ObstacleCourse()                             Agent()                                   
 *
 */

// Make a blank map 
MercatorMap map;
PImage background;

// Declare GIS-style Objects
ArrayList<POI> pois;
ArrayList<Way> ways; 
ArrayList<Polygon> polygons;

Benches benches;
boolean displayInfo;

// A function to contain model initialization
void initModel() {
  
  /* Step 1: Initialize Network Using ONLY ONE of these methods */
  //randomNetwork(0.5); // a number between 0.0 and 1.0 specifies how 'porous' the network is
  //waysNetwork(ways);
  //randomNetworkMinusBuildings(0.1, polygons); // a number between 0.0 and 1.0 specifies how 'porous' the network is
  randomNetworkOnLand(0.1, polygons, ways);
  initPaths();
}

void initPaths() {
  /* Step 2: Initialize Paths Using ONLY ONE of these methods */
  //randomPaths(1);
  //poiPaths(1);
  
  /* Step 3: Initialize Population */
  //initPopulation(10*paths.size());
  initWanderers(100);
}

void setup() {
  size(1000, 650);
  
  /* Intialize your data structures early in setup */
  map = new MercatorMap(width, height, 41.88513, 41.88022, -87.62489, -87.61399, 0); // Coordinates pulled from OSM Export
  polygons = new ArrayList<Polygon>();
  ways = new ArrayList<Way>();
  pois = new ArrayList<POI>();
  
  /* Load in and parse your data in setup -- don't want to do this every frame! */
  loadData();
  parseData();
  
  /* Initialize our model and simulation */
  initModel();
  benches = new Benches();
  
  displayInfo = true;
}

void draw() {
  background(0);
  
  /* background image from OSM */
  image(background, 0, 0);
  //drawGISObjects();
  
  ///*  Displays the Graph in grayscale */
  tint(255, 150); // overlaid as an image
  image(network.img, 0, 0);
  
  benches.draw();
  
  /*  Displays the path last calculated in Pathfinder.
   *  The results are overridden everytime findPath() is run.
   *  FORMAT: display(color, alpha)
   */
  //boolean showVisited = true;
  //finder.display(255, 200, showVisited);
  
  /*  Displays the path properties.
   *  FORMAT: display(color, alpha)
   */
  //for (Path p: paths) {
  //  p.display(100, 100);
  //}
  
  /*  Update and Display the population of agents
   *  FORMAT: display(color, alpha)
   */
  boolean collisionDetection = true;
  for (Person p: people) {
    p.update(personLocations(people), collisionDetection);
    p.display(#FFFFFF, 255);
  }
  
  //Info
  if (displayInfo) {
    fill(0, 150);
    rect(50, 50, width-100, height-100);
    fill(255);
    textSize(48);
    text("Millennium Park", 100, 150);
    textSize(28);
    text("White dots represent park visitors and", 100, 250);
    text("black circles represent benches.", 100, 290);
    text("Press i to toggle this information panel", 100, 340);
    text("and any other key to regenerate the people.", 100, 380);
  }
}

void keyPressed() {
  if (key == 'i') {
    displayInfo = !displayInfo;
  } else {
    initPaths();
  }
}

void mouseClicked() {
  benches.toggle(mouseX, mouseY);
}

void mousePressed() {
  benches.checkSelections();
}

void mouseReleased() {
  benches.releaseAll();
}
