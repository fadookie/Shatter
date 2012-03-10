import megamu.mesh.*;
import fisica.*;
PVector fillColor;
FWorld world;


float[][] points = new float[100][2];
Voronoi voronoi;
MPolygon[] regions;

PVector scale;


//Re-using some PVector objects to reduce garbage during calcs in a tight loop
PVector workVectorA;
PVector workVectorB;
PVector workVectorC;

			
void setup()
{
  size(600, 600);
  Fisica.init(this);

  //Make the world
  world = new FWorld();
  world.setGrabbable(true); //Only allow mouse grabbing in debug mode
  world.setGravity(0, 0);
  world.setEdgesRestitution(0.5);

  scale = new PVector(0.8,0.8);

  workVectorA = new PVector();
  workVectorB = new PVector();
  workVectorC = new PVector();
  
  fillColor = new PVector(120, 30, 90);
  
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
    boolean addPoly = true;
    for (int j = 0; j < regionCoordinates.length; j++) {
      PVector coords;

      float x = regionCoordinates[j][0];
      float y = regionCoordinates[j][1];

      //x = constrain(x, 0, width);
      //y = constrain(y, 0, height);

      //translate to origin
      x -= points[i][0];
      y -= points[i][1];
  
      //Apply transformations
      //[a c
      // b d]
      
      workVectorA.x = scale.x; //a
      workVectorA.y = 0; //b

      workVectorB.x = 0; //c
      workVectorB.y = scale.y; //d

      //x(a,b) + y(c,d)
      workVectorA.mult(x);
      workVectorB.mult(y);
      coords = PVector.add(workVectorA, workVectorB); //If this adds too much garbage, try instance .add() on another work vector
      x = coords.x + points[i][0];
      y = coords.y + points[i][1];

      if ((x < 0) ||
          (x > width) ||
          (y < 0) ||
          (y > height)
         ){
        addPoly = false; //poly is outside of screen, don't add it
      }

      //translate to origin
      //coords.x += points[i][0];
      //coords.y += points[i][1];
      poly.vertex(x, y);

      println("poly.vertex("+x+", "+y+")");

      //for (int k = 0; k < regionCoordinates[j].length; k++) {
      //  println(regionCoordinates[j] + ", " + regionCoordinates[j][k]);
      //}
    }

    if (addPoly) {
      world.add(poly);
    }
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
