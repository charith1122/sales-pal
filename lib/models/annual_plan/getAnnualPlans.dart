class GetAnnualPlans {
  bool done;
  List<BodyOfGetAnnualPlans> body;
  String message;

  GetAnnualPlans({this.done, this.body});

  GetAnnualPlans.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    if (json['body'] != null) {
      body = <BodyOfGetAnnualPlans>[];
      json['body'].forEach((v) {
        body.add(new BodyOfGetAnnualPlans.fromJson(v));
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

class BodyOfGetAnnualPlans {
  String id;
  String userId;
  String year;
  String month;
  String pros;
  String app;
  String sale;
  String follow;
  String nop;
  String anbp;

  BodyOfGetAnnualPlans(
      {this.id,
      this.userId,
      this.year,
      this.month,
      this.pros,
      this.app,
      this.sale,
      this.follow,
      this.nop,
      this.anbp});

  BodyOfGetAnnualPlans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    year = json['year'];
    month = json['month'];
    pros = json['pros'];
    app = json['app'];
    sale = json['sale'];
    follow = json['follow'];
    nop = json['nop'];
    anbp = json['anbp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['year'] = this.year;
    data['month'] = this.month;
    data['pros'] = this.pros;
    data['app'] = this.app;
    data['sale'] = this.sale;
    data['follow'] = this.follow;
    data['nop'] = this.nop;
    data['anbp'] = this.anbp;
    return data;
  }
}
