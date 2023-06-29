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
  int rprtJanFup;
  int rprtFebFup;
  int rprtMarFup;
  int rprtAprlFup;
  int rprtMayFup;
  int rprtJunFup;
  int rprtJulFup;
  int rprtAugFup;
  int rprtSepFup;
  int rprtOctFup;
  int rprtNovFup;
  int rprtDecFup;
  int rprtJanNop;
  int rprtFebNop;
  int rprtMarNop;
  int rprtAprlNop;
  int rprtMayNop;
  int rprtJunNop;
  int rprtJulNop;
  int rprtAugNop;
  int rprtSepNop;
  int rprtOctNop;
  int rprtNovNop;
  int rprtDecNop;
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
      this.rprtJanFup,
      this.rprtFebFup,
      this.rprtMarFup,
      this.rprtAprlFup,
      this.rprtMayFup,
      this.rprtJunFup,
      this.rprtJulFup,
      this.rprtAugFup,
      this.rprtSepFup,
      this.rprtOctFup,
      this.rprtNovFup,
      this.rprtDecFup,
      this.rprtJanNop,
      this.rprtFebNop,
      this.rprtMarNop,
      this.rprtAprlNop,
      this.rprtMayNop,
      this.rprtJunNop,
      this.rprtJulNop,
      this.rprtAugNop,
      this.rprtSepNop,
      this.rprtOctNop,
      this.rprtNovNop,
      this.rprtDecNop,
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
    rprtJanPros = json['rprt_jan_pros'] != null ? json['rprt_jan_pros'] : 0;
    rprtFebPros = json['rprt_feb_pros'];
    rprtMarPros = json['rprt_mar_pros'];
    rprtAprlPros = json['rprt_aprl_pros'];
    rprtMayPros = json['rprt_may_pros'];
    rprtJunPros = json['rprt_jun_pros'];
    rprtJulPros = json['rprt_jul_pros'];
    rprtAugPros = json['rprt_aug_pros'];
    rprtSepPros = json['rprt_sep_pros'];
    rprtOctPros = json['rprt_oct_pros'];
    rprtNovPros = json['rprt_nov_pros'];
    rprtDecPros = json['rprt_dec_pros'];
    rprtJanApp = json['rprt_jan_app'];
    rprtFebApp = json['rprt_feb_app'];
    rprtMarApp = json['rprt_mar_app'];
    rprtAprlApp = json['rprt_aprl_app'];
    rprtMayApp = json['rprt_may_app'];
    rprtJunApp = json['rprt_jun_app'];
    rprtJulApp = json['rprt_jul_app'];
    rprtAugApp = json['rprt_aug_app'];
    rprtSepApp = json['rprt_sep_app'];
    rprtOctApp = json['rprt_oct_app'];
    rprtNovApp = json['rprt_nov_app'];
    rprtDecApp = json['rprt_dec_app'];
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
    rprtJanFup = json['rprt_jan_fup'];
    rprtFebFup = json['rprt_feb_fup'];
    rprtMarFup = json['rprt_mar_fup'];
    rprtAprlFup = json['rprt_aprl_fup'];
    rprtMayFup = json['rprt_may_fup'];
    rprtJunFup = json['rprt_jun_fup'];
    rprtJulFup = json['rprt_jul_fup'];
    rprtAugFup = json['rprt_aug_fup'];
    rprtSepFup = json['rprt_sep_fup'];
    rprtOctFup = json['rprt_oct_fup'];
    rprtNovFup = json['rprt_nov_fup'];
    rprtDecFup = json['rprt_dec_fup'];
    rprtJanNop = json['rprt_jan_nop'];
    rprtFebNop = json['rprt_feb_nop'];
    rprtMarNop = json['rprt_mar_nop'];
    rprtAprlNop = json['rprt_aprl_nop'];
    rprtMayNop = json['rprt_may_nop'];
    rprtJunNop = json['rprt_jun_nop'];
    rprtJulNop = json['rprt_jul_nop'];
    rprtAugNop = json['rprt_aug_nop'];
    rprtSepNop = json['rprt_sep_nop'];
    rprtOctNop = json['rprt_oct_nop'];
    rprtNovNop = json['rprt_nov_nop'];
    rprtDecNop = json['rprt_dec_nop'];
    rprtJanAnbp = json['rprt_jan_anbp'];
    rprtFebAnbp = json['rprt_feb_anbp'];
    rprtMarAnbp = json['rprt_mar_anbp'];
    rprtAprlAnbp = json['rprt_aprl_anbp'];
    rprtMayAnbp = json['rprt_may_anbp'];
    rprtJunAnbp = json['rprt_jun_anbp'];
    rprtJulAnbp = json['rprt_jul_anbp'];
    rprtAugAnbp = json['rprt_aug_anbp'];
    rprtSepAnbp = json['rprt_sep_anbp'];
    rprtOctAnbp = json['rprt_oct_anbp'];
    rprtNovAnbp = json['rprt_nov_anbp'];
    rprtDecAnbp = json['rprt_dec_anbp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rprt_jan_pros'] = this.rprtJanPros;
    data['rprt_feb_pros'] = this.rprtFebPros;
    data['rprt_mar_pros'] = this.rprtMarPros;
    data['rprt_aprl_pros'] = this.rprtAprlPros;
    data['rprt_may_pros'] = this.rprtMayPros;
    data['rprt_jun_pros'] = this.rprtJunPros;
    data['rprt_jul_pros'] = this.rprtJulPros;
    data['rprt_aug_pros'] = this.rprtAugPros;
    data['rprt_sep_pros'] = this.rprtSepPros;
    data['rprt_oct_pros'] = this.rprtOctPros;
    data['rprt_nov_pros'] = this.rprtNovPros;
    data['rprt_dec_pros'] = this.rprtDecPros;
    data['rprt_jan_app'] = this.rprtJanApp;
    data['rprt_feb_app'] = this.rprtFebApp;
    data['rprt_mar_app'] = this.rprtMarApp;
    data['rprt_aprl_app'] = this.rprtAprlApp;
    data['rprt_may_app'] = this.rprtMayApp;
    data['rprt_jun_app'] = this.rprtJunApp;
    data['rprt_jul_app'] = this.rprtJulApp;
    data['rprt_aug_app'] = this.rprtAugApp;
    data['rprt_sep_app'] = this.rprtSepApp;
    data['rprt_oct_app'] = this.rprtOctApp;
    data['rprt_nov_app'] = this.rprtNovApp;
    data['rprt_dec_app'] = this.rprtDecApp;
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
    data['rprt_jan_fup'] = this.rprtJanFup;
    data['rprt_feb_fup'] = this.rprtFebFup;
    data['rprt_mar_fup'] = this.rprtMarFup;
    data['rprt_aprl_fup'] = this.rprtAprlFup;
    data['rprt_may_fup'] = this.rprtMayFup;
    data['rprt_jun_fup'] = this.rprtJunFup;
    data['rprt_jul_fup'] = this.rprtJulFup;
    data['rprt_aug_fup'] = this.rprtAugFup;
    data['rprt_sep_fup'] = this.rprtSepFup;
    data['rprt_oct_fup'] = this.rprtOctFup;
    data['rprt_nov_fup'] = this.rprtNovFup;
    data['rprt_dec_fup'] = this.rprtDecFup;
    data['rprt_jan_nop'] = this.rprtJanNop;
    data['rprt_feb_nop'] = this.rprtFebNop;
    data['rprt_mar_nop'] = this.rprtMarNop;
    data['rprt_aprl_nop'] = this.rprtAprlNop;
    data['rprt_may_nop'] = this.rprtMayNop;
    data['rprt_jun_nop'] = this.rprtJunNop;
    data['rprt_jul_nop'] = this.rprtJulNop;
    data['rprt_aug_nop'] = this.rprtAugNop;
    data['rprt_sep_nop'] = this.rprtSepNop;
    data['rprt_oct_nop'] = this.rprtOctNop;
    data['rprt_nov_nop'] = this.rprtNovNop;
    data['rprt_dec_nop'] = this.rprtDecNop;
    data['rprt_jan_anbp'] = this.rprtJanAnbp;
    data['rprt_feb_anbp'] = this.rprtFebAnbp;
    data['rprt_mar_anbp'] = this.rprtMarAnbp;
    data['rprt_aprl_anbp'] = this.rprtAprlAnbp;
    data['rprt_may_anbp'] = this.rprtMayAnbp;
    data['rprt_jun_anbp'] = this.rprtJunAnbp;
    data['rprt_jul_anbp'] = this.rprtJulAnbp;
    data['rprt_aug_anbp'] = this.rprtAugAnbp;
    data['rprt_sep_anbp'] = this.rprtSepAnbp;
    data['rprt_oct_anbp'] = this.rprtOctAnbp;
    data['rprt_nov_anbp'] = this.rprtNovAnbp;
    data['rprt_dec_anbp'] = this.rprtDecAnbp;
    return data;
  }
}
