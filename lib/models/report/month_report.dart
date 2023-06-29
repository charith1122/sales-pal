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
  int firstFup;
  int secondFup;
  int thirdFup;
  int forthFup;
  int fifthFup;
  int firstNop;
  int secondNop;
  int thirdNop;
  int forthNop;
  int fifthNop;
  int firstAnbp;
  int secondAnbp;
  int thirdAnbp;
  int forthAnbp;
  int fifthAnbp;
  var monthPros;
  var monthApp;
  var monthSale;
  var monthFup;
  var monthNop;
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
      this.firstFup,
      this.secondFup,
      this.thirdFup,
      this.forthFup,
      this.fifthFup,
      this.firstNop,
      this.secondNop,
      this.thirdNop,
      this.forthNop,
      this.fifthNop,
      this.firstAnbp,
      this.secondAnbp,
      this.thirdAnbp,
      this.forthAnbp,
      this.fifthAnbp,
      this.monthPros,
      this.monthApp,
      this.monthSale,
      this.monthFup,
      this.monthNop,
      this.monthAnbp});

  BodyOfMonthReport.fromJson(Map<String, dynamic> json) {
    firstPros = json['first_pros'];
    secondPros = json['second_pros'];
    thirdPros = json['third_pros'];
    forthPros = json['forth_pros'];
    fifthPros = json['fifth_pros'];
    firstApp = json['first_app'];
    secondApp = json['second_app'];
    thirdApp = json['third_app'];
    forthApp = json['forth_app'];
    fifthApp = json['fifth_app'];
    firstSale = json['first_sale'];
    secondSale = json['second_sale'];
    thirdSale = json['third_sale'];
    forthSale = json['forth_sale'];
    fifthSale = json['fifth_sale'];
    firstFup = json['first_fup'];
    secondFup = json['second_fup'];
    thirdFup = json['third_fup'];
    forthFup = json['forth_fup'];
    fifthFup = json['fifth_fup'];
    firstNop = json['first_nop'];
    secondNop = json['second_nop'];
    thirdNop = json['third_nop'];
    forthNop = json['forth_nop'];
    fifthNop = json['fifth_nop'];
    firstAnbp = json['first_anbp'];
    secondAnbp = json['second_anbp'];
    thirdAnbp = json['third_anbp'];
    forthAnbp = json['forth_anbp'];
    fifthAnbp = json['fifth_anbp'];
    monthPros = json['month_pros'];
    monthApp = json['month_app'];
    monthSale = json['month_sale'];
    monthFup = json['month_fup'];
    monthNop = json['month_nop'];
    monthAnbp = json['month_anbp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_pros'] = this.firstPros;
    data['second_pros'] = this.secondPros;
    data['third_pros'] = this.thirdPros;
    data['forth_pros'] = this.forthPros;
    data['fifth_pros'] = this.fifthPros;
    data['first_app'] = this.firstApp;
    data['second_app'] = this.secondApp;
    data['third_app'] = this.thirdApp;
    data['forth_app'] = this.forthApp;
    data['fifth_app'] = this.fifthApp;
    data['first_sale'] = this.firstSale;
    data['second_sale'] = this.secondSale;
    data['third_sale'] = this.thirdSale;
    data['forth_sale'] = this.forthSale;
    data['fifth_sale'] = this.fifthSale;
    data['first_fup'] = this.firstFup;
    data['second_fup'] = this.secondFup;
    data['third_fup'] = this.thirdFup;
    data['forth_fup'] = this.forthFup;
    data['fifth_fup'] = this.fifthFup;
    data['first_nop'] = this.firstNop;
    data['second_nop'] = this.secondNop;
    data['third_nop'] = this.thirdNop;
    data['forth_nop'] = this.forthNop;
    data['fifth_nop'] = this.fifthNop;
    data['first_anbp'] = this.firstAnbp;
    data['second_anbp'] = this.secondAnbp;
    data['third_anbp'] = this.thirdAnbp;
    data['forth_anbp'] = this.forthAnbp;
    data['fifth_anbp'] = this.fifthAnbp;
    data['month_pros'] = this.monthPros;
    data['month_app'] = this.monthApp;
    data['month_sale'] = this.monthSale;
    data['month_fup'] = this.monthFup;
    data['month_nop'] = this.monthNop;
    data['month_anbp'] = this.monthAnbp;
    return data;
  }
}
