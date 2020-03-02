import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/detail_actor.dart';
import 'package:peliculas/src/pages/detail_movie.dart';
import 'package:peliculas/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'detail_movie' : (BuildContext context) => DetailMovie(),
        'detail_actor' : (BuildContext context) => DetailActor(),

      },
    );
  }
}