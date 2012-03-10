import megamu.mesh.*;


float[][] points = new float[100][2];
Voronoi voronoi;
MPolygon[] regions;
			
void setup()
{
  size(600, 600);
  
  for(int i = 0; i < points.length; i++)
  {
    points[i][0] = random(width);
    points[i][1] = random(height);
  }
  voronoi = new Voronoi( points );
  
  regions = voronoi.getRegions();

}

void draw()
{
    for(int i=0; i<regions.length; i++)
  {
  	// an array of points
  	float[][] regionCoordinates = regions[i].getCoords();
  	
  	fill(255,0,0);
  	regions[i].draw(this); // draw this shape
  }
}
