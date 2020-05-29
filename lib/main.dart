import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:medifo1/camera.dart';
import 'package:medifo1/display.dart';
import 'package:flutter/material.dart';
import 'vision_text.dart';
import 'package:camera/camera.dart';
import 'camera.dart';

List<CameraDescription> cameras;

Future<Null> main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();
  //print(await hacker_news_scraper.initiate(Client(),"wikoryl"));
  cameras = await availableCameras();

//void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Named Routes Demo',
    initialRoute: '/',
    routes: {
      '/': (context) => StartScreen(),
      '/vision_text': (context) => VisionTextWidget(),
      '/display': (context) => HomePage(),
      '/camera':(context) => CameraExampleHome(cameras),
    },
  ),

  );
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
                    backgroundColor: Colors.white,
                    radius: 94.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left:22.0),
                      child: Image(
                        image: AssetImage("images/medifo.jpg"),
                        height: 120,
                        //fit: BoxFit.fitHeight,
                      ),
                    ),
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
