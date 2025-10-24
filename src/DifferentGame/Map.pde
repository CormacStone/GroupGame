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
    //dval = getAjacent(player.x/20, player.y/20);
    for (int i = 0; i < cols; i++) {
      if (i < cols - 5) ty += 2;
      for (int j = 0; j < rows; j++) {
        if (i < cols - 5 && j < rows - 5) {
          map[i][j].add(1);
        } else if (j >= rows - 6 || i < cols - 5) {
          map[i][j].add(3);
          ta += 10;
        }
      }
    }
  }
  // work in progress for colision detection
  int getAjacent(int col, int row) {
    int nRoof = 0;
    for (int i = col-1; i < col+2; i++) {
      for (int j = row+1; j < row+2; j++) {
        ArrayList<Integer> cell = map[i][j];
        for (int val : cell) {
          if (val == 3) {
            println(i);
            println(j);
          }
        }
      }
    }
    return nRoof;
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
