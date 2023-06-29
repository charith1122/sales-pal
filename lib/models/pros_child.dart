class Child {
  //modal class for Person object
  String name, dob;
  Child({this.name, this.dob});

  Child.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dob'] = this.dob;
    return data;
  }

  factory Child.fromMap(Map<String, dynamic> data) => Child(
        name: data['name'],
        dob: data['dob'],
      );
}
