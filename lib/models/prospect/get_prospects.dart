class GetProspects {
  bool done;
  List<BodyOfGetProspects> body;
  String message;

  GetProspects({this.done, this.body});

  GetProspects.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    if (json['body'] != null) {
      body = <BodyOfGetProspects>[];
      json['body'].forEach((v) {
        body.add(new BodyOfGetProspects.fromJson(v));
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

class BodyOfGetProspects {
  String id;
  String userId;
  String prosNo;
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
  String createdAt;
  String updatedAt;
  String planId;

  BodyOfGetProspects(
      {this.id,
      this.userId,
      this.prosNo,
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
      this.createdAt,
      this.updatedAt,
      this.planId});

  BodyOfGetProspects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    prosNo = json['pros_no'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    planId = json['plan_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['pros_no'] = this.prosNo;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['plan_id'] = this.planId;
    return data;
  }
}
