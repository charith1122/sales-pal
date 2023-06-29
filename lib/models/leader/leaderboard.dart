class MemberByContact {
  bool done;
  BodyOfMemberByContact body;
  String message;

  MemberByContact({this.done, this.body, this.message});

  MemberByContact.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    body = json['body'] != null
        ? new BodyOfMemberByContact.fromJson(json['body'])
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

class BodyOfMemberByContact {
  String id;
  String name;
  String companyId;
  String position;
  String regNo;
  String companyName;

  BodyOfMemberByContact(
      {this.id,
      this.name,
      this.companyId,
      this.position,
      this.regNo,
      this.companyName});

  BodyOfMemberByContact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyId = json['company_id'];
    position = json['position'];
    regNo = json['reg_no'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['company_id'] = this.companyId;
    data['position'] = this.position;
    data['reg_no'] = this.regNo;
    data['company_name'] = this.companyName;
    return data;
  }
}

class LeaderMembers {
  bool done;
  List<BodyOfLeaderMembers> body;
  String message;

  LeaderMembers({this.done, this.body, this.message});

  LeaderMembers.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    if (json['body'] != null) {
      body = <BodyOfLeaderMembers>[];
      json['body'].forEach((v) {
        body.add(new BodyOfLeaderMembers.fromJson(v));
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

class BodyOfLeaderMembers {
  String id;
  String memberId;
  String status;
  String memberName;
  String regNo;
  String contact;
  String company;

  BodyOfLeaderMembers(
      {this.id,
      this.memberId,
      this.status,
      this.memberName,
      this.regNo,
      this.contact,
      this.company});

  BodyOfLeaderMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    status = json['status'];
    memberName = json['member_name'];
    company = json['company'];
    contact = json['contact'];
    regNo = json['reg_no'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_id'] = this.memberId;
    data['status'] = this.status;
    data['member_name'] = this.memberName;
    data['reg_no'] = this.regNo;
    data['contact'] = this.contact;
    data['company'] = this.company;
    return data;
  }
}

class LeadersRequests {
  bool done;
  BodyOfLeadersRequests body;
  String message;

  LeadersRequests({this.done, this.body, this.message});

  LeadersRequests.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    body = json['body'] != null
        ? new BodyOfLeadersRequests.fromJson(json['body'])
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

class BodyOfLeadersRequests {
  String id;
  String leaderId;
  String leaderName;

  BodyOfLeadersRequests({this.id, this.leaderId, this.leaderName});

  BodyOfLeadersRequests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaderId = json['leader_id'];
    leaderName = json['leader_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leader_id'] = this.leaderId;
    data['leader_name'] = this.leaderName;
    return data;
  }
}
