class Note {
  int? id;
  String? judul;
  String? konten;

  Note({this.id, this.judul, this.konten});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }

    map['judul'] = judul;
    map['konten'] = konten;

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.judul = map['judul'];
    this.konten = map['konten'];
  }
}
