class Move{
  String type;
  String name;
  int accuracy;
  int id;
  int priority;
  int power;
  
  ResourceGetter resources = new ResourceGetter();
  Move(String name){
    JSONObject data = resources.getResource("move", name);
    
    this.name = data.getString("name");
    this.id = data.getInt("id");
    this.priority = data.getInt("priority");
    //this.power = data.getInt("power");
  }
  
  @Override
  String toString() {
    return this.name;
  }
}
