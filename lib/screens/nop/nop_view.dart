import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/models/appointments/get_appointment_by_id.dart';
import 'package:pros_bot/models/follow_up/coverage.dart';
import 'package:pros_bot/models/nop/covers_by_id.dart';
import 'package:pros_bot/models/nop/get_plan_by_id.dart';
import 'package:pros_bot/screens/follow_up/follow_up.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/nop/nop_list.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class NOPView extends StatefulWidget {
  final String id;
  final String name;
  final String prosId;
  const NOPView({
    Key key,
    this.id,
    this.name,
    this.prosId,
  }) : super(key: key);

  // final String title;

  @override
  State<NOPView> createState() => _NOPState();
}

class _NOPState extends State<NOPView> {
  List<Coverage> cover = [];
  List<BodyOfGetPlanCoversById> prosCover = [];
  List<BodyOfGetPlanCoversById> spouseCover = [];
  List<BodyOfGetPlanCoversById> childCover = [];

  DateTime selectedDate = DateTime.now();
  var selectedUser;

  bool isSubmitting = false;

  bool isLoading = true;
  GetPlanById nopDetails;

  TextEditingController nameController = TextEditingController();
  TextEditingController policyNoController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController premiumController = TextEditingController();

  TextEditingController tagController = TextEditingController();
  TextEditingController coverforController = TextEditingController();

  DateFormat dtFormatter = DateFormat('yyyy-MM-dd');

  List<String> payType = ['Monthly', 'Quaterly', 'Half Yearly', 'Annually'];

