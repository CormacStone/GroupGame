//Cormac Stone, Trace Kinghorn
class Player {
  float x, y;
  float w, h;
  float xspeed;
  float vy; // vertical velocity
  PImage remmy;

  Player(float x, float y) {
    this(x, y, 20, 20, 3);
  }

  Player(float x, float y, float w, float h, float xspeed) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.xspeed = xspeed;
    this.vy = 0;
  }

  void display() {
    fill(255, 0, 0);    
    //rect(x, y, w, h);
    remmy = loadImage("remmeigh3-3.png");
    image(remmy, x-40, y-20);

  }

  void handleMovement() {
    float newX = player.x;
    float newY = player.y;

    // Horizontal movement
    if (l && !map.hasSolidToLeft(player.x, player.y, player.h)) {
      newX -= player.xspeed;
    }
    if (r && !map.hasSolidToRight(player.x, player.y, player.w, player.h)) {
      newX += player.xspeed;
    }

    // Apply gravity
    if (!onGround) player.vy += gravity;

    // Vertical movement
    newY += player.vy;

    // --- Floor collision ---
    onGround = false;
    int colLeft = int(newX / map.cellSize);
    int colRight = int((newX + player.w - 1) / map.cellSize);
    int bottomRow = int((newY + player.h) / map.cellSize);

    for (int c = colLeft; c <= colRight; c++) {
      if (map.isSolid(c, bottomRow)) {
        newY = bottomRow * map.cellSize - player.h; // snap to ground
        player.vy = 0;
        onGround = true;
        break;
      }
    }

    // --- Ceiling collision ---
    int topRow = int(newY / map.cellSize);
    for (int c = colLeft; c <= colRight; c++) {
      if (map.isSolid(c, topRow)) {
        newY = (topRow + 1) * map.cellSize;
        player.vy = 0;
      }
    }

    // --- Jumping ---
    if (u && onGround &&jAvail) {
      player.vy = jumpForce;
      onGround = false;
      jAvail = false;
    }

    int playerColLeft = int(player.x / map.cellSize);
    int playerColRight = int((player.x + player.w - 1) / map.cellSize);
    int playerRow = int((player.y + player.h / 2) / map.cellSize);

    int leftTile = map.getTile(playerColLeft, playerRow);
    int rightTile = map.getTile(playerColRight, playerRow);

    if (leftTile == 5) loadNextMap("left");
    if (rightTile == 5) loadNextMap("right");


    // Commit updates
    player.x = newX;
    player.y = newY;
  }

  void loadNextMap(String e) {
    if (e=="left") {
      currentLevel--;
      e = "done";
    }
    if (e == "right") {
      currentLevel++;
      e = "donw";
    }
    String nextMapFile = currentLevel + ".csv";
    println("Loading next map: " + nextMapFile);

    map = new Map(nextMapFile);

    // Reset player to start position
    player.x = 50;
    player.y = 50;
    player.vy = 0;

    // Reset camera too
    camX = 0;
    camY = 0;
  }
}
