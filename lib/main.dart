import 'package:flutter/material.dart';
import 'package:peliculas/src/home_page.dart';
import 'package:peliculas/src/pages/details_movie.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'details_movie':(BuildContext context) => DetailsMovie()
      },
    );
  }
}