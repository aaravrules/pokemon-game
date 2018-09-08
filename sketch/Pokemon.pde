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
    JSONArray typesJSON = json.getJSONArray("types"); //<>//
    for (int i = 0; i < typesJSON.size(); i++) {
      JSONObject j = typesJSON.getJSONObject(i);
      JSONObject t = j.getJSONObject("type");
      types.add(t.getString("name"));
    }
   
    JSONObject spritesJSON = json.getJSONObject("sprites");
    String imgLink = spritesJSON.getString("front_default");
    this.img = resources.getPokemonImage(this.name, imgLink);
    
    // Get Pokemon's Moves
    JSONArray jsonMoves = json.getJSONArray("moves");
    for (int i = 0; i < jsonMoves.size(); i++) {
      JSONObject jsonMove = jsonMoves.getJSONObject(i);
      String moveName = jsonMove.getJSONObject("move").getString("name");
     // float moveDamage = jsonMove.getJSONObject("move").getFloat("damage");

      Move move = new Move(moveName);
     
      this.moves.add(move);
    }
    
    // Get Pokemon's Stats (hp, attack, defense)
    JSONArray jsonStats = json.getJSONArray("stats");
    for (int i = 0; i < jsonStats.size(); i++) {
      JSONObject stat = jsonStats.getJSONObject(i);
      String statName = stat.getJSONObject("stat").getString("name");
      println(statName);
      if (statName.equals("hp")) {
        this.hp = stat.getInt("base_stat");
      } else if (statName.equals("attack")) {
        this.attack = stat.getInt("base_stat");
      } else if (statName.equals("defense")) {
        this.defense = stat.getInt("base_stat");
      } 
    }
  }
  void sayHello(){
    println ("My name is " + this.name);
  } 
  int attack(Pokemon pokemon, Move move){ //<>//
    //damage = 22 times power times A/D  divided by 50 + 2 //<>//
    println(this.attack);
    float damage;
    println("the move power is " + str(move.power));
    println("the pokemon attack is " + str(this.attack));
    println("the pokemon defense is " + str(pokemon.defense));
    damage = ((22 * move.power * this.attack / pokemon.defense) / 50) + 2;
    
    pokemon.hp = pokemon.hp - int(damage); //<>//
    
    return int(damage);
    
  }
}
