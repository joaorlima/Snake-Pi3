// 30, 30
// Valor de Cada Quadrado: 20
ArrayList<Integer> x = new ArrayList<Integer>(), y = new ArrayList<Integer>();
int dir = 2;
int[] dx = {0, 0, 1, -1}; // Direita, Esquerda
int[] dy = {1, -1, 0, 0}; //Cima, Baixo
int ax = 12;
int ay = 10;
boolean game = false;
int gameScreen = 0;

PImage initialScreen;
PImage gameOverScreen;

void setup(){
  size(600, 600);
  x.add(5);
  y.add(5);
  initialScreen = loadImage("start_game.jpeg");
  gameOverScreen = loadImage("game_over.jpeg");
}

void draw() {
  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  }
}

void initScreen() {
  background(0);
  image(initialScreen, 0, 0);
}

void startGame() {
  gameScreen=1;
}  

void gameScreen(){
  background(0);
  stroke(0,40,0);
  for(int i = 1; i < 30; i++) line(i*20, 0, i*20, height); // Linhas Verticais
  for(int i = 1; i < 30; i++) line(0, i*20, width, i*20); // Linhas Horizontais
  fill(0, 255, 0);
  stroke(255);
  for(int i = 0 ; i < x.size(); i++) rect(x.get(i)*20, y.get(i)*20, 20, 20);
  if (!game){
    fill(255, 0, 0); rect(ax*20, ay*20, 20, 20); if (frameCount % 5 == 0) {
      x.add(0, x.get(0) + dx[dir]); y.add(0, y.get(0) + dy[dir]);
      if(x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= 30 || y.get(0) >= 30) game = true;
      for(int i=1;i<x.size();i++) 
        if(x.get(0)==x.get(i)&&y.get(0)==y.get(i)) game = true;
      if(x.get(0)==ax && y.get(0)==ay) { ax = (int)random(0, 30); ay = (int)random(0, 30); }
      else{
      x.remove(x.size()-1); y.remove(y.size()-1);
      }
    }
      }
      else {
    fill(0, 255, 0);
    PFont f = createFont("Palatino Linotype", 64);
    image(gameOverScreen, 0, 0);
    if(keyPressed && key == ' '){
      x.clear(); y.clear(); x.add(5);  y.add(5); game = false;
      }
    if(keyPressed && key == ' ' && gameScreen == 0){
      startGame(); 
     }
  }
}

void keyPressed(){
  int newdirs = keyCode == DOWN ? 0 : (keyCode == UP ? 1 : (keyCode == RIGHT ? 2 : (keyCode == LEFT ? 3 : -1) ) ); // Setas para movimentação
  if(newdirs!=-1&&(x.size()<=1||!(x.get(1)==x.get(0)+dx[newdirs]&&y.get(1)==y.get(0)+dy[newdirs]))) dir=newdirs;
  int newdirk = key == 's' || key == 'S' ? 0 : (key == 'w' || key == 'W' ? 1 : (key == 'd' || key == 'D' ? 2 : (key == 'a' || key == 'A'  ? 3: -1 ) ) ); // Atalhos do teclado para movimentação
  if(newdirk!=-1&&(x.size()<=1||!(x.get(1)==x.get(0)+dx[newdirk]&&y.get(1)==y.get(0)+dy[newdirk]))) dir=newdirk;
   if(gameScreen == 0){
    startGame();
  }
} 
