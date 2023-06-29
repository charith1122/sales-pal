class UserProfile {
  bool done;
  BodyOfUserProfile body;
  String message;

  UserProfile({this.done, this.body, this.message});

  UserProfile.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
    body = json['body'] != null
        ? new BodyOfUserProfile.fromJson(json['body'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['done'] = this.done;
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    return data;
  }
}

class BodyOfUserProfile {
  String id;
  String name;
  String nic;
  String contactNo;
  String countryCode;
  String email;
  String address;
  String companyId;
  String companyName;
  String regNo;
  String position;
  String jobRole;
  String country;
  int verified;
  int active;
  String createdAt;
  String updatedAt;

  BodyOfUserProfile(
      {this.id,
      this.name,
      this.nic,
      this.contactNo,
      this.countryCode,
      this.email,
      this.address,
      this.companyId,
      this.companyName,
      this.regNo,
      this.position,
      this.jobRole,
      this.country,
      this.verified,
      this.active,
      this.createdAt,
      this.updatedAt});

  BodyOfUserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nic = json['nic'];
    contactNo = json['contact_no'];
    countryCode = json['country_code'];
    email = json['email'];
    address = json['address'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    regNo = json['reg_no'] ?? '';
    position = json['position'];
    jobRole = json['job_role'];
    country = json['country'];
    verified = json['verified'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nic'] = this.nic;
    data['contact_no'] = this.contactNo;
    data['country_code'] = this.countryCode;
    data['email'] = this.email;
    data['address'] = this.address;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['reg_no'] = this.regNo;
    data['position'] = this.position;
    data['job_role'] = this.jobRole;
    data['country'] = this.country;
    data['verified'] = this.verified;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
