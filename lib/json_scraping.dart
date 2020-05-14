import 'dart:convert';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
//import 'package:translator/translator.dart';
import 'dart:async';
//final translator = new GoogleTranslator();
//String _textTranslated = "Aditya";
Future initiate(BaseClient client,String s) async {

  /*_onTextChanged(String text) {
    print(text);
    translator.translate(text, to: 'fr').then((s){
        _textTranslated = s;
    });
    print(_textTranslated);
    return _textTranslated;
  }*/

  Response response = await client.get('https://www.tabletwise.com/'+s+'-tablet');
  if (response.statusCode != 200) return response.body;
  // Use html parser
  var document = parse(response.body);
  List<Element> links = document.querySelectorAll('h2');
  //List<Element> link1 = document.querySelectorAll('h2+div');
  List<Map<String, dynamic>> linkMap1 = [];
  //List<Map<String, dynamic>> linkMap2 = [];
  // List<Element> link2 = document.querySelectorAll('div');
  for (var link in links){
    linkMap1.add({
      'title': link.text,
      //'content': link.text,
    });
  }

  return json.encode(linkMap1);
}

Future initiate1(BaseClient client,String s) async {
  Response response = await client.get('https://www.tabletwise.com/'+s+'-tablet');
  if (response.statusCode != 200) return response.body;
  // Use html parser
  var document = parse(response.body);
  //List<Element> links = document.querySelectorAll('h2');
  List<Element> link1 = document.querySelectorAll('h2+div');
  //List<Map<String, dynamic>> linkMap1 = [];
  List<Map<String, dynamic>> linkMap2 = [];
  // List<Element> link2 = document.querySelectorAll('div');
  for (var link in link1){
    linkMap2.add({
      //'title': link.text,
      'content': link.text,
    });
  }
  return json.encode(linkMap2);
}