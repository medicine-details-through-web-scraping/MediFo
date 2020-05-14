class Note {
  String title;
  //  String text;

  Note(this.title);

  Note.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    //text = json['text'];
  }
}