
/*class Casts{
   List<Cast> casts = new List();
  Casts.fromMaptoList(List<dynamic>jsonlist){
    if (jsonlist == null)return;
    for (var item in jsonlist){
      final cast = new Cast.fromJSONMap(item);
    }
      
    }
  }
   

  Peliculas();
  Peliculas.fromMaptoList(List<dynamic> jsonlist){
    if(jsonlist == null) return;
    for(var item in jsonlist){
      final pelicula = new Pelicula.fromJSONMap(item);
      peliculas.add(pelicula);
    }
  }
}*/
class Actores{
  
  //Crear una lista de peliculas que se retorne hacia la vista
  List<Actor> actores = new List();

  Actores();
  Actores.fromMaptoList(List<dynamic> jsonlist){
    if(jsonlist == null) return;
    for(var item in jsonlist){
      final actor = new Actor.fromJSONMap(item);
      actores.add(actor);
    }
  }

}



class Actor{
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor ( {
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

    Actor.fromJSONMap(Map<String, dynamic> json){
    castId                = json['cast_id'];
    character                = json['character'];
    creditId                  = json['credit_id'];
    gender               = json['gender'];
    id                        = json['id'];
    name             = json['name'];
    order     = json['order'];
    profilePath = json['profile_path'];
    
  }
  getProfilePath(){
    if (profilePath == null) {
      return 'https://cdn.dribbble.com/users/874140/screenshots/3489641/ghost_result.gif';
    } else {
      return 'http://image.tmdb.org/t/p/w500/$profilePath';
    }
  
  }
}

//mapear a los actores como el otro con el json paste y hacer el metodo para jala la imagen del actorS