int init_n_mosquittos = 1000;
ArrayList<Mosquitto> mosquittos = new ArrayList<Mosquitto>();
ArrayList<Mosquitto> next_mosquittos = new ArrayList<Mosquitto>();
int new_index = init_n_mosquittos;
int show_after = 1;
int next_show = 0;

void setup() {
  size(960, 720);
  frameRate(45);
  for (int i = 0 ; i < init_n_mosquittos ; i++) {
    mosquittos.add(new Mosquitto(i));
  }
}

void draw() {
  if(next_show % show_after == 0) {
    background(220);
    for (int i = 0 ; i < mosquittos.size() ; i++) {
      mosquittos.get(i).show();
    }
    next_show = 0;
  }
  next_show++;
  for (int i = 0 ; i < mosquittos.size() ; i++) {
    mosquittos.get(i).update();
  }
  
  for (int i = 0 ; i < mosquittos.size() ; i++) {
        if(mosquittos.get(i).kill) {
            mosquittos.remove(i);
            i--;
        }
  }
  mosquittos.addAll(mosquittos.size()-1, next_mosquittos);
  if(next_mosquittos.size() > 0) {
    System.out.println("Next Mosquittos: " + next_mosquittos.size());
    System.out.println("     Mosquittos: " + mosquittos.size());
  }
  next_mosquittos.clear();
  
}
