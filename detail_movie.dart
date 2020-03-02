import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            showSliverAppBar(pelicula),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: 25.0,
              ),
              _showContent(pelicula),
              mostrarSinopsis(pelicula),
              SizedBox(
                height: 25.0,
              ),
              obtenerListaActores(pelicula)
            ]))
          ],
        ),
      ),
    );
  }

  SliverAppBar showSliverAppBar(Pelicula pelicula) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
            width: 250.0,
            child: Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20.0),
            )),
        centerTitle: true,
        background: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(pelicula.getBackdrop())),
      ),
    );
  }

  Widget _showContent(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.only(left: 25.0),
      child: Row(
        children: <Widget>[
          // SizedBox(width: 25.0,),
          ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: Image(
                  height: 180.0,
                  image: NetworkImage(pelicula.getPosterPath()))),
          SizedBox(
            width: 15.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(pelicula.originalTitle),
              Text('Pelicula de adultos: ' + pelicula.getAdult()),
              Text('Fecha de lanzamiento: ' + pelicula.releaseDate),
              // Text(pelicula.voteAverage.toString())
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 3.0,
                center: Text(pelicula.voteAverage.toString()),
                progressColor: Colors.blue,
                backgroundColor: Colors.grey,
                percent: pelicula.voteAverage * 0.1,
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget mostrarSinopsis(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          Text(
            'Sinópsis',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            pelicula.overview,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget obtenerListaActores(Pelicula pelicula) {
    final moviesProvider = new MoviesProvider();
    return FutureBuilder(
        future: moviesProvider.getActores(pelicula.id),
        builder: (BuildContext context, AsyncSnapshot<List<Actor>> actores) {
          if (actores.hasData) {
            return mostrarFotosActores(actores.data, context);
          } else {
            return Container(
                height: 150.0,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget mostrarFotosActores(List<Actor> actores, BuildContext context) {
    return SizedBox(
      height: 300.0,
      child: PageView.builder(
          pageSnapping: false,
          controller: PageController(initialPage: 1, viewportFraction: 0.3),
          itemCount: actores.length,
          itemBuilder: (BuildContext context, int index) {
            return cardActor(actores[index], context);
          }),
    );
    
    
  }


  Widget cardActor(Actor actor, BuildContext context) {
    /*return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                height: 150.0,
                fit: BoxFit.fill,
                placeholder: AssetImage('assets/img/loading.gif'),
                image: NetworkImage(actor.getProfilePath())),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(actor.character, overflow: TextOverflow.ellipsis),
        ],
      ),
    );*/
    return GestureDetector(
      onTap: (){
          Navigator.pushNamed(context, 'detail_actor', arguments: actor);
        },
        child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                height: 150.0,
                fit: BoxFit.fill,
                placeholder: AssetImage('assets/img/loading.gif'),
                image: NetworkImage(actor.getProfilePath())),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(actor.character, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
