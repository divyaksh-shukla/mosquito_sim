class Mosquitto {
  private float r = random(0,1);
  private int index;
  private float angle = random(0,2) * PI;
  private float x = width/2 + r * cos(angle);
  private float y = height/2 + r * sin(angle);
  private float source_x = x;
  private float source_y = y;
  private float speed = random(0.1, 20);
  private float spread_angle = 0;
  private int steps = 0;
  private int totalSteps = floor(random(1500, 2500));
  private int totalDistance = floor(random(350, 450));
  private int reproduceSteps = floor(random(950, 1100));
  private int reproduceDistance = floor(random(1, 10));
  private boolean canReproduce = true;
  private boolean kill = false;
  
  Mosquitto(int index) {
    this.index = index;
  }
  
  Mosquitto(int index, float x, float y) {
    this.index = index;
    this.x = x;
    this.y = y;
    this.source_x = x;
    this.source_y = y;
  }
  
  void show() {
    fill(0,0,0,150);
    noStroke();
    ellipse(x, y, 10, 10);
  }
  
  void update() {
    float distance_from_source = sqrt(sq(x - source_x) + sq(y - source_y));
    float spread = 1 / (1 + exp(-0.01 * distance_from_source)) * 2.0 - 1.0;
    this.spread_angle = spread;
    this.angle = this.angle + random(-spread, spread) * PI;
    x = x + speed * cos(angle);
    y = y + speed * sin(angle);
    distance_from_source = distance(x, y, source_x, source_y);
    steps++;
    reproduce();
    die();
  }
  
  void reproduce() {
    if (steps > reproduceSteps && canReproduce) {
      for (int i = 0 ; i < mosquittos.size(); i++) {
        if (i != index && distance(x, y, mosquittos.get(i).x, mosquittos.get(i).y) < reproduceDistance && partnerCanReproduce(mosquittos.get(i))) {
          next_mosquittos.add(new Mosquitto(new_index, x, y));
          //next_mosquittos.add(new Mosquitto(new_index+1, x, y));
          new_index += 1;
          canReproduce = false;
        }
      }
    }
  }
  
  void die() {
        if(steps > totalSteps || distance(x, y, source_x, source_y) > totalDistance) {
            kill = true;
        }
    }
  
  float distance(float x1, float y1, float x2, float y2) {
    return sqrt(sq(x1-x2) + sq(y1-y2));
  }
  
  private boolean partnerCanReproduce(Mosquitto mosquitto) {
    return (mosquitto.steps > mosquitto.reproduceSteps && mosquitto.canReproduce);
  }
}
