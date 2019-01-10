class Timer {
  // variables
  int starttime = 0, stoptime = 0;
  int elapsed;
  int minutes = 0;
  int seconds = 0;
  int level;
  boolean running = false;
  boolean saved = false;
  Table table;
  TableRow previousRecord;
  int previousScore;

  Timer() {
    table = loadTable("best_times.csv", "header");
  }

  //functie om tijd te starten
  void StartTime() {
    starttime = millis();
    running = true;
  }

  // functie om tijd te stoppen
  void StopTime() {
    stoptime = millis();
    running = false;
  }

  int getElapsedTime() {
    if (running) {
      elapsed = (millis() - starttime);
    } else {
      elapsed = (stoptime - starttime);
    }
    return elapsed;
  }

  // secondes optellen time krijgen
  void TijdSeconden () {
    if (gameState == inGame) {
      seconds = (getElapsedTime()  / 1000) % 60;
    }
  }

  void TijdMinuten() {
    if (gameState == inGame && seconds == 0) {
      minutes = (getElapsedTime() / (1000*60)) % 60;
    }
  }

  // function to keep track of the score
  int score() {
    // every second that passes lowers score by 10, and every move done lowers score by 100
    int score = initialScore - ((getElapsedTime()  / 1000) * 10) - (moves * 100); 
    if (score < 0) {
      score = 0;
    }
    return score;
  }

  // function om tijd te displayen in game
  void displayTime() {
    fill(#000000);
    textSize(25);
    textAlign(LEFT);
    text(minutes + ":" + seconds, 1200, 680);
    text("Score: " + score(), 1100, 710);
  }

  void displayLevelBest(int level, float X, float Y) {
    TableRow previousRecord = table.findRow(str(level), "Level");
    String bestTime = previousRecord.getString("Time string");
    int bestScore = previousRecord.getInt("Score");
    textAlign(LEFT);
    textSize(12);
    text("Time: " + bestTime, X - 45, Y + 20);
    text("Score: " + bestScore, X - 45, Y + 40);
  }

  void timeTrack () {
    if (gameState == inGame && win == false) {
      if (!running && starttime == 0) {
        StartTime();
      }
      TijdSeconden();
      TijdMinuten();
    } else if (gameState == winScreen) {
      if (!saved) {
        saveTime();
      }
    } else if (gameState != inGame && gameState != winScreen) {
      saved = false;
      running = false;
      elapsed = 0;
      seconds = 0;
      minutes = 0;
    }
  }

  void resetTimes() {
    for (int i = 1; i <= levelAmount; i++) {
      TableRow record = table.findRow(str(i), "Level");
      record.setInt("Elapsed time", 100000);
      record.setString("Time string", "0:0");
      record.setInt("Score", 0);
      saveTable(table, "best_times.csv");
    }
  }

  // Function to save the current time and score to best_times.csv if the current time in the level is better than the previous best
  void saveTime() {
    StopTime();
    println((stoptime - starttime));
    previousRecord = table.findRow(str(levelSelector+1), "Level");
    println(levelSelector+1);
    int previousElapsed = previousRecord.getInt("Elapsed time");
    previousScore = previousRecord.getInt("Score");
    println(previousElapsed);
    println(previousScore);
    // Only save if the current time is shorter than the previously recorded time
    if (previousElapsed > (stoptime - starttime)) {
      previousRecord.setInt("Elapsed time", (stoptime - starttime));
      previousRecord.setString("Time string", str(minutes) + ":" + str(seconds));
      saveTable(table, "best_times.csv");
    }
    if (previousScore < score()) {
      previousRecord.setInt("Score", score());
      saveTable(table, "best_times.csv");
    }
    saved = true;
  }
}
