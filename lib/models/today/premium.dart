class PremiumList {
  bool done;
  String message;
  List<BodyOfPremiumList> body;

  PremiumList({this.done, this.body, this.message});

  PremiumList.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
    if (json['body'] != null) {
      body = <BodyOfPremiumList>[];
      json['body'].forEach((v) {
        body.add(new BodyOfPremiumList.fromJson(v));
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

class BodyOfPremiumList {
  String id;
  String userId;
  String prosId;
  String policyNo;
  String commenceDate;
  String payType;
  int premium;
  int prosNum;
  String prosName;

  BodyOfPremiumList(
      {this.id,
      this.userId,
      this.prosId,
      this.policyNo,
      this.commenceDate,
      this.payType,
      this.premium,
      this.prosNum,
      this.prosName});

  BodyOfPremiumList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    prosId = json['pros_id'];
    policyNo = json['policy_no'];
    commenceDate = json['commence_date'];
    payType = json['pay_type'];
    premium = json['premium'];
    prosNum = json['pros_no'];
    prosName = json['pros_name'];
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
    data['pros_no'] = this.prosNum;
    data['pros_name'] = this.prosName;
    return data;
  }
}
