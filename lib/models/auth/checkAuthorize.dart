class CheckAuthorize {
  bool done;
  Body body;
  String message;

  CheckAuthorize({this.done, this.body, this.message});

  CheckAuthorize.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['done'] = this.done;
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Body {
  String id;
  bool registered;

  Body({this.id, this.registered});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registered = json['registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['registered'] = this.registered;
    return data;
  }
}
