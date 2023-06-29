class CustomerLoginUpdateDetails {
  bool done;
  BodyOfPostCustomerLogin body;
  String message;

  CustomerLoginUpdateDetails({this.done, this.body, this.message});

  CustomerLoginUpdateDetails.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    body = json['body'] != null
        ? new BodyOfPostCustomerLogin.fromJson(json['body'])
        : null;
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

class BodyOfPostCustomerLogin {
  String id;
  String contactNo;
  String name;
  String nic;
  String countryCode;
  String email;
  String address;
  String position;
  String country;
  String regNo;
  String jobRole;
  String companyId;
  String companyName;
  int users;

  BodyOfPostCustomerLogin({this.id, this.contactNo, this.name, this.users});

  BodyOfPostCustomerLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactNo = json['contactNo'];
    name = json['name'];
    nic = json['nic'];
    countryCode = json['country_code'];
    email = json['email'];
    address = json['address'];
    position = json['position'];
    country = json['country'];
    regNo = json['reg_no'] ?? '';
    jobRole = json['job_role'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    users = json['users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contactNo'] = this.contactNo;
    data['name'] = this.name;
    data['nic'] = this.nic;
    data['country_code'] = this.countryCode;
    data['email'] = this.email;
    data['address'] = this.address;
    data['position'] = this.position;
    data['country'] = this.country;
    data['reg_no'] = this.regNo;
    data['job_role'] = this.jobRole;
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['users'] = this.users;
    return data;
  }
}



/* class CustomerLoginUpdateDetails {
  var done;
  var message;
  BodyOfPostCustomerLogin body;

  CustomerLoginUpdateDetails({this.done, this.message, this.body});

  CustomerLoginUpdateDetails.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
    body = json['body'] != null
        ? new BodyOfPostCustomerLogin.fromJson(json['body'])
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


class BodyOfPostCustomerLogin {
  var id;
  // var nic;
  var name;
  // var lastName;
  var contactNo;
  var address;
  // var dateCreated;
  // var dateUpdated;
  var email;

  BodyOfPostCustomerLogin(
      {this.id,
      // this.nic,
      this.name,
      // this.lastName,
      this.contactNo,
      this.address,
      // this.dateCreated,
      // this.dateUpdated,
      this.email});

  BodyOfPostCustomerLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['first_name'];
    // lastName = json['last_name'];
    contactNo = json['contact_no'];
    address = json['address'];
    // dateCreated = json['date_created'];
    // dateUpdated = json['date_updated'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.name;
    // data['last_name'] = this.lastName;
    data['contact_no'] = this.contactNo;
    data['address'] = this.address;
    // data['date_created'] = this.dateCreated;
    // data['date_updated'] = this.dateUpdated;
    data['email'] = this.email;

    return data;
  }
}
 */