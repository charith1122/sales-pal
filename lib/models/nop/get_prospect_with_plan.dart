class GetProspectWithPlan {
  bool done;
  String message;
  List<BodyOfGetProspectWithPlan> body;

  GetProspectWithPlan({this.done, this.body, this.message});

  GetProspectWithPlan.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
    if (json['body'] != null) {
      body = <BodyOfGetProspectWithPlan>[];
      json['body'].forEach((v) {
        body.add(new BodyOfGetProspectWithPlan.fromJson(v));
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

class BodyOfGetProspectWithPlan {
  String id;
  String prosNo;
  String userId;
  String name;
  String nic;
  String dateOfBirth;
  String address;
  String contact;
  String countryCode;
  String occupation;
  String income;
  String email;
  String whatsapp;
  String gender;
  int isMarried;
  String createdAt;
  String updatedAt;
  String planId;
  int planCount;
  String policyNo;

  BodyOfGetProspectWithPlan(
      {this.id,
      this.prosNo,
      this.userId,
      this.name,
      this.nic,
      this.dateOfBirth,
      this.address,
      this.contact,
      this.countryCode,
      this.occupation,
      this.income,
      this.email,
      this.whatsapp,
      this.gender,
      this.isMarried,
      this.createdAt,
      this.updatedAt,
      this.planId,
      this.planCount,
      this.policyNo});

  BodyOfGetProspectWithPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prosNo = json['pros_no'];
    userId = json['user_id'];
    name = json['name'];
    nic = json['nic'];
    dateOfBirth = json['date_of_birth'];
    address = json['address'];
    contact = json['contact'];
    countryCode = json['country_code'];
    occupation = json['occupation'];
    income = json['income'];
    email = json['email'];
    whatsapp = json['whatsapp'];
    gender = json['gender'];
    isMarried = json['is_married'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    planId = json['plan_id'];
    planCount = json['plan_count'];
    policyNo = json['policy_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pros_no'] = this.prosNo;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['nic'] = this.nic;
    data['date_of_birth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['country_code'] = this.countryCode;
    data['occupation'] = this.occupation;
    data['income'] = this.income;
    data['email'] = this.email;
    data['whatsapp'] = this.whatsapp;
    data['gender'] = this.gender;
    data['is_married'] = this.isMarried;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['plan_id'] = this.planId;
    data['plan_count'] = this.planCount;
    data['policy_no'] = this.policyNo;
    return data;
  }
}
