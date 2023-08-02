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
import 'package:pros_bot/models/report/month_report.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/reports/monthly_print.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class WeeklyReports extends StatefulWidget {
  const WeeklyReports({Key key}) : super(key: key);

  // final String title;

  @override
  State<WeeklyReports> createState() => _WeeklyReportsState();
}

class _WeeklyReportsState extends State<WeeklyReports> {
  int selectedVal;

  List<String> monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final today = DateTime.now();

  bool canPrint = false;

  String _chosenValue = '2022';
  String _chosenMonth = '10';
  String _lodedYear = '2022';
  String _loadMonth = '10';

  String myCompany = '';

  TextEditingController numberController = TextEditingController();

  List<Plan> plans = [];

  BodyOfMonthReport monthReport;

  String firstPros = '0';
  String secondPros = '0';
  String thirdPros = '0';
  String forthPros = '0';
  String fifthPros = '0';
  String firstApp = '0';
  String secondApp = '0';
  String thirdApp = '0';
  String forthApp = '0';
  String fifthApp = '0';
  String firstSale = '0';
  String secondSale = '0';
  String thirdSale = '0';
  String forthSale = '0';
  String fifthSale = '0';
  String firstFup = '0';
  String secondFup = '0';
  String thirdFup = '0';
  String forthFup = '0';
  String fifthFup = '0';
  String firstNop = '0';
  String secondNop = '0';
  String thirdNop = '0';
  String forthNop = '0';
  String fifthNop = '0';
  String firstAnbp = '0';
  String secondAnbp = '0';
  String thirdAnbp = '0';
  String forthAnbp = '0';
  String fifthAnbp = '0';

  String monthPros = '0';
  String monthApp = '0';
  String monthSale = '0';
  String monthFup = '0';
  String monthNop = '0';
  String monthAnbp = '0';

  List<BodyOfGetAnnualPlans> savedPlans = [];
  bool isLoading = true;
  bool isSubmitting = false;

