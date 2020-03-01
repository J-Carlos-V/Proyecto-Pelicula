/*import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movie_provider.dart';
import 'package:peliculas/witgets/card_swiper_widget.dart';
import 'package:peliculas/witgets/footer_cards_widget.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_swiperCards(),_footerCards()],
      )),
    );
  }

  Widget _swiperCards() {
    moviesProvider.getMovies();
    return FutureBuilder(
        builder: (BuildContext contect, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        return CardSwiper(peliculas: snapshot.data);
      } else {
        //Aqui se pone el loanding
        return Container(
          height: 400.0,
          child: Center(child:
          CircularProgressIndicator()
          )
        );
      }
    });
  }

  Widget _footerCards(){

    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Películas más populares'),
          SizedBox(height: 10.0,),
          FutureBuilder(
            future: moviesProvider.getPopular(),
            builder: (BuildContext context, AsyncSnapshot snapshot){

              //snapshot.data.forEach(peli) => print(peli.title);
              if (snapshot.hasData) {
                return FooterCards(peliculas: snapshot.data,);
              } else {
                return CircularProgressIndicator();
              }

            }
          )
        ],
      ),
    );

  }

}
*//*
import 'package:flutter/material.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas'),
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[_swiperCards()],
          ),
        ));
  }

  Widget _swiperCards() {
    return CardSwiper(peliculas: [
      1,2,3,4,5
    ]);
  }
}
*/
import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movie_provider.dart';
import 'package:peliculas/witgets/card_swiper_widget.dart';
import 'package:peliculas/witgets/footer_cards_widget.dart';



class HomePage extends StatelessWidget {
final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
  
  
    return Scaffold(
        appBar: AppBar(
            title: Text('Peliculas'),
            backgroundColor: Colors.deepPurple,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {})
            ]),
        body: Container(
          child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_swiperCards(),_footerCards()],
     //children: <Widget>[_swiperCards()],
          ),
        ),
        );
  }

  Widget _swiperCards() {
    //crear un futureBuilder para cargar los datos
  return FutureBuilder(
    future: moviesProvider.getMovies(),
    builder: (BuildContext context, AsyncSnapshot snapshot){
      if (snapshot.hasData) {
        return CardSwiper(peliculas: snapshot.data);
      }else{
        return Container(
          height: 400.0,
          child: Center(child: CircularProgressIndicator()
          )
          );
        
      }
        });
  }

      Widget _footerCards(){

        return Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Text('Peliculas mas Populares'),
              SizedBox(height: 10.0,),
              FutureBuilder(
                future: moviesProvider.getPopular(),
                builder: (BuildContext contex, AsyncSnapshot<List> snapshot){
                  //snapshot.data.forEach((peli)=> print(peli.title));
                  if (snapshot.hasData){
                    return FooterCards(peliculas: snapshot.data);
                  }
                  return Container(child: Center(),);
                }
              )
            ],
          ),
        );
      

   
  
    }
    
  }