class ResourceGetter{
  ResourceGetter() {}
  
  String sketchPath = "/Users/aaravsharma/Desktop/Processing/Projects/Pokemon/sketch/";
  
  JSONObject getResource(String resourceType, String resourceID) {
    //checks if data is cached
    File cachedFile = new File(sketchPath + "resources/" + resourceType + "/" + resourceID + ".txt");
    println(cachedFile.getAbsolutePath());
    if (cachedFile.exists()) {
      //data is cached; open file and parse as json
      String jsonString = loadStrings(sketchPath + "resources/" + resourceType + "/" + resourceID + ".txt")[0];
      println(jsonString);
      JSONObject json = parseJSONObject(jsonString);
      return json;
    }    
    // data not cached
    GetRequest get = new GetRequest("https://pokeapi.co/api/v2/" + resourceType + "/" + resourceID);
    get.addHeader("User-Agent", "Mozilla/5.0");
    get.send();
    String jsonString = get.getContent();
    // cache the string
    saveStrings(sketchPath + "resources/" + resourceType + "/" + resourceID + ".txt", new String[]{jsonString});
    JSONObject json = parseJSONObject(jsonString);
    return json;
  }
  
  PImage getPokemonImage(String pokemonName, String imgLink) {
    File cachedImg = new File(sketchPath + "resources/sprites/" + pokemonName + ".png");
    println(cachedImg.exists());
    if (cachedImg.exists()) {
      return loadImage(sketchPath + "resources/sprites/" + pokemonName + ".png");
    } else {
      PImage image = loadImage(imgLink);
      image.save(sketchPath + "resources/sprites/" + pokemonName + ".png");
      return image;
    }
  }



}
