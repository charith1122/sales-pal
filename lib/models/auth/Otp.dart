class OtpData {
  bool done;
  String message;

  OtpData({this.done, this.message});

  OtpData.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['done'] = this.done;
    data['message'] = this.message;
    return data;
  }
}