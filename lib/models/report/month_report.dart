class MonthReport {
  bool done;
  BodyOfMonthReport body;
  String message;

  MonthReport({this.done, this.body, this.message});

  MonthReport.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    body = json['body'] != null
        ? new BodyOfMonthReport.fromJson(json['body'])
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

class BodyOfMonthReport {
  int firstPros;
  int secondPros;
  int thirdPros;
  int forthPros;
  int fifthPros;
  int firstApp;
  int secondApp;
  int thirdApp;
  int forthApp;
  int fifthApp;
  int firstSale;
  int secondSale;
  int thirdSale;
  int forthSale;
  int fifthSale;
  int firstAnbp;
  int secondAnbp;
  int thirdAnbp;
  int forthAnbp;
  int fifthAnbp;
  var monthPros;
  var monthApp;
  var monthSale;
  var monthAnbp;

  BodyOfMonthReport(
      {this.firstPros,
      this.secondPros,
      this.thirdPros,
      this.forthPros,
      this.fifthPros,
      this.firstApp,
      this.secondApp,
      this.thirdApp,
      this.forthApp,
      this.fifthApp,
      this.firstSale,
      this.secondSale,
      this.thirdSale,
      this.forthSale,
      this.fifthSale,
      this.firstAnbp,
      this.secondAnbp,
      this.thirdAnbp,
      this.forthAnbp,
      this.fifthAnbp,
      this.monthPros,
      this.monthApp,
      this.monthSale,
      this.monthAnbp});

  BodyOfMonthReport.fromJson(Map<String, dynamic> json) {
    firstPros = json['first_cus'];
    secondPros = json['second_cus'];
    thirdPros = json['third_cus'];
    forthPros = json['forth_cus'];
    fifthPros = json['fifth_cus'];
    firstApp = json['first_orders'];
    secondApp = json['second_orders'];
    thirdApp = json['third_orders'];
    forthApp = json['forth_orders'];
    fifthApp = json['fifth_orders'];
    firstSale = json['first_sale'];
    secondSale = json['second_sale'];
    thirdSale = json['third_sale'];
    forthSale = json['forth_sale'];
    fifthSale = json['fifth_sale'];
    
    firstAnbp = json['first_value'];
    secondAnbp = json['second_value'];
    thirdAnbp = json['third_value'];
    forthAnbp = json['forth_value'];
    fifthAnbp = json['fifth_value'];
    monthPros = json['month_cus'];
    monthApp = json['month_orders'];
    monthSale = json['month_sale'];
    
    monthAnbp = json['month_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_cus'] = this.firstPros;
    data['second_cus'] = this.secondPros;
    data['third_cus'] = this.thirdPros;
    data['forth_cus'] = this.forthPros;
    data['fifth_cus'] = this.fifthPros;
    data['first_orders'] = this.firstApp;
    data['second_orders'] = this.secondApp;
    data['third_orders'] = this.thirdApp;
    data['forth_orders'] = this.forthApp;
    data['fifth_orders'] = this.fifthApp;
    data['first_sale'] = this.firstSale;
    data['second_sale'] = this.secondSale;
    data['third_sale'] = this.thirdSale;
    data['forth_sale'] = this.forthSale;
    data['fifth_sale'] = this.fifthSale;
    data['first_value'] = this.firstAnbp;
    data['second_value'] = this.secondAnbp;
    data['third_value'] = this.thirdAnbp;
    data['forth_value'] = this.forthAnbp;
    data['fifth_value'] = this.fifthAnbp;
    data['month_cus'] = this.monthPros;
    data['month_orders'] = this.monthApp;
    data['month_sale'] = this.monthSale;
    data['month_value'] = this.monthAnbp;
    return data;
  }
}
