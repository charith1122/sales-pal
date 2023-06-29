class Coverage {
  //modal class for Person object
  String tag, cover_for;
  Coverage({this.tag, this.cover_for});

  Coverage.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    cover_for = json['cover_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['cover_for'] = this.cover_for;
    return data;
  }

  factory Coverage.fromMap(Map<String, dynamic> data) => Coverage(
        tag: data['name'],
        cover_for: data['cover_for'],
      );
}
