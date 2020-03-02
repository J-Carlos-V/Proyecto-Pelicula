import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/models/person_model.dart';

class MoviesProvider {
  String _apikey = 'dbe7b97d96ec37923790b92018830628';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  String bio;

  //Crear un Future para que obtenga el listado del API

  Future<List<Pelicula>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    return await getResponseAPI(url);
  }

  Future<List<Pelicula>> getPopular() async {
    final url = Uri.https(
        _url, '3/movie/popular', {'api_key': _apikey, 'language': _language});

    return await getResponseAPI(url);
  }

  Future<List<Pelicula>> getResponseAPI(Uri url) async {
    //Crear la petición GET
    final resp = await http.get(url);
    //Decodificar el JSON
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.peliculas;
  }

  Future<List<Actor>> getActores(int peliculaID) async {
    final url = Uri.https(_url, '3/movie/$peliculaID/credits',
        {'api_key': _apikey, 'language': _language});

      //Crear la petición GET
    final resp = await http.get(url);
    //Decodificar el JSON
    final decodedData = json.decode(resp.body);
    //TODO JSON DECODIFICADO ES POR DEFECTO UN MAP
    final actores = new Actores.fromJsonList(decodedData['cast']);

    return actores.actores;  
  }

  Future<Person> getPerson(int idPerson ) async {
    final url = Uri.https(_url, '3/person/$idPerson',
        {'api_key': _apikey, 'language': _language});

      //Crear la petición GET
    final resp = await http.get(url);
    //Decodificar el JSON
    final decodedData = json.decode(resp.body);
    //TODO JSON DECODIFICADO ES POR DEFECTO UN MAP
    final person = new Person.fromJsonMap(decodedData);

    return person; 
  }

  Future<String> getBiography(int idPerson ) async {
    final url = Uri.https(_url, '3/person/$idPerson/translations',
        {'api_key': _apikey, 'language': _language});

      //Crear la petición GET
    final resp = await http.get(url);
    //Decodificar el JSON
    final decodedData = json.decode(resp.body);
    for(var i = 0; i < decodedData['translations'].length; i++){
        var dta = decodedData['translations'][i];
         if(dta['iso_639_1']=="en"){
           bio =  dta['data']['biography'];
         }
         if(dta['iso_639_1']=="es"){
           bio =  dta['data']['biography'];
         }
         
    }    
    return bio; 
  }


}
