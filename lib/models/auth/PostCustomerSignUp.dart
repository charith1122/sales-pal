class PostCustomerSignUp {
  bool done;
  String message;
  BodyOfPostCustomerSignUp body;

  PostCustomerSignUp({this.done, this.message, this.body});

  PostCustomerSignUp.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
    body = json['body'] != null
        ? new BodyOfPostCustomerSignUp.fromJson(json['body'])
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

class BodyOfPostCustomerSignUp {
  // var id;
  // var customerNo;
  var contactNo;

  BodyOfPostCustomerSignUp(
      {
      // this.id,
      //  this.customerNo,
      this.contactNo});

  BodyOfPostCustomerSignUp.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    // customerNo = json['customer_no'];
    contactNo = json['contact_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    // data['customer_no'] = this.customerNo;
    data['contact_no'] = this.contactNo;
    return data;
  }
}
