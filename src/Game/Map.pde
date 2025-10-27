class Map {
  ArrayList<Integer>[][] map;
  int cellSize = 20;
  int rows, cols, mval = 0;
  int ta, ty, tx;
  int location, rval, lval, dval, uval;

  Map() {
    cols = width / cellSize;
    rows = height / cellSize;
    map = (ArrayList<Integer>[][]) new ArrayList[cols][rows];
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        map[i][j] = new ArrayList<Integer>();
      }
    }
    //actually filling the map array
    map[10][20].add(4);
    map[11][20].add(4);
    map[12][20].add(4);
    map[13][20].add(4);
    map[16][15].add(4);
    map[17][15].add(4);
    map[18][15].add(4);
    map[20][10].add(4);
    map[25][24].add(3);
    map[26][24].add(3);
    map[27][24].add(3);
    map[28][24].add(3);
    map[29][24].add(3);
    map[1][24].add(3);
    map[2][24].add(3);
    map[3][24].add(3);
    map[4][24].add(3);
    map[5][24].add(3);
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (i == 0 || j == 0 || i == cols-1 || j == rows-1) {
          map[i][j].add(3);
        }
        if (j >= rows - 5) {
          // Bottom 5 rows = ground
          map[i][j].add(3);
        } else {
          // Everything else = air
          map[i][j].add(1);
        }
      }
    }
    if (player != null ) {
      dval = getGroundBelowPlayer(int(player.x)/20);
    }
  }
  // work in progress for colision detection
  int getGroundBelowPlayer(int col) {
    // Clamp to valid bounds
    col = constrain(col, 0, cols - 1);

    int startRow = int(player.y / cellSize);
    startRow = constrain(startRow, 0, rows - 1);

    int foundRow = -1; // if no ground is found

    for (int i = startRow; i < rows; i++) {
      ArrayList<Integer> cell = map[col][i];
      if (cell == null) continue;

      // if any tile in this cell counts as solid
      if (cell.contains(3) || cell.contains(4)) {
        foundRow = i;
        break; // stop at first solid cell below
      }
    }

    // If we never found ground, return the bottom row (so you can treat it as "no ground")
    if (foundRow == -1) return rows - 1;

    return foundRow;
  }

  boolean hasSolidToRight(float px, float py, float pWidth, float pHeight) {
    int col = int(floor((px + pWidth) / cellSize));
    int topRow = int(floor((py - pHeight) / cellSize));
    int bottomRow = int(floor((py - 1) / cellSize)); // exclude below floor

    col = constrain(col, 0, cols - 1);
    topRow = constrain(topRow, 0, rows - 1);
    bottomRow = constrain(bottomRow, 0, rows - 1);

    for (int j = topRow; j <= bottomRow; j++) {
      ArrayList<Integer> cell = map[col][j];
      if (cell != null && (cell.contains(3) || cell.contains(4))) {
        return true;
      }
    }
    return false;
  }

  boolean hasSolidToLeft(float px, float py, float pHeight) {
    // left edge of player
    int col = int(floor(px / cellSize));

    // player top and bottom rows
    int topRow = int(floor((py - pHeight/2) / cellSize));
    int bottomRow = int(floor((py + pHeight/2 - 1) / cellSize)); // include only player's height

    // constrain to map
    col = constrain(col, 0, cols - 1);
    topRow = constrain(topRow, 0, rows - 1);
    bottomRow = constrain(bottomRow, 0, rows - 1);

    for (int j = topRow; j <= bottomRow; j++) {
      ArrayList<Integer> cell = map[col][j];
      if (cell != null && (cell.contains(3) || cell.contains(4))) {
        return true;
      }
    }
    return false;
  }

  void drawMap() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        ArrayList<Integer> cell = map[i][j];
        fill(50);
        if (cell.contains(0)) fill(0, 150, 255); // e.g. water
        if (cell.contains(3)) fill(0, 255, 0);   // e.g. terrain
        if (cell.contains(4)) fill(50, 150, 200);
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      }
    }
  }
}
