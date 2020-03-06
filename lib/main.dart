import 'dart:async';
import 'package:medifo1/display.dart';
import 'package:flutter/material.dart';
import 'vision_text.dart';

Future main(List<String> arguments) async {
  //print(await hacker_news_scraper.initiate(Client(),"wikoryl"));

//void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Named Routes Demo',
    initialRoute: '/',
    routes: {
      '/': (context) => StartScreen(),
      '/vision_text': (context) => VisionTextWidget(),
      '/display': (context) => HomePage(),
    },
  ));

  //print(await hacker_news_scraper.initiate(Client(),"wikoryl"));
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black87,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'MEDIFO', style: TextStyle( fontFamily:'Aclonica',color: Colors.white,fontSize: 50.0),
              ),
              Center(
                child: RaisedButton(
                  color: Colors.black87,
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage: AssetImage('images/ml.jpg'),
                  ),
                  onPressed: () {
                    // Navigate to the second screen using a named route
                    Navigator.pushNamed(context, '/vision_text');
                  },
                ),
              ),

              Center(
                child: Text(
                  'MEDICINE INFO.', style: TextStyle( fontFamily:'Aclonica',color: Colors.white,fontSize: 40.0),
                ),
              )
            ],
          )),
    );
  }
}
