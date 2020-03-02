
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';

class FooterPage extends StatelessWidget {


  final List<Pelicula> movies;

FooterPage({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height*0.25,
      child: PageView(
        pageSnapping: false,
        controller: PageController(initialPage: 1,
        viewportFraction: 0.3),
      ),
    );
  }

  List<Widget>_cards( context){
    return movies.map((pelicula){
      //REVISAR ESTO
      return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, 'detail',arguments: movies);
        },
              child: Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: <Widget>[
               ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                fit: BoxFit.fill,
                placeholder: AssetImage('assets/img/loading.gif'),
                image: NetworkImage(pelicula.getPosterPath()),
              ),
            )
            ],
          ),
        ),
      );
    }).toList();
  }
}