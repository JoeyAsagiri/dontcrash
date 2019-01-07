class Timer {
  // variables
  int starttime, stoptime;
  int elapsed;
  int minutes = 0;
  int seconds = 0;
  int level;
  boolean running = false;
  boolean saved = false;
  Table table;

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
    int score = initialScore - (seconds * 10) - (moves * 100); 
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
    text(score(), 1200, 710);
  }
  
  void displayLevelBest(int level, float X, float Y){
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
      if (!running) {
        StartTime();
      }
      TijdSeconden();
      TijdMinuten();
    } else if (win == true && gameState == inGame) {
      if (!saved) {
        saveTime();
      }
      StopTime();
    } else if (gameState != inGame) {
      saved = false;
      running = false;
      elapsed = 0;
      seconds = 0;
      minutes = 0;
    }
  }

  // Function to save the current time and score to best_times.csv if the current time in the level is better than the previous best
  void saveTime() {
    TableRow previousRecord = table.findRow(str(selectLevel+1), "Level");
    int previousElapsed = previousRecord.getInt("Elapsed time");
    int previousScore = previousRecord.getInt("Score");
    // Only save if the current time is shorter than the previously recorded time
    if (previousElapsed > elapsed) {
      previousRecord.setInt("Elapsed time", elapsed);
      previousRecord.setString("Time string", str(minutes) + ": " + str(seconds));
      saveTable(table, "best_times.csv");
    }
    if (previousScore < score()) {
      previousRecord.setInt("Score", score());
      saveTable(table, "best_times.csv");
    }
    saved = true;
  }
}
