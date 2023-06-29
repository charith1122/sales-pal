class AnalyseData {
  bool done;
  BodyOfAnalyseData body;
  String message;

  AnalyseData({this.done, this.body});

  AnalyseData.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
    body = json['body'] != null
        ? new BodyOfAnalyseData.fromJson(json['body'])
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

class BodyOfAnalyseData {
  int prospects;
  int appointments;
  int okAppointments;
  int rejectAppointments;
  int salesInterviews;
  int okSalesInterviews;
  int rejectSalesInterviews;
  int followUps;
  int nop;
  int premium;
  int todos;
  int dob;
  int requsts;

  BodyOfAnalyseData(
      {this.prospects,
      this.appointments,
      this.okAppointments,
      this.rejectAppointments,
      this.salesInterviews,
      this.okSalesInterviews,
      this.rejectSalesInterviews,
      this.followUps,
      this.nop,
      this.premium,
      this.todos,
      this.dob,
      this.requsts});

  BodyOfAnalyseData.fromJson(Map<String, dynamic> json) {
    prospects = json['prospects'];
    appointments = json['appointments'];
    okAppointments = json['ok_appointments'];
    rejectAppointments = json['reject_appointments'];
    salesInterviews = json['sales_interviews'];
    okSalesInterviews = json['ok_sales_interviews'];
    rejectSalesInterviews = json['reject_sales_interviews'];
    followUps = json['follow_ups'];
    nop = json['nop'];
    premium = json['premium'];
    todos = json['todos'];
    dob = json['dob'];
    requsts = json['requsts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospects'] = this.prospects;
    data['appointments'] = this.appointments;
    data['ok_appointments'] = this.okAppointments;
    data['reject_appointments'] = this.rejectAppointments;
    data['sales_interviews'] = this.salesInterviews;
    data['ok_sales_interviews'] = this.okSalesInterviews;
    data['reject_sales_interviews'] = this.rejectSalesInterviews;
    data['follow_ups'] = this.followUps;
    data['nop'] = this.nop;
    data['premium'] = this.premium;
    data['todos'] = this.todos;
    data['dob'] = this.dob;
    data['requsts'] = this.requsts;
    return data;
  }
}
