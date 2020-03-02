class Person {
  int id;
  String birthday;
  String name;
  String biography;
  double popularity;
  String placeOfBirth;
  String profilePath;


  Person({
    this.id,
    this.birthday,
    this.name,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath
  });

   Person.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    birthday = json['birthday'];
    name = json['name'];
    biography = json['biography'];
    popularity = json['popularity'];
    placeOfBirth = json['place_of_birth'];
    profilePath = json['profile_path'];
  }

   getProfilePath() {
    if (profilePath == null) {
      return 'https://upload.wikimedia.org/wikipedia/commons/f/fc/No_picture_available.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }

}
