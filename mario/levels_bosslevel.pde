/**
 * Boss!
 */
class BossLevel extends MarioLevel
{
  BossLevel(float w, float h)
  {
    super(w, h);
    addLevelLayer("Background Layer", new BackgroundColorLayer(this, color(24,48,72)));
    addLevelLayer("Star Layer", new BossBackgroundLayer(this));

    LevelLayer layer = new BossLayer(this);
    addLevelLayer("Boss Layer", layer);
    mario.setPosition(width/8, height-32);
    layer.addPlayer(mario);

    SoundManager.load(this, "audio/bg/Bonus.mp3");
  }
  
  void updateMario(Player p) {
    super.updateMario(p);
    mario.setPosition(width/8, height-32);
  }

  /**
   * If mario loses, we must end the level prematurely:
   */
  void end() {
    SoundManager.pause(this);
    super.end();
  }

  /**
   * But if he wins, we end the level properly:
   */
  void finish() {
    SoundManager.pause(this);
    super.finish();
  }  

}
