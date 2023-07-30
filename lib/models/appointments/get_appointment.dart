class GetAppointments {
  bool done;
  List<BodyOfGetAppointments> body;
  String message;

  GetAppointments({this.done, this.body});

  GetAppointments.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    if (json['body'] != null) {
      body = <BodyOfGetAppointments>[];
      json['body'].forEach((v) {
        body.add(new BodyOfGetAppointments.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['done'] = done;
    if (body != null) {
      data['body'] = body.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class BodyOfGetAppointments {
  String id;
  String userId;
  String prospectId;
  String date;
  String time;
  String status;
  String reason;
  String note;
  String prosName;
  int prosNum;

  BodyOfGetAppointments(
      {this.id,
      this.userId,
      this.prospectId,
      this.date,
      this.time,
      this.status,
      this.reason,
      this.note,
      this.prosName,
      this.prosNum});

  BodyOfGetAppointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    prospectId = json['customer_id'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    reason = json['reason'];
    note = json['note'];
    prosName = json['customer_name'];
    prosNum = json['cus_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['customer_id'] = prospectId;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    data['reason'] = reason;
    data['note'] = note;
    data['customer_name'] = prosName;
    data['cus_no'] = prosNum;
    return data;
  }
}
