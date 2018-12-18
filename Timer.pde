class Timer {
  // variables
  int starttime, stoptime;
  int elapsed;
  int minutes = 0;
  int seconds = 0;
  boolean running = false;

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
      println(starttime);
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
      StopTime();
    } else if (gameState != inGame) {
      running = false;
      elapsed = 0;
      seconds = 0;
      minutes = 0;
    }
  }
}
