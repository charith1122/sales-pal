class GetAppointmentById {
  bool done;
  Body body;
  String message;

  GetAppointmentById({this.done, this.body, this.message});

  GetAppointmentById.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
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

class Body {
  String id;
  String userId;
  String prospectId;
  String date;
  String time;
  String status;
  String reason;
  String note;
  String prosName;

  Body(
      {this.id,
      this.userId,
      this.prospectId,
      this.date,
      this.time,
      this.status,
      this.reason,
      this.note,
      this.prosName});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    prospectId = json['prospect_id'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    reason = json['reason'];
    note = json['note'];
    prosName = json['pros_name'];
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
    return data;
  }
}
