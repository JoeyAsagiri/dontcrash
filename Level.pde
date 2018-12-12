class Level {
  int[] level1Links = new int[tileCountLeft];
  int[] level1Rechts = new int[tileCountRight];
  boolean[] level1LinksSelect = new boolean[tileCountRight];
  boolean[] level1RechtsSelect = new boolean[tileCountRight];

  int[] level2Links = new int[tileCountLeft];
  int[] level2Rechts = new int[tileCountRight];
  boolean[] level2LinksSelect = new boolean[tileCountRight];
  boolean[] level2RechtsSelect = new boolean[tileCountRight];

  int[] level3Links = new int[tileCountRight];
  int[] level3Rechts = new int[tileCountRight];
  boolean[] level3LinksSelect = new boolean[tileCountRight];
  boolean[] level3RechtsSelect = new boolean[tileCountRight];

  //Constructor class om de level arrays in te vullen wanneer de klass aangemaakt word
  Level() {
    level1Links[0] = 8;
    level1Links[1] = 6;
    level1Links[2] = 3;
    level1Links[3] = 8;
    level1Links[4] = 8;
    level1Links[5] = 8;
    level1Links[6] = 8;
    level1Links[7] = 8;

    level1LinksSelect[0] = true;
    level1LinksSelect[1] = true;
    level1LinksSelect[2] = true;
    level1LinksSelect[3] = false;
    level1LinksSelect[4] = false;
    level1LinksSelect[5] = false;
    level1LinksSelect[6] = false;
    level1LinksSelect[7] = false;
    level1LinksSelect[8] = false;

    level1Rechts[0] = 1;
    level1Rechts[1] = 8;
    level1Rechts[2] = 8;
    level1Rechts[3] = 8; 
    level1Rechts[4] = 6;
    level1Rechts[5] = 5;
    level1Rechts[6] = 8;
    level1Rechts[7] = 8;
    level1Rechts[8] = 7;
    level1Rechts[9] = 4;
    level1Rechts[10] = 8;
    level1Rechts[11] = 8;
    level1Rechts[12] = 3;
    level1Rechts[13] = 8;
    level1Rechts[14] = 8;
    level1Rechts[15] = 8;

    level1RechtsSelect[0] = true;
    level1RechtsSelect[1] = true;
    level1RechtsSelect[2] = true;
    level1RechtsSelect[3] = true;
    level1RechtsSelect[4] = true;
    level1RechtsSelect[5] = true;
    level1RechtsSelect[6] = false;
    level1RechtsSelect[7] = false;
    level1RechtsSelect[8] = true;
    level1RechtsSelect[9] = true;
    level1RechtsSelect[10] = false;
    level1RechtsSelect[11] = false;
    level1RechtsSelect[12] = true;
    level1RechtsSelect[13] = false;
    level1RechtsSelect[14] = false;
    level1RechtsSelect[15] = false;

    level2Links[0] = 8;
    level2Links[1] = 2;
    level2Links[2] = 3;
    level2Links[3] = 4;
    level2Links[4] = 5;
    level2Links[5] = 6;
    level2Links[6] = 7;
    level2Links[7] = 8;

    level2Rechts[0] = 1;
    level2Rechts[1] = 8;
    level2Rechts[2] = 8;
    level2Rechts[3] = 8; 
    level2Rechts[4] = 8;
    level2Rechts[5] = 8;
    level2Rechts[6] = 8;
    level2Rechts[7] = 8;
    level2Rechts[8] = 8;
    level2Rechts[9] = 8;
    level2Rechts[10] = 8;
    level2Rechts[11] = 8;
    level2Rechts[12] = 8;
    level2Rechts[13] = 8;
    level2Rechts[14] = 8;
    level2Rechts[15] = 8; 

    level3Links[0] = 3;
    level3Links[1] = 4;
    level3Links[2] = 6;
    level3Links[3] = 6;
    level3Links[4] = 1;
    level3Links[5] = 6;
    level3Links[6] = 7;
    level3Links[7] = 8;

    level3Rechts[0] = 1;
    level3Rechts[1] = 1;
    level3Rechts[2] = 1;
    level3Rechts[3] = 1; 
    level3Rechts[4] = 1;
    level3Rechts[5] = 1;
    level3Rechts[6] = 1;
    level3Rechts[7] = 1;
    level3Rechts[8] = 1;
    level3Rechts[9] = 1;
    level3Rechts[10] = 1;
    level3Rechts[11] = 1;
    level3Rechts[12] = 1;
    level3Rechts[13] = 1;
    level3Rechts[14] = 1;
    level3Rechts[15] = 1; 
  }
}
