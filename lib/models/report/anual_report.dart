class AnualReport {
  bool done;
  BodyOfAnualReport body;
  String message;

  AnualReport({this.done, this.body, this.message});

  AnualReport.fromJson(Map<String, dynamic> json) {
    done = json['done'];
    body = json['body'] != null
        ? new BodyOfAnualReport.fromJson(json['body'])
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

class BodyOfAnualReport {
  int rprtJanPros;
  int rprtFebPros;
  int rprtMarPros;
  int rprtAprlPros;
  int rprtMayPros;
  int rprtJunPros;
  int rprtJulPros;
  int rprtAugPros;
  int rprtSepPros;
  int rprtOctPros;
  int rprtNovPros;
  int rprtDecPros;
  int rprtJanApp;
  int rprtFebApp;
  int rprtMarApp;
  int rprtAprlApp;
  int rprtMayApp;
  int rprtJunApp;
  int rprtJulApp;
  int rprtAugApp;
  int rprtSepApp;
  int rprtOctApp;
  int rprtNovApp;
  int rprtDecApp;
  int rprtJanSale;
  int rprtFebSale;
  int rprtMarSale;
  int rprtAprlSale;
  int rprtMaySale;
  int rprtJunSale;
  int rprtJulSale;
  int rprtAugSale;
  int rprtSepSale;
  int rprtOctSale;
  int rprtNovSale;
  int rprtDecSale;
  
  int rprtJanAnbp;
  int rprtFebAnbp;
  int rprtMarAnbp;
  int rprtAprlAnbp;
  int rprtMayAnbp;
  int rprtJunAnbp;
  int rprtJulAnbp;
  int rprtAugAnbp;
  int rprtSepAnbp;
  int rprtOctAnbp;
  int rprtNovAnbp;
  int rprtDecAnbp;

  BodyOfAnualReport(
      {this.rprtJanPros,
      this.rprtFebPros,
      this.rprtMarPros,
      this.rprtAprlPros,
      this.rprtMayPros,
      this.rprtJunPros,
      this.rprtJulPros,
      this.rprtAugPros,
      this.rprtSepPros,
      this.rprtOctPros,
      this.rprtNovPros,
      this.rprtDecPros,
      this.rprtJanApp,
      this.rprtFebApp,
      this.rprtMarApp,
      this.rprtAprlApp,
      this.rprtMayApp,
      this.rprtJunApp,
      this.rprtJulApp,
      this.rprtAugApp,
      this.rprtSepApp,
      this.rprtOctApp,
      this.rprtNovApp,
      this.rprtDecApp,
      this.rprtJanSale,
      this.rprtFebSale,
      this.rprtMarSale,
      this.rprtAprlSale,
      this.rprtMaySale,
      this.rprtJunSale,
      this.rprtJulSale,
      this.rprtAugSale,
      this.rprtSepSale,
      this.rprtOctSale,
      this.rprtNovSale,
      this.rprtDecSale,
      this.rprtJanAnbp,
      this.rprtFebAnbp,
      this.rprtMarAnbp,
      this.rprtAprlAnbp,
      this.rprtMayAnbp,
      this.rprtJunAnbp,
      this.rprtJulAnbp,
      this.rprtAugAnbp,
      this.rprtSepAnbp,
      this.rprtOctAnbp,
      this.rprtNovAnbp,
      this.rprtDecAnbp});

  BodyOfAnualReport.fromJson(Map<String, dynamic> json) {
    rprtJanPros = json['rprt_jan_cus'] != null ? json['rprt_jan_cus'] : 0;
    rprtFebPros = json['rprt_feb_cus'];
    rprtMarPros = json['rprt_mar_cus'];
    rprtAprlPros = json['rprt_aprl_cus'];
    rprtMayPros = json['rprt_may_cus'];
    rprtJunPros = json['rprt_jun_cus'];
    rprtJulPros = json['rprt_jul_cus'];
    rprtAugPros = json['rprt_aug_cus'];
    rprtSepPros = json['rprt_sep_cus'];
    rprtOctPros = json['rprt_oct_cus'];
    rprtNovPros = json['rprt_nov_cus'];
    rprtDecPros = json['rprt_dec_cus'];
    rprtJanApp = json['rprt_jan_orders'];
    rprtFebApp = json['rprt_feb_orders'];
    rprtMarApp = json['rprt_mar_orders'];
    rprtAprlApp = json['rprt_aprl_orders'];
    rprtMayApp = json['rprt_may_orders'];
    rprtJunApp = json['rprt_jun_orders'];
    rprtJulApp = json['rprt_jul_orders'];
    rprtAugApp = json['rprt_aug_orders'];
    rprtSepApp = json['rprt_sep_orders'];
    rprtOctApp = json['rprt_oct_orders'];
    rprtNovApp = json['rprt_nov_orders'];
    rprtDecApp = json['rprt_dec_orders'];
    rprtJanSale = json['rprt_jan_sale'];
    rprtFebSale = json['rprt_feb_sale'];
    rprtMarSale = json['rprt_mar_sale'];
    rprtAprlSale = json['rprt_aprl_sale'];
    rprtMaySale = json['rprt_may_sale'];
    rprtJunSale = json['rprt_jun_sale'];
    rprtJulSale = json['rprt_jul_sale'];
    rprtAugSale = json['rprt_aug_sale'];
    rprtSepSale = json['rprt_sep_sale'];
    rprtOctSale = json['rprt_oct_sale'];
    rprtNovSale = json['rprt_nov_sale'];
    rprtDecSale = json['rprt_dec_sale'];
    
    rprtJanAnbp = json['rprt_jan_value'];
    rprtFebAnbp = json['rprt_feb_value'];
    rprtMarAnbp = json['rprt_mar_value'];
    rprtAprlAnbp = json['rprt_aprl_value'];
    rprtMayAnbp = json['rprt_may_value'];
    rprtJunAnbp = json['rprt_jun_value'];
    rprtJulAnbp = json['rprt_jul_value'];
    rprtAugAnbp = json['rprt_aug_value'];
    rprtSepAnbp = json['rprt_sep_value'];
    rprtOctAnbp = json['rprt_oct_value'];
    rprtNovAnbp = json['rprt_nov_value'];
    rprtDecAnbp = json['rprt_dec_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rprt_jan_cus'] = this.rprtJanPros;
    data['rprt_feb_cus'] = this.rprtFebPros;
    data['rprt_mar_cus'] = this.rprtMarPros;
    data['rprt_aprl_cus'] = this.rprtAprlPros;
    data['rprt_may_cus'] = this.rprtMayPros;
    data['rprt_jun_cus'] = this.rprtJunPros;
    data['rprt_jul_cus'] = this.rprtJulPros;
    data['rprt_aug_cus'] = this.rprtAugPros;
    data['rprt_sep_cus'] = this.rprtSepPros;
    data['rprt_oct_cus'] = this.rprtOctPros;
    data['rprt_nov_cus'] = this.rprtNovPros;
    data['rprt_dec_cus'] = this.rprtDecPros;
    data['rprt_jan_orders'] = this.rprtJanApp;
    data['rprt_feb_orders'] = this.rprtFebApp;
    data['rprt_mar_orders'] = this.rprtMarApp;
    data['rprt_aprl_orders'] = this.rprtAprlApp;
    data['rprt_may_orders'] = this.rprtMayApp;
    data['rprt_jun_orders'] = this.rprtJunApp;
    data['rprt_jul_orders'] = this.rprtJulApp;
    data['rprt_aug_orders'] = this.rprtAugApp;
    data['rprt_sep_orders'] = this.rprtSepApp;
    data['rprt_oct_orders'] = this.rprtOctApp;
    data['rprt_nov_orders'] = this.rprtNovApp;
    data['rprt_dec_orders'] = this.rprtDecApp;
    data['rprt_jan_sale'] = this.rprtJanSale;
    data['rprt_feb_sale'] = this.rprtFebSale;
    data['rprt_mar_sale'] = this.rprtMarSale;
    data['rprt_aprl_sale'] = this.rprtAprlSale;
    data['rprt_may_sale'] = this.rprtMaySale;
    data['rprt_jun_sale'] = this.rprtJunSale;
    data['rprt_jul_sale'] = this.rprtJulSale;
    data['rprt_aug_sale'] = this.rprtAugSale;
    data['rprt_sep_sale'] = this.rprtSepSale;
    data['rprt_oct_sale'] = this.rprtOctSale;
    data['rprt_nov_sale'] = this.rprtNovSale;
    data['rprt_dec_sale'] = this.rprtDecSale;
    
    data['rprt_jan_value'] = this.rprtJanAnbp;
    data['rprt_feb_value'] = this.rprtFebAnbp;
    data['rprt_mar_value'] = this.rprtMarAnbp;
    data['rprt_aprl_value'] = this.rprtAprlAnbp;
    data['rprt_may_value'] = this.rprtMayAnbp;
    data['rprt_jun_value'] = this.rprtJunAnbp;
    data['rprt_jul_value'] = this.rprtJulAnbp;
    data['rprt_aug_value'] = this.rprtAugAnbp;
    data['rprt_sep_value'] = this.rprtSepAnbp;
    data['rprt_oct_value'] = this.rprtOctAnbp;
    data['rprt_nov_value'] = this.rprtNovAnbp;
    data['rprt_dec_value'] = this.rprtDecAnbp;
    return data;
  }
}
