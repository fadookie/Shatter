import megamu.mesh.*;
import fisica.*;
PVector fillColor;
FWorld world;


float[][] points = new float[100][2];
Voronoi voronoi;
MPolygon[] regions;
			
void setup()
{
  Fisica.init(this);
    //Make the world
    world = new FWorld();
    world.setGrabbable(true); //Only allow mouse grabbing in debug mode
    world.setGravity(0, 0);
    world.setEdgesRestitution(0.5);
  
  fillColor = new PVector(120, 30, 90);
  size(600, 600);
  
  for(int i = 0; i < points.length; i++)
  {
    points[i][0] = random(width);
    points[i][1] = random(height);
  }
  voronoi = new Voronoi( points );
  
  regions = voronoi.getRegions();

    for(int i=0; i<regions.length; i++)
  {
  	// an array of points
  	float[][] regionCoordinates = regions[i].getCoords();

    FPoly poly = new FPoly();
    poly.setBullet(false);
    poly.setStrokeWeight(3);
    poly.setFill(fillColor.x, fillColor.y, fillColor.z);
    float density = 10;
    poly.setDensity(density);
    poly.setRestitution(0.5);
  	
  	fill(255,0,0);
    for (int j = 0; j < regionCoordinates.length; j++) {

      float x = regionCoordinates[j][0];
      float y = regionCoordinates[j][1];
      x = constrain(x, 0, width);
      y = constrain(y, 0, height);
      poly.vertex(x, y);
      println("poly.vertex("+x+", "+y+")");

      //for (int k = 0; k < regionCoordinates[j].length; k++) {
      //  println(regionCoordinates[j] + ", " + regionCoordinates[j][k]);
      //}
    }
    world.add(poly);
    //break;

    //poly = new FPoly();
    //poly.setStrokeWeight(3);
    //poly.setFill(120, 30, 90);
    //poly.setDensity(10);
    //poly.setRestitution(0.5);
    //poly.vertex(10, 0);
    //poly.vertex(20, 0);
    //poly.vertex(0, 15);
    //world.add(poly);
    

  	//regions[i].draw(this); // draw this shape
  }

}

void draw()
{
    background(255);
  world.step();
  world.draw(this); 
}
