class Event{
  String name;
  int difficulty;
  int firstYear, firstMonth, firstDay;
  boolean bucketList_YorN;
  
  Event(String n, int d, int y, int m, int day) {
  this.name = n;
  this.difficulty = d;
  this.firstYear = y;
  this.firstMonth = m;
  this.firstDay = day;
  this.bucketList_YorN = false;
  }
}
