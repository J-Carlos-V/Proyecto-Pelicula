import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class DetailMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(slivers: <Widget>[
        showSliverAppBar(pelicula),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10.0,
          ),
          _showContent(pelicula),
          mostrarSinopsis(pelicula),
          SizedBox(height: 25.0),
          obtenerListaActores(pelicula),
        ]))
      ])),
    );
  }

  SliverAppBar showSliverAppBar(Pelicula pelicula) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(pelicula.title),
        centerTitle: true,
        background: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/imag/loading.gif'),
            image: NetworkImage(pelicula.getBackdrop()),
      ),
    ));
  }

  Widget _showContent(Pelicula pelicula) {
    return Container(
        padding: EdgeInsets.only(left: 25.0),
        child: Row(
          children: <Widget>[
            Image(
              height: 180.0,
              image: NetworkImage(pelicula.getPosterPath()),
            ),
            SizedBox(
              width: 15.0,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(pelicula.originalTitle),
                Text(pelicula.getAdult()),
                Text(pelicula.releaseDate),
                Text(pelicula.popularity.toString())
              ],
            ))
          ],
        ));
  }

  Widget mostrarSinopsis(pelicula) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            Text(
              'Sinópsis',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            Text(
              pelicula.overview,
              textAlign: TextAlign.justify,
            )
          ],
        ));
  }

  Widget obtenerListaActores(Pelicula pelicula) {
    final moviesProvider = new MoviesProvider();
    return FutureBuilder(
        future: moviesProvider.getActores(pelicula.id),
        builder: (BuildContext context, AsyncSnapshot<List<Actor>> actores) {
          if (actores.hasData) {
            return mostratFotosActores(actores.data);
          } else {
            return Container(
          height: 150.0,
          child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget mostratFotosActores(List<Actor> actores) {
    return SizedBox(
      height: 300.0,
      child: PageView.builder(
          controller: PageController(initialPage: 1, viewportFraction: 0.3),
          itemBuilder: (BuildContext context, int index) {
            return cardActor(actores[index]);
          }),
    );
  }

  Widget cardActor(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/loading.gid'),
              image: NetworkImage(actor.getProfilePath()),
              fit: BoxFit.fill,
              height: 160.0,
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis,),
          Text(actor.character, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
