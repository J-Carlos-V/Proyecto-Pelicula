



import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';


class FooterCards extends StatelessWidget {
  final List<Pelicula> peliculas;

  FooterCards({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    /*return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'details_movie', arguments: peliculas);
      },*/
          return Container(
        height: _screenSize.height * 0.25,
        child: PageView(
          pageSnapping: false,//que no se dentenga por bloques
          controller: PageController(initialPage: 1, viewportFraction: 0.3),
          children: _cards(context),
        ),
      
    );
  }

  List<Widget> _cards(BuildContext context) {
    return peliculas.map((pelicula) {
      return GestureDetector(
        onTap: (){
           Navigator.pushNamed(context, 'details_movie', arguments: pelicula);
        //  Navigator.pushNamed(context,'details_movie');
          //print('se presiono el card' + pelicula.title);
        },
              child: Container(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  height: 120.0,
                  placeholder: AssetImage('assets/img/loanding.gif'),
                  image: NetworkImage(pelicula.getPosterPath()),
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 5.0,),
              Text(
                pelicula.title,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      );
    }).toList();
  }
}
