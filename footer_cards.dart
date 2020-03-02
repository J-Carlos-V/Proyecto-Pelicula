import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';

class FooterPage extends StatelessWidget {
  final List<Pelicula> peliculas;

  FooterPage({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.25,
      child: PageView(
          pageSnapping: false,
          controller: PageController(initialPage: 1, viewportFraction: 0.3),
          children: _cards(context)),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return peliculas.map((pelicula) {
      return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, 'detail_movie', arguments: pelicula);
        },
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/loading.gif'),
                  image: NetworkImage(pelicula.getPosterPath()),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
  }
}