  var selectedUser;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text('January'), value: '1'),
      DropdownMenuItem(child: Text('February'), value: '2'),
      DropdownMenuItem(child: Text('March'), value: '3'),
      DropdownMenuItem(child: Text('April'), value: '4'),
      DropdownMenuItem(child: Text('May'), value: '5'),
      DropdownMenuItem(child: Text('June'), value: '6'),
      DropdownMenuItem(child: Text('July'), value: '7'),
      DropdownMenuItem(child: Text('August'), value: '8'),
      DropdownMenuItem(child: Text('September'), value: '9'),
      DropdownMenuItem(child: Text('October'), value: '10'),
      DropdownMenuItem(child: Text('November'), value: '11'),
      DropdownMenuItem(child: Text('December'), value: '12'),
    ];
    return menuItems;
  }

  TextEditingController janProsController = TextEditingController();
  TextEditingController janAppController = TextEditingController();
  TextEditingController janSiController = TextEditingController();
  TextEditingController janAnbpController = TextEditingController();

  TextEditingController febProsController = TextEditingController();
  TextEditingController febAppController = TextEditingController();
  TextEditingController febSiController = TextEditingController();
  TextEditingController febAnbpController = TextEditingController();

  TextEditingController marProsController = TextEditingController();
  TextEditingController marAppController = TextEditingController();
  TextEditingController marSiController = TextEditingController();
  TextEditingController marAnbpController = TextEditingController();

  TextEditingController aprlProsController = TextEditingController();
  TextEditingController aprlAppController = TextEditingController();
  TextEditingController aprlSiController = TextEditingController();
  TextEditingController aprlAnbpController = TextEditingController();

  TextEditingController mayProsController = TextEditingController();
  TextEditingController mayAppController = TextEditingController();
  TextEditingController maySiController = TextEditingController();
  TextEditingController mayAnbpController = TextEditingController();

  TextEditingController junProsController = TextEditingController();
  TextEditingController junAppController = TextEditingController();
  TextEditingController junSiController = TextEditingController();
  TextEditingController junAnbpController = TextEditingController();

  @override
  void initState() {
    _chosenValue = today.year.toString();
    _chosenMonth = today.month.toString();
    _lodedYear = today.year.toString();
    _loadMonth = today.month.toString();
    super.initState();
    getuser();
  }

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    getAnnualPlan();
    // setTextFieldsNull();
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
          .getMonthReport(
              userId: selectedUser["body"]["id"],
              year: _chosenValue,
              month: _chosenMonth)
          .then((value) {
        if (value.done) {
          monthReport = value.body;
          setValues();
          setState(() {
            _lodedYear = _chosenValue;
            _loadMonth = _chosenMonth;
            isLoading = false;
            canPrint = true;
          });
          print(savedPlans);
        } else {}
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  setValues() {
    setState(() {
      firstPros = monthReport.firstPros.toString();
      secondPros = monthReport.secondPros.toString();
      thirdPros = monthReport.thirdPros.toString();
      forthPros = monthReport.forthPros.toString();
      fifthPros = monthReport.fifthPros.toString();
      firstApp = monthReport.firstApp.toString();
      secondApp = monthReport.secondApp.toString();
      thirdApp = monthReport.thirdApp.toString();
      forthApp = monthReport.forthApp.toString();
      fifthApp = monthReport.fifthApp.toString();
      firstSale = monthReport.firstSale.toString();
      secondSale = monthReport.secondSale.toString();
      thirdSale = monthReport.thirdSale.toString();
      forthSale = monthReport.forthSale.toString();
      fifthSale = monthReport.fifthSale.toString();
      
      firstAnbp = (monthReport.firstAnbp * 12).toString();
      secondAnbp = (monthReport.secondAnbp * 12).toString();
      thirdAnbp = (monthReport.thirdAnbp * 12).toString();
      forthAnbp = (monthReport.forthAnbp * 12).toString();
      fifthAnbp = (monthReport.fifthAnbp * 12).toString();
      monthPros = monthReport.monthPros.toString();
      monthApp = monthReport.monthApp.toString();
      monthSale = monthReport.monthSale.toString();
      monthAnbp = monthReport.monthAnbp.toString();
    });
  }

  setTextFieldsNull() {
    setState(() {
      janProsController.text = '0';
      janAppController.text = '0';
      janSiController.text = '0';
      janAnbpController.text = '0';
      febProsController.text = '0';
      febAppController.text = '0';
      febSiController.text = '0';
      febAnbpController.text = '0';
      marProsController.text = '0';
      marAppController.text = '0';
      marSiController.text = '0';
      marAnbpController.text = '0';
      aprlProsController.text = '0';
      aprlAppController.text = '0';
      aprlSiController.text = '0';
      aprlAnbpController.text = '0';
      mayProsController.text = '0';
      mayAppController.text = '0';
      maySiController.text = '0';
      mayAnbpController.text = '0';
      junProsController.text = '0';
      junAppController.text = '0';
      junSiController.text = '0';
      junAnbpController.text = '0';
    });
  }

/*   showNumberDialog({BuildContext context, TextEditingController txtControl}) {
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
                                floatingLabelBehavior:FloatingLabelBehavior.never,
                                floatingLabelBehavior:FloatingLabelBehavior.never,
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
 */
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                          "Month",
                          style: TextStyle(
                              // color: Colors.black,
                              // fontSize: 16,
                              // fontWeight: FontWeight.w600
                              ),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _chosenValue = value;
                          });
                          if (_lodedYear != _chosenValue) {
                            setState(() {
                              isLoading = true;
                            });
                            getAnnualPlan();
                          }
                        },
                      ),
                    ),
                    Container(
                      width: 135,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 0.5)),
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _chosenMonth,
                        elevation: 5,
                        underline: Container(color: Colors.transparent),
                        style: TextStyle(color: Colors.black),
                        // items: dropdownItems,
                        items: dropdownItems,

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
                            _chosenMonth = value;
                          });
                          if (_loadMonth != _chosenMonth) {
                            setState(() {
                              isLoading = true;
                            });
                            getAnnualPlan();
                          }
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
                                builder: (context) => MonthlyPrint(
                                    monthReport: monthReport,
                                    year: _lodedYear,
                                    month: _loadMonth,
                                    name: selectedUser["body"]["name"],
                                    company: myCompany,
                                    phone: selectedUser["body"]["contactNo"]),
                              ),
                            );
                            // rootBundle.
                          }),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.SECONDARY_COLOR)),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Business Plan - ' +
                            _lodedYear +
                            ' ' +
                            monthList[(int.parse(_loadMonth) - 1)],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
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
                                  // 1: FixedColumnWidth(40),
                                  // 2: FixedColumnWidth(40),
                                  // 3: FixedColumnWidth(40),
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
                                            child: Center(child: Text('Week'))),
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
                                      /*  TableCell(
                                        child: Center(child: Text('F.Up')),
                                      ),
                                      TableCell(
                                        child: Center(child: Text('NOP')),
                                      ), */
                                    ],
                                  ),
                                  // First
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('1st'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthPros) * 2 / 9)
                                              .ceil()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthApp) * 2 / 9)
                                              .ceil()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthSale) * 2 / 9)
                                              .ceil()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /* TableCell(
                                        child: Text(
                                          (int.parse(monthFup) * 2 / 9)
                                              .ceil()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthNop) * 2 / 9)
                                              .ceil()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  // second
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('2nd'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthPros) * 2 / 9)
                                              .ceil()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthApp) * 2 / 9)
                                              .ceil()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthSale) * 2 / 9)
                                              .ceil()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*  TableCell(
                                        child: Text(
                                          (int.parse(monthFup) * 2 / 9)
                                              .ceil()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthNop) * 2 / 9)
                                              .ceil()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //third
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('3rd'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthPros) * 2 / 9)
                                              .floor()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthApp) * 2 / 9)
                                              .floor()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthSale) * 2 / 9)
                                              .floor()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*  TableCell(
                                        child: Text(
                                          (int.parse(monthFup) * 2 / 9)
                                              .floor()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthNop) * 2 / 9)
                                              .floor()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //4th
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('4th'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthPros) * 2 / 9)
                                              .floor()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthApp) * 2 / 9)
                                              .floor()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthSale) * 2 / 9)
                                              .floor()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*  TableCell(
                                        child: Text(
                                          (int.parse(monthFup) * 2 / 9)
                                              .floor()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthNop) * 2 / 9)
                                              .floor()
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //5th
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('5th'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(monthPros) -
                                                  (((int.parse(monthPros) *
                                                                  2 /
                                                                  9)
                                                              .ceil() *
                                                          2) +
                                                      ((int.parse(monthPros) *
                                                                  2 /
                                                                  9)
                                                              .floor() *
                                                          2)))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          /* (int.parse(monthApp) -
                                                  int.parse(monthApp) *
                                                      4 *
                                                      2 /
                                                      9)
                                              .floor()
                                              .toString(), */
                                          (int.parse(monthApp) -
                                                  (((int.parse(monthApp) *
                                                                  2 /
                                                                  9)
                                                              .ceil() *
                                                          2) +
                                                      ((int.parse(monthApp) *
                                                                  2 /
                                                                  9)
                                                              .floor() *
                                                          2)))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          /* (int.parse(monthSale) -
                                                  int.parse(monthSale) *
                                                      4 *
                                                      2 /
                                                      9)
                                              .floor()
                                              .toString(), */
                                          (int.parse(monthSale) -
                                                  (((int.parse(monthSale) *
                                                                  2 /
                                                                  9)
                                                              .ceil() *
                                                          2) +
                                                      ((int.parse(monthSale) *
                                                                  2 /
                                                                  9)
                                                              .floor() *
                                                          2)))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*  TableCell(
                                        child: Text(
                                          /* (int.parse(monthFup) -
                                                  int.parse(monthFup) *
                                                      4 *
                                                      2 /
                                                      9)
                                              .floor()
                                              .toString(), */
                                          (int.parse(monthFup) -
                                                  (((int.parse(monthFup) *
                                                                  2 /
                                                                  9)
                                                              .ceil() *
                                                          2) +
                                                      ((int.parse(monthFup) *
                                                                  2 /
                                                                  9)
                                                              .floor() *
                                                          2)))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          /*  (int.parse(monthNop) -
                                                  int.parse(monthNop) *
                                                      4 *
                                                      2 /
                                                      9)
                                              .floor()
                                              .toString(), */
                                          (int.parse(monthNop) -
                                                  (((int.parse(monthNop) *
                                                                  2 /
                                                                  9)
                                                              .ceil() *
                                                          2) +
                                                      ((int.parse(monthNop) *
                                                                  2 /
                                                                  9)
                                                              .floor() *
                                                          2)))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  // total
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child:
                                                Center(child: Text('Total'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          monthPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          monthApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          monthSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /* TableCell(
                                        child: Text(
                                          monthFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          monthNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 180,
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
                                                      child: Text('ANBP'))),
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
                                                  (int.parse(monthAnbp) * 2 / 9)
                                                      .floor()
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text(
                                              (int.parse(monthAnbp) * 2 / 9)
                                                  .floor()
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ))),
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
                                                  (int.parse(monthAnbp) * 2 / 9)
                                                      .floor()
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text(
                                              (int.parse(monthAnbp) * 2 * 2 / 9)
                                                  .floor()
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ))),
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
                                                  (int.parse(monthAnbp) * 2 / 9)
                                                      .floor()
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text(
                                              (int.parse(monthAnbp) * 3 * 2 / 9)
                                                  .floor()
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ))),
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
                                                  (int.parse(monthAnbp) * 2 / 9)
                                                      .floor()
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text(
                                              (int.parse(monthAnbp) * 2 * 4 / 9)
                                                  .floor()
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ))),
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
                                                  (int.parse(monthAnbp) -
                                                          int.parse(monthAnbp) *
                                                              4 *
                                                              2 /
                                                              9)
                                                      .floor()
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text(
                                              monthAnbp,
                                              textAlign: TextAlign.center,
                                            ))),
                                          ],
                                        ),
                                        // Total
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  monthAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                              child: Center(
                                                child: Text(
                                                  monthAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
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
                        'Business Review - ' +
                            _lodedYear +
                            ' ' +
                            monthList[(int.parse(_loadMonth) - 1)],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
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
                                  // 1: FixedColumnWidth(40),
                                  // 2: FixedColumnWidth(40),
                                  // 3: FixedColumnWidth(40),
                                  // 4: FixedColumnWidth(40),
                                  //5: FixedColumnWidth(40),
                                },
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: <TableRow>[
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 70,
                                            child: Center(child: Text('Week'))),
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
                                      /*  TableCell(
                                        child: Center(child: Text('F.Up')),
                                      ),
                                      TableCell(
                                        child: Center(child: Text('NOP')),
                                      ), */
                                    ],
                                  ),
                                  // First
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('1st'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          firstPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          firstApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          firstSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*    TableCell(
                                        child: Text(
                                          firstFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          firstNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  // second
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('2nd'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          secondPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          secondApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          secondSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /* TableCell(
                                        child: Text(
                                          secondFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          secondNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //third
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('3rd'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          thirdPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          thirdApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          thirdSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /* TableCell(
                                        child: Text(
                                          thirdFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          thirdNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //4th
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('4th'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          forthPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          forthApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          forthSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /* TableCell(
                                        child: Text(
                                          forthFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          forthNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  //5th
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child: Center(child: Text('5th'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          fifthPros,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          fifthApp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          fifthSale,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /*  TableCell(
                                        child: Text(
                                          fifthFup,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          fifthNop,
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                  // total
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                            height: 50,
                                            child:
                                                Center(child: Text('Total'))),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(firstPros) +
                                                  int.parse(secondPros) +
                                                  int.parse(thirdPros) +
                                                  int.parse(forthPros) +
                                                  int.parse(fifthPros))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(firstApp) +
                                                  int.parse(secondApp) +
                                                  int.parse(thirdApp) +
                                                  int.parse(forthApp) +
                                                  int.parse(fifthApp))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(firstSale) +
                                                  int.parse(secondSale) +
                                                  int.parse(thirdSale) +
                                                  int.parse(forthSale) +
                                                  int.parse(fifthSale))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      /* TableCell(
                                        child: Text(
                                          (int.parse(firstFup) +
                                                  int.parse(secondFup) +
                                                  int.parse(thirdFup) +
                                                  int.parse(forthFup) +
                                                  int.parse(fifthFup))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          (int.parse(firstNop) +
                                                  int.parse(secondNop) +
                                                  int.parse(thirdNop) +
                                                  int.parse(forthNop) +
                                                  int.parse(fifthNop))
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ), */
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 180,
                              child: Column(
                                children: [
                                  Table(
                                      border: TableBorder.all(
                                          color: AppColors.SECONDARY_COLOR),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const <int,
                                          TableColumnWidth>{
                                        // 0: FixedColumnWidth(40),
                                        // 1: FixedColumnWidth(40),
                                      },
                                      children: <TableRow>[
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Container(
                                                  height: 35,
                                                  child: Center(
                                                      child: Text('ANBP'))),
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
                                                      child: Text('Weekly'))),
                                            ),
                                            TableCell(
                                              child:
                                                  Center(child: Text('Total')),
                                            ),
                                          ],
                                        ),
                                        //1st wk
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  firstAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text(firstAnbp))),
                                          ],
                                        ),
                                        //2nd
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  secondAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text(
                                                        (int.parse(firstAnbp) +
                                                                int.parse(
                                                                    secondAnbp))
                                                            .toString()))),
                                          ],
                                        ),
                                        //3rd
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  thirdAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                firstAnbp) +
                                                            int.parse(
                                                                secondAnbp) +
                                                            int.parse(
                                                                thirdAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // 4th
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  forthAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                firstAnbp) +
                                                            int.parse(
                                                                secondAnbp) +
                                                            int.parse(
                                                                thirdAnbp) +
                                                            int.parse(
                                                                forthAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // 5th
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  fifthAnbp,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                firstAnbp) +
                                                            int.parse(
                                                                secondAnbp) +
                                                            int.parse(
                                                                thirdAnbp) +
                                                            int.parse(
                                                                forthAnbp) +
                                                            int.parse(
                                                                fifthAnbp))
                                                        .toString()))),
                                          ],
                                        ),
                                        // total
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  ((int.parse(firstAnbp) +
                                                          int.parse(
                                                              secondAnbp) +
                                                          int.parse(thirdAnbp) +
                                                          int.parse(forthAnbp) +
                                                          int.parse(fifthAnbp))
                                                      .toString()),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )),
                                            TableCell(
                                                child: Center(
                                                    child: Text((int.parse(
                                                                firstAnbp) +
                                                            int.parse(
                                                                secondAnbp) +
                                                            int.parse(
                                                                thirdAnbp) +
                                                            int.parse(
                                                                forthAnbp) +
                                                            int.parse(
                                                                fifthAnbp))
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
