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

String printTyped = " ";
final int backSpaceX = 250;
final int spaceX = 684;
final int yTopButton = 250;
final int sizeOfTopButton = 100;
final int letterY = 420;
final int sizeOfLetterButton = 100;
final int xsizeOfGroupButton = 170;
final int ysizeOfGroupButton = 60;
final float yPosGroupButtonOne = 490;
final float yPosGroupButtonTwo = 565;
final float xText = (xsizeOfGroupButton / 2); //arbitrary value of 10 to account for spacing 
final float yTextOne = (yPosGroupButtonOne+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
final float yTextTwo = (yPosGroupButtonTwo+ysizeOfGroupButton/2) + 15; //arbitrary value of + 5 to account for spacing
ArrayList<Integer> xPosButtons = new ArrayList<Integer>();
ArrayList<Integer> letterXPosButtons = new ArrayList<Integer>();
final int DPIofYourDeviceScreen = 534; //you will need to look up the DPI or PPI of your device to make sure you get the right scale!!
                                      //http://en.wikipedia.org/wiki/List_of_displays_by_pixel_density
final float sizeOfInputArea = DPIofYourDeviceScreen*1; //aka, 1.0 inches square!
final int LETTER_STROKE_COLOR = 0;

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

  for (i = 0; i < 3; i++)
  {
    x = 210 + (i*xsizeOfGroupButton);
    xPosButtons.add(x);
  }
  
  for (i = 0; i < 2; i++)
  {
    x = 280 + (i*xsizeOfGroupButton);
    xPosButtons.add(x);
  }
  for (i = 0; i < 5; i++) 
  {
    int letterX = 267 + i * sizeOfLetterButton;
    letterXPosButtons.add(letterX);
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
    
    for (int i = 0; i < 5; i++) {
      // Minus 10 because rects are drawn oddly
      rect(letterXPosButtons.get(i), letterY-10, sizeOfLetterButton, sizeOfLetterButton);
    }
    
    fill(0,0,0);
    text(currentFirstLetter, letterXPosButtons.get(0), letterY); 
    text(currentSecondLetter, letterXPosButtons.get(1), letterY);
    text(currentThirdLetter, letterXPosButtons.get(2), letterY);
    text(currentFourthLetter, letterXPosButtons.get(3), letterY);
    text(currentFifthLetter, letterXPosButtons.get(4), letterY);
    drawBackspace();
    drawSpace();



    rectMode(CORNER);
    //rect(200, 200+sizeOfInputArea/2, sizeOfInputArea/2, sizeOfInputArea/2); //draw left red button
    fill(0, 255, 0);
    textSize(30);
    //rect(200+sizeOfInputArea/2, 200+sizeOfInputArea/2, sizeOfInputArea/2, sizeOfInputArea/2); //draw right green button

    fill(255);

    //drawing five buttons for alphabet

    rect(xPosButtons.get(0), yPosGroupButtonOne, xsizeOfGroupButton, ysizeOfGroupButton); //drag next button
    rect(xPosButtons.get(1), yPosGroupButtonOne, xsizeOfGroupButton, ysizeOfGroupButton); //drag next button
    rect(xPosButtons.get(2), yPosGroupButtonOne, xsizeOfGroupButton, ysizeOfGroupButton); //drag next button
    rect(xPosButtons.get(3), yPosGroupButtonTwo, xsizeOfGroupButton, ysizeOfGroupButton); //drag next button
    rect(xPosButtons.get(4), yPosGroupButtonTwo, xsizeOfGroupButton, ysizeOfGroupButton); //drag next button

    fill(0);
    textSize(40);
    text("a b c d e", xPosButtons.get(0) + xText, yTextOne); //draw next label
    text("f g h i j", xPosButtons.get(1) + xText, yTextOne);
    text("k l m n o", xPosButtons.get(2) + xText, yTextOne);
    text("p q r s t", xPosButtons.get(3) + xText, yTextTwo);
    text("u v w x y", xPosButtons.get(4) + xText, yTextTwo);
    
    textSize(30);
  }
  
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

void mousePressed()
{
  println("Mouse X is: " + mouseX + " Mouse Y is " + mouseY);

  if (didMouseClick(backSpaceX-sizeOfTopButton/2, yTopButton-sizeOfTopButton/2, sizeOfTopButton, sizeOfTopButton) && currentTyped.length()>0) {
    currentTyped = currentTyped.substring(0, currentTyped.length()-1);
  }
  
  println("Spce x is " + spaceX);
  if (didMouseClick(spaceX-sizeOfTopButton/2, yTopButton-sizeOfTopButton/2, sizeOfTopButton, sizeOfTopButton)) {
    currentTyped += ' ';
  }

  //checking for group buttons 

  if (didMouseClick(xPosButtons.get(0), yPosGroupButtonOne, xsizeOfGroupButton, ysizeOfGroupButton))
  {
    currentFirstLetter = 'a';
    currentSecondLetter = 'b';
    currentThirdLetter = 'c';
    currentFourthLetter = 'd';
    currentFifthLetter = 'e';
  }

  else if (didMouseClick(xPosButtons.get(1), yPosGroupButtonOne, xsizeOfGroupButton, ysizeOfGroupButton))
  {
    currentFirstLetter = 'f';
    currentSecondLetter = 'g';
    currentThirdLetter = 'h';
    currentFourthLetter = 'i';
    currentFifthLetter = 'j';
  }

  else if (didMouseClick(xPosButtons.get(2), yPosGroupButtonOne, xsizeOfGroupButton, ysizeOfGroupButton))
  {
    currentFirstLetter = 'k';
    currentSecondLetter = 'l';
    currentThirdLetter = 'm';
    currentFourthLetter = 'n';
    currentFifthLetter = 'o';
  }

  else if (didMouseClick(xPosButtons.get(3), yPosGroupButtonTwo, xsizeOfGroupButton, ysizeOfGroupButton))
  {
    currentFirstLetter = 'p';
    currentSecondLetter = 'q';
    currentThirdLetter = 'r';
    currentFourthLetter = 's';
    currentFifthLetter = 't';
  }

  else if (didMouseClick(xPosButtons.get(4), yPosGroupButtonTwo, xsizeOfGroupButton, ysizeOfGroupButton))
  {
    currentFirstLetter = 'u';
    currentSecondLetter = 'v';
    currentThirdLetter = 'w';
    currentFourthLetter = 'x';
    currentFifthLetter = 'y';
  }


  //checking for top five letters 
  int halfButton = sizeOfLetterButton/2;
  if (didMouseClick(letterXPosButtons.get(0) - halfButton, letterY - halfButton - 15, sizeOfLetterButton, sizeOfLetterButton)) //check if click in first letter button
  {
    currentTyped+=currentFirstLetter;
  }
  else if (didMouseClick(letterXPosButtons.get(1) - halfButton, letterY - halfButton - 15, sizeOfLetterButton, sizeOfLetterButton)) //check if click in second letter button
  {
    currentTyped+=currentSecondLetter;
  }
  else if (didMouseClick(letterXPosButtons.get(2) - halfButton, letterY - halfButton - 15, sizeOfLetterButton, sizeOfLetterButton)) //check if click in third letter button
  {
    currentTyped+=currentThirdLetter;
  }
  
  else if (didMouseClick(letterXPosButtons.get(3) - halfButton, letterY - halfButton - 15, sizeOfLetterButton, sizeOfLetterButton)) //check if click in fourth letter button
  {
    currentTyped+=currentFourthLetter;
  }
  else if (didMouseClick(letterXPosButtons.get(4) - halfButton, letterY - halfButton - 15, sizeOfLetterButton, sizeOfLetterButton)) //check if click in fifth letter button
  {
    currentTyped+=currentFifthLetter;
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