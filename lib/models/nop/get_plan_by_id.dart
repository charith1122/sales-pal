class GetPlanById {
  bool done;
  Body body;
  String message;

  GetPlanById({this.done, this.body, this.message});

  GetPlanById.fromJson(Map<String, dynamic> json) {
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
  String userId;
  String prosId;
  String policyNo;
  String commenceDate;
  int premium;
  String prosName;
  String payType;

  Body(
      {this.id,
      this.userId,
      this.prosId,
      this.policyNo,
      this.commenceDate,
      this.premium,
      this.prosName,
      this.payType});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    prosId = json['pros_id'];
    policyNo = json['policy_no'];
    commenceDate = json['commence_date'];
    premium = json['premium'];
    prosName = json['pros_name'];
    payType = json['pay_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['pros_id'] = this.prosId;
    data['policy_no'] = this.policyNo;
    data['commence_date'] = this.commenceDate;
    data['premium'] = this.premium;
    data['pros_name'] = this.prosName;
    data['pay_type'] = this.payType;
    return data;
  }
}
