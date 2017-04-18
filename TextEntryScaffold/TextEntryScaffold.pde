import java.util.Arrays;
import java.util.Collections;

String[] phrases; //contains all of the phrases
int totalTrialNum = 4; //the total number of phrases to be tested - set this low for testing. Might be ~10 for the real bakeoff!
int currTrialNum = 0; // the current trial number (indexes into trials array above)
float startTime = 0; // time starts when the first letter is entered
float finishTime = 0; // records the time of when the final trial ends
float lastTime = 0; //the timestamp of when the last trial was completed
float lettersEnteredTotal = 0; //a running total of the number of letters the user has entered (need this for final WPM computation)
float lettersExpectedTotal = 0; //a running total of the number of letters expected (correct phrases)
float errorsTotal = 0; //a running total of the number of errors (when hitting next)
String currentPhrase = ""; //the current target phrase
String currentTyped = ""; //what the user has typed so far
char currentFirstLetter = 'a';
char currentSecondLetter = 'b';
char currentThirdLetter = 'c';
char currentFourthLetter = 'd';
char currentFifthLetter = 'e';

ArrayList<Character> letters = new ArrayList<Character>();
ArrayList<Character> letters1 = new ArrayList<Character>();
ArrayList<Character> letters2 = new ArrayList<Character>();
ArrayList<Character> letters3 = new ArrayList<Character>();

boolean zoom = false;
boolean zoom1 = false;
boolean zoom2 = false;
boolean zoom3 = false;
String printTyped = " ";

final int backSpaceX = 250;
final int spaceX = 684;
final int yTopButton = 250;
final int sizeOfTopButton = 100;
final int letterY = 420;
final int sizeOfLetterButton = 100;

int xsizeOfGroupButton = 50;
int ysizeOfGroupButton = 60;

