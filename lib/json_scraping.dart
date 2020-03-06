import 'dart:convert';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

Future initiate(BaseClient client,String s) async {
  // Make API call to Hackernews homepage
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
  // Make API call to Hackernews homepage
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