import 'dart:async';
import 'dart:io';
//import 'package:http/http.dart';
//import 'json_scraping.dart' as hacker_news_scraper;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';
import 'package:medifo1/display.dart' as display;
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

class VisionTextWidget extends StatefulWidget {


  @override
  _VisionTextWidgetState createState() {
    return _VisionTextWidgetState();
  }
}

class _VisionTextWidgetState extends State<VisionTextWidget> {
  File _file;
  List<VisionText> _currentLabels = <VisionText>[];

  FirebaseVisionTextDetector detector = FirebaseVisionTextDetector.instance;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black38,
          appBar: AppBar(
            title: Text('Text Detection'),
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(Icons.photo_camera,color: Colors.white,),
              onPressed: () {
                Navigator.pushNamed(context, '/camera');
              },
            ),
          ),
          body: _buildBody(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              try {
                //var file = await ImagePicker.pickImage(source: ImageSource.camera);
                var file =
                await ImagePicker.pickImage(source: ImageSource.gallery);
                if (file != null) {
                  setState(() {
                    _file = file;
                  });
                  try {
                    var currentLabels =
                    await detector.detectFromPath(_file?.path);
                    setState(() {
                      _currentLabels = currentLabels;
                    });
                  } catch (e) {
                    print(e.toString());
                  }
                }
              } catch (e) {
                print(e.toString());
              }
            },
            child: Icon(Icons.camera, color: Colors.white, ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 500.0,
      child: Center(
        child: _file == null
            ? Text('No Image', style: TextStyle(color: Colors.white),)
            : FutureBuilder<Size>(
          future: _getImageSize(Image.file(_file, fit: BoxFit.fitWidth)),
          builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
            if (snapshot.hasData) {
              return Container(
                  foregroundDecoration:
                  TextDetectDecoration(_currentLabels, snapshot.data),
                  child: Image.file(_file, fit: BoxFit.fitWidth));
            } else {
              return Text('Detecting...', style: TextStyle(color: Colors.white),);
            }
          },
        ),
      ),
    );
  }

  Future<Size> _getImageSize(Image image) {
    Completer<Size> completer = Completer<Size>();
    image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener(
            (ImageInfo info, bool _) =>
            completer.complete(
                Size(info.image.width.toDouble(),
                    info.image.height.toDouble()))));
    return completer.future;
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildImage(),
          _buildList(_currentLabels),
        ],
      ),
    );
  }

  Widget _buildList(List<VisionText> texts) {
    if (texts.length == 0) {
      return Text('Empty',style: TextStyle(color: Colors.white),);
    }
    return Expanded(
      child: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(0.0),
            itemCount: texts.length,
            itemBuilder: (context, i) {
              return _buildRow(texts[i].text);
            }
        ),
      ),
    );
  }

  Widget _buildRow(String text) {
    return ListTile (
      trailing: GestureDetector(
        onTap: () async{
          print("tapped"+"$text");
          //_HomePageState.dis("$text");
           // debugPrint(await hacker_news_scraper.initiate(Client(),"$text"),wrapWidth: 1024);
          display.dis("$text");
          Navigator.pushNamed(context, '/display');
        },
        child: Icon(
          Icons.arrow_forward_ios, color: Colors.white,
          //key: ,
        ),
      ),
      title: Text(
        "Text: $text", style: TextStyle(color: Colors.white),
      ),
    );
  }
}
class TextDetectDecoration extends Decoration {
  final Size _originalImageSize;
  final List<VisionText> _texts;
  TextDetectDecoration(List<VisionText> texts, Size originalImageSize)
      : _texts = texts,
        _originalImageSize = originalImageSize;

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return _TextDetectPainter(_texts, _originalImageSize);
  }
}

class _TextDetectPainter extends BoxPainter {
  final List<VisionText> _texts;
  final Size _originalImageSize;
  _TextDetectPainter(texts, originalImageSize)
      : _texts = texts,
        _originalImageSize = originalImageSize;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..color = Colors.red
      ..style = PaintingStyle.stroke;
    print("original Image Size : $_originalImageSize");

    final _heightRatio = _originalImageSize.height / configuration.size.height;
    final _widthRatio = _originalImageSize.width / configuration.size.width;
    for (var text in _texts) {
      print("text : ${text.text}, rect : ${text.rect}");
      final _rect = Rect.fromLTRB(
          offset.dx + text.rect.left / _widthRatio,
          offset.dy + text.rect.top / _heightRatio,
          offset.dx + text.rect.right / _widthRatio,
          offset.dy + text.rect.bottom / _heightRatio);
      //final _rect = Rect.fromLTRB(24.0, 115.0, 75.0, 131.2);
      print("_rect : $_rect");
      canvas.drawRect(_rect, paint);
    }

    print("offset : $offset");
    print("configuration : $configuration");

    final rect = offset & configuration.size;

    print("rect container : $rect");

    //canvas.drawRect(rect, paint);
    canvas.restore();
  }
}
