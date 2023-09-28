class MJoke {
  String? title;
  int? id;
  MJoke({this.title, this.id});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "title": title,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  MJoke.fromMap(Map<String, Object?> map) {
    id = map["id"] as int;
    title = map["title"] as String;
  }
}
