/*
  This is my implementation of what I understand to be the linear and circular buffers.
  (From what I remember from the lecture I had with Olga about it last year during my MED1)
  DO NOTE THAT THIS I WHAT I UNDERSTAND TO BE WHAT YOU'RE TALKING ABOUT WHEN YOU
  ASK FOR LINEAR AND CIRCULAR BUFFER
  
  Using the linear buffer, the first element of both x and y arrays are set to the
  current mouseX and mouseY every frame. Then, every element of both arrays except 
  the first are set to its previous one.
  
  Using the circular buffer you only change the value of the 
  x and y arrays of the element corresponding to the current value of indexPosition
  once in every frame.
  
  So, as it can be seen, the main difference is the performance. The linear buffer
  requires changing the value of every element of the x and y arrays every frame.
  On the other hand, with the circular buffer you never change the values of any
  element from the arrays, except for the element corresponding to the current value
  of indexPosition
  
  So, to conclude, in this implementation they are both used to achieve the same effect
  visually of a snake-like behaviour of ellipses, but the circular buffer is more performant
  than the linear buffer as the former doesn't require to keep changing the values of every element
  of the x and y arrays in every frame.
*/

int size = 4; // size of the arrays
int [] x, y; // declaring two integer arrays for the x and y coordinates repectively
int indexPosition = 0; // to keep track of the current index element

void setup() {
  size(600, 600);
  // initializing both x and y arrays
  x = new int[size];
  y = new int[size];
}

void draw() {
  background(0);
  
  // -------------------------------- LINEAR  BUFFER --------------------------------
  x[0] = mouseX;
  y[0] = mouseY;
  // in this for loop we set every element (except the first) to its previous one.
  // Starting from the last element of the arrays (from x[size-1] and y[size-1]) 
  // to element number 1 (until x[1] and y[1]) 
  for (int i = size - 1; i > 0; i--) {
    x[i] = x[i-1];
    y[i] = y[i-1];
    ellipse(x[i], y[i], 25, 25);
  }
  /*
  What is going on in linear buffer each frame?
  First run of draw():
  x[0] = mouseX;
  y[0] = mouseY;
  // i = size - 1 = 4 - 1 --> i = 3
  i = 3 --> x[3] = x[3-1] --> x[3] = x[2];
        --> y[3] = y[3-1] --> y[3] = y[2];
  i = 2 --> x[2] = x[2-1] --> x[2] = x[1];
        --> y[2] = y[2-1] --> y[2] = y[1];
  i = 1 --> x[1] = x[1-1] --> x[1] = x[0]; 
        --> y[1] = y[1-1] --> y[1] = y[0];
        
  Second run of draw(): the same process as the previous frame
  And so on...
  */
  
  background(0);
  
  // -------------------------------- CIRCULAR BUFFER --------------------------------
  x[indexPosition] = mouseX;
  y[indexPosition] = mouseY;
  indexPosition = (indexPosition + 1) % size;
  for (int i = 0; i < size; i++) {
    int pos = (indexPosition + i) % size;
    ellipse(x[pos], y[pos], 25, 25);
  }
  
  /*
  What is going on in circular buffer each frame?
  First run of draw():
  x[0] = mouseX;
  y[0] = mouseY;
  indexPosition = (0 + 1) % 4; // indexPosition = 1 % 4 = 1
  i = 0 --> pos = (1 + 0) % 4; // pos = 1 % 4 = 1
  i = 1 --> pos = (1 + 1) % 4; // pos = 2 % 4 = 2
  i = 2 --> pos = (1 + 2) % 4; // pos = 3 % 4 = 3
  i = 3 --> pos = (1 + 3) % 4; // pos = 4 % 4 = 0
  
  Second run of draw():
  x[1] = mouseX;
  y[1] = mouseY;
  indexPosition = (1 + 1) % 4; // indexPosition = 2 % 4 = 2
  i = 0 --> pos = (2 + 0) % 4; // pos = 2 % 4 = 2
  i = 1 --> pos = (2 + 1) % 4; // pos = 3 % 4 = 3
  i = 2 --> pos = (2 + 2) % 4; // pos = 4 % 4 = 0
  i = 3 --> pos = (2 + 3) % 4; // pos = 5 % 4 = 1
  
  Third run of draw():
  x[2] = mouseX;
  y[2] = mouseY;
  indexPosition = (2 + 1) % 4; // indexPosition = 3 % 4 = 3
  i = 0 --> pos = (3 + 0) % 4; // pos = 3 % 4 = 3
  i = 1 --> pos = (3 + 1) % 4; // pos = 4 % 4 = 0
  i = 2 --> pos = (3 + 2) % 4; // pos = 5 % 4 = 1
  i = 3 --> pos = (3 + 3) % 4; // pos = 6 % 4 = 2
  
  Fourth run of draw():
  x[3] = mouseX;
  y[3] = mouseY;
  indexPosition = (3 + 1) % 4; // indexPosition = 4 % 4 = 0
  i = 0 --> pos = (4 + 0) % 4; // pos = 4 % 4 = 0
  i = 1 --> pos = (4 + 1) % 4; // pos = 5 % 4 = 1
  i = 2 --> pos = (4 + 2) % 4; // pos = 6 % 4 = 2
  i = 3 --> pos = (4 + 3) % 4; // pos = 7 % 4 = 3
  
  Fifth run of draw():
  x[0] = mouseX;
  y[0] = mouseY;
  indexPosition = (4 + 1) % 4; // indexPosition = 5 % 4 = 1
  i = 0 --> pos = (1 + 0) % 4; // pos = 1 % 4 = 1
  i = 1 --> pos = (1 + 1) % 4; // pos = 2 % 4 = 2
  i = 2 --> pos = (1 + 2) % 4; // pos = 3 % 4 = 3
  i = 3 --> pos = (1 + 3) % 4; // pos = 4 % 4 = 0
  
  And so on...
  */
}

void keyPressed() {
  // to check canvas on current frame (saved on sketch folder)
  if(keyCode == RIGHT) saveFrame("frame.png");
}
