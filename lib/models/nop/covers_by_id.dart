class GetPlanCoversById {
  bool done;
  String message;
  List<BodyOfGetPlanCoversById> body;

  GetPlanCoversById({this.done, this.body});

  GetPlanCoversById.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    message = json['message'];
    if (json['body'] != null) {
      body = <BodyOfGetPlanCoversById>[];
      json['body'].forEach((v) {
        body.add(new BodyOfGetPlanCoversById.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['done'] = this.done;
    data['message'] = this.message;
    if (this.body != null) {
      data['body'] = this.body.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BodyOfGetPlanCoversById {
  String id;
  String planId;
  String tag;
  String coveredPerson;

  BodyOfGetPlanCoversById({this.id, this.planId, this.tag, this.coveredPerson});

  BodyOfGetPlanCoversById.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['plan_id'];
    tag = json['tag'];
    coveredPerson = json['covered_person'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_id'] = this.planId;
    data['tag'] = this.tag;
    data['covered_person'] = this.coveredPerson;
    return data;
  }
}
