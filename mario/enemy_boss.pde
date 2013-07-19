/**
 * Our main enemy
 */
class Boss extends MarioEnemy {

  float radial = 100;
  int numHit = 1;
  Boss(float x, float y) {
    super("Boss Trooper");
    setStates();
    //setForces(-0.25, DOWN_FORCE);    
    setImpulseCoefficients(1.2*DAMPENING, DAMPENING);
    setPosition(x,y);
  }
  
  /**
   * Set up our states
   */
  void setStates() {
    // idle state
    State idle = new State("idle", "graphics/enemies/boss-standing.gif", 1, 2);
    idle.setAnimationSpeed(0.1);
    idle.setDuration(30);
    addState(idle);
    
    // we throw mountains
    State flying = new State("flying", "graphics/enemies/boss-flying.gif");
    flying.addPathLine(0, 0, 0, -radial, 15);
    flying.setLooping(false);
    flying.setAnimationSpeed(0.5);
    //SoundManager.load(flying, "audio/Squish.mp3");
    addState(flying);

    // throw mountain
    State throwing = new State("throwing", "graphics/enemies/boss-throwing.gif");
    throwing.setDuration(20);
    throwing.setAnimationSpeed(0.5);
    SoundManager.load(throwing, "audio/Squish.mp3");
    addState(throwing);

    State falling = new State("falling", "graphics/enemies/boss-flying.gif");
    falling.addPathLine(0, -radial, 0, 0, 15);
    falling.setLooping(false);
    falling.setAnimationSpeed(0.5);
    //SoundManager.load(falling, "audio/Squish.mp3");
    addState(falling);


    // walking state
    /*State walking = new State("idle", "graphics/enemies/boss-walking.gif", 1, 2);
    walking.setAnimationSpeed(0.12);
    addState(walking);*/

    // if we get squished, we first get inshell...
    State inshell = new State("inshell", "graphics/enemies/boss-inshell.gif", 1, 2);
    inshell.setAnimationSpeed(0.12);
    inshell.setDuration(350); // get to the other side
    SoundManager.load(inshell, "audio/Squish.mp3");
    addState(inshell);
    

    State dead = new State("dead", "graphics/enemies/boss-die.gif");
      dead.setAnimationSpeed(0.25);
      dead.setDuration(100);
      addState(dead);   
      SoundManager.load(dead, "audio/Squish.mp3");

    setCurrentState("idle");
  }
  
  /**
   * when we hit a vertical wall, we want our
   * boss to reverse direction
   */
  void gotBlocked(Boundary b, float[] intersection, float[] original) {
    if (b.x==b.xw) {
      ix = -ix;
      fx = -fx;
      setHorizontalFlip(fx > 0);
    }
  }
  
  void hit() {
    SoundManager.play(active);

    // do we have our shell? Then we only get half-squished.
    if (active.name != "inshell") {
      numHit += 1;
      if (numHit == 2)
        setCurrentState("die");
      else {
        setCurrentState("inshell");
        setForces(-0.5, 0);
      }
    }
    
  }

  void handleStateFinished(State which) {
    if (which.name == "idle") {
       setCurrentState("flying");
    } else if (which.name == "flying") {
      setCurrentState("throwing");
    } else if (which.name == "throwing") {

    Player player = layer.players.get(0);
    k = new BanzaiBill(100, 100, "graphics/enemies/mountain1.gif", "audio/rock.mp3");
    k.setPosition(player.x, 0);
    k.setImpulse(0, 1);
    layer.addInteractor(k);


      //k.setImpulse(6, 0);
      
      setCurrentState("falling");
    } else if (which.name == "falling") {
      setCurrentState("idle");
    } else if (which.name == "inshell") {
      setForces(0, 0);
      setCurrentState("idle");
      setHorizontalFlip(true);
    } else if (which.name == "die") {
      // no shell... this boss is toast.
      removeActor();
      KeyPickup key = new KeyPickup(2000,364);
      addForPlayerOnly(key);
    }
  }

  // make sure all states are center/bottom anchored
  void addState(State st) {
    st.sprite.anchor(CENTER, BOTTOM);
    super.addState(st);
  }

}


