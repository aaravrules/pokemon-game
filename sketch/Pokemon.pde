class Pokemon {
  String name;
  String type;
  int hp;
  int level;
  int attack;
  int defense;
  
  ResourceGetter resources = new ResourceGetter();
  
  PImage img;
  int i = 0;
  String back = "";
  
  ArrayList<String> types;
  ArrayList<Move> moves;

  Pokemon (String name){
    // this.name = name;
    JSONObject json = resources.getResource("pokemon", name);
    this.moves = new ArrayList();
    this.name = json.getString("name");
    
    types = new ArrayList();
    JSONArray typesJSON = json.getJSONArray("types");
    for (int i = 0; i < typesJSON.size(); i++) {
      JSONObject j = typesJSON.getJSONObject(i);
      JSONObject t = j.getJSONObject("type");
      types.add(t.getString("name"));
    }
    println(types);
   
    JSONObject spritesJSON = json.getJSONObject("sprites");
    String imgLink = spritesJSON.getString("front_default");
    this.img = resources.getPokemonImage(this.name, imgLink);
    
    // Get Pokemon's Moves
    JSONArray jsonMoves = json.getJSONArray("moves");
    for (int i = 0; i < jsonMoves.size(); i++) {
      JSONObject jsonMove = jsonMoves.getJSONObject(i);
      String moveName = jsonMove.getJSONObject("move").getString("name");
      System.out.println(moveName);
      Move move = new Move(moveName);
      this.moves.add(move);
    }
  }
  void sayHello(){
    println ("My name is " + this.name);
  } 
  void attack(Pokemon pokemon, Move move){
    //damage = 22 times power times A/D  divided by 50 + 2
     
    float damage;
    if (random(100) > move.accuracy) {
      damage = 0;
    } else {
      damage = ((22 * move.power * this.attack / pokemon.defense) / 50) + 2;
    }
    
    pokemon.hp = pokemon.hp - int(damage);
    
  }
  
  

  
 
   
}
