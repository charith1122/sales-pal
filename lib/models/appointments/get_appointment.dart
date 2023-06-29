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
    data['done'] = this.done;
    if (this.body != null) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
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
    prospectId = json['prospect_id'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    reason = json['reason'];
    note = json['note'];
    prosName = json['pros_name'];
    prosNum = json['pros_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['prospect_id'] = this.prospectId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['note'] = this.note;
    data['pros_name'] = this.prosName;
    data['pros_no'] = this.prosNum;
    return data;
  }
}
