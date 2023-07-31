import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pros_bot/components/annual_plan/textFiel.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/models/annual_plan/getAnnualPlans.dart';
import 'package:pros_bot/models/annual_plan/plan.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/models/report/anual_report.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/reports/anual_print.dart';
// import 'package:pros_bot/screens/reports/pdf_preview.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class Reports extends StatefulWidget {
  const Reports({Key key}) : super(key: key);

  // final String title;

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  int selectedVal;

  bool canPrint = false;

  BodyOfAnualReport anualReport;
  final today = DateTime.now();
  String _chosenValue = '2023';
  String _lodedYear = '2023';

  String myCompany = '';

  TextEditingController numberController = TextEditingController();

  List<Plan> plans = [];

  List<BodyOfGetAnnualPlans> savedPlans = [];
  List<BodyOfGetAnnualPlans> savedPlans2 = [];
  bool isLoading = true;
  bool isSubmitting = false;

  var selectedUser;

  TextEditingController janProsController = TextEditingController();
  TextEditingController janAppController = TextEditingController();
  TextEditingController janSiController = TextEditingController();
  TextEditingController janFuController = TextEditingController();
  TextEditingController janNopController = TextEditingController();
  TextEditingController janAnbpController = TextEditingController();

  TextEditingController febProsController = TextEditingController();
  TextEditingController febAppController = TextEditingController();
  TextEditingController febSiController = TextEditingController();
  TextEditingController febFuController = TextEditingController();
  TextEditingController febNopController = TextEditingController();
  TextEditingController febAnbpController = TextEditingController();

  TextEditingController marProsController = TextEditingController();
  TextEditingController marAppController = TextEditingController();
  TextEditingController marSiController = TextEditingController();
  TextEditingController marFuController = TextEditingController();
  TextEditingController marNopController = TextEditingController();
  TextEditingController marAnbpController = TextEditingController();

  TextEditingController aprlProsController = TextEditingController();
  TextEditingController aprlAppController = TextEditingController();
  TextEditingController aprlSiController = TextEditingController();
  TextEditingController aprlFuController = TextEditingController();
  TextEditingController aprlNopController = TextEditingController();
  TextEditingController aprlAnbpController = TextEditingController();

  TextEditingController mayProsController = TextEditingController();
  TextEditingController mayAppController = TextEditingController();
  TextEditingController maySiController = TextEditingController();
  TextEditingController mayFuController = TextEditingController();
  TextEditingController mayNopController = TextEditingController();
  TextEditingController mayAnbpController = TextEditingController();

  TextEditingController junProsController = TextEditingController();
  TextEditingController junAppController = TextEditingController();
  TextEditingController junSiController = TextEditingController();
  TextEditingController junFuController = TextEditingController();
  TextEditingController junNopController = TextEditingController();
  TextEditingController junAnbpController = TextEditingController();

  TextEditingController julProsController = TextEditingController();
  TextEditingController julAppController = TextEditingController();
  TextEditingController julSiController = TextEditingController();
  TextEditingController julFuController = TextEditingController();
  TextEditingController julNopController = TextEditingController();
  TextEditingController julAnbpController = TextEditingController();

  TextEditingController augProsController = TextEditingController();
  TextEditingController augAppController = TextEditingController();
  TextEditingController augSiController = TextEditingController();
  TextEditingController augFuController = TextEditingController();
  TextEditingController augNopController = TextEditingController();
  TextEditingController augAnbpController = TextEditingController();

  TextEditingController sepProsController = TextEditingController();
  TextEditingController sepAppController = TextEditingController();
  TextEditingController sepSiController = TextEditingController();
  TextEditingController sepFuController = TextEditingController();
  TextEditingController sepNopController = TextEditingController();
  TextEditingController sepAnbpController = TextEditingController();

  TextEditingController octProsController = TextEditingController();
  TextEditingController octAppController = TextEditingController();
  TextEditingController octSiController = TextEditingController();
  TextEditingController octFuController = TextEditingController();
  TextEditingController octNopController = TextEditingController();
  TextEditingController octAnbpController = TextEditingController();

  TextEditingController novProsController = TextEditingController();
  TextEditingController novAppController = TextEditingController();
  TextEditingController novSiController = TextEditingController();
  TextEditingController novFuController = TextEditingController();
  TextEditingController novNopController = TextEditingController();
  TextEditingController novAnbpController = TextEditingController();

  TextEditingController decProsController = TextEditingController();
  TextEditingController decAppController = TextEditingController();
  TextEditingController decSiController = TextEditingController();
  TextEditingController decFuController = TextEditingController();
  TextEditingController decNopController = TextEditingController();
  TextEditingController decAnbpController = TextEditingController();

  String rprtJanPros = '0';
  String rprtFebPros = '0';
  String rprtMarPros = '0';
  String rprtAprlPros = '0';
  String rprtMayPros = '0';
  String rprtJunPros = '0';
  String rprtJulPros = '0';
  String rprtAugPros = '0';
  String rprtSepPros = '0';
  String rprtOctPros = '0';
  String rprtNovPros = '0';
  String rprtDecPros = '0';
  String rprtJanApp = '0';
  String rprtFebApp = '0';
  String rprtMarApp = '0';
  String rprtAprlApp = '0';
  String rprtMayApp = '0';
  String rprtJunApp = '0';
  String rprtJulApp = '0';
  String rprtAugApp = '0';
  String rprtSepApp = '0';
  String rprtOctApp = '0';
  String rprtNovApp = '0';
  String rprtDecApp = '0';
  String rprtJanSale = '0';
  String rprtFebSale = '0';
  String rprtMarSale = '0';
  String rprtAprlSale = '0';
  String rprtMaySale = '0';
  String rprtJunSale = '0';
  String rprtJulSale = '0';
  String rprtAugSale = '0';
  String rprtSepSale = '0';
  String rprtOctSale = '0';
  String rprtNovSale = '0';
  String rprtDecSale = '0';
  String rprtJanFup = '0';
  String rprtFebFup = '0';
  String rprtMarFup = '0';
  String rprtAprlFup = '0';
  String rprtMayFup = '0';
  String rprtJunFup = '0';
  String rprtJulFup = '0';
  String rprtAugFup = '0';
  String rprtSepFup = '0';
  String rprtOctFup = '0';
  String rprtNovFup = '0';
  String rprtDecFup = '0';
  String rprtJanNop = '0';
  String rprtFebNop = '0';
  String rprtMarNop = '0';
  String rprtAprlNop = '0';
  String rprtMayNop = '0';
  String rprtJunNop = '0';
  String rprtJulNop = '0';
  String rprtAugNop = '0';
  String rprtSepNop = '0';
  String rprtOctNop = '0';
  String rprtNovNop = '0';
  String rprtDecNop = '0';
  String rprtJanAnbp = '0';
  String rprtFebAnbp = '0';
  String rprtMarAnbp = '0';
  String rprtAprlAnbp = '0';
  String rprtMayAnbp = '0';
  String rprtJunAnbp = '0';
  String rprtJulAnbp = '0';
  String rprtAugAnbp = '0';
  String rprtSepAnbp = '0';
  String rprtOctAnbp = '0';
  String rprtNovAnbp = '0';
  String rprtDecAnbp = '0';

  @override
  void initState() {
    super.initState();

    _chosenValue = today.year.toString();
    _lodedYear = today.year.toString();

    setState(() {
      janAnbpController.text = '0';
      febAnbpController.text = '0';
      marAnbpController.text = '0';
      aprlAnbpController.text = '0';
      mayAnbpController.text = '0';
      junAnbpController.text = '0';
      julAnbpController.text = '0';
      augAnbpController.text = '0';
      sepAnbpController.text = '0';
      octAnbpController.text = '0';
      novAnbpController.text = '0';
      decAnbpController.text = '0';
    });

    getuser();
  }

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    getAnnualPlan();
    getCompany();
  }

  getCompany() async {
    try {
      await APIs()
          .getMyCompany(userId: selectedUser["body"]["id"])
          .then((value) {
        // print(value["body"]["name"]);
        setState(() {
          myCompany = value["body"]["name"];
        });
      });
    } catch (e) {}
  }

  getAnnualPlan() async {
    try {
      savedPlans.clear();
      await APIs()
          .getAnnualPlans(
              userId: selectedUser["body"]["id"], year: _chosenValue)
          .then((value) {
        value.body.forEach((item) {
          savedPlans.add(item);
        });
        if (savedPlans.isNotEmpty) {
          setDataFields();
        } else {
          setTextFieldsNull();
        }
        getAnnualReport();
        setState(() {
          _lodedYear = _chosenValue;
          // isLoading = false;
        });
        print(savedPlans);
        setState(() {
          savedPlans2 = value.body;
          canPrint = true;
        });
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  getAnnualReport() async {
    try {
      savedPlans.clear();
      await APIs()
          .getAnnualReport(
              userId: selectedUser["body"]["id"], year: _chosenValue)
          .then((value) {
        if (value.done) {
          anualReport = value.body;
          setValues();
          setState(() {
            // _lodedYear = _chosenValue;
            isLoading = false;
          });
          print(savedPlans);
        } else {}
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  setDataFields() {
    for (int a = 0; a < savedPlans.length; a++) {
      if (savedPlans[a].month == 'January') {
        setState(() {
          janProsController.text = savedPlans[a].pros;
          janAppController.text = savedPlans[a].app;
          janSiController.text = savedPlans[a].sale;
          janFuController.text = savedPlans[a].follow;
          janNopController.text = savedPlans[a].nop;
          janAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'February') {
        setState(() {
          febProsController.text = savedPlans[a].pros;
          febAppController.text = savedPlans[a].app;
          febSiController.text = savedPlans[a].sale;
          febFuController.text = savedPlans[a].follow;
          febNopController.text = savedPlans[a].nop;
          febAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'March') {
        setState(() {
          marProsController.text = savedPlans[a].pros;
          marAppController.text = savedPlans[a].app;
          marSiController.text = savedPlans[a].sale;
          marFuController.text = savedPlans[a].follow;
          marNopController.text = savedPlans[a].nop;
          marAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'April') {
        setState(() {
          aprlProsController.text = savedPlans[a].pros;
          aprlAppController.text = savedPlans[a].app;
          aprlSiController.text = savedPlans[a].sale;
          aprlFuController.text = savedPlans[a].follow;
          aprlNopController.text = savedPlans[a].nop;
          aprlAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'May') {
        setState(() {
          mayProsController.text = savedPlans[a].pros;
          mayAppController.text = savedPlans[a].app;
          maySiController.text = savedPlans[a].sale;
          mayFuController.text = savedPlans[a].follow;
          mayNopController.text = savedPlans[a].nop;
          mayAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'June') {
        setState(() {
          junProsController.text = savedPlans[a].pros;
          junAppController.text = savedPlans[a].app;
          junSiController.text = savedPlans[a].sale;
          junFuController.text = savedPlans[a].follow;
          junNopController.text = savedPlans[a].nop;
          junAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'July') {
        setState(() {
          julProsController.text = savedPlans[a].pros;
          julAppController.text = savedPlans[a].app;
          julSiController.text = savedPlans[a].sale;
          julFuController.text = savedPlans[a].follow;
          julNopController.text = savedPlans[a].nop;
          julAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'August') {
        setState(() {
          augProsController.text = savedPlans[a].pros;
          augAppController.text = savedPlans[a].app;
          augSiController.text = savedPlans[a].sale;
          augFuController.text = savedPlans[a].follow;
          augNopController.text = savedPlans[a].nop;
          augAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'September') {
        setState(() {
          sepProsController.text = savedPlans[a].pros;
          sepAppController.text = savedPlans[a].app;
          sepSiController.text = savedPlans[a].sale;
          sepFuController.text = savedPlans[a].follow;
          sepNopController.text = savedPlans[a].nop;
          sepAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'October') {
        setState(() {
          octProsController.text = savedPlans[a].pros;
          octAppController.text = savedPlans[a].app;
          octSiController.text = savedPlans[a].sale;
          octFuController.text = savedPlans[a].follow;
          octNopController.text = savedPlans[a].nop;
          octAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'November') {
        setState(() {
          novProsController.text = savedPlans[a].pros;
          novAppController.text = savedPlans[a].app;
          novSiController.text = savedPlans[a].sale;
          novFuController.text = savedPlans[a].follow;
          novNopController.text = savedPlans[a].nop;
          novAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'December') {
        setState(() {
          decProsController.text = savedPlans[a].pros;
          decAppController.text = savedPlans[a].app;
          decSiController.text = savedPlans[a].sale;
          decFuController.text = savedPlans[a].follow;
          decNopController.text = savedPlans[a].nop;
          decAnbpController.text = savedPlans[a].anbp;
        });
      } else {
        // setTextFieldsNull();
      }
    }
  }

  setTextFieldsNull() {
    setState(() {
      janProsController.text = '0';
      janAppController.text = '0';
      janSiController.text = '0';
      janFuController.text = '0';
      janNopController.text = '0';
      janAnbpController.text = '0';
      febProsController.text = '0';
      febAppController.text = '0';
      febSiController.text = '0';
      febFuController.text = '0';
      febNopController.text = '0';
      febAnbpController.text = '0';
      marProsController.text = '0';
      marAppController.text = '0';
      marSiController.text = '0';
      marFuController.text = '0';
      marNopController.text = '0';
      marAnbpController.text = '0';
      aprlProsController.text = '0';
      aprlAppController.text = '0';
      aprlSiController.text = '0';
      aprlFuController.text = '0';
      aprlNopController.text = '0';
      aprlAnbpController.text = '0';
      mayProsController.text = '0';
      mayAppController.text = '0';
      maySiController.text = '0';
      mayFuController.text = '0';
      mayNopController.text = '0';
      mayAnbpController.text = '0';
      junProsController.text = '0';
      junAppController.text = '0';
      junSiController.text = '0';
      junFuController.text = '0';
      junNopController.text = '0';
      junAnbpController.text = '0';
      julProsController.text = '0';
      julAppController.text = '0';
      julSiController.text = '0';
      julFuController.text = '0';
      julNopController.text = '0';
      julAnbpController.text = '0';
      augProsController.text = '0';
      augAppController.text = '0';
      augSiController.text = '0';
      augFuController.text = '0';
      augNopController.text = '0';
      augAnbpController.text = '0';
      sepProsController.text = '0';
      sepAppController.text = '0';
      sepSiController.text = '0';
      sepFuController.text = '0';
      sepNopController.text = '0';
      sepAnbpController.text = '0';
      octProsController.text = '0';
      octAppController.text = '0';
      octSiController.text = '0';
      octFuController.text = '0';
      octNopController.text = '0';
      octAnbpController.text = '0';
      novProsController.text = '0';
      novAppController.text = '0';
      novSiController.text = '0';
      novFuController.text = '0';
      novNopController.text = '0';
      novAnbpController.text = '0';
      decProsController.text = '0';
      decAppController.text = '0';
      decSiController.text = '0';
      decFuController.text = '0';
      decNopController.text = '0';
      decAnbpController.text = '0';
    });
  }

  setValues() {
    setState(() {
      rprtJanPros = anualReport.rprtJanPros.toString();
      rprtFebPros = anualReport.rprtFebPros.toString();
      rprtMarPros = anualReport.rprtMarPros.toString();
      rprtAprlPros = anualReport.rprtAprlPros.toString();
      rprtMayPros = anualReport.rprtMayPros.toString();
      rprtJunPros = anualReport.rprtJunPros.toString();
      rprtJulPros = anualReport.rprtJulPros.toString();
      rprtAugPros = anualReport.rprtAugPros.toString();
      rprtSepPros = anualReport.rprtSepPros.toString();
      rprtOctPros = anualReport.rprtOctPros.toString();
      rprtNovPros = anualReport.rprtNovPros.toString();
      rprtDecPros = anualReport.rprtDecPros.toString();
      rprtJanApp = anualReport.rprtJanApp.toString();
      rprtFebApp = anualReport.rprtFebApp.toString();
      rprtMarApp = anualReport.rprtMarApp.toString();
      rprtAprlApp = anualReport.rprtAprlApp.toString();
      rprtMayApp = anualReport.rprtMayApp.toString();
      rprtJunApp = anualReport.rprtJunApp.toString();
      rprtJulApp = anualReport.rprtJulApp.toString();
      rprtAugApp = anualReport.rprtAugApp.toString();
      rprtSepApp = anualReport.rprtSepApp.toString();
      rprtOctApp = anualReport.rprtOctApp.toString();
      rprtNovApp = anualReport.rprtNovApp.toString();
      rprtDecApp = anualReport.rprtDecApp.toString();
      rprtJanSale = anualReport.rprtJanSale.toString();
      rprtFebSale = anualReport.rprtFebSale.toString();
      rprtMarSale = anualReport.rprtMarSale.toString();
      rprtAprlSale = anualReport.rprtAprlSale.toString();
      rprtMaySale = anualReport.rprtMaySale.toString();
      rprtJunSale = anualReport.rprtJunSale.toString();
      rprtJulSale = anualReport.rprtJulSale.toString();
      rprtAugSale = anualReport.rprtAugSale.toString();
      rprtSepSale = anualReport.rprtSepSale.toString();
      rprtOctSale = anualReport.rprtOctSale.toString();
      rprtNovSale = anualReport.rprtNovSale.toString();
      rprtDecSale = anualReport.rprtDecSale.toString();
      rprtJanFup = anualReport.rprtJanFup.toString();
      rprtFebFup = anualReport.rprtFebFup.toString();
      rprtMarFup = anualReport.rprtMarFup.toString();
      rprtAprlFup = anualReport.rprtAprlFup.toString();
      rprtMayFup = anualReport.rprtMayFup.toString();
      rprtJunFup = anualReport.rprtJunFup.toString();
      rprtJulFup = anualReport.rprtJulFup.toString();
      rprtAugFup = anualReport.rprtAugFup.toString();
      rprtSepFup = anualReport.rprtSepFup.toString();
      rprtOctFup = anualReport.rprtOctFup.toString();
      rprtNovFup = anualReport.rprtNovFup.toString();
      rprtDecFup = anualReport.rprtDecFup.toString();
      rprtJanNop = anualReport.rprtJanNop.toString();
      rprtFebNop = anualReport.rprtFebNop.toString();
      rprtMarNop = anualReport.rprtMarNop.toString();
      rprtAprlNop = anualReport.rprtAprlNop.toString();
      rprtMayNop = anualReport.rprtMayNop.toString();
      rprtJunNop = anualReport.rprtJunNop.toString();
      rprtJulNop = anualReport.rprtJulNop.toString();
      rprtAugNop = anualReport.rprtAugNop.toString();
      rprtSepNop = anualReport.rprtSepNop.toString();
      rprtOctNop = anualReport.rprtOctNop.toString();
      rprtNovNop = anualReport.rprtNovNop.toString();
      rprtDecNop = anualReport.rprtDecNop.toString();
      rprtJanAnbp = (anualReport.rprtJanAnbp * 12).toString();
      rprtFebAnbp = (anualReport.rprtFebAnbp * 12).toString();
      rprtMarAnbp = (anualReport.rprtMarAnbp * 12).toString();
      rprtAprlAnbp = (anualReport.rprtAprlAnbp * 12).toString();
      rprtMayAnbp = (anualReport.rprtMayAnbp * 12).toString();
      rprtJunAnbp = (anualReport.rprtJunAnbp * 12).toString();
      rprtJulAnbp = (anualReport.rprtJulAnbp * 12).toString();
      rprtAugAnbp = (anualReport.rprtAugAnbp * 12).toString();
      rprtSepAnbp = (anualReport.rprtSepAnbp * 12).toString();
      rprtOctAnbp = (anualReport.rprtOctAnbp * 12).toString();
      rprtNovAnbp = (anualReport.rprtNovAnbp * 12).toString();
      rprtDecAnbp = (anualReport.rprtDecAnbp * 12).toString();
    });
  }

  showNumberDialog({BuildContext context, TextEditingController txtControl}) {
    final size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here

            child: Container(
              padding: const EdgeInsets.all(10),
              // height: 400, //280,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Insert Value',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          numberController.clear();
                        });
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: numberController,

                    style:
                        TextStyle(fontSize: 12, color: AppColors.PRIMARY_COLOR),
                    // obscureText: obsecure,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorMaxLines: 2,
                      errorStyle: TextStyle(
                          color: Color.fromARGB(255, 182, 40, 30),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          overflow: TextOverflow.fade),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      labelText: 'Number',
                      labelStyle: AppStyles.labelStyle,
                      floatingLabelStyle: AppStyles.floatingLabelStyle,
                      contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    ),

                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      setState(() {});
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(),
                      ),
                      onPressed: () {
                        setState(() {
                          txtControl.text = numberController.text;
                        });
                        Navigator.pop(context);
                        setState(() {
                          numberController.clear();
                        });
                      },
                      child: const Text('OK'),
                    ),
                  ],
                )
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: Drawer(),
      /* appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        /* leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {}
            // scaffoldKey.currentState.openDrawer(),
            ), */
        actions: [
          IconButton(
              icon: Icon(
                Icons.home_filled,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                 Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                );
              }
              // scaffoldKey.currentState.openDrawer(),
              )
        ],
        centerTitle: true,
        title: Text('Anual Plan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        automaticallyImplyLeading: false,
      ), */
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: isLoading
          ? Container(
              child: Center(
              child: SpinKitCubeGrid(
                color: AppColors.SECONDARY_COLOR,
                size: 50.0,
              ),
            ))
          : ListView(
              children: [
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 32,
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 0.5)),
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _chosenValue,
                          elevation: 5,
                          underline: Container(color: Colors.transparent),
                          style: TextStyle(color: Colors.black),
                          // items: dropdownItems,
                          items: <String>[
                            '2022',
                            '2023',
                            '2024',
                            '2025',
                            '2026',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: Text(
                            "Reason",
                            style: TextStyle(
                                // color: Colors.black,
                                // fontSize: 16,
                                // fontWeight: FontWeight.w600
                                ),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _chosenValue = value;
                              if (_lodedYear != _chosenValue) {
                                setState(() {
                                  isLoading = true;
                                });
                                getAnnualPlan();
                              }
                            });
                          },
                        ),
                      ),
                      if (canPrint)
                        IconButton(
                            iconSize: 32,
                            color: AppColors.SECONDARY_COLOR,
                            icon: const Icon(Icons.print),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AnnualPrint(
                                      plan: savedPlans2,
                                      anualReport: anualReport,
                                      year: _lodedYear,
                                      name: selectedUser["body"]["name"],
                                      company: myCompany,
                                      phone: selectedUser["body"]["contactNo"]),
                                ),
                              );
                              // rootBundle.
                            }),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.SECONDARY_COLOR)),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Business Plan - ' + _lodedYear,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        // margin: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width - 124,
                              child: Table(
                                border: TableBorder.all(
                                    color: AppColors.SECONDARY_COLOR),
                                columnWidths: const <int, TableColumnWidth>{
                                  0: IntrinsicColumnWidth(),
                                  // 1: FlexColumnWidth(25),
                                  //1: FixedColumnWidth(40),
                                  //2: FixedColumnWidth(40),
                                  //3: FixedColumnWidth(40),
                                  //4: FixedColumnWidth(40),
                                  // 5: FixedColumnWidth(40),
                                },
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: <TableRow>[
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 70,
                                            child:
                                                Center(child: Text('Month'))),
                                      ),
                                      TableCell(
                                        child: Center(child: Text('Cust:')),
                                      ),
                                      TableCell(
                                        child: Center(child: Text('App:')),
                                      ),
                                      TableCell(
                                        child: Center(child: Text('S.I:')),
                                      ),
                                      /*  TableCell(
                                        child: Center(child: Text('F.Up')),
                                      ),
                                      TableCell(
                                        child: Center(child: Text('NOP')),
                                      ), */
                                    ],
                                  ),
                                  // January
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Jan'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: janProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: janAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: janSiController,
                                              function: () {},
                                              context: context)),
                                      /* TableCell(
                                          child: reportText(
                                              txtControl: janFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: janNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                  //February
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Feb'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: febProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: febAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: febSiController,
                                              function: () {},
                                              context: context)),
                                      /* TableCell(
                                          child: reportText(
                                              txtControl: febFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: febNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                  //March
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Mar'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: marProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: marAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: marSiController,
                                              function: () {},
                                              context: context)),
                                      /*  TableCell(
                                          child: reportText(
                                              txtControl: marFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: marNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                  //April
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Apr'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: aprlProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: aprlAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: aprlSiController,
                                              function: () {},
                                              context: context)),
                                      /*   TableCell(
                                          child: reportText(
                                              txtControl: aprlFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: aprlNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                  //May
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('May'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: mayProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: mayAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: maySiController,
                                              function: () {},
                                              context: context)),
                                      /*  TableCell(
                                          child: reportText(
                                              txtControl: mayFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: mayNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                  //June
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Jun'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: junProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: junAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: junSiController,
                                              function: () {},
                                              context: context)),
                                      /* TableCell(
                                          child: reportText(
                                              txtControl: junFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: junNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                  //July
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Jul'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: julProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: julAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: julSiController,
                                              function: () {},
                                              context: context)),
                                      /* TableCell(
                                          child: reportText(
                                              txtControl: julFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: julNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                  //August
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Aug'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: augProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: augAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: augSiController,
                                              function: () {},
                                              context: context)),
                                      /* TableCell(
                                          child: reportText(
                                              txtControl: augFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: augNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                  // September
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Sept'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: sepProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: sepAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: sepSiController,
                                              function: () {},
                                              context: context)),
                                      /* TableCell(
                                          child: reportText(
                                              txtControl: sepFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: sepNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                  // October
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Oct:'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: octProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: octAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: octSiController,
                                              function: () {},
                                              context: context)),
                                      /*  TableCell(
                                          child: reportText(
                                              txtControl: octFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: octNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                  // November
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Nov'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: novProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: novAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: novSiController,
                                              function: () {},
                                              context: context)),
                                      /* TableCell(
                                          child: reportText(
                                              txtControl: novFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: novNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                  // December
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Dec'))),
                                      ),
                                      TableCell(
                                          child: reportText(
                                              txtControl: decProsController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: decAppController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: decSiController,
                                              function: () {},
                                              context: context)),
                                      /*  TableCell(
                                          child: reportText(
                                              txtControl: decFuController,
                                              function: () {},
                                              context: context)),
                                      TableCell(
                                          child: reportText(
                                              txtControl: decNopController,
                                              function: () {},
                                              context: context)), */
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 150,
                              child: Column(
                                children: [
                                  Table(
                                      border: TableBorder.all(
                                          color: AppColors.SECONDARY_COLOR),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: <TableRow>[
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Container(
                                                  height: 35,
                                                  child: Center(
                                                      child: Text('ANBP:'))),
                                            ),
                                          ],
                                        ),
                                      ]),
                                  Table(
                                      border: TableBorder.all(
                                          color: AppColors.SECONDARY_COLOR),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: <TableRow>[
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Container(
                                                  height: 35,
                                                  child: Center(
                                                      child: Text('Month'))),
                                            ),
                                            TableCell(
                                              child:
                                                  Center(child: Text('Total')),
                                            ),
                                          ],
                                        ),
                                        //january
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl: janAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text(
                                                        janAnbpController
                                                            .text))),
                                          ],
                                        ),
                                        //Feb
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl: febAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                janAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                febAnbpController
                                                                    .text))
                                                        .toString()))),
                                          ],
                                        ),
                                        //March
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl: marAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                janAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                febAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                marAnbpController
                                                                    .text))
                                                        .toString()))),
                                          ],
                                        ),
                                        // April
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl:
                                                      aprlAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                janAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                febAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                marAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                aprlAnbpController
                                                                    .text))
                                                        .toString()))),
                                          ],
                                        ),
                                        // May
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl: mayAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                janAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                febAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                marAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                aprlAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                mayAnbpController
                                                                    .text))
                                                        .toString()))),
                                          ],
                                        ),
                                        // june
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl: junAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                janAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                febAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                marAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                aprlAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                mayAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                junAnbpController
                                                                    .text))
                                                        .toString()))),
                                          ],
                                        ),
                                        // july
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl: julAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                janAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                febAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                marAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                aprlAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                mayAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                junAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                julAnbpController
                                                                    .text))
                                                        .toString()))),
                                          ],
                                        ),
                                        // aug
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl: augAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                janAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                febAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                marAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                aprlAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                mayAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                junAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                julAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                augAnbpController.text))
                                                        .toString()))),
                                          ],
                                        ),
                                        // sep
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl: sepAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                janAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                febAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                marAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                aprlAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                mayAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                junAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                julAnbpController
                                                                    .text) +
                                                            int.parse(augAnbpController.text) +
                                                            int.parse(sepAnbpController.text))
                                                        .toString()))),
                                          ],
                                        ),
                                        // oct
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl: octAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                janAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                febAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                marAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                aprlAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                mayAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                junAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                julAnbpController
                                                                    .text) +
                                                            int.parse(augAnbpController.text) +
                                                            int.parse(sepAnbpController.text) +
                                                            int.parse(octAnbpController.text))
                                                        .toString()))),
                                          ],
                                        ),
                                        // nov
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl: novAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                janAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                febAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                marAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                aprlAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                mayAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                junAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                julAnbpController
                                                                    .text) +
                                                            int.parse(augAnbpController.text) +
                                                            int.parse(sepAnbpController.text) +
                                                            int.parse(octAnbpController.text) +
                                                            int.parse(novAnbpController.text))
                                                        .toString()))),
                                          ],
                                        ),
                                        // dec
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: reportText(
                                                  txtControl: decAnbpController,
                                                  function: () {},
                                                  context: context),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                janAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                febAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                marAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                aprlAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                mayAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                junAnbpController
                                                                    .text) +
                                                            int.parse(
                                                                julAnbpController
                                                                    .text) +
                                                            int.parse(augAnbpController.text) +
                                                            int.parse(sepAnbpController.text) +
                                                            int.parse(octAnbpController.text) +
                                                            int.parse(novAnbpController.text) +
                                                            int.parse(decAnbpController.text))
                                                        .toString()))),
                                          ],
                                        ),
                                      ]),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.SECONDARY_COLOR)),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Business Review - ' + _lodedYear,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        // margin: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width - 124,
                              child: Table(
                                border: TableBorder.all(
                                    color: AppColors.SECONDARY_COLOR),
                                columnWidths: const <int, TableColumnWidth>{
                                  0: IntrinsicColumnWidth(),
                                  // 1: FlexColumnWidth(25),
                                  //1: FixedColumnWidth(40),
                                  //2: FixedColumnWidth(40),
                                  //3: FixedColumnWidth(40),
                                  // 4: FixedColumnWidth(40),
                                  // 5: FixedColumnWidth(40),
                                },
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: <TableRow>[
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 70,
                                            child:
                                                Center(child: Text('Month'))),
                                      ),
                                      TableCell(
                                        child: Center(child: Text('Pros:')),
                                      ),
                                      TableCell(
                                        child: Center(child: Text('App:')),
                                      ),
                                      TableCell(
                                        child: Center(child: Text('S.I:')),
                                      ),
                                      /*     TableCell(
                                        child: Center(child: Text('F.Up')),
                                      ),
                                      TableCell(
                                        child: Center(child: Text('NOP')),
                                      ), */
                                    ],
                                  ),
                                  // January
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Jan'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJanPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJanApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJanSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*  TableCell(
                                        child: Text(
                                          rprtJanFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJanNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //February
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Feb'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtFebPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtFebApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtFebSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /* TableCell(
                                        child: Text(
                                          rprtFebFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtFebNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //March
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Mar'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtMarPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtMarApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtMarSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*  TableCell(
                                        child: Text(
                                          rprtMarFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtMarNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //April
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Apr'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtAprlPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtAprlApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtAprlSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /* TableCell(
                                        child: Text(
                                          rprtAprlFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtAprlNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //May
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('May'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtMayPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtMayApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtMaySale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*  TableCell(
                                        child: Text(
                                          rprtMayFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtMayNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //June
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Jun'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJunPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJunApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJunSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /* TableCell(
                                        child: Text(
                                          rprtJunFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJunNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //July
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Jul'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJulPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJulApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJulSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*  TableCell(
                                        child: Text(
                                          rprtJulFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtJulNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //August
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Aug'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtAugPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtAugApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtAugSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*  TableCell(
                                        child: Text(
                                          rprtAugFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtAugNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  // September
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Sept'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtSepPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtSepApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtSepSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*  TableCell(
                                        child: Text(
                                          rprtSepFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtSepNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  // October
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Oct:'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtOctPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtOctApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtOctSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /* TableCell(
                                        child: Text(
                                          rprtOctFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtOctNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  // November
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Nov'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtNovPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtNovApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtNovSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*   TableCell(
                                        child: Text(
                                          rprtNovFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtNovNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  // December
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('Dec'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtDecPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtDecApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtDecSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /* TableCell(
                                        child: Text(
                                          rprtDecFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          rprtDecNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 150,
                              child: Column(
                                children: [
                                  Table(
                                      border: TableBorder.all(
                                          color: AppColors.SECONDARY_COLOR),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: <TableRow>[
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Container(
                                                  height: 35,
                                                  child: Center(
                                                      child: Text('ANBP:'))),
                                            ),
                                          ],
                                        ),
                                      ]),
                                  Table(
                                      border: TableBorder.all(
                                          color: AppColors.SECONDARY_COLOR),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: <TableRow>[
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Container(
                                                  height: 35,
                                                  child: Center(
                                                      child: Text('Month'))),
                                            ),
                                            TableCell(
                                              child:
                                                  Center(child: Text('Total')),
                                            ),
                                          ],
                                        ),
                                        //january
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtJanAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text(rprtJanAnbp))),
                                          ],
                                        ),
                                        //Feb
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtFebAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                rprtJanAnbp) +
                                                            int.parse(
                                                                rprtFebAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        //March
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtMarAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                rprtJanAnbp) +
                                                            int.parse(
                                                                rprtFebAnbp) +
                                                            int.parse(
                                                                rprtMarAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // April
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtAprlAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                rprtJanAnbp) +
                                                            int.parse(
                                                                rprtFebAnbp) +
                                                            int.parse(
                                                                rprtMarAnbp) +
                                                            int.parse(
                                                                rprtAprlAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // May
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtMayAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                rprtJanAnbp) +
                                                            int.parse(
                                                                rprtFebAnbp) +
                                                            int.parse(
                                                                rprtMarAnbp) +
                                                            int.parse(
                                                                rprtAprlAnbp) +
                                                            int.parse(
                                                                rprtMayAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // june
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtJunAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                rprtJanAnbp) +
                                                            int.parse(
                                                                rprtFebAnbp) +
                                                            int.parse(
                                                                rprtMarAnbp) +
                                                            int.parse(
                                                                rprtAprlAnbp) +
                                                            int.parse(
                                                                rprtMayAnbp) +
                                                            int.parse(
                                                                rprtJunAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // july
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtJulAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                rprtJanAnbp) +
                                                            int.parse(
                                                                rprtFebAnbp) +
                                                            int.parse(
                                                                rprtMarAnbp) +
                                                            int.parse(
                                                                rprtAprlAnbp) +
                                                            int.parse(
                                                                rprtMayAnbp) +
                                                            int.parse(
                                                                rprtJunAnbp) +
                                                            int.parse(
                                                                rprtJulAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // aug
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtAugAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                rprtJanAnbp) +
                                                            int.parse(
                                                                rprtFebAnbp) +
                                                            int.parse(
                                                                rprtMarAnbp) +
                                                            int.parse(
                                                                rprtAprlAnbp) +
                                                            int.parse(
                                                                rprtMayAnbp) +
                                                            int.parse(
                                                                rprtJunAnbp) +
                                                            int.parse(
                                                                rprtJulAnbp) +
                                                            int.parse(
                                                                rprtAugAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // sep
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtSepAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                rprtJanAnbp) +
                                                            int.parse(
                                                                rprtFebAnbp) +
                                                            int.parse(
                                                                rprtMarAnbp) +
                                                            int.parse(
                                                                rprtAprlAnbp) +
                                                            int.parse(
                                                                rprtMayAnbp) +
                                                            int.parse(
                                                                rprtJunAnbp) +
                                                            int.parse(
                                                                rprtJulAnbp) +
                                                            int.parse(
                                                                rprtAugAnbp) +
                                                            int.parse(
                                                                rprtSepAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // oct
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtOctAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                rprtJanAnbp) +
                                                            int.parse(
                                                                rprtFebAnbp) +
                                                            int.parse(
                                                                rprtMarAnbp) +
                                                            int.parse(
                                                                rprtAprlAnbp) +
                                                            int.parse(
                                                                rprtMayAnbp) +
                                                            int.parse(
                                                                rprtJunAnbp) +
                                                            int.parse(
                                                                rprtJulAnbp) +
                                                            int.parse(
                                                                rprtAugAnbp) +
                                                            int.parse(
                                                                rprtSepAnbp) +
                                                            int.parse(
                                                                rprtOctAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // nov
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtNovAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                rprtJanAnbp) +
                                                            int.parse(
                                                                rprtFebAnbp) +
                                                            int.parse(
                                                                rprtMarAnbp) +
                                                            int.parse(
                                                                rprtAprlAnbp) +
                                                            int.parse(
                                                                rprtMayAnbp) +
                                                            int.parse(
                                                                rprtJunAnbp) +
                                                            int.parse(
                                                                rprtJulAnbp) +
                                                            int.parse(
                                                                rprtAugAnbp) +
                                                            int.parse(
                                                                rprtSepAnbp) +
                                                            int.parse(
                                                                rprtOctAnbp) +
                                                            int.parse(
                                                                rprtNovAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // dec
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  rprtDecAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                rprtJanAnbp) +
                                                            int.parse(
                                                                rprtFebAnbp) +
                                                            int.parse(
                                                                rprtMarAnbp) +
                                                            int.parse(
                                                                rprtAprlAnbp) +
                                                            int.parse(
                                                                rprtMayAnbp) +
                                                            int.parse(
                                                                rprtJunAnbp) +
                                                            int.parse(
                                                                rprtJulAnbp) +
                                                            int.parse(
                                                                rprtAugAnbp) +
                                                            int.parse(
                                                                rprtSepAnbp) +
                                                            int.parse(
                                                                rprtOctAnbp) +
                                                            int.parse(
                                                                rprtNovAnbp) +
                                                            int.parse(
                                                                rprtDecAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                      ]),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
    );
  }
}
