import http.requests.*;
Pokemon pk;
Pokemon opponent;
PImage bg;
float playerPokemonX;
float playerPokemonY;
int counter;
//make a state variable.mode of game not Move
String mode = "follow mouse";

String currentMessage = "";
ArrayList<Move> randomMoves;
String randomMovesString;

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
  if (mode == "follow mouse") {
    playerPokemonX = mouseX;
    playerPokemonY = mouseY;
  } else if (mode == "choose move") {
    currentMessage = randomMovesString;
  }
  
  showDialogueBox(currentMessage);
  
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
  mode = "choose move";
  counter = counter + 1;
}

void keyPressed() {
  if (mode == "choose move") {
    // Choosing the move to do
    if (key == '1'){
      moveChosen(randomMoves.get(0));
    } else if (key == '2'){
      moveChosen(randomMoves.get(1));
    } else if (key == '3'){
      moveChosen(randomMoves.get(2));
    } else if (key == '4'){
      moveChosen(randomMoves.get(3));
    }
  }
}

void moveChosen(Move playerMove){
  mode = "move chosen";
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
  
  String message = "";
  
  // First move: first Pokemon attacks second Pokemon with firstMove
  int firstDamage = firstPokemon.attack(secondPokemon, firstMove);
  message += firstPokemon.name + " used " + firstMove.name + " on " + secondPokemon.name + ". It did " + str(firstDamage) + " damage.\n";
  if (secondPokemon.hp <= 0){
    message += secondPokemon.name + " has fainted.\n";
  } else {
    message += secondPokemon.name + " has " + str(secondPokemon.hp) + " hp left.\n";
    
    int secondDamage = secondPokemon.attack(firstPokemon, secondMove);
    message += secondPokemon.name + " used " + secondMove.name + " on " + firstPokemon.name + ". It did " + str(secondDamage) + " damage.\n";
    if (firstPokemon.hp <= 0){
      message += firstPokemon.name + " has fainted.";
    } else {
      message += firstPokemon.name + " has " + str(firstPokemon.hp) + " hp left.";
    } 
  }
  
  // showDialogueBox(message);
  currentMessage = message;
}