float yPosGroupButtonOne = 400;
float yPosGroupButtonTwo = 475;
float yPosGroupButtonThree = 550;
float xText = (xsizeOfGroupButton / 2); //arbitrary value of 10 to account for spacing 
float yTextOne = (yPosGroupButtonOne+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
float yTextTwo = (yPosGroupButtonTwo+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
float yTextThree = (yPosGroupButtonThree+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
ArrayList<Integer> xPosButtons = new ArrayList<Integer>();
ArrayList<Integer> letterXPosButtons = new ArrayList<Integer>();
ArrayList<Integer> zoom1X = new ArrayList<Integer>();
ArrayList<Integer> zoom2X = new ArrayList<Integer>();
ArrayList<Integer> zoom3X = new ArrayList<Integer>();



final int DPIofYourDeviceScreen = 534; //you will need to look up the DPI or PPI of your device to make sure you get the right scale!!
                                      //http://en.wikipedia.org/wiki/List_of_displays_by_pixel_density
final float sizeOfInputArea = DPIofYourDeviceScreen*1; //aka, 1.0 inches square!
final int LETTER_STROKE_COLOR = 0;
final int zoomAreaOneX = 200;
final int zoomAreaY = 290; 
final int zoomAreaSizeX = 177;
final int zoomAreaSizeY = 440;
final int zoomAreaTwoX = zoomAreaOneX + zoomAreaSizeX;
final int zoomAreaThreeX = zoomAreaTwoX + zoomAreaSizeX;

int xsizeOfZoom1 = 120;

//You can modify anything in here. This is just a basic implementation.
void setup()
{
  int i;
  int x;
  phrases = loadStrings("phrases2.txt"); //load the phrase set into memory
  Collections.shuffle(Arrays.asList(phrases)); //randomize the order of the phrases
    
  orientation(PORTRAIT); //can also be LANDSCAPE -- sets orientation on android device
  size(1000, 1000); //Sets the size of the app. You may want to modify this to your device. Many phones today are 1080 wide by 1920 tall.
  textFont(createFont("Arial", 24)); //set the font to arial 24
  noStroke(); //my code doesn't use any strokes.

  letters.add('q');
  letters.add('w');
  letters.add('e');
  letters.add('r');
  letters.add('t');
  letters.add('y');
  letters.add('u');
  letters.add('i');
  letters.add('o');
  letters.add('p');
  letters.add('a');
  letters.add('s');
  letters.add('d');
  letters.add('f');
  letters.add('g');
  letters.add('h');
  letters.add('j');
  letters.add('k');
  letters.add('l');
  letters.add('z');
  letters.add('x');
  letters.add('c');
  letters.add('v');
  letters.add('b');
  letters.add('n');
  letters.add('m');
  
  letters1.add('q');
  letters1.add('w');
  letters1.add('e');
  letters1.add('r');
  letters1.add('a');
  letters1.add('s');
  letters1.add('d');
  letters1.add('z');
  letters1.add('x');
  
  letters2.add('r');
  letters2.add('t');
  letters2.add('y');
  letters2.add('u');
  letters2.add('f');
  letters2.add('g');
  letters2.add('h');
  letters2.add('c');
  letters2.add('v');
  letters2.add('b');
  letters2.add('n');
  
  letters3.add('i');
  letters3.add('o');
  letters3.add('p');
  letters3.add('j');
  letters3.add('k');
  letters3.add('l');
  letters3.add('n');
  letters3.add('m');

  // row 1
  for (i = 0; i < 10; i++)
  {
    x = 210 + (i*xsizeOfGroupButton);
    xPosButtons.add(x);
  }
    
  // row 2
  for (i = 0; i < 9; i++)
  {
    x = 235 + (i*xsizeOfGroupButton);
    xPosButtons.add(x);
  }
    
  // row 3
  for (i = 0; i < 7; i++)
  {
    x = 285 + (i*xsizeOfGroupButton);
    xPosButtons.add(x);
  }
  
  
  // zoom1 row 1
  for (i = 0; i < 4; i++)
  {
    x = 220 + (i*xsizeOfZoom1);
    zoom1X.add(x);
  }
    
  // row 2
  for (i = 0; i < 3; i++)
  {
    x = 275 + (i*xsizeOfZoom1);
    zoom1X.add(x);
  }
    
  for (i = 0; i < 2; i++)
  {
    x = 335 + (i*xsizeOfZoom1);
    zoom1X.add(x);
  }

  //zoom 2 row1
  for (i = 0; i < 4; i++)
  {
    x = 230 + (i*xsizeOfZoom1);
    zoom2X.add(x);
  }
    
  // row 2
  for (i = 0; i < 3; i++)
  {
    x = 300 + (i*xsizeOfZoom1);
    zoom2X.add(x);
  }
    
  // row 3
  for (i = 0; i < 3; i++)
  {
    x = 300 + (i*xsizeOfZoom1);
    zoom2X.add(x);
  }


  // zoom 3 row 1
  for (i = 0; i < 3; i++)
  {
    x = 335 + (i*xsizeOfZoom1);
    zoom3X.add(x);
  }
    
  // row 2
  for (i = 0; i < 3; i++)
  {
    x = 300 + (i*xsizeOfZoom1);
    zoom3X.add(x);
  }
    
  for (i = 0; i < 2; i++)
  {
    x = 255 + (i*xsizeOfZoom1);
    zoom3X.add(x);
  }



}



//You can modify anything in here. This is just a basic implementation.
void draw()
{
  background(0); //clear background

 // image(watch,-200,200);
  fill(100);
  rect(200, 200, sizeOfInputArea, sizeOfInputArea); //input area should be 2" by 2"

  if (finishTime!=0)
  {
    fill(255);
    textAlign(CENTER);
    text("Finished", 280, 150);
    return;
  }

  if (startTime==0 & !mousePressed)
  {
    fill(255);
    textAlign(CENTER);
    text("Click to start time!", 280, 150); //display this messsage until the user clicks!
  }

  if (startTime==0 & mousePressed)
  {
    nextTrial(); //start the trials!
  }

  if (startTime!=0)
  {
    //you will need something like the next 10 lines in your code. Output does not have to be within the 2 inch area!
    textAlign(LEFT); //align the text left
    fill(128);
    text("Phrase " + (currTrialNum+1) + " of " + totalTrialNum, 70, 50); //draw the trial count
    fill(255);
    text("Target:   " + currentPhrase, 70, 100); //draw the target string
    printTyped = currentTyped.replace(" ", "_");
    text("Entered:  " + printTyped, 70, 140); //draw what the user has entered thus far 
    fill(255, 0, 0);
    rect(800, 00, 200, 200); //drag next button
    fill(255);
    text("NEXT > ", 850, 100); //draw next label

    //my draw code
    textAlign(CENTER);
    fill(255, 0, 0);
    textSize(40);
    rectMode(CENTER);
    strokeWeight(5);
    stroke(LETTER_STROKE_COLOR);
    
    drawBackspace();
    drawSpace();

    rectMode(CORNER);
    fill(0,0,255);
    rect(zoomAreaOneX, zoomAreaY, zoomAreaSizeX, zoomAreaSizeY);
    fill(0,0,255,500);
    rect(zoomAreaTwoX, zoomAreaY, zoomAreaSizeX, zoomAreaSizeY);
    fill(0,0,255,300);
    rect(zoomAreaThreeX, zoomAreaY, zoomAreaSizeX, zoomAreaSizeY);
    fill(0, 255, 0);
    textSize(30);

    fill(255);
    textSize(30);
    
    if (zoom1) {
      zoomFirst();
    }
    else if (zoom2)
    {
      zoomSecond();
    }

    else if (zoom3)
    {
      zoomThird(); 
    }
    else {
      drawUnZoom();
    }
  }
}

void zoomFirst() {
  int i;
  xsizeOfGroupButton = 120;
  ysizeOfGroupButton = 120;
  yPosGroupButtonOne = 300;
  yPosGroupButtonTwo = 450;
  yPosGroupButtonThree = 600;
  xText = (xsizeOfGroupButton / 2); //arbitrary value of 10 to account for spacing 
  yTextOne = (yPosGroupButtonOne+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
  yTextTwo = (yPosGroupButtonTwo+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
  yTextThree = (yPosGroupButtonThree+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
  // row 1
  for (i = 0; i < 4; i++)
  {
    fill(255);
    rect(zoom1X.get(i), yPosGroupButtonOne, xsizeOfGroupButton, ysizeOfGroupButton);
    fill(0);
    text(letters1.get(i), zoom1X.get(i) + xText, yTextOne);
  }
    
  // row 2
  for (i = 0; i < 3; i++)
  {
    fill(255);
    rect(zoom1X.get(i+4), yPosGroupButtonTwo, xsizeOfGroupButton, ysizeOfGroupButton);
    fill(0);      
    text(letters1.get(i+4), zoom1X.get(i+4) + xText, yTextTwo);
  }
    
  // row 3
  for (i = 0; i < 2; i++)
  {
    fill(255);
    rect(zoom1X.get(i+7), yPosGroupButtonThree, xsizeOfGroupButton, ysizeOfGroupButton);
    fill(0);
    text(letters1.get(i+7), zoom1X.get(i+7) + xText, yTextThree);
  }
    
}

void zoomSecond() {
    int i;
    xsizeOfGroupButton = 120;
    ysizeOfGroupButton = 120;
    yPosGroupButtonOne = 300;
    yPosGroupButtonTwo = 450;
    yPosGroupButtonThree = 600;
    xText = (xsizeOfGroupButton / 2); //arbitrary value of 10 to account for spacing 
    yTextOne = (yPosGroupButtonOne+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
    yTextTwo = (yPosGroupButtonTwo+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
    yTextThree = (yPosGroupButtonThree+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
    // row 1
    for (i = 0; i < 4; i++)
    {
      fill(255);
      rect(zoom2X.get(i), yPosGroupButtonOne, xsizeOfGroupButton, ysizeOfGroupButton);
      fill(0);
      text(letters2.get(i), zoom2X.get(i) + xText, yTextOne);
    }
      
    // row 2
    for (i = 0; i < 3; i++)
    {
      fill(255);
      rect(zoom2X.get(i+4), yPosGroupButtonTwo, xsizeOfGroupButton, ysizeOfGroupButton);
      fill(0);      
      text(letters2.get(i+4), zoom2X.get(i+4) + xText, yTextTwo);
    }
      
    // row 3
    for (i = 0; i < 3; i++)
    {
      fill(255);
      rect(zoom2X.get(i+7), yPosGroupButtonThree, xsizeOfGroupButton, ysizeOfGroupButton);
      fill(0);
      text(letters2.get(i+7), zoom2X.get(i+7) + xText, yTextThree);
    }
}
void zoomThird() {
  int i;
  xsizeOfGroupButton = 120;
  ysizeOfGroupButton = 120;
  yPosGroupButtonOne = 300;
  yPosGroupButtonTwo = 450;
  yPosGroupButtonThree = 600;
  xText = (xsizeOfGroupButton / 2); //arbitrary value of 10 to account for spacing 
  yTextOne = (yPosGroupButtonOne+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
  yTextTwo = (yPosGroupButtonTwo+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
  yTextThree = (yPosGroupButtonThree+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
  // row 1
  for (i = 0; i < 3; i++)
  {
    fill(255);
    rect(zoom3X.get(i), yPosGroupButtonOne, xsizeOfGroupButton, ysizeOfGroupButton);
    fill(0);
    text(letters3.get(i), zoom3X.get(i) + xText, yTextOne);
  }
    
  // row 2
  for (i = 0; i < 3; i++)
  {
    fill(255);
    rect(zoom3X.get(i+3), yPosGroupButtonTwo, xsizeOfGroupButton, ysizeOfGroupButton);
    fill(0);      
    text(letters3.get(i+3), zoom3X.get(i+3) + xText, yTextTwo);
  }
    
  // row 3
  for (i = 0; i < 2; i++)
  {
    fill(255);
    rect(zoom3X.get(i+6), yPosGroupButtonThree, xsizeOfGroupButton, ysizeOfGroupButton);
    fill(0);
    text(letters3.get(i+6), zoom3X.get(i+6) + xText, yTextThree);
  }
}


void drawUnZoom() {
  int i;
  // row 1
    for (i = 0; i < 10; i++)
    {
      fill(255);
      rect(xPosButtons.get(i), yPosGroupButtonOne, xsizeOfGroupButton, ysizeOfGroupButton);
      fill(0);
      text(letters.get(i), xPosButtons.get(i) + xText, yTextOne);
    }
      
    // row 2
    for (i = 0; i < 9; i++)
    {
      fill(255);
      rect(xPosButtons.get(i+10), yPosGroupButtonTwo, xsizeOfGroupButton, ysizeOfGroupButton);
      fill(0);      
      text(letters.get(i+10), xPosButtons.get(i+10) + xText, yTextTwo);
    }
      
    // row 3
    for (i = 0; i < 7; i++)
    {
      fill(255);
      rect(xPosButtons.get(i+19), yPosGroupButtonThree, xsizeOfGroupButton, ysizeOfGroupButton);
      fill(0);
      text(letters.get(i+19), xPosButtons.get(i+19) + xText, yTextThree);
    }
}

void unzoom() {
  zoom = false;
  zoom1 = false;
  zoom2 = false;
  zoom3 = false;
  xsizeOfGroupButton = 50;
  ysizeOfGroupButton = 60;
  yPosGroupButtonOne = 400;
  yPosGroupButtonTwo = 475;
  yPosGroupButtonThree = 550;
  xText = (xsizeOfGroupButton / 2); //arbitrary value of 10 to account for spacing 
  yTextOne = (yPosGroupButtonOne+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
  yTextTwo = (yPosGroupButtonTwo+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
  yTextThree = (yPosGroupButtonThree+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
}

void drawSpace() {
 stroke(LETTER_STROKE_COLOR);   
 fill(255,0,0);
 rect(spaceX, yTopButton, sizeOfTopButton, sizeOfTopButton);
 fill(0);
 text("_", spaceX, yTopButton);
}

void drawBackspace() {
 stroke(LETTER_STROKE_COLOR);   
 fill(255,0,0);
 rect(backSpaceX, yTopButton, sizeOfTopButton, sizeOfTopButton);
 fill(0);
 text("X", backSpaceX, yTopButton+10);
}

boolean didMouseClick(float x, float y, float w, float h) //simple function to do hit testing
{
  return (mouseX > x && mouseX<x+w && mouseY>y && mouseY<y+h); //check to see if it is in button bounds
}

char zoom1Click(int x, int y) {
  int i;
  for (i = 0; i < 4; i++) {
    if (didMouseClick(220+(i*xsizeOfZoom1), yPosGroupButtonOne, xsizeOfGroupButton, xsizeOfGroupButton)) {
      println("clicked in first row got: %c", letters1.get(i));
      return letters1.get(i);
    }
  }
  for (i = 0; i < 3; i++) {
    if (didMouseClick(275+(i*xsizeOfZoom1), yPosGroupButtonTwo, xsizeOfGroupButton, xsizeOfGroupButton)) {
      return letters1.get(i+4);
    }
  }
  for (i = 0; i < 2; i++) {
    if (didMouseClick(335+(i*xsizeOfZoom1), yPosGroupButtonThree, xsizeOfGroupButton, xsizeOfGroupButton)) {
      return letters1.get(i+7);
    }
  }
  return 0;
}

char zoom2Click(int x, int y) {
  int i;
  for (i = 0; i < 4; i++) {
    if (didMouseClick(230+(i*xsizeOfZoom1), yPosGroupButtonOne, xsizeOfGroupButton, xsizeOfGroupButton)) {
      return letters2.get(i);
    }
  }
  for (i = 0; i < 3; i++) {
    if (didMouseClick(300+(i*xsizeOfZoom1), yPosGroupButtonTwo, xsizeOfGroupButton, xsizeOfGroupButton)) {
      return letters2.get(i+4);
    }
  }
  for (i = 0; i < 3; i++) {
    if (didMouseClick(300+(i*xsizeOfZoom1), yPosGroupButtonThree, xsizeOfGroupButton, xsizeOfGroupButton)) {
      return letters2.get(i+7);
    }
  }
  return 0;
}

char zoom3Click(int x, int y) {
  int i;
  for (i = 0; i < 3; i++) {
    if (didMouseClick(335+(i*xsizeOfZoom1), yPosGroupButtonOne, xsizeOfGroupButton, xsizeOfGroupButton)) {
      println("clicked in first row got: %c", letters1.get(i));
      return letters3.get(i);
    }
  }
  for (i = 0; i < 3; i++) {
    if (didMouseClick(300+(i*xsizeOfZoom1), yPosGroupButtonTwo, xsizeOfGroupButton, xsizeOfGroupButton)) {
      return letters3.get(i+3);
    }
  }
  for (i = 0; i < 2; i++) {
    if (didMouseClick(255+(i*xsizeOfZoom1), yPosGroupButtonThree, xsizeOfGroupButton, xsizeOfGroupButton)) {
      return letters3.get(i+6);
    }
  }
  return 0;
}

void mousePressed()
{
  if (startTime == 0) {
    return;
  }
  println(mouseX + " " + mouseY);
  //if (zoom) {
  //  unzoom();
  // }
  if (didMouseClick(backSpaceX-sizeOfTopButton/2, yTopButton-sizeOfTopButton/2, sizeOfTopButton, sizeOfTopButton) && currentTyped.length()>0) {
    currentTyped = currentTyped.substring(0, currentTyped.length()-1);
  }
  
  else if (didMouseClick(spaceX-sizeOfTopButton/2, yTopButton-sizeOfTopButton/2, sizeOfTopButton, sizeOfTopButton)) {
    currentTyped += ' ';
  }
  
  else if (zoom1) {
    char res = zoom1Click(mouseX, mouseY);
    if (res != 0) {
      currentTyped += res;
    }
    else {
      unzoom();
    }
  }
  else if (zoom2) {
    char res = zoom2Click(mouseX, mouseY);
    if (res != 0) {
      currentTyped += res;
    }
    else {
      unzoom();
    }
  }
  else if (zoom3) {
    char res = zoom3Click(mouseX, mouseY);
    if (res != 0) {
      currentTyped += res;
    }
    else {
      unzoom();
    }
  }
  else if (!zoom && didMouseClick(zoomAreaOneX, zoomAreaY, zoomAreaTwoX - zoomAreaOneX, 600)) //check if click in first letter button
  {
    zoom1 = true;
    zoom = true;
    println("Zooming first area");
    zoomFirst();
  }
  else if (!zoom && didMouseClick(zoomAreaTwoX, zoomAreaY, zoomAreaTwoX - zoomAreaOneX, 600)) //check if click in first letter button
  {
    zoom2 = true;
    zoom = true;
    println("Zooming 2nd area");
    zoomSecond();
  }
  else if (!zoom && didMouseClick(zoomAreaThreeX, zoomAreaY, zoomAreaTwoX - zoomAreaOneX, 600)) //check if click in first letter button
  { 
    zoom3 = true;
    zoom = true;
    println("Zooming third area");
    zoomThird();
  }


  //You are allowed to have a next button outside the 2" area
  if (didMouseClick(800, 00, 200, 200)) //check if click is in next button
  {
    nextTrial(); //if so, advance to next trial
  }
}


void nextTrial()
{
  if (currTrialNum >= totalTrialNum) //check to see if experiment is done
    return; //if so, just return

    if (startTime!=0 && finishTime==0) //in the middle of trials
  {
    System.out.println("==================");
    System.out.println("Phrase " + (currTrialNum+1) + " of " + totalTrialNum); //output
    System.out.println("Target phrase: " + currentPhrase); //output
    System.out.println("Phrase length: " + currentPhrase.length()); //output
    System.out.println("User typed: " + currentTyped); //output
    System.out.println("User typed length: " + currentTyped.length()); //output
    System.out.println("Number of errors: " + computeLevenshteinDistance(currentTyped.trim(), currentPhrase.trim())); //trim whitespace and compute errors
    System.out.println("Time taken on this trial: " + (millis()-lastTime)); //output
    System.out.println("Time taken since beginning: " + (millis()-startTime)); //output
    System.out.println("==================");
    lettersExpectedTotal+=currentPhrase.length();
    lettersEnteredTotal+=currentTyped.length();
    errorsTotal+=computeLevenshteinDistance(currentTyped.trim(), currentPhrase.trim());
  }

  //probably shouldn't need to modify any of this output / penalty code.
  if (currTrialNum == totalTrialNum-1) //check to see if experiment just finished
  {
    finishTime = millis();
    System.out.println("==================");
    System.out.println("Trials complete!"); //output
    System.out.println("Total time taken: " + (finishTime - startTime)); //output
    System.out.println("Total letters entered: " + lettersEnteredTotal); //output
    System.out.println("Total letters expected: " + lettersExpectedTotal); //output
    System.out.println("Total errors entered: " + errorsTotal); //output
    
    float wpm = (lettersEnteredTotal/5.0f)/((finishTime - startTime)/60000f); //FYI - 60K is number of milliseconds in minute
    System.out.println("Raw WPM: " + wpm); //output
    
    float freebieErrors = lettersExpectedTotal*.05; //no penalty if errors are under 5% of chars
    
    System.out.println("Freebie errors: " + freebieErrors); //output
    float penalty = max(errorsTotal-freebieErrors,0) * .5f;
    
    System.out.println("Penalty: " + penalty);
    System.out.println("WPM w/ penalty: " + (wpm-penalty)); //yes, minus, becuase higher WPM is better
    System.out.println("==================");
    
    currTrialNum++; //increment by one so this mesage only appears once when all trials are done
    return;
  }

  if (startTime==0) //first trial starting now
  {
    System.out.println("Trials beginning! Starting timer..."); //output we're done
    startTime = millis(); //start the timer!
  }
  else
  {
    currTrialNum++; //increment trial number
  }

  lastTime = millis(); //record the time of when this trial ended
  currentTyped = ""; //clear what is currently typed preparing for next trial
  currentPhrase = phrases[currTrialNum]; // load the next phrase!
  //currentPhrase = "abc"; // uncomment this to override the test phrase (useful for debugging)
}



//=========SHOULD NOT NEED TO TOUCH THIS METHOD AT ALL!==============
int computeLevenshteinDistance(String phrase1, String phrase2) //this computers error between two strings
{
  int[][] distance = new int[phrase1.length() + 1][phrase2.length() + 1];

  for (int i = 0; i <= phrase1.length(); i++)
    distance[i][0] = i;
  for (int j = 1; j <= phrase2.length(); j++)
    distance[0][j] = j;

  for (int i = 1; i <= phrase1.length(); i++)
    for (int j = 1; j <= phrase2.length(); j++)
      distance[i][j] = min(min(distance[i - 1][j] + 1, distance[i][j - 1] + 1), distance[i - 1][j - 1] + ((phrase1.charAt(i - 1) == phrase2.charAt(j - 1)) ? 0 : 1));

  return distance[phrase1.length()][phrase2.length()];
}