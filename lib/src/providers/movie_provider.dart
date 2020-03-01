import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/cast_model.dart';
import 'package:peliculas/src/models/movie_model.dart';

class MoviesProvider{

  String _apikey="04776d6936e4758e73676f4866c96245";
  String _url="api.themoviedb.org";
  String _language="es-ES";
  //Crear un Future para obtener la lista de peliculas

  Future<List<Pelicula>> getResponseAPI(Uri url) async{

    final response = await http.get(url);
    //Mecodificar los datos obtenidos del API
    final decodeData = json.decode(response.body);
    final peliculas = new Peliculas.fromMaptoList(decodeData['results']);
    return peliculas.peliculas;

  }

  Future<List<Pelicula>> getMovies() async{
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'lamguage': _language
    });
    return await getResponseAPI(url);
  }
  
  Future<List<Pelicula>> getPopular() async{
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'lamguage': _language
    });
    return await getResponseAPI(url);
  }


Future<List<Actor>>getCast(int peliculaId) async{
  final url = Uri.https(_url, '3/movie/$peliculaId/credits',{
      'api_key' : _apikey,
      'lamguage': _language
    });
    final response = await http.get(url);
    //Mecodificar los datos obtenidos del API
    final decodeData = json.decode(response.body);
    final actores = new Actores.fromMaptoList(decodeData['cast']);
    return actores.actores;


}
}