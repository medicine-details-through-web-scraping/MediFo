class Note1 {
  String title;
    //String text;

  Note1(this.title);

  Note1.fromJson(Map<String, dynamic> json) {
    title = json['content'];
    //text = json['text'];
  }
}