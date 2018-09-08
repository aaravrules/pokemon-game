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
    if (data.isNull("accuracy")) {
      this.accuracy = 100;
    } else {
      this.accuracy = data.getInt("accuracy");
    }
    if (data.isNull("power")){
      this.power = 0;
    } else {
      this.power = data.getInt("power");
    }
   
  }
  
  @Override
  String toString() {
    return this.name;
  }
}
