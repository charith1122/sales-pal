class DobList {
  bool done;
  String message;
  List<BodyOfDobList> body;

  DobList({this.done, this.body});

  DobList.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
    if (json['body'] != null) {
      body = <BodyOfDobList>[];
      json['body'].forEach((v) {
        body.add(new BodyOfDobList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['done'] = this.done;
    data['message'] = this.message;
    if (this.body != null) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BodyOfDobList {
  String id;
  int prosNum;
  String name;
  String dateOfBirth;
  String contact;

  BodyOfDobList(
      {this.id, this.prosNum, this.name, this.dateOfBirth, this.contact});

  BodyOfDobList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prosNum = json['pros_num'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pros_num'] = this.prosNum;
    data['name'] = this.name;
    data['date_of_birth'] = this.dateOfBirth;
    data['contact'] = this.contact;
    return data;
  }
}
