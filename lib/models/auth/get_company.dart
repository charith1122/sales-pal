class GetCompany {
  bool done;
  List<BodyOfGetCompany> body;
  String message;

  GetCompany({this.done, this.body, this.message});

  GetCompany.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    if (json['body'] != null) {
      body = <BodyOfGetCompany>[];
      json['body'].forEach((v) {
        body.add(new BodyOfGetCompany.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['done'] = this.done;
    if (this.body != null) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class BodyOfGetCompany {
  String id;
  String name;
  String code;

  BodyOfGetCompany({this.id, this.name, this.code});

  BodyOfGetCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}
