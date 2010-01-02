FloatTable IRIS;


int rowCount;
int barWidth = 4; // Add to the end of setup( )


int colOne;
int colTwo;


PFont plotFont;

float plotX1, plotY1;
float plotX2, plotY2;


float IRISMin, IRISMax;


void setup() {

  size(720, 405);
  
  IRIS = new FloatTable("iris.tsv");
  rowCount = IRIS.getRowCount();
  
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);


  IRISMin = .1*(IRIS.getTableMax( ));
  IRISMax = 1.1*(IRIS.getTableMax( ));

  // Corners of the plotted time series
  plotX1 = 50;
  plotX2 = width - plotX1;
  plotY1 = 60;
  plotY2 = height - plotY1;
 
  smooth( );
} 
 
 

 
   

void draw() {
  background(210);
  
  // Show the plot area as a white box  
  fill(255);
  rectMode(CORNERS);
  noStroke();
  rect(plotX1, plotY1, plotX2, plotY2);

  //drawHorLabels();

  strokeWeight(5); 
  stroke(#5679C1); 
  drawScatter(0, 1);
}





void drawScatter(int colOne, int colTwo) {

  int rowCount = IRIS.getRowCount(); 
 
   // Draw the title of the current plot.
  fill(0);
  textSize(14);
  String title = "Scatter Plot of Sepal Length vs Sepal Width; Red:setosa  Blue:virginica  Green:versicolor";
  text(title, plotX1, plotY1 - 3);
 
  for (int row = 0; row < rowCount ; row++) {

    if ( (row < 51) ){ 
      stroke(255,0,0);
      float valueOne = IRIS.getFloat(row, colOne);
      float valueTwo = IRIS.getFloat(row, colTwo);    
      float x = map(valueOne, IRISMin, IRISMax , plotX1, plotX2);
      float y = map(valueTwo, IRISMin, IRISMax, plotY2, plotY1);
      point(x, y);
    }
    
    if ( (row > 50) && (row < 101 ) ){ 
      stroke(0,255,0);      
      float valueOne = IRIS.getFloat(row, colOne);
      float valueTwo = IRIS.getFloat(row, colTwo);    
      float x = map(valueOne, IRISMin, IRISMax , plotX1, plotX2);
      float y = map(valueTwo, IRISMin, IRISMax, plotY2, plotY1);
      point(x, y);
    }
    
    
    if ( (row > 100) && (row < rowCount) ){ 
      stroke(0,0,255);      
      float valueOne = IRIS.getFloat(row, colOne);
      float valueTwo = IRIS.getFloat(row, colTwo);    
      float x = map(valueOne, IRISMin, IRISMax , plotX1, plotX2);
      float y = map(valueTwo, IRISMin, IRISMax, plotY2, plotY1);
      point(x, y);
    }    
  }
}  
 




