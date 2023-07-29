import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pros_bot/components/common/label.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/models/home/analyse_data.dart';
import 'package:pros_bot/models/pros_child.dart';
import 'package:pros_bot/models/prospect/occupation_list.dart';
import 'package:pros_bot/models/prospect/prospect_by_id.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/prospecting/prospecting.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class NewProspect extends StatefulWidget {
  final VoidCallback getProspects;
  final String id;
  const NewProspect({Key key, this.getProspects, this.id}) : super(key: key);
  @override
  _NewProspectState createState() => _NewProspectState();
}

class _NewProspectState extends State<NewProspect> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateofBirthController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController incomeController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController spouseNameController = TextEditingController();
  TextEditingController spousephoneController = TextEditingController();
  TextEditingController spouseDobController = TextEditingController();
  TextEditingController annivesaryController = TextEditingController();
  TextEditingController spouseNicController = TextEditingController();
  TextEditingController spouseAddressController = TextEditingController();
  TextEditingController spouseOccupationController = TextEditingController();

  TextEditingController childNameController = TextEditingController();
  TextEditingController childDobController = TextEditingController();

  List<Child> children = [];

  DateTime selectedDate = DateTime.now();

  DateFormat dtFormatter = DateFormat('yyyy-MM-dd');

  String _chosenGender;
  String occupation = "";
  String spouseOccupation = "";

  bool isMarried = false;
  bool haveChildren = false;

  var selectedUser;

  var genderList = ['Mr.', 'Mrs', 'Miss', 'Venerable'];

  bool isSubmitting = false;
  bool isLoading = true;
  GetProspectById prospector;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getuser();
    // getProspectById
  }

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    if (widget.id != null) {
      getProspectById();
      getChildren();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  getChildren() async {
    try {
      await APIs()
          .getChildrenById(
              userId: selectedUser["body"]["id"], prosId: widget.id)
          .then((value) {
        value.body.forEach((item) {
          children.add(Child(name: item.name, dob: item.dateOfBirth));
        });
        if (children.length > 0) {
          setState(() {
            haveChildren = true;
          });
        }
        // print(prospects);
      });
    } catch (e) {}
  }

  getProspectById() async {
    try {
      await APIs()
          .getProspectById(
              userId: selectedUser["body"]["id"], prosId: widget.id)
          .then((value) async {
        if (value.done != null) {
          prospector = new GetProspectById.fromJson(value.toJson());
          if (prospector.done == true) {
            setState(() {
              isLoading = false;
              nameController.text = prospector.body.name;
              dateofBirthController.text = dtFormatter
                  .format(DateTime.parse(prospector.body.dateOfBirth));
              nicController.text = prospector.body.nic;
              addressController.text = prospector.body.address;
              phoneController.text = prospector.body.contact;
              occupation = occupationList.contains(prospector.body.occupation)
                  ? prospector.body.occupation
                  : '';
              occupationController.text = prospector.body.occupation;
              incomeController.text = prospector.body.income;
              whatsappController.text = prospector.body.whatsapp;
              _chosenGender = genderList.contains(prospector.body.gender)
                  ? prospector.body.gender
                  : null;
              emailController.text = prospector.body.email;
              spouseNameController.text = prospector.body.spouseName;
              spousephoneController.text = prospector.body.spousePhone;
              spouseDobController.text =
                  dtFormatter.format(DateTime.parse(prospector.body.spouseDob));
              annivesaryController.text = dtFormatter
                  .format(DateTime.parse(prospector.body.annivesary));
              spouseNicController.text = prospector.body.spouseNic;
              spouseAddressController.text = prospector.body.spouseAddress;
              spouseOccupation =
                  occupationList.contains(prospector.body.spouseOccupation)
                      ? prospector.body.spouseOccupation
                      : '';
              spouseOccupationController.text =
                  prospector.body.spouseOccupation;

              if (prospector.body.isMarried == 1) {
                isMarried = true;
              } else {
                isMarried = false;
              }

              if (children.length > 0) {
                haveChildren = true;
              } else {
                haveChildren = false;
              }
            });
          } else {
            await EasyLoading.dismiss();
            errorMessage(message: value.message);
            setState(() {
              isLoading = false;
            });
          }
        } else {
          await EasyLoading.dismiss();
          errorMessage(message: value.message);
          setState(() {
            isLoading = false;
          });
        }
        // print(appointments);
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  createChild({BuildContext context}) {
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
                          'Add Child',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.PRIMARY_COLOR),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            childNameController.clear();
                            childDobController.clear();
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
                  labelText(label: 'Name'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: childNameController,

                      style: AppStyles.textFieldStyle,

                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: AppColors.SECONDARY_COLOR,
                        errorMaxLines: 2,
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 182, 40, 30),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            overflow: TextOverflow.fade),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        prefixIcon: Icon(
                          Icons.person,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                        labelText: 'Name',
                        labelStyle: AppStyles.labelStyle,
                        floatingLabelStyle: AppStyles.floatingLabelStyle,
                        contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      ),
                      // controller: newPasswordController,
                      // textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        // FocusScope.of(context).nextFocus();
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  SizedBox(height: 15),
                  labelText(label: 'Birthday'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: childDobController,
                      onTap: () {
                        _selectDate(context, 'CHILD');
                      },
                      readOnly: true,
                      style: AppStyles.textFieldStyle,
                      // obscureText: obsecure,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: AppColors.SECONDARY_COLOR,
                        errorMaxLines: 2,
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 182, 40, 30),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            overflow: TextOverflow.fade),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                        labelText: 'Date Of Birth',
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
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        color: AppColors.PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                            color: AppColors.SECONDARY_COLOR, width: 2)),
                    child: FlatButton(
                      height: 40,
                      minWidth: 200,
                      onPressed: () {
                        children.add(Child(
                            name: childNameController.text,
                            dob: childDobController.text));
                        setState(() {
                          childNameController.clear();
                          childDobController.clear();
                        });
                        print(children);
                        Navigator.pop(context);
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

  //function of date selector
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
      if (type == 'PROS') {
        dateofBirthController.text = dateFormatted;
      } else if (type == 'SPOUSE') {
        spouseDobController.text = dateFormatted;
      } else if (type == 'ANNIVASARY') {
        annivesaryController.text = dateFormatted;
      } else {
        childDobController.text = dateFormatted;
      }

      var duration = Duration(seconds: 2);
      return Timer(duration, () {
        selectedDate = DateTime.now();
      });
    }
  }

  createNewProspect() async {
    if (nameController.text == '' ||
        nameController.text == null ||
        nicController.text == '' ||
        nicController.text == null ||
        addressController.text == '' ||
        addressController.text == null ||
        phoneController.text == '' ||
        phoneController.text == null) {
      errorMessage(
          message: 'Name,NIC,Address and phone number fields are required');
    } else {
      setState(() {
        isSubmitting = true;
      });
      var result = await APIs().createProspect(
        user_id: selectedUser["body"]["id"],
        name: nameController.text,
        nic: nicController.text,
        address: addressController.text,
        contact: phoneController.text,
        country_code: '+94',
        email: emailController.text,
        whatsapp: whatsappController.text,
      );
      // print(result);
      if (result.done != null) {
        if (result.done) {
          setState(() {
            isSubmitting = false;
          });
          successMessage(
              message: result.message != '' || result.message != null
                  ? result.message
                  : 'Successfully Created');
          // widget.getProspects;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Prospecting(),
          ));
        } else {
          errorMessage(
              message: result.message != '' || result.message != null
                  ? result.message
                  : 'Please Try again Later');
          setState(() {
            isSubmitting = false;
          });
        }
      } else {
        errorMessage(
            message: result.message != '' || result.message != null
                ? result.message
                : 'Please Try again Later');
        setState(() {
          isSubmitting = false;
        });
      }
      /* } else {
      messageToastRed('Description or Media URL is required');
    } */
    }
  }

  updateProspect() async {
    if (nameController.text == '' ||
        nameController.text == null ||
        nicController.text == '' ||
        nicController.text == null ||
        addressController.text == '' ||
        addressController.text == null ||
        phoneController.text == '' ||
        phoneController.text == null) {
      errorMessage(
          message: 'Name,NIC,Address and phone number fields are required');
    } else {
      setState(() {
        isSubmitting = true;
      });
      var result = await APIs().updateProspect(
        pros_id: prospector.body.id,
        user_id: selectedUser["body"]["id"],
        name: nameController.text,
        nic: nicController.text,
        address: addressController.text,
        contact: phoneController.text,
        country_code: '+94',
        email: emailController.text,
        whatsapp: whatsappController.text,
      );
      // print(result);
      if (result.done != null) {
        if (result.done) {
          setState(() {
            isSubmitting = false;
          });
          successMessage(
              message: result.message != '' || result.message != null
                  ? result.message
                  : 'Successfully Updated');
          // widget.getProspects;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Prospecting(),
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
        }
      } else {
        errorMessage(
            message: result.message != '' || result.message != null
                ? result.message
                : 'Please Try again Later');
        setState(() {
          isSubmitting = false;
        });
      }
      /* } else {
      messageToastRed('Description or Media URL is required');
    } */
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(),
      child: Scaffold(
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
          title: Text('New Prospect',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          // automaticallyImplyLeading: false,
        ),
        body: isLoading
            ? Container(
                color: AppColors.PRIMARY_COLOR,
                child: Center(
                  child: SpinKitCubeGrid(
                    color: AppColors.SECONDARY_COLOR,
                    size: 50.0,
                  ),
                ))
            : Container(
                height: size.height,
                width: double.infinity,
                color: AppColors.PRIMARY_COLOR,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 15, right: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text('Life Assured',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: AppColors.SECONDARY_COLOR)),
                            SizedBox(height: 15),
                            /* Row(
                              children: [
                                Container(
                                  width: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(width: 0.5),
                                      color: AppColors.SECONDARY_COLOR),
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15),
                                  child: Row(
                                    children: [
                                      Icon(Icons.safety_divider,
                                          color: AppColors.PRIMARY_COLOR),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: _chosenGender,
                                          elevation: 5,
                                          underline: Container(
                                              color: Colors.transparent),
                                          style: TextStyle(
                                              color: AppColors.PRIMARY_COLOR),
                                          // items: dropdownItems,
                                          items: <String>[
                                            'Mr.',
                                            'Mrs',
                                            'Miss',
                                            'Venerable'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.PRIMARY_COLOR,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }).toList(),
                                          hint: Text(
                                            "Select",
                                            style: TextStyle(
                                                color: AppColors.PRIMARY_COLOR,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onChanged: (String value) {
                                            setState(() {
                                              _chosenGender = value;
                                              // print('_chosenValue' + _chosenValue);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ), */

                            SizedBox(height: 15),
                            labelText(label: 'Name'),

                            TextFormField(
                              controller: nameController,
                              style: AppStyles.textFieldStyle,
                              // obscureText: obsecure,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: AppColors.SECONDARY_COLOR,
                                errorMaxLines: 2,
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 182, 40, 30),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    overflow: TextOverflow.fade),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                labelText: 'Name',
                                labelStyle: AppStyles.labelStyle,
                                floatingLabelStyle:
                                    AppStyles.floatingLabelStyle,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            //  SizedBox(height: 15),
                            /* labelText(label: 'Birthday'),
                            TextFormField(
                              controller: dateofBirthController,
                              onTap: () {
                                _selectDate(context, 'PROS');
                              },
                              readOnly: true,
                              style: AppStyles.textFieldStyle,
                              // obscureText: obsecure,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: AppColors.SECONDARY_COLOR,
                                errorMaxLines: 2,
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 182, 40, 30),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    overflow: TextOverflow.fade),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                labelText: 'Date Of Birth',
                                labelStyle: AppStyles.labelStyle,
                                floatingLabelStyle:
                                    AppStyles.floatingLabelStyle,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ), */
                            SizedBox(height: 15),
                            labelText(label: 'NIC'),
                            TextFormField(
                              controller: nicController,
                              style: AppStyles.textFieldStyle,
                              // obscureText: obsecure,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: AppColors.SECONDARY_COLOR,
                                errorMaxLines: 2,
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 182, 40, 30),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    overflow: TextOverflow.fade),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                prefixIcon: Icon(
                                  Icons.account_box_outlined,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                labelText: 'ID',
                                labelStyle: AppStyles.labelStyle,
                                floatingLabelStyle:
                                    AppStyles.floatingLabelStyle,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            SizedBox(height: 15),
                            labelText(label: 'Address'),
                            TextFormField(
                              controller: addressController,
                              style: AppStyles.textFieldStyle,
                              // obscureText: obsecure,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: AppColors.SECONDARY_COLOR,
                                errorMaxLines: 2,
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 182, 40, 30),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    overflow: TextOverflow.fade),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                prefixIcon: Icon(
                                  Icons.location_pin,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                labelText: 'Address',
                                labelStyle: AppStyles.labelStyle,
                                floatingLabelStyle:
                                    AppStyles.floatingLabelStyle,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            SizedBox(height: 15),
                            labelText(label: 'Phone Number'),
                            TextFormField(
                              controller: phoneController,
                              style: AppStyles.textFieldStyle,
                              // obscureText: obsecure,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: AppColors.SECONDARY_COLOR,
                                errorMaxLines: 2,
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 182, 40, 30),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    overflow: TextOverflow.fade),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                labelText: 'Phone',
                                labelStyle: AppStyles.labelStyle,
                                floatingLabelStyle:
                                    AppStyles.floatingLabelStyle,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            /*  SizedBox(height: 15),
                            labelText(label: 'Occupation'),
                            Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(width: 0.5),
                                  color: AppColors.SECONDARY_COLOR),
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 30),
                              child: Row(
                                children: [
                                  Icon(Icons.manage_accounts_rounded,
                                      color: AppColors.PRIMARY_COLOR),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: DropdownSearch<String>(
                                      popupBackgroundColor:
                                          AppColors.PRIMARY_COLOR,
                                      dropdownSearchBaseStyle: TextStyle(
                                          color: AppColors.PRIMARY_COLOR,
                                          decorationColor:
                                              AppColors.PRIMARY_COLOR),
                                      dropdownSearchDecoration: InputDecoration(
                                        hintText: 'Occupation',
                                        labelText: 'Occupation',
                                        labelStyle: AppStyles.labelStyle,
                                        floatingLabelStyle:
                                            AppStyles.floatingLabelStyle,
                                        filled: true,

                                        fillColor: AppColors.SECONDARY_COLOR,
                                        errorMaxLines: 2,
                                        errorStyle: AppStyles.errorTextStyle,

                                        // contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      ),

                                      //mode of dropdown
                                      mode: Mode.DIALOG,

                                      //to show search box
                                      showSearchBox: true,
                                      // showSelectedItem: true,
                                      //list of dropdown items

                                      items: occupationList,
                                      // : "Country",
                                      onChanged: (value) {
                                        setState(() {
                                          occupation = value;
                                        });
                                      },
                                      //show selected item
                                      selectedItem: occupation,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 15),
                            labelText(label: 'Income'),
                            TextFormField(
                              controller: incomeController,
                              style: AppStyles.textFieldStyle,
                              // obscureText: obsecure,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: AppColors.SECONDARY_COLOR,
                                errorMaxLines: 2,
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 182, 40, 30),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    overflow: TextOverflow.fade),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                prefixIcon: Icon(
                                  Icons.money,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                labelText: 'Income',
                                labelStyle: AppStyles.labelStyle,
                                floatingLabelStyle:
                                    AppStyles.floatingLabelStyle,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ), */
                            SizedBox(height: 15),
                            labelText(label: 'Whatsapp Number'),
                            TextFormField(
                              controller: whatsappController,
                              style: AppStyles.textFieldStyle,
                              // obscureText: obsecure,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: AppColors.SECONDARY_COLOR,
                                errorMaxLines: 2,
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 182, 40, 30),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    overflow: TextOverflow.fade),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                prefixIcon: Icon(
                                  Icons.comment_rounded,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                labelText: 'Whatsapp Number',
                                labelStyle: AppStyles.labelStyle,
                                floatingLabelStyle:
                                    AppStyles.floatingLabelStyle,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            SizedBox(height: 15),
                            labelText(label: 'Email'),
                            TextFormField(
                              controller: emailController,
                              style: AppStyles.textFieldStyle,
                              // obscureText: obsecure,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: AppColors.SECONDARY_COLOR,
                                errorMaxLines: 2,
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 182, 40, 30),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    overflow: TextOverflow.fade),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                labelText: 'Email',
                                labelStyle: AppStyles.labelStyle,
                                floatingLabelStyle:
                                    AppStyles.floatingLabelStyle,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            SizedBox(height: 10),
                            /* Row(
                              mainAxisAlignment: isMarried
                                  ? MainAxisAlignment.spaceEvenly
                                  : MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Is married?',
                                        style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR),
                                      ),
                                      Checkbox(
                                          checkColor: AppColors.PRIMARY_COLOR,
                                          activeColor:
                                              AppColors.SECONDARY_COLOR,
                                          value: isMarried,
                                          onChanged: (bool value) {
                                            setState(() {
                                              isMarried = value;
                                            });
                                            print(isMarried);
                                          }),
                                    ],
                                  ),
                                ),
                                isMarried
                                    ? Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Have Children?',
                                              style: TextStyle(
                                                  color: AppColors
                                                      .SECONDARY_COLOR),
                                            ),
                                            Checkbox(
                                                checkColor:
                                                    AppColors.PRIMARY_COLOR,
                                                activeColor:
                                                    AppColors.SECONDARY_COLOR,
                                                value: haveChildren,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    haveChildren = value;
                                                  });
                                                  print(haveChildren);
                                                }),
                                          ],
                                        ),
                                      )
                                    : SizedBox(
                                        width: 0,
                                      ),
                              ],
                            ),
                            // SizedBox(height: 10),
                            isMarried
                                ? Column(
                                    children: [
                                      SizedBox(height: 15),
                                      Divider(
                                        thickness: 2,
                                      ),
                                      Text('Spouse',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color:
                                                  AppColors.SECONDARY_COLOR)),
                                      SizedBox(height: 12),
                                      labelText(label: 'Spouse Name'),
                                      TextFormField(
                                        style: AppStyles.textFieldStyle,
                                        controller: spouseNameController,
                                        // obscureText: obsecure,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          filled: true,
                                          fillColor: AppColors.SECONDARY_COLOR,
                                          errorMaxLines: 2,
                                          errorStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 182, 40, 30),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              overflow: TextOverflow.fade),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: AppColors.PRIMARY_COLOR,
                                          ),
                                          labelText: 'Name',
                                          labelStyle: AppStyles.labelStyle,
                                          floatingLabelStyle:
                                              AppStyles.floatingLabelStyle,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                      SizedBox(height: 15),
                                      labelText(label: 'Spouse phone number'),
                                      TextFormField(
                                        style: AppStyles.textFieldStyle,
                                        controller: spousephoneController,
                                        // obscureText: obsecure,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          filled: true,
                                          fillColor: AppColors.SECONDARY_COLOR,
                                          errorMaxLines: 2,
                                          errorStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 182, 40, 30),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              overflow: TextOverflow.fade),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          prefixIcon: Icon(
                                            Icons.phone,
                                            color: AppColors.PRIMARY_COLOR,
                                          ),
                                          labelText: 'Phone',
                                          labelStyle: AppStyles.labelStyle,
                                          floatingLabelStyle:
                                              AppStyles.floatingLabelStyle,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                      SizedBox(height: 15),
                                      labelText(label: 'Spouse Birthday'),
                                      TextFormField(
                                        controller: spouseDobController,
                                        onTap: () {
                                          _selectDate(context, 'SPOUSE');
                                        },
                                        readOnly: true,
                                        style: AppStyles.textFieldStyle,
                                        // obscureText: obsecure,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          filled: true,
                                          fillColor: AppColors.SECONDARY_COLOR,
                                          errorMaxLines: 2,
                                          errorStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 182, 40, 30),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              overflow: TextOverflow.fade),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: AppColors.PRIMARY_COLOR,
                                          ),
                                          labelText: 'Date Of Birth',
                                          labelStyle: AppStyles.labelStyle,
                                          floatingLabelStyle:
                                              AppStyles.floatingLabelStyle,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                      SizedBox(height: 15),
                                      labelText(
                                          label: 'Wedding Anniversary Date'),
                                      TextFormField(
                                        controller: annivesaryController,
                                        onTap: () {
                                          _selectDate(context, 'ANNIVASARY');
                                        },
                                        readOnly: true,
                                        style: AppStyles.textFieldStyle,
                                        // obscureText: obsecure,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          filled: true,
                                          fillColor: AppColors.SECONDARY_COLOR,
                                          errorMaxLines: 2,
                                          errorStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 182, 40, 30),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              overflow: TextOverflow.fade),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: AppColors.PRIMARY_COLOR,
                                          ),
                                          labelText: 'Date Of Anniversary',
                                          labelStyle: AppStyles.labelStyle,
                                          floatingLabelStyle:
                                              AppStyles.floatingLabelStyle,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                      SizedBox(height: 15),
                                      labelText(label: 'Spouse Id'),
                                      TextFormField(
                                        controller: spouseNicController,
                                        style: AppStyles.textFieldStyle,
                                        // obscureText: obsecure,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          filled: true,
                                          fillColor: AppColors.SECONDARY_COLOR,
                                          errorMaxLines: 2,
                                          errorStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 182, 40, 30),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              overflow: TextOverflow.fade),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          prefixIcon: Icon(
                                            Icons.account_box_outlined,
                                            color: AppColors.PRIMARY_COLOR,
                                          ),
                                          labelText: 'ID',
                                          labelStyle: AppStyles.labelStyle,
                                          floatingLabelStyle:
                                              AppStyles.floatingLabelStyle,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                      SizedBox(height: 15),
                                      labelText(label: 'Spouse Address'),
                                      TextFormField(
                                        controller: spouseAddressController,
                                        style: AppStyles.textFieldStyle,
                                        // obscureText: obsecure,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          filled: true,
                                          fillColor: AppColors.SECONDARY_COLOR,
                                          errorMaxLines: 2,
                                          errorStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 182, 40, 30),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              overflow: TextOverflow.fade),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          prefixIcon: Icon(
                                            Icons.location_pin,
                                            color: AppColors.PRIMARY_COLOR,
                                          ),
                                          labelText: 'Address',
                                          labelStyle: AppStyles.labelStyle,
                                          floatingLabelStyle:
                                              AppStyles.floatingLabelStyle,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                      ),
                                      SizedBox(height: 15),
                                      labelText(label: 'Spouse Occupation'),
                                      Container(
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(width: 0.5),
                                            color: AppColors.SECONDARY_COLOR),
                                        padding: const EdgeInsets.only(
                                            left: 15.0, right: 30),
                                        child: Row(
                                          children: [
                                            Icon(Icons.manage_accounts_rounded,
                                                color: AppColors.PRIMARY_COLOR),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: DropdownSearch<String>(
                                                popupBackgroundColor:
                                                    AppColors.PRIMARY_COLOR,
                                                dropdownSearchDecoration:
                                                    InputDecoration(
                                                  hintText: 'Spouse Occupation',
                                                  labelText:
                                                      'Spouse Occupation',
                                                  labelStyle:
                                                      AppStyles.labelStyle,
                                                  filled: true,
                                                  fillColor:
                                                      AppColors.SECONDARY_COLOR,
                                                  errorMaxLines: 2,
                                                  errorStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 182, 40, 30),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      overflow:
                                                          TextOverflow.fade),
                                                  // contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                                ),

                                                //mode of dropdown

                                                mode: Mode.DIALOG,
                                                //to show search box
                                                showSearchBox: true,
                                                // showSelectedItem: true,
                                                //list of dropdown items
                                                items: occupationList,
                                                // : "Country",
                                                onChanged: (value) {
                                                  setState(() {
                                                    spouseOccupation = value;
                                                  });
                                                },
                                                //show selected item
                                                selectedItem: spouseOccupation,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            haveChildren
                                ? Column(
                                    children: [
                                      SizedBox(height: 15),
                                      Divider(
                                        thickness: 2,
                                      ),
                                      SizedBox(height: 10),
                                      Text('Children',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color:
                                                  AppColors.SECONDARY_COLOR)),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle:
                                              const TextStyle(fontSize: 16),
                                        ),
                                        onPressed: () {
                                          createChild(context: context);
                                        },
                                        child: const Text(
                                          'Add Child +',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      for (int k = 0; k < children.length; k++)
                                        Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.PRIMARY_COLOR,
                                                border: Border.all(
                                                    color: AppColors
                                                        .SECONDARY_COLOR),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Name : ' +
                                                          children[k].name,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .SECONDARY_COLOR),
                                                    ),
                                                    SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      'Date of Birth : ' +
                                                          children[k].dob,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .SECONDARY_COLOR),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.all(0),
                                                  onPressed: () {
                                                    setState(() {
                                                      children.removeAt(k);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .delete_forever_rounded,
                                                    size: 20,
                                                    color: AppColors
                                                        .SECONDARY_COLOR,
                                                  ),
                                                ),
                                              ],
                                            ))
                                    ],
                                  )
                                : Container(), */
                            SizedBox(height: 20),
                            isSubmitting
                                ? Container(
                                    child: Center(
                                    child: SpinKitThreeBounce(
                                      color: AppColors.SECONDARY_COLOR,
                                      size: 25.0,
                                    ),
                                  ))
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.PRIMARY_COLOR,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        border: Border.all(
                                            color: AppColors.SECONDARY_COLOR,
                                            width: 2)),
                                    child: FlatButton(
                                      height: 50,
                                      // minWidth: size.width,
                                      onPressed: () {
                                        widget.id == null
                                            ? createNewProspect()
                                            : updateProspect();
                                      },
                                      child: Text(
                                        widget.id == null
                                            ? "Submit"
                                            : "Save Changes",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
