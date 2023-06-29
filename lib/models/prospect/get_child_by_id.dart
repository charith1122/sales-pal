class GetChildrenById {
  bool done;
  String message;
  List<BodyOfGetChildrenById> body;

  GetChildrenById({this.done, this.body});

  GetChildrenById.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
    if (json['body'] != null) {
      body = <BodyOfGetChildrenById>[];
      json['body'].forEach((v) {
        body.add(new BodyOfGetChildrenById.fromJson(v));
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

class BodyOfGetChildrenById {
  // String id;
  // String prospectId;
  String name;
  String dateOfBirth;

  BodyOfGetChildrenById(
      {/* this.id, this.prospectId, */ this.name, this.dateOfBirth});

  BodyOfGetChildrenById.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    // prospectId = json['prospect_id'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    // data['prospect_id'] = this.prospectId;
    data['name'] = this.name;
    data['date_of_birth'] = this.dateOfBirth;
    return data;
  }
}
