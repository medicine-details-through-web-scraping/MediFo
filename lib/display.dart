import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'json_scraping.dart' as hacker_news_scraper;
import 'package:flutter/material.dart';
import 'package:medifo1/entities/note.dart';
import 'package:medifo1/entities/note1.dart';



/*class App extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}*/

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}
String s;
Future dis(String ss){
  s=ss;
}
class _HomePageState extends State<HomePage> {
  List<Note> _notes = List<Note>();
  List<Note1> _notes1 = List<Note1>();

  Future<List<Note>> fetchNotes() async {
    //var url = 'https://raw.githubusercontent.com/boriszv/json/master/random_example.json';
    var response = await hacker_news_scraper.initiate(Client(),s);
    var notes = List<Note>();
    var notesJson = json.decode(response);
    for (var noteJson in notesJson) {
      notes.add(Note.fromJson(noteJson));
    }
    return notes;
  }
  Future<List<Note1>> fetchNotes1() async {
    var response = await hacker_news_scraper.initiate1(Client(),s);
    var notes1 = List<Note1>();
    var notesJson1 = json.decode(response);
    for (var noteJson1 in notesJson1) {
      notes1.add(Note1.fromJson(noteJson1));
    }
    return notes1;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    fetchNotes1().then((value) {
      setState(() {
        _notes1.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(s),
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              tooltip: 'Back',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView.builder(
            //itemCount: list.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _notes[index].title,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        _notes1[index].title,
                        style: TextStyle(
                            color: Colors.grey.shade600
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: _notes1.length,
          )
      ),
    );
  }
}
