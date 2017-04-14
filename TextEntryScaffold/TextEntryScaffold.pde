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

final float xsizeOfGroupButton = 80;
final float ysizeOfGroupButton = 50;
final float yPosGroupButton = 575;
final float xText = (xsizeOfGroupButton / 2); //arbitrary value of / 5 to account for spacing 
final float yText = (yPosGroupButton+ysizeOfGroupButton/2) + 5; //arbitrary value of + 5 to account for spacing 
ArrayList<Integer> xPosButtons = new ArrayList<Integer>();

final int DPIofYourDeviceScreen = 441; //you will need to look up the DPI or PPI of your device to make sure you get the right scale!!
                                      //http://en.wikipedia.org/wiki/List_of_displays_by_pixel_density
final float sizeOfInputArea = DPIofYourDeviceScreen*1; //aka, 1.0 inches square!
final int LETTER_STROKE_COLOR = 0;

//You can modify anything in here. This is just a basic implementation.
void setup()
{
  phrases = loadStrings("phrases2.txt"); //load the phrase set into memory
  Collections.shuffle(Arrays.asList(phrases)); //randomize the order of the phrases
    
  orientation(PORTRAIT); //can also be LANDSCAPE -- sets orientation on android device
  size(1000, 1000); //Sets the size of the app. You may want to modify this to your device. Many phones today are 1080 wide by 1920 tall.
  textFont(createFont("Arial", 24)); //set the font to arial 24
  noStroke(); //my code doesn't use any strokes.

   for (int i = 0; i < 5; i++)
  {
    int x = 225 + (i*75);
    xPosButtons.add(x);
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
    text("Entered:  " + currentTyped, 70, 140); //draw what the user has entered thus far 
    fill(255, 0, 0);
    rect(800, 00, 200, 200); //drag next button
    fill(255);
    text("NEXT > ", 850, 100); //draw next label

    //my draw code
    textAlign(CENTER);
    fill(255, 0, 0);
    textSize(40);
    rectMode(CENTER);
    //strokeWeight(5);
    stroke(LETTER_STROKE_COLOR);
    
    // 1st letter
    rect(260, 490, 80, 80);
    //fill(240, 0, 0, 50);
    stroke(LETTER_STROKE_COLOR);
    strokeWeight(5);
    
    // 2nd letter 
    rect(340, 490, 80, 80);
    //fill(230, 0, 0);
    stroke(LETTER_STROKE_COLOR);
    strokeWeight(5);

    
    // 3rd letter 
    rect(420, 490, 80, 80);
    //fill(220, 0, 0);
    stroke(LETTER_STROKE_COLOR);
    
    // 4th letter 
    rect(500, 490, 80, 80);
    //fill(220, 0, 0);
    stroke(LETTER_STROKE_COLOR);
    
    // 5th letter 
    rect(580, 490, 80, 80);
    //fill(220, 0, 0);
    stroke(LETTER_STROKE_COLOR);
    fill(0,0,0);
    text(currentFirstLetter, 260, 500); 
    text(currentSecondLetter, 340, 500);
    text(currentThirdLetter, 420, 500);
    text(currentFourthLetter, 500, 500);
    text(currentFifthLetter, 580, 500);
    drawBackspace();
    drawSpace();



    rectMode(CORNER);
    //rect(200, 200+sizeOfInputArea/2, sizeOfInputArea/2, sizeOfInputArea/2); //draw left red button
    fill(0, 255, 0);
    textSize(30);
    //rect(200+sizeOfInputArea/2, 200+sizeOfInputArea/2, sizeOfInputArea/2, sizeOfInputArea/2); //draw right green button

    fill(255);

    //drawing five buttons for alphabet

    rect(xPosButtons.get(0), yPosGroupButton, xsizeOfGroupButton, ysizeOfGroupButton); //drag next button
    rect(xPosButtons.get(1), yPosGroupButton, xsizeOfGroupButton, ysizeOfGroupButton); //drag next button
    rect(xPosButtons.get(2), yPosGroupButton, xsizeOfGroupButton, ysizeOfGroupButton); //drag next button
    rect(xPosButtons.get(3), yPosGroupButton, xsizeOfGroupButton, ysizeOfGroupButton); //drag next button
    rect(xPosButtons.get(4), yPosGroupButton, xsizeOfGroupButton, ysizeOfGroupButton); //drag next button

    fill(0);
    text("a-e", xPosButtons.get(0) + xText, yText); //draw next label
    text("f-k", xPosButtons.get(1) + xText, yText);
    text("l-p", xPosButtons.get(2) + xText, yText);
    text("q-u", xPosButtons.get(3) + xText, yText);
    text("v-z", xPosButtons.get(4) + xText, yText);

  }
  
}

void drawSpace() {
 stroke(LETTER_STROKE_COLOR);   
 fill(255,0,0);
 rect(600, 240, 80, 80);
 fill(0);
 text("_", 600, 250);
}

void drawBackspace() {
 stroke(LETTER_STROKE_COLOR);   
 fill(255,0,0);
 rect(240, 240, 80, 80);
 fill(0);
 text("X", 240, 250);
}

boolean didMouseClick(float x, float y, float w, float h) //simple function to do hit testing
{
  return (mouseX > x && mouseX<x+w && mouseY>y && mouseY<y+h); //check to see if it is in button bounds
}

void mousePressed()
{
  println("Mouse X is: " + mouseX + " Mouse Y is " + mouseY);

  if (didMouseClick(200, 200, 80, 80) && currentTyped.length()>0) {
    currentTyped = currentTyped.substring(0, currentTyped.length()-1);
  }
  
  if (didMouseClick(560, 200, 80, 80)) {
    currentTyped += ' ';
  }

  if (didMouseClick(220, 450, 80, 80)) //check if click in first letter button
  {
    println("In 1");
    currentTyped+=currentFirstLetter;
  }
  else if (didMouseClick(300, 450, 80, 80)) //check if click in second letter button
  {
    println("In 2");
    currentTyped+=currentSecondLetter;
  }
  else if (didMouseClick(380, 450, 80, 80)) //check if click in third letter button
  {
    currentTyped+=currentThirdLetter;
  }
  
  else if (didMouseClick(460, 450, 80, 80)) //check if click in fourth letter button
  {
    currentTyped+=currentFourthLetter;
  }
  else if (didMouseClick(520, 450, 80, 80)) //check if click in fifth letter button
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
