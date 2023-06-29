class MultiplePlans {
  bool done;
  List<BodyOfMultiplePlans> body;
  String message;

  MultiplePlans({this.done, this.body, this.message});

  MultiplePlans.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    if (json['body'] != null) {
      body = <BodyOfMultiplePlans>[];
      json['body'].forEach((v) {
        body.add(new BodyOfMultiplePlans.fromJson(v));
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

class BodyOfMultiplePlans {
  String id;
  String userId;
  String prosId;
  String policyNo;
  String commenceDate;
  String payType;
  int premium;

  BodyOfMultiplePlans(
      {this.id,
      this.userId,
      this.prosId,
      this.policyNo,
      this.commenceDate,
      this.payType,
      this.premium});

  BodyOfMultiplePlans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    prosId = json['pros_id'];
    policyNo = json['policy_no'];
    commenceDate = json['commence_date'];
    payType = json['pay_type'];
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['pros_id'] = this.prosId;
    data['policy_no'] = this.policyNo;
    data['commence_date'] = this.commenceDate;
    data['pay_type'] = this.payType;
    data['premium'] = this.premium;
    return data;
  }
}
