class BossLayer extends MarioLayer {
  BanzaiBill k;
  
  BossLayer(Level parent) {
    super(parent);

    // repeating background sprite image
    /*Sprite bgsprite = new Sprite("graphics/backgrounds/nightsky_fg.gif");
    bgsprite.align(RIGHT, TOP);
    TilingSprite backdrop = new TilingSprite(bgsprite, 0, 0, width, height);
    addBackgroundSprite(backdrop);      
*/
    // side walls
    addBoundary(new Boundary(-1,0, -1,height));
    addBoundary(new Boundary(width+1,height, width+1,0));
    
    // set up ground
    addGround("cave", 0, height-16, width, height);
  
    float w = 32, w2 = 2*w, w4 = w2*2, w8 = w4*2;
    /*addGroundPlatform("cave", width/2-w, height-64, w2, 48);
    addGroundPlatform("cave", width/2-w2, height-48, w4, 32);
    addGroundPlatform("cave", width/2-w4, height-32, w8, 16);*/

    Boss boss = new Boss(width/8*7, height-45);
    boss.setLevelLayer(this);
    addInteractor(boss);
  }

  
}
