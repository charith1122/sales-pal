class UserPlans {
  bool done;
  List<BodyOfUserPlans> body;
  String message;

  UserPlans({this.done, this.body});

  UserPlans.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
    if (json['body'] != null) {
      body = <BodyOfUserPlans>[];
      json['body'].forEach((v) {
        body.add(new BodyOfUserPlans.fromJson(v));
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

class BodyOfUserPlans {
  String id;
  String userId;
  String prosId;
  String policyNo;
  String commenceDate;
  String payType;
  int premium;
  String prosName;
  int planCount;

  BodyOfUserPlans(
      {this.id,
      this.userId,
      this.prosId,
      this.policyNo,
      this.commenceDate,
      this.payType,
      this.premium,
      this.prosName,
      this.planCount});

  BodyOfUserPlans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    prosId = json['pros_id'];
    policyNo = json['policy_no'];
    commenceDate = json['commence_date'];
    payType = json['pay_type'];
    premium = json['premium'];
    prosName = json['pros_name'];
    planCount = json['plan_count'];
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
    data['pros_name'] = this.prosName;
    data['plan_count'] = this.planCount;
    return data;
  }
}
