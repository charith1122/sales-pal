import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pros_bot/components/common/label.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/models/follow_up/coverage.dart';
import 'package:pros_bot/models/pros_child.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/models/today/dob_list.dart';
import 'package:pros_bot/models/today/premium.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/nop/nop.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class Premium extends StatefulWidget {
  const Premium({Key key}) : super(key: key);

  // final String title;

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  var selectedUser;
  List<BodyOfPremiumList> prospects = [];
  DateTime selectedDate = DateTime.now();
  bool isLoading = true;
  TextEditingController dateController = TextEditingController();
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  bool isSearchResult = false;
  TextEditingController searchController = TextEditingController();

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    setState(() {
      dateController.text = dateFormat.format(selectedDate);
    });
    print(selectedUser);
    getProspects();
  }

  @override
  void initState() {
    super.initState();
    getuser();
  }

  getProspects() async {
    try {
      await APIs()
          .getPremiumList(
              userId: selectedUser["body"]["id"], date: dateController.text)
          .then((value) {
        prospects.clear();
        /* value.body.forEach((item) {
          prospects.add(item);
        }); */
        prospects = value.body;
        print(prospects);
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
      EasyLoading.dismiss();
      isSearchResult = true;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: selectedDate,
      firstDate: DateTime(-100),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.PRIMARY_COLOR, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: AppColors.PRIMARY_COLOR, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.PRIMARY_COLOR, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      DateTime dt = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );
      DateFormat formatter = DateFormat('yyyy-MM-dd EEEE hh:mm a');
      DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

      String formatted = formatter.format(dt);

      String dateFormatted = dateFormatter.format(dt);

      dateController.text = dateFormatted;

      var duration = Duration(seconds: 1);
      return Timer(duration, () {
        // print(dateController.text);
        getProspects();
        // _chosenValue = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        // drawer: Drawer(),
        appBar: AppBar(
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
                  _selectDate(context);
                  /*  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
                  ); */
                }
                // scaffoldKey.currentState.openDrawer(),
                )
          ],
          centerTitle: true,
          title: Text('Premium list',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
        body: isLoading
            ? Container(
                color: AppColors.PRIMARY_COLOR,
                child: Center(
                  child: SpinKitCubeGrid(
                    color: AppColors.SECONDARY_COLOR,
                    size: 50.0,
                    // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                  ),
                ))
            : Container(
                child: Stack(children: [
                  prospects.isNotEmpty
                      ? Container(
                          color: AppColors.PRIMARY_COLOR,
                          padding: EdgeInsets.only(
                              top: 6, left: 0, right: 0, bottom: 2),
                          child: Container(
                            margin: const EdgeInsets.only(top: 68),
                            child: ListView(
                              children: [
                                for (int i = 0; i < prospects.length; i++)
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 15),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.SECONDARY_COLOR,
                                            width: 2)),
                                    child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 55,
                                            child: Text(
                                              prospects[i].prosNum.toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                              width: size.width - 110,
                                              child: Column(
                                                children: [
                                                  Text(prospects[i].prosName),
                                                  Text(dateFormat.format(
                                                      DateTime.parse(
                                                          prospects[i]
                                                              .commenceDate))),
                                                ],
                                              )),
                                          /*  Spacer(),
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          NOP(
                                                    name: prospects[i].name,
                                                    prosId: prospects[i].id,
                                                  ),
                                                ));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .SECONDARY_COLOR,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  'NOP',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .PRIMARY_COLOR),
                                                ),
                                              )) */
                                        ]),
                                  ),
                              ],
                            ),
                          ))
                      : Center(
                          child: Text('No prospects with plan'),
                        ),
                  Positioned(
                    child: Container(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          labelText(label: 'Selected Date'),
                          Container(
                            width: 150,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                // color: AppColors.SECONDARY_COLOR,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.SECONDARY_COLOR)),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: dateController,
                              onTap: () {
                                _selectDate(context);
                              },
                              readOnly: true,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              // obscureText: obsecure,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                errorMaxLines: 2,
                                filled: true,
                                fillColor: AppColors.PRIMARY_COLOR,
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 182, 40, 30),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    overflow: TextOverflow.fade),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                /* prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: AppColors.SECONDARY_COLOR,
                                ), */
                                // labelText: 'Commencment Date',
                                labelStyle: AppStyles.labelStyle,
                                floatingLabelStyle:
                                    AppStyles.floatingLabelStyle,
                                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                              ),
                              onEditingComplete: () {
                                // FocusScope.of(context).nextFocus();
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  // passwordvalidate = true;
                                });
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ));
  }
}
