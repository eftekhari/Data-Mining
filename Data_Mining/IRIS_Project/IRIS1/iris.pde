FloatTable IRIS;

int rowCount;
int barWidth = 10; 

PFont plotFont;

float plotX1, plotY1;
float plotX2, plotY2;

float sumOne = 0;
float sumTwo = 0;

float sepalLenghtAvOne = 0;
float sepalLenghtAvTwo = 0;
float sepalLenghtAvThree = 0;
float sepalLenghtStdOne = 0;
float sepalLenghtStdTwo = 0;
float sepalLenghtStdThree = 0;

float x1 = 50;
float x2 = 140;
float x3 = 240;


void setup() {

  size(300, 500);
  
  IRIS = new FloatTable("iris.tsv");
  rowCount = IRIS.getRowCount();
  
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);

  // Corners of the plotted time series
  plotX1 = 25;
  plotX2 = width - plotX1;
  plotY1 = 25;
  plotY2 = height - plotY1;


  // Find the average & standard deviation of sepal length
  for (int row = 0; row<rowCount; row++) {
    if ( row<rowCount/3 ){
      float val = IRIS.getFloat(row, 0);
      sumOne+=val;
      sumTwo+=val*val;
    }

  }
  sepalLenghtAvOne = 3* (sumOne/rowCount);
  sepalLenghtStdOne = pow(3*(sumTwo/rowCount)-pow(sepalLenghtAvOne,2),.5);



  sumOne = 0;
  sumTwo = 0;  
  for (int row = 0; row<rowCount ; row++) {
    if ( (row > (rowCount/3)-1) && (row < (2*rowCount)/3) ){
      float val = IRIS.getFloat(row, 0);
       sumOne+=val;
       sumTwo+=val*val;
       println(val);
    }   
  }
  sepalLenghtAvTwo = 3* (sumOne/rowCount);
  sepalLenghtStdTwo = pow( 3*(sumTwo/rowCount)-pow(sepalLenghtAvTwo,2) ,.5 );
  
  
  sumOne = 0;
  sumTwo = 0;  
  for (int row = 0; row<rowCount; row++) {
    if ( (row < rowCount) && (row > ((2*rowCount)/3)-1) ) {
      float val = IRIS.getFloat(row, 0);
      sumOne+=val;
      sumTwo+=val*val;
    }
  }
  sepalLenghtAvThree = 3* (sumOne/rowCount);
  sepalLenghtStdThree = pow( 3*(sumTwo/rowCount)-pow(sepalLenghtAvThree,2),.5 );



  println(sepalLenghtStdOne);
  println(sepalLenghtStdTwo);
  println(sepalLenghtStdThree);  
  smooth( );
} 
 
 
 
void draw() {
  background(210);
  
  // Show the plot area as a white box  
  fill(255);
  rectMode(CORNERS);
  noStroke();
  rect(plotX1, plotY1, plotX2, plotY2);

  drawHorLabels();

  noStroke();
  drawAverages(sepalLenghtAvOne, sepalLenghtAvTwo, sepalLenghtAvThree, sepalLenghtStdOne, sepalLenghtStdTwo, sepalLenghtStdThree);   
}

void drawAverages(float sepalLenghtAvOne,float sepalLenghtAvTwo,float sepalLenghtAvThree, float sepalLenghtStdOne, float sepalLenghtStdTwo, float sepalLenghtStdThree) {

  // Draw the title of the current plot.
  fill(0);
  textSize(10);
  String title = "Average and Standard Deviation of Sepal Lenght \n Red:Average & Blue:Standard deviation";
  text(title, plotX1+120, plotY1 -1);
  
  rectMode(CORNERS);


  
  float x = map(sepalLenghtAvOne, 0, sepalLenghtAvThree+1, plotY1, plotY2);
  float y = map(sepalLenghtAvTwo, 0, sepalLenghtAvThree+1, plotY1, plotY2);
  float z = map(sepalLenghtAvThree, 0, sepalLenghtAvThree+1, plotY1, plotY2);
  
  fill(255,0,0);
  stroke(255,0,0);
  rect(x1-barWidth/2, x, x1+barWidth/2, plotY2);
  rect(x2-barWidth/2, y, x2+barWidth/2, plotY2);
  rect(x3-barWidth/2, z, x3+barWidth/2, plotY2); 


  x = map(sepalLenghtStdOne, 0, sepalLenghtStdThree+1, plotY1, plotY2);
  y = map(sepalLenghtStdTwo, 0, sepalLenghtStdThree+1, plotY1, plotY2);
  z = map(sepalLenghtStdThree, 0, sepalLenghtStdThree+1, plotY1, plotY2);
  
  fill(0,0,255);  
  stroke(0,0,255);
  rect(x1+barWidth/2, x, x1+((3*barWidth)/2), plotY2);
  rect(x2+barWidth/2, y, x2+((3*barWidth)/2), plotY2);
  rect(x3+barWidth/2, z, x3+((3*barWidth)/2), plotY2);
 

}

 
void drawHorLabels( ) {
  fill(0);
  textSize(10);
  textAlign(CENTER, TOP);
  // Use thin, gray lines to draw the grid.
  stroke(224);
  strokeWeight(1);


      text("Setosa", x1, plotY2 + 10);
      line(x1, plotY1, x1, plotY2);
     text("Versicolor", x2, plotY2 + 10);
      line(x2, plotY1, x2, plotY2);
      text("Virginica", x3, plotY2 + 10);
      line(x3, plotY1, x3, plotY2);
}



