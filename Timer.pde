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

  // function om tijd te displayen in game
  void displayTime() {
    fill(#000000);
    textSize(25);
    textAlign(CENTER);
    text(minutes, 1200, 700);
    text(":", 1230, 700);
    text(seconds, 1260, 700);
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

  // Function to save the current time to best_times.csv if the current time in the level is better than the previous best
  void saveTime() {
    TableRow previousTime = table.findRow(str(selectLevel), "Level");
    int previousElapsed = previousTime.getInt("Elapsed time");
    // Only save if the current time is shorter than the previously recorded time
    if (previousElapsed > elapsed) {
      previousTime.setInt("Elapsed time", elapsed);
      previousTime.setString("Time string", str(minutes) + " minutes : " + str(seconds) + " seconds");
      saveTable(table, "best_times.csv");
    }
    saved = true;
  }
}
