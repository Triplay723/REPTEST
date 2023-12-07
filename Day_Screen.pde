void drawDayScreen(int month, int day) {  
  int padding = 70;
  
  Day currentDay = Days[year-startingYear][month-1][dayBeingShown - 1];
  
  textSize(40);
  fill(255);
  rectMode(CORNERS);  
  
  textAlign(LEFT);
  text(nameOfMonth(month) + " " + day, 100,93);
  textAlign(CENTER);
  
  rect(0+padding, 120, width-padding, height-padding);
  rect(0+padding, 470, width-padding, height-padding);
  
  textSize(23);
  text("Finished!", 780, 92);
  checkmark = loadImage("green check.png");
  xMark = loadImage("x mark.png");
  emptyBucket = loadImage("empty bucket icon.png");
  fullBucket = loadImage("full bucket icon.png");
  image(checkmark, 843, 65, 40, 40);
  
  button1.setVisible(true);
  custom_slider1.setVisible(true);
  textfield1.setVisible(true);  
  
  //Difficulty/priority text
  textSize(14);
  fill(0,0,255);
  text("Difficulty/Priority", 660, 486);
  fill(255);
  
  for (int i=0; i < currentDay.events.size(); i++) {
    fill(0);
    textSize(20);
    textAlign(LEFT);
    text(currentDay.events.get(i).name, 96, 160+35*i); //9 event maximum
    textAlign(CENTER);
    image(xMark, 600, 145+35*i, 20, 20);
    textSize(13);
    text("Delete Event", 660, 160+35*i);
    if (Days[year-startingYear][month-1][dayBeingShown - 1].events.get(i).bucketList_YorN == false)
      image(emptyBucket, 727, 145+35*i, 25, 25);
    else
      image(fullBucket, 727, 145+35*i, 25, 25);
    fill(255);
  }
  
  if (mousePressed == true) {
    
    //If clicked the "finished!" button
    if(mouseX >= 840 && mouseX <= 885) {
      if (mouseY >= 65 && mouseY <= 105) {
        DrawDayScreen = false;
        textfield1.setVisible(false);
        custom_slider1.setVisible(false);
        DrawOnce = true;
        randomizeAffirmation();
      }
    }
    
    //if clicked "delete" an event
    for (int i=0; i<currentDay.events.size(); i++) { //check for each event
      if (mouseX >= 594 && mouseX <= 700) {
        if (mouseY >=140+35*i && mouseY <= 164+35*i) {          
                    
          String eventName = currentDay.events.get(i).name;     
          boolean NewMonth = false;
          
          int pseudoYear = currentDay.events.get(i).firstYear;
          int pseudoMonth = currentDay.events.get(i).firstMonth;
          int pseudoDay = currentDay.events.get(i).firstDay;
          
          int numberDifficulty = Days[year-startingYear][month-1][dayBeingShown - 1].events.get(i).difficulty;                                                
          
          removeEvent(eventName, Days[pseudoYear - startingYear][ pseudoMonth - 1][pseudoDay - 1]);
          
          for (int n = 0; n < lengthOfMonth(pseudoYear, pseudoMonth); n++){                                               
            if (isValueInArray(n + 1, difficulties[numberDifficulty - 1])){
              if (pseudoDay - 1 + n < lengthOfMonth(pseudoYear, pseudoMonth)){                
                removeEvent(eventName, Days[pseudoYear-startingYear][pseudoMonth - 1][pseudoDay - 1 + n]);
              }
              
              else if ((pseudoDay - 1) + (n+1)> lengthOfMonth(pseudoYear, pseudoMonth) && NewMonth == false){ 
                NewMonth = true;
                
                StartOfNewMonth = ((pseudoDay - 1) + (n+1)) - lengthOfMonth(pseudoYear, pseudoMonth) - 1;
                pseudoMonth = pseudoMonth + 1;                
                
                if (pseudoMonth == 13){ // small issue but ill ask Teja how to deal with it
                  pseudoMonth = 1;
                  pseudoYear += 1; 
                }                               
                                
                removeEvent(eventName, Days[pseudoYear-startingYear][pseudoMonth - 1][StartOfNewMonth]);
                AddedIncriments = n - StartOfNewMonth;
              }

              
              else if (NewMonth == true){                
                AddedIncriments = n - StartOfNewMonth - (lengthOfMonth(pseudoYear, pseudoMonth) - pseudoDay);
                removeEvent(eventName, Days[pseudoYear-startingYear][pseudoMonth - 1][StartOfNewMonth + AddedIncriments - 1]);                            
              }              
            }            
          }          
        }          
      }
    }
    
      //If turn an event into type bucket list
    for (int i=0; i<Days[year-startingYear][month-1][dayBeingShown - 1].events.size(); i++) { //check for each event
      if (mouseX >= 720 && mouseX <= 759) {
        if (mouseY >=138+35*i && mouseY <= 169+35*i) {
          Days[year-startingYear][month-1][dayBeingShown - 1].events.get(i).bucketList_YorN = !Days[year-startingYear][month-1][dayBeingShown - 1].events.get(i).bucketList_YorN;
          if (Days[year-startingYear][month-1][dayBeingShown - 1].events.get(i).bucketList_YorN == false)
            image(emptyBucket, 727, 145+35*i, 25, 25);
          else
            image(fullBucket, 727, 145+35*i, 25, 25);          
        }
      }
    }
  }
  rect(93,480, 570,520); //border around text field
}
