//Cormac Stone
class Map {
  int[][] map;
  int cellSize = 20;
  int rows, cols;
  String fileName;
  PGraphics mapLayer; // for cached drawing

  Map() {
    this(null);
  }

  Map(String fileName) {
    this.fileName = fileName;

    cols = width / cellSize;
    rows = height / cellSize;

    if (fileName != null) {
      println("Loading map from CSV: " + fileName);
      loadFromCSV(fileName);
    } else {
      println("Using built-in default map");
      fillDefaultMap();
    }

    buildMapLayer();
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
    map = new int[cols][rows];

    for (int j = 0; j < rows; j++) {
      String[] tokens = split(lines[j], ',');
      for (int i = 0; i < cols && i < tokens.length; i++) {
        map[i][j] = int(trim(tokens[i]));
      }
    }
  }

  // -------------------------------------------------------------------------
  // Default fallback map
  void fillDefaultMap() {
    cols = width / cellSize;
    rows = height / cellSize;
    map = new int[cols][rows];

    // Base ground & air
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (j >= rows - 5) map[i][j] = 3; // ground
        else map[i][j] = 1; // air
      }
    }

    // Borders
    for (int i = 0; i < cols; i++) {
      map[i][0] = 3;
      map[i][rows - 1] = 3;
    }
    for (int j = 0; j < rows; j++) {
      map[0][j] = 3;
      map[cols - 1][j] = 3;
    }

    // Some extra blocks
    map[10][20] = 4;
    map[11][20] = 4;
    map[12][20] = 4;
    map[13][20] = 4;
    map[16][15] = 4;
    map[17][15] = 4;
    map[18][15] = 4;
    map[20][10] = 4;

    map[25][24] = 3;
    map[26][24] = 3;
    map[27][24] = 3;
    map[28][24] = 3;
    map[29][24] = 3;
    map[1][24]  = 3;
    map[2][24]  = 3;
    map[3][24]  = 3;
    map[4][24]  = 3;
    map[5][24]  = 3;
  }

  // -------------------------------------------------------------------------
  // Pre-render static map layer (massive performance gain)
  void buildMapLayer() {
    mapLayer = createGraphics(cols * cellSize, rows * cellSize);
    mapLayer.beginDraw();
    mapLayer.noStroke();

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        int val = map[i][j];
        if (val == 1) continue; // air → skip
        else if (val == 0) mapLayer.fill(0, 150, 255);
        else if (val == 3) mapLayer.fill(0, 255, 0);
        else if (val == 4) mapLayer.fill(80);
        else if (val == 5) mapLayer.fill(0);
        else mapLayer.fill(200);
        mapLayer.rect(i * cellSize, j * cellSize, cellSize, cellSize);
      }
    }

    mapLayer.endDraw();
  }

  // -------------------------------------------------------------------------
  // Draw only the visible portion
  // In Map class
  void drawMap() {
    image(mapLayer, 0, 0);
  }


  // -------------------------------------------------------------------------
  // Example helper functions (optional collision checks)
  boolean isSolid(int col, int row) {
    if (col < 0 || row < 0 || col >= cols || row >= rows) return true;
    int val = map[col][row];
    return (val == 3 || val == 4);
  }

  boolean hasSolidToRight(float px, float py, float pWidth, float pHeight) {
    int col = int((px + pWidth) / cellSize);
    int top = int(py / cellSize);
    int bottom = int((py + pHeight - 1) / cellSize);
    for (int j = top; j <= bottom; j++) {
      if (isSolid(col, j)) return true;
    }
    return false;
  }

  boolean hasSolidToLeft(float px, float py, float pHeight) {
    int col = int((px - 1) / cellSize);
    int top = int(py / cellSize);
    int bottom = int((py + pHeight - 1) / cellSize);
    for (int j = top; j <= bottom; j++) {
      if (isSolid(col, j)) return true;
    }
    return false;
  }

  int getGroundBelowPlayer(float playerX, float playerY) {
    int col = int(playerX / cellSize);
    int startRow = int(playerY / cellSize);
    for (int j = startRow; j < rows; j++) {
      if (isSolid(col, j)) return j;
    }
    return rows - 1;
  }
  int getTile(int col, int row) {
    if (col < 0 || row < 0 || col >= cols || row >= rows) return -1;
    return map[col][row];
  }
}
