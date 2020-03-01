import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;
  CardSwiper({ this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: FadeInImage(
                fit: BoxFit.fill,
                placeholder: AssetImage('assets/img/loanding.gif'),
                image: NetworkImage(peliculas[index].getPosterPath())),
          );
        },
        itemCount: peliculas.length,
        itemWidth:
            _screenSize.width * 0.7, //Toma el 70% de la pantalla del ancho
        itemHeight: _screenSize.height * 0.5, //Esto toma el 50% de la pantalla
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
