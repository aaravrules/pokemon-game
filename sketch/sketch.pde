import http.requests.*;
Pokemon pk;
Pokemon opponent;
PImage bg;
float playerPokemonX;
float playerPokemonY;
int counter;

ArrayList<Move> randomMoves;
String randomMovesString;

boolean followMouse = true;
void setup(){
  size(1200, 900);
  imageMode(CENTER);
  bg = loadImage("stadium.jpg");
  pk = new Pokemon("greninja");
  pk.sayHello();

  opponent = new Pokemon(str(int(random(1, 803))));
  //opponent = new Pokemon("81");
  println(opponent.name); 
  
  randomMoves = new ArrayList<Move>();
  int index;
  Move item;
  while (randomMoves.size() < 4) {
    index = int(random(pk.moves.size()));
    item = pk.moves.get(index);
    if (!randomMoves.contains(item)){
      randomMoves.add(item);
    }
  }
  
  randomMovesString = "";
  int counter = 1;
  
  for (int i = 0; i < randomMoves.size(); i++){
    Move m = randomMoves.get(i);
    randomMovesString += counter + ". " + m.name + "\n";
    counter += 1;
    
  }
  /**
  for (Move m : randomMoves) {
    randomMovesString += counter + ". " + m.name + "\n";
    counter += 1;
  }
  **/
  
   
}

void draw(){
  image(bg, width/2, height/2, width, height);
  if (followMouse) {
    playerPokemonX = mouseX;
    playerPokemonY = mouseY;
  } else {
    showDialogueBox(randomMovesString);
  }
  
  

  image(pk.img, playerPokemonX, playerPokemonY, 150, 150);
  fill(0);
  text("YOU", playerPokemonX, playerPokemonY - 80);
  textSize(32);
  textAlign(CENTER);
  
  image(opponent.img, playerPokemonY, playerPokemonX, 150, 150);
  fill(0);
  text("CPU", playerPokemonY, playerPokemonX - 80);
  textSize(32);
  textAlign(CENTER);
  //stroke(255);
  //fill(128);
  //ellipse(mouseX - 50, mouseY - 100, 100, 100);
  
      
}


void showDialogueBox(String words){
  textAlign(LEFT);
  fill(0, 0, 0);
  rect(100, 650, width - 200, 350);
  fill(255, 255, 255);
  textSize(20);
  text(words, 110, 660, width - 210, 340);
}

void mouseClicked() {
  followMouse = false;
  counter = counter + 1;
}

void keyPressed() {
  if (!followMouse) {
    // Choosing the move to do
    if (key == '1'){
      println(randomMoves.get(0));
      println(pk);
    } else if (key == '2'){
      println(randomMoves.get(1));
    } else if (key == '3'){
      println(randomMoves.get(2));
    } else if (key == '4'){
      println(randomMoves.get(3));
    }
  }
}

void moveChosen(Move playerMove){
  int randomIndex = int(random(0, opponent.moves.size()));
  Move opponentMove = opponent.moves.get(randomIndex);
  
  Move firstMove;
  Move secondMove;
  
  Pokemon firstPokemon;
  Pokemon secondPokemon;
  
  if (playerMove.priority >= opponentMove.priority) {
    firstMove = playerMove;
    secondMove = opponentMove;
    
    firstPokemon = pk;
    secondPokemon = opponent;
  } else {
    firstMove = opponentMove;
    secondMove = playerMove;
    
    firstPokemon = opponent;
    secondPokemon = pk;
  }
  /*
  First move:
    Defender dead?
    If so, end.(Print something)
   Second move:
     Defender dead?
     If so, end(Print something)
    */
 
}
