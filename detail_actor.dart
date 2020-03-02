import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/person_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class DetailActor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Actor actor = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            showSliverAppBar(actor),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: 25.0,
              ),
              getInfoPersona(actor.id),
              getBiography(actor.id),
              SizedBox(
                height: 25.0,
              ),
              //obtenerListaActores(actor)
            ]))
          ],
        ),
      ),
    );
  }

  SliverAppBar showSliverAppBar(Actor actor) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
            width: 250.0,
            child: Text(
              actor.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20.0),
            )),
        centerTitle: true,
        background: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(actor.getProfilePath())),
    ));
  }

  Widget getInfoPersona(int actorId) {
    final moviesProvider = new MoviesProvider();
    return FutureBuilder(
        future: moviesProvider.getPerson(actorId),
        builder: (BuildContext context, AsyncSnapshot<Person> person) {
          if (person.hasData) {
            return _showContent(person.data);
          } else {
            return Container(
                height: 150.0,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }

 Widget getBiography(int actorId) {
    final moviesProvider = new MoviesProvider();
    return FutureBuilder(
        future: moviesProvider.getBiography(actorId),
        builder: (BuildContext context, AsyncSnapshot<String> biography) {
          if (biography.hasData) {
            return showBiography(biography.data);
          } else {
            return Container(
                height: 150.0,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }


  Widget _showContent(Person person) {
    return Container(
      padding: EdgeInsets.only(left: 25.0),
      child: Row(
        children: <Widget>[
          // SizedBox(width: 25.0,),
          ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: Image(
                  height: 180.0,
                  image: NetworkImage(person.getProfilePath()))),
          SizedBox(
            width: 15.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(person.name),
              Text(person.placeOfBirth),
              Text(person.birthday),
              CircularPercentIndicator(
                radius: 40.0, 
                lineWidth: 3.0,
                center: Text(person.popularity.toString()),
                progressColor: Colors.blue,
                backgroundColor: Colors.grey,
                percent: person.popularity * 0.01,
              ),

              // Text(pelicula.voteAverage.toString())
            ],
          ))
        ],
      ),
    );
  }

 Widget showBiography(String biography) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          Text(
            'Biografia',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            biography,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

 
}
