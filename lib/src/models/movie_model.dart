class Peliculas{
  //Crear una lista de peliculas que se retorne hacia la vista
  List<Pelicula> peliculas = new List();

  Peliculas();
  Peliculas.fromMaptoList(List<dynamic> jsonlist){
    if(jsonlist == null) return;
    for(var item in jsonlist){
      final pelicula = new Pelicula.fromJSONMap(item);
      peliculas.add(pelicula);
    }
  }
}
//Key API: 04776d6936e4758e73676f4866c96245

class Pelicula {
  double popularity;
  int vote_count;
  bool video;
  String poster_path;
  int id;
  bool adult;
  String backdrop_path;
  String original_language;
  String original_title;
  List<int> genre_ids;
  String title;
  double vote_average;
  String overview;
  String release_date;

  Pelicula({
    this.popularity,
    this.vote_count,
    this.video,
    this.poster_path,
    this.id,
    this.adult,
    this.backdrop_path,
    this.original_language,
    this.original_title,
    this.genre_ids,
    this.title,
    this.vote_average,
    this.overview,
    this.release_date,
  });

  Pelicula.fromJSONMap(Map <String, dynamic>json){
    popularity          = json['popularity'] / 1;
    vote_count          = json['vote_count'];
    video               = json['video'];
    poster_path         = json['poster_path'];
    id                  = json['id'];
    adult               = json['adult'];
    backdrop_path       = json['backdrop_path'];
    original_language   = json['original_language'];
    original_title      = json['original_title'];
    genre_ids           = json['genre_ids'].cast<int>();
    title               = json['title'];
    vote_average        = json['vote_average'] / 1;
    overview            = json['overview'];
    release_date        = json['release_date'];
  }
  getPosterPath(){
    if (poster_path == null) {
      return 'https://mantuatownship.com/wp-content/uploads/2018/01/no-results-empty-state.jpg';
    } else {
      return 'http://image.tmdb.org/t/p/w500/$poster_path';
    }
  
  }
    getBackdropPath(){
    if (backdrop_path == null) {
      return 'https://mantuatownship.com/wp-content/uploads/2018/01/no-results-empty-state.jpg';
    } else {
      return 'http://image.tmdb.org/t/p/w500/$backdrop_path';
    }
  
  }
  

}