  String _chosenValue;
  String selectedPayType = 'Monthly';

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    if (widget.id != null) {
      getAppointmentById();
      getCoverages();
    }
  }

  @override
  void initState() {
    super.initState();
    getuser();
    /* setState(() {
      nameController.text = widget.name;
    }); */
  }

  getAppointmentById() async {
    try {
      await APIs()
          .getPlanById(userId: selectedUser["body"]["id"], id: widget.id)
          .then((value) async {
        if (value.done != null) {
          nopDetails = new GetPlanById.fromJson(value.toJson());
          if (nopDetails.done == true) {
            setState(() {
              isLoading = false;
              nameController.text = nopDetails.body.prosName;
              policyNoController.text = nopDetails.body.policyNo;
              dateController.text = dtFormatter
                  .format(DateTime.parse(nopDetails.body.commenceDate));
              selectedPayType = nopDetails.body.payType;
              premiumController.text = nopDetails.body.premium.toString();
            });
          } else {
            await EasyLoading.dismiss();
            errorMessage(message: value.message);
            setState(() {
              isLoading = false;
            });
            Navigator.of(context, rootNavigator: true).pop();
          }
        } else {
          await EasyLoading.dismiss();
          errorMessage(message: value.message);
          setState(() {
            isLoading = false;
          });
          Navigator.of(context, rootNavigator: true).pop();
        }
        // print(appointments);
      });
    } catch (e) {}
  }

  createCover({BuildContext context}) {
    final size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here

            child: Container(
              // height: 400, //280,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Add Cover',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            tagController.clear();
                            coverforController.clear();
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
                      controller: tagController,

                      style: TextStyle(
                          fontSize: 12, color: AppColors.PRIMARY_COLOR),
                      // obscureText: obsecure,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorMaxLines: 2,
                        filled: true,
                        fillColor: AppColors.SECONDARY_COLOR,
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 182, 40, 30),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            overflow: TextOverflow.fade),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        // prefixIcon: Icon(
                        //   Icons.person,
                        //   color: AppColors.PRIMARY_COLOR,
                        // ),
                        labelText: ' Tag ',
                        labelStyle: AppStyles.labelStyle,
                        floatingLabelStyle: AppStyles.floatingLabelStyle,
                        contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      ),

                      onEditingComplete: () {
                        // FocusScope.of(context).nextFocus();
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: size.width,
                    decoration: BoxDecoration(
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
                        'Prospect',
                        'Spouse',
                        'Child',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        "Cover For",
                        style: TextStyle(
                            // color: Colors.black,
                            // fontSize: 16,
                            // fontWeight: FontWeight.w600
                            ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValue = value;
                          print('_chosenValue' + _chosenValue);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                            color: AppColors.SECONDARY_COLOR, width: 2)),
                    child: FlatButton(
                      height: 40,
                      minWidth: 200,
                      onPressed: () {
                        if (tagController.text == '' ||
                            _chosenValue == null ||
                            tagController.text == null) {
                          errorMessage(message: 'Insert Tag and Cover For');
                        } else {
                          cover.add(Coverage(
                              tag: tagController.text,
                              cover_for: _chosenValue));
                          setState(() {
                            tagController.clear();
                            _chosenValue = null;
                          });
                          print(cover);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          );
        });
  }

  updateNOP() async {
    // print('picked img ' + base64Image.toString());
    // if (descriptionController.text != '' || base64Image.toString() != null) {
    if (policyNoController.text == '' ||
        policyNoController.text == null ||
        dateController.text == '' ||
        dateController.text == null ||
        premiumController.text == '' ||
        premiumController.text == null) {
      errorMessage(
          message:
              'Policy No:, Commencement date and Premium fields are Required!');
    } else {
      setState(() {
        isSubmitting = true;
      });
      var result = await APIs().updateNOP(
          id: widget.id,
          user_id: selectedUser["body"]["id"],
          pros_id: widget.prosId,
          policy_no: policyNoController.text,
          commence_date: dateController.text,
          premium: premiumController.text,
          payType: selectedPayType,
          covers: cover);
      // print(result);
      if (result.done != null) {
        if (result.done) {
          setState(() {
            isSubmitting = false;
          });
          // widget.getProspects;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => NOPList(),
          ));
          /* setState(() {
          verifiedUser = true;
          navigate();
        }); */
        } else {
          errorMessage(
              message: result.message != '' || result.message != null
                  ? result.message
                  : 'Please Try again Later');
          setState(() {
            isSubmitting = false;
          });
          // Navigator.of(context, rootNavigator: true).pop();

        }
      } else {
        errorMessage(
            message: result.message != '' || result.message != null
                ? result.message
                : 'Please Try again Later');
        setState(() {
          isSubmitting = false;
        });
        // Navigator.of(context, rootNavigator: true).pop();

      }
      /* } else {
      messageToastRed('Description or Media URL is required');
    } */
    }
  }

  getCoverages() async {
    try {
      await APIs().getPlanCoverById(id: widget.id).then((value) {
        value.body.forEach((item) {
          // cover.add(item);
          cover.add(Coverage(tag: item.tag, cover_for: item.coveredPerson));
          /*  if (item.coveredPerson == 'Prospect') {
            prosCover.add(item);
          } else if (item.coveredPerson == 'Spouse') {
            spouseCover.add(item);
          } else if (item.coveredPerson == 'Child') {
            childCover.add(item);
          } */
        });
        print(cover);
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: selectedDate,
      firstDate: DateTime(-100),
      lastDate: DateTime.now(),
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

      var duration = Duration(seconds: 2);
      return Timer(duration, () {
        _chosenValue = null;
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
        title: Text(widget.name + ' - Policy',
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
              color: AppColors.PRIMARY_COLOR,
              padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 2),
              child: ListView(
                children: [
                  /* Row(
                    children: [
                      FlatButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            createCover(context: context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Spacer(),
                      FlatButton(
                          onPressed: () {
                            /* Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => NOP(
                                // type: 'EDIT',
                                ),
                          )); */
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              '0001',
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                    ],
                  ), */
                  TextFormField(
                    // initialValue: 'K.M.A.Shiran Kularathna',
                    controller: nameController,
                    readOnly: true,
                    style:
                        TextStyle(fontSize: 12, color: AppColors.PRIMARY_COLOR),
                    // obscureText: obsecure,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorMaxLines: 2,
                      filled: true,
                      fillColor: AppColors.SECONDARY_COLOR,
                      errorStyle: TextStyle(
                          color: Color.fromARGB(255, 182, 40, 30),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          overflow: TextOverflow.fade),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                      labelText: ' Name ',
                      labelStyle: AppStyles.labelStyle,
                      floatingLabelStyle: AppStyles.floatingLabelStyle,
                      contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    ),
                    // controller: newPasswordController,
                    // textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      // FocusScope.of(context).nextFocus();
                      FocusScope.of(context).unfocus();
                      setState(() {
                        // passwordvalidate = true;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    // readOnly: true,
                    controller: policyNoController,
                    // initialValue: 'AP 2022-4466',
                    style:
                        TextStyle(fontSize: 12, color: AppColors.PRIMARY_COLOR),
                    // obscureText: obsecure,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorMaxLines: 2,
                      filled: true,
                      fillColor: AppColors.SECONDARY_COLOR,
                      errorStyle: TextStyle(
                          color: Color.fromARGB(255, 182, 40, 30),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          overflow: TextOverflow.fade),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                      labelText: ' Policy Number ',
                      labelStyle: AppStyles.labelStyle,
                      floatingLabelStyle: AppStyles.floatingLabelStyle,
                      contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    ),
                    // controller: newPasswordController,
                    // textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      // FocusScope.of(context).nextFocus();
                      FocusScope.of(context).unfocus();
                      setState(() {
                        // passwordvalidate = true;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    // readOnly: true,
                    controller: dateController,
                    /* onTap: () {
                      _selectDate(context, 'PROS');
                    }, */

                    style:
                        TextStyle(fontSize: 12, color: AppColors.PRIMARY_COLOR),
                    // obscureText: obsecure,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorMaxLines: 2,
                      filled: true,
                      fillColor: AppColors.SECONDARY_COLOR,
                      errorStyle: TextStyle(
                          color: Color.fromARGB(255, 182, 40, 30),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          overflow: TextOverflow.fade),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                      labelText: ' Commencment Date ',
                      labelStyle: AppStyles.labelStyle,
                      floatingLabelStyle: AppStyles.floatingLabelStyle,
                      contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    ),
                    onEditingComplete: () {
                      // FocusScope.of(context).nextFocus();
                      FocusScope.of(context).unfocus();
                      setState(() {
                        // passwordvalidate = true;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 0.5),
                        color: AppColors.SECONDARY_COLOR),
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedPayType,
                      elevation: 5,
                      underline: Container(color: Colors.transparent),
                      style: TextStyle(color: AppColors.PRIMARY_COLOR),
                      // items: dropdownItems,
                      items:
                          payType.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        "Payment type",
                        style: TextStyle(
                            // color: Colors.black,
                            // fontSize: 16,
                            // fontWeight: FontWeight.w600
                            ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          selectedPayType = value;
                          // print('selectedPayType' + selectedPayType);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    // readOnly: true,
                    controller: premiumController,
                    // initialValue: 'LKR 16500.00',
                    style:
                        TextStyle(fontSize: 12, color: AppColors.PRIMARY_COLOR),
                    // obscureText: obsecure,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorMaxLines: 2,
                      filled: true,
                      fillColor: AppColors.SECONDARY_COLOR,
                      errorStyle: TextStyle(
                          color: Color.fromARGB(255, 182, 40, 30),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          overflow: TextOverflow.fade),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      prefixIcon: Icon(
                        Icons.money,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                      labelText: ' Premium ',
                      labelStyle: AppStyles.labelStyle,
                      floatingLabelStyle: AppStyles.floatingLabelStyle,
                      contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    ),
                    // controller: newPasswordController,
                    // textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      // FocusScope.of(context).nextFocus();
                      FocusScope.of(context).unfocus();
                      setState(() {
                        // passwordvalidate = true;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 20),
                  cover.isNotEmpty
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // color: Colors.amber,
                              width: (size.width - 30) / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Life Assured',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  for (int i = 0; i < cover.length; i++)
                                    cover[i].cover_for == 'Prospect'
                                        ? Container(
                                            height: 40,
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.all(10),
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                color:
                                                    AppColors.SECONDARY_COLOR,
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              children: [
                                                Text(
                                                  cover[i].tag,
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .PRIMARY_COLOR),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  padding: EdgeInsets.all(0),
                                                  onPressed: () {
                                                    setState(() {
                                                      cover.removeAt(i);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .delete_forever_rounded,
                                                    size: 20,
                                                    color:
                                                        AppColors.PRIMARY_COLOR,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                ],
                              ),
                            ),
                            Container(
                              // color: Colors.amber,
                              width: (size.width - 30) / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Spouse/Child',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  for (int j = 0; j < cover.length; j++)
                                    cover[j].cover_for != 'Prospect'
                                        ? Container(
                                            height: 40,
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.all(10),
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                color:
                                                    AppColors.SECONDARY_COLOR,
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              children: [
                                                Text(
                                                  cover[j].tag,
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .PRIMARY_COLOR),
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  padding: EdgeInsets.all(0),
                                                  onPressed: () {
                                                    setState(() {
                                                      cover.removeAt(j);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .delete_forever_rounded,
                                                    size: 20,
                                                    color:
                                                        AppColors.PRIMARY_COLOR,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  for (int x = 0; x < spouseCover.length; x++)
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(10),
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          color: AppColors.SECONDARY_COLOR,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        spouseCover[x].tag,
                                        style: TextStyle(
                                            color: AppColors.PRIMARY_COLOR),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      createCover(context: context);
                    },
                    child: const Text(
                      'Add Coverage +',
                      style: TextStyle(color: AppColors.SECONDARY_COLOR),
                    ),
                  ),
                  SizedBox(height: 20),
                  isSubmitting
                      ? Container(
                          child: Center(
                          child: SpinKitThreeBounce(
                            color: AppColors.SECONDARY_COLOR,
                            size: 25.0,
                          ),
                        ))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.PRIMARY_COLOR,

                                  /*  gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    AppColors.PRIMARY_COLOR,
                                    AppColors.SECONDARY_COLOR,
                                  ]), */
                                  borderRadius: BorderRadius.circular(25.0),
                                  border: Border.all(
                                      color: AppColors.SECONDARY_COLOR,
                                      width: 2)),
                              child: FlatButton(
                                height: 50,
                                // minWidth: size.width,
                                onPressed: () {
                                  updateNOP();
                                },
                                child: Text(
                                  "Save Changes",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              )),
    );
  }
}
