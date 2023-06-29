class Plan {
  //modal class for Person object
  String month, pros, app, sale, follow, nop, anbp;
  Plan({
    this.month,
    this.pros,
    this.app,
    this.sale,
    this.follow,
    this.nop,
    this.anbp,
  });

  Plan.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    pros = json['pros'];
    app = json['app'];
    sale = json['sale'];
    follow = json['follow'];
    nop = json['nop'];
    anbp = json['anbp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['pros'] = this.pros;
    data['app'] = this.app;
    data['sale'] = this.sale;
    data['follow'] = this.follow;
    data['nop'] = this.nop;
    data['anbp'] = this.anbp;
    return data;
  }

  factory Plan.fromMap(Map<String, dynamic> data) => Plan(
        month: data['month'],
        pros: data['pros'],
        app: data['app'],
        sale: data['sale'],
        follow: data['follow'],
        nop: data['nop'],
        anbp: data['anbp'],
      );
}
