import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: new Swiper(
        itemWidth: _screenSize.width * 0.7, //70% de la pantalla ancho
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              fit: BoxFit.fill,
              placeholder: AssetImage('assets/img/loading.gif'), 
              image: NetworkImage(peliculas[index].getPosterPath()))
          );
        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(), //se puede quitar
        //control: new SwiperControl(), //se puede quitar
      ),
    );
  }
}
