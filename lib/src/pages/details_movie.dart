import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movie_provider.dart';
import 'package:peliculas/src/models/cast_model.dart';

class DetailsMovie extends StatelessWidget {
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
              height: 15.0,
            ),
            _moviePoster(pelicula),
            _showDescription(pelicula),
            _showCast(pelicula),
          ]))
        ],
      )),
    );
  }

  SliverAppBar showSliverAppBar(Pelicula pelicula) {
    return SliverAppBar(
      backgroundColor: Colors.deepPurple,
      elevation: 2.0,
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/img/loanding.gif'),
            image: NetworkImage(pelicula.getBackdropPath())),
        title: Text(pelicula.title),
        centerTitle: true,
      ),
    );
  }

  Widget _moviePoster(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
                height: 170.0, image: NetworkImage(pelicula.getPosterPath())),
          ),
          SizedBox(
            width: 10.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(pelicula.title),
              Text(pelicula.original_title),
              Row(
                children: <Widget>[
                  Icon(Icons.stars),
                  Text(pelicula.vote_average.toString()),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget _showDescription(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Text(pelicula.overview,textAlign: TextAlign.justify,),

    );
  }


  Widget _showCast(Pelicula pelicula){
    final moviesProvider = new MoviesProvider();

    return FutureBuilder(
      future: moviesProvider.getCast(pelicula.id),
      builder: (BuildContext context, AsyncSnapshot<List>snapshot){
        if (snapshot.hasData) {
          return _showListActores(
            snapshot.data
          );
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }
  Widget _showListActores(List<Actor>actores){
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (BuildContext context, int index){
            return _showProfileActor(actores[index]);
        },
      ),
    );
  }

  Widget _showProfileActor(Actor actor){
    return Container(
      
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
                      child: FadeInImage(
              height: 140.0,
              fit: BoxFit.fill,
              placeholder: AssetImage('assets/img/loanding.gif'),
              image: NetworkImage(actor.getProfilePath()),
               ),
          ),
          SizedBox(height: 5.0,),
          Text(actor.name, overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}
