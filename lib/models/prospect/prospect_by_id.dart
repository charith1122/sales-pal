class GetProspectById {
  bool done;
  BodyOfGetProspectById body;
  String message;

  GetProspectById({this.done, this.body});

  GetProspectById.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
    body = json['body'] != null
        ? new BodyOfGetProspectById.fromJson(json['body'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['done'] = this.done;
    data['message'] = this.message;
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    return data;
  }
}

class BodyOfGetProspectById {
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
  String spouseName;
  String spousePhone;
  String spouseDob;
  String annivesary;
  String spouseNic;
  String spouseAddress;
  String spouseOccupation;

  BodyOfGetProspectById(
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
      this.spouseName,
      this.spousePhone,
      this.spouseDob,
      this.annivesary,
      this.spouseNic,
      this.spouseAddress,
      this.spouseOccupation});

  BodyOfGetProspectById.fromJson(Map<String, dynamic> json) {
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
    spouseName = json['spouse_name'];
    spousePhone = json['spouse_phone'];
    spouseDob = json['spouse_dob'];
    annivesary = json['annivesary'];
    spouseNic = json['spouse_nic'];
    spouseAddress = json['spouse_address'];
    spouseOccupation = json['spouse_occupation'];
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
    data['spouse_name'] = this.spouseName;
    data['spouse_phone'] = this.spousePhone;
    data['spouse_dob'] = this.spouseDob;
    data['annivesary'] = this.annivesary;
    data['spouse_nic'] = this.spouseNic;
    data['spouse_address'] = this.spouseAddress;
    data['spouse_occupation'] = this.spouseOccupation;
    return data;
  }
}
