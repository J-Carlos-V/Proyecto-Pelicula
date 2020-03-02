import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/footer_cards.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Peliculas'),
            backgroundColor: Colors.indigoAccent,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {})
            ],
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[_swipeCards(), _footerCards(context)],
            ),
          )),
    );
  }

  Widget _swipeCards() {
    return FutureBuilder(
        future: moviesProvider.getNowPlaying(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(peliculas: snapshot.data);
          } else {
            return Container(
                height: 400.0,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget _footerCards(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text(
            'Más populares',
            style: Theme.of(context).textTheme.subhead,
          ),
          SizedBox(height: 10.0,),
          FutureBuilder(
              future: moviesProvider.getPopular(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return FooterPage(peliculas: snapshot.data);
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
