class Map {
  ArrayList<Integer>[][] map;
  int cellSize = 20;
  int rows, cols, mval = 0;
  int ta, ty, tx;
  int location, rval, lval, dval, uval;
  String fileName;

  Map() {
    this(null); // default = no file
  }

  Map(String fileName) {
    this.fileName = fileName;

    cols = width / cellSize;
    rows = height / cellSize;
    map = (ArrayList<Integer>[][]) new ArrayList[cols][rows];

    // initialize every cell with an empty list
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        map[i][j] = new ArrayList<Integer>();
      }
    }

    if (fileName != null) {
      println("Loading map from CSV: " + fileName);
      loadFromCSV(fileName);
    } else {
      println("Using built-in default map");
      fillDefaultMap();
    }

    if (player != null) {
      dval = getGroundBelowPlayer(int(player.x)/20);
    }
  }

  // -------------------------------------------------------------------------
  // CSV loading logic
  void loadFromCSV(String fileName) {
    String[] lines = loadStrings(fileName);
    if (lines == null) {
      println("⚠️ Could not load " + fileName + ", using default map instead.");
      fillDefaultMap();
      return;
    }

    rows = lines.length;
    cols = split(lines[0], ',').length;
    map = (ArrayList<Integer>[][]) new ArrayList[cols][rows];

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        map[i][j] = new ArrayList<Integer>();
      }
    }

    for (int j = 0; j < rows; j++) {
      String[] tokens = split(lines[j], ',');
      for (int i = 0; i < cols && i < tokens.length; i++) {
        int val = int(trim(tokens[i]));
        map[i][j].add(val);
      }
    }
  }

  // -------------------------------------------------------------------------
  // Default fallback map (your original setup)
  void fillDefaultMap() {
    // hardcoded blocks
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

    // fill rest of map
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (i == 0 || j == 0 || i == cols - 1 || j == rows - 1) {
          map[i][j].add(3);
        }
        if (j >= rows - 5) {
          map[i][j].add(3); // ground
        } else {
          map[i][j].add(1); // air
        }
      }
    }
  }

  // -------------------------------------------------------------------------
  int getGroundBelowPlayer(int col) {
    col = constrain(col, 0, cols - 1);
    int startRow = int(player.y / cellSize);
    startRow = constrain(startRow, 0, rows - 1);

    for (int i = startRow; i < rows; i++) {
      ArrayList<Integer> cell = map[col][i];
      if (cell == null) continue;
      if (cell.contains(3) || cell.contains(4)) return i;
    }
    return rows - 1;
  }

  boolean hasSolidToRight(float px, float py, float pWidth, float pHeight) {
    int col = int(floor((px + pWidth) / cellSize));
    int topRow = int(floor((py - pHeight) / cellSize));
    int bottomRow = int(floor((py - 1) / cellSize));
    col = constrain(col, 0, cols - 1);
    topRow = constrain(topRow, 0, rows - 1);
    bottomRow = constrain(bottomRow, 0, rows - 1);
    for (int j = topRow; j <= bottomRow; j++) {
      ArrayList<Integer> cell = map[col][j];
      if (cell != null && (cell.contains(3) || cell.contains(4))) return true;
    }
    return false;
  }

  boolean hasSolidToLeft(float px, float py, float pHeight) {
    int col = int(floor((px - 1) / cellSize));
    int topRow = int(floor(py / cellSize));
    int bottomRow = int(floor((py + pHeight - 1) / cellSize));
    col = constrain(col, 0, cols - 1);
    topRow = constrain(topRow, 0, rows - 1);
    bottomRow = constrain(bottomRow, 0, rows - 1);
    for (int j = topRow; j <= bottomRow; j++) {
      ArrayList<Integer> cell = map[col][j];
      if (cell != null && (cell.contains(3) || cell.contains(4))) return true;
    }
    return false;
  }

  // -------------------------------------------------------------------------
  void drawMap() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        ArrayList<Integer> cell = map[i][j];
        fill(50);
        if (cell.contains(0)) fill(0, 150, 255);
        else if (cell.contains(3)) fill(0, 255, 0);
        else if (cell.contains(4)) fill(80);
        else fill(200);
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
      }
    }
  }
}
