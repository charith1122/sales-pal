// import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pros_bot/components/common/buttons.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/models/auth/PostCustomerSignUp.dart';
import 'package:pros_bot/models/auth/getCustomerLoginUpdateDetails.dart';
import 'package:pros_bot/models/auth/get_company.dart';
import 'package:pros_bot/models/home/profile.dart';
import 'package:pros_bot/models/prospect/prospect_by_id.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

import 'package:country_picker/country_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String mobileNo;
  ProfileScreen({
    this.mobileNo = '',
  });
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PostCustomerSignUp postCustomerSignUp;
  CustomerLoginUpdateDetails getCustomerLoginDetails;

  List<BodyOfGetCompany> companies = [];

  bool isLoading = true;

  String country;
  String _chosenValue;

  TextEditingController nameController = new TextEditingController();
  TextEditingController nicController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController positionController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController regNoController = new TextEditingController();

  String addressHome = "";
  String addressWork = "";

  var selectedUser;
  UserProfile prospector;

  String myCompany;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      for (int k = 0; k < companies.length; k++)
        DropdownMenuItem(
            child: Center(
                child: Text(
              companies[k].name,
              textAlign: TextAlign.center,
            )),
            value: companies[k].id),
    ];
    return menuItems;
  }

  @override
  void initState() {
    super.initState();
    getCompanies();
    getuser();
  }

  @override
  void dispose() {
    super.dispose();
    // getCompanies();
  }

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    getProspectById();
  }

  getProspectById() async {
    try {
      await APIs()
          .getUserById(userId: selectedUser["body"]["id"])
          .then((value) async {
        if (value.done != null) {
          prospector = UserProfile.fromJson(value.toJson());
          if (prospector.done == true) {
            setState(() {
              isLoading = false;
              nameController.text = prospector.body.name;

              nicController.text = prospector.body.nic;
              addressController.text = prospector.body.address;
              phoneController.text = prospector.body.contactNo;
              // country = prospector.body.country;
              countryController.text = prospector.body.country;
              regNoController.text = prospector.body.regNo;
              myCompany = prospector.body.companyId;
              positionController.text = prospector.body.position;
              _chosenValue = prospector.body.jobRole;
              emailController.text = prospector.body.email;
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

  selectCountry() {
    showCountryPicker(
        context: context,
        countryListTheme: CountryListThemeData(
          flagSize: 25,
          textStyle: TextStyle(color: AppColors.PRIMARY_COLOR_NEW),
          backgroundColor: Colors.white,
          // textStyle: AppStyles.countryPickerNames,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          inputDecoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            // labelText: 'Search',
            // hintText: 'Start typing to search',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
          ),
        ),
        onSelect: (value) {
          setState(() {
            country = value.name;
            countryController.text = country;
          });
        });
  }

  getCompanies() async {
    try {
      await APIs().getCompanies().then((value) {
        print(value);
        value.body.forEach((item) {
          companies.add(item);
        });
      });
    } catch (e) {}
    setState(() {
      // isLoading = false;
    });
  }

  register() async {
    try {
      if (phoneController.text == "" ||
          phoneController.text == null ||
          nameController.text == "" ||
          nameController.text == null ||
          nicController.text == "" ||
          nicController.text == null ||
          emailController.text == "" ||
          emailController.text == null ||
          addressController.text == "" ||
          addressController.text == null ||
          /*   myCompany == "" ||
          myCompany == null ||
          positionController.text == "" ||
          positionController.text == null || */
          countryController.text == "" ||
          countryController.text == null) {
        errorMessage(message: 'All Fields are required');
      } else {
        await EasyLoading.show(
          status: 'loading...',
          dismissOnTap: false,
        );
        FocusScope.of(context).unfocus();
        await APIs()
            .updateUserDetails(
          user_id: prospector.body.id,
          name: nameController.text,
          nic: nicController.text,
          email: emailController.text,
          address: addressController.text,
          /*     companyId: myCompany,
                position: positionController.text, */
          country: countryController.text,
          /*  jobRole: _chosenValue,
                regNo: regNoController.text */
        )
            .then((value) async {
          if (value.done != null) {
            postCustomerSignUp =
                new PostCustomerSignUp.fromJson(value.toJson());
            if (value.done == true) {
              login(mobileNo: prospector.body.contactNo);
            } else {
              await EasyLoading.dismiss();
              errorMessage(message: value.message);
            }
          } else {
            await EasyLoading.dismiss();
            errorMessage(message: value.message);
          }
        });
      }
      // }
    } catch (e) {
      await EasyLoading.dismiss();
      errorMessage(message: e.message);
    }
  }

  login({String mobileNo}) async {
    try {
      // await APIs().postCustomerLogin(
      //   mobileNo: mobileNo,
      // );
      await APIs().postCustomerLogin(mobileNo: mobileNo).then((value) async {
        if (value.done != null) {
          getCustomerLoginDetails =
              new CustomerLoginUpdateDetails.fromJson(value.toJson());
          if (getCustomerLoginDetails.done == true) {
            updateLoginDetails();

            // successMessage(message: "Sign in was Successfully.");
          } else {
            await EasyLoading.dismiss();
            errorMessage(message: value.message);
          }
        } else {
          await EasyLoading.dismiss();
          errorMessage(message: value.message);
        }
      });
    } catch (e) {
      // await EasyLoading.dismiss();
      // errorMessage(message: e);
    }
  }

  updateLoginDetails() async {
    updateUserAuthPref(key: "userAuth", data: getCustomerLoginDetails);
    // await updateLocations();
    // if (widget.isHomePage) {
    await EasyLoading.dismiss();
    Navigator.pushAndRemoveUntil(
      context,
      // MaterialPageRoute(
      //     builder: (context) => MainMenuScreen(
      //           isInternetConnected: true,
      //         )),
      MaterialPageRoute(
          builder: (context) => HomePage(
              // isInternetConnected: true,
              )),
      (Route<dynamic> route) => false,
    );
    // } else {
    //   getCustomerDetails();
    // }
  }

  getCustomerDetails() async {
    try {
      getCustomerLoginDetails = new CustomerLoginUpdateDetails.fromJson(
          await getUserAuthPref(key: "userAuth"));
    } catch (e) {}

    try {
      if (getCustomerLoginDetails != null) {
        if (getCustomerLoginDetails.done != null) {
          if (getCustomerLoginDetails.done) {
            await EasyLoading.dismiss();
            successMessage(message: "Sign up was Successfully.");
            // double lat = 0;
            // double lng = 0;

            // getCustomerLoginDetails.body.user.savedLocations.forEach((element) {
            //   if (element.locationType == "Home") {
            //     setState(() {
            //       lat = double.parse(element.latitude);
            //       lng = double.parse(element.longitude);
            //     });
            //   } else if (element.locationType == "Work") {
            //     if (lat == 0 && lng == 0) {
            //       setState(() {
            //         lat = double.parse(element.latitude);
            //         lng = double.parse(element.longitude);
            //       });
            //     }
            //   }
            // });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                    // whatPage: "reg",
                    ),
              ),
            );
          } else {
            getCustomerDetails();
          }
        } else {
          await EasyLoading.dismiss();
          errorMessage(message: getCustomerLoginDetails.message);
        }
      } else {
        await EasyLoading.dismiss();
        errorMessage(message: getCustomerLoginDetails.message);
      }
    } catch (e) {
      // await EasyLoading.dismiss();
      // errorMessage(message: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.PRIMARY_COLOR_NEW,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: AppColors.PRIMARY_COLOR_NEW,
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
            ),
            body: isLoading
                ? Container(
                    child: Center(
                    child: SpinKitCubeGrid(
                      color: AppColors.SECONDARY_COLOR_NEW,
                      size: 50.0,
                      // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                    ),
                  ))
                : Container(
                    height: size.height,
                    width: double.infinity,
                    // color: Colors.white,
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 15, right: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: 75,
                                  height: 75,
                                  child: Icon(
                                    Icons.person_outline,
                                    size: 60,
                                    color: Colors.black54,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black54, width: 3),
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 30),
                                Text('Name',
                                    style: AppStyles.textFieldHeaderStyle),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: nameController,
                                  style: AppStyles.textFieldStyle2,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,

                                    // fillColor: AppColors.SECONDARY_COLOR_NEW,
                                    errorMaxLines: 2,
                                    errorStyle: AppStyles.errorTextStyle,
                                    // border: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.all(
                                    //   Radius.circular(50),
                                    // )),
                                    border: InputBorder.none,

                                    // // labelText: ' Name ',
                                    // labelStyle: AppStyles.labelStyle,
                                    // floatingLabelStyle:
                                    // AppStyles.floatingLabelStyle,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  ),
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {});
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(height: 15),
                                Text('ID',
                                    style: AppStyles.textFieldHeaderStyle),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: nicController,
                                  style: AppStyles.textFieldStyle2,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,

                                    filled: false,
                                    fillColor: AppColors.SECONDARY_COLOR_NEW,
                                    errorMaxLines: 2,
                                    errorStyle: AppStyles.errorTextStyle,
                                    border: InputBorder.none,
                                    // labelText: '  ID ',
                                    // labelStyle: AppStyles.labelStyle,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  ),
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {});
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(height: 15),
                                Text('Phone Number',
                                    style: AppStyles.textFieldHeaderStyle),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: phoneController,
                                  style: AppStyles.textFieldStyle2,
                                  readOnly: true,
                                  // enabled: false,
                                  // obscureText: obsecure,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,

                                    filled: false,
                                    fillColor: AppColors.SECONDARY_COLOR_NEW,
                                    errorMaxLines: 2,
                                    errorStyle: AppStyles.errorTextStyle,
                                    border: InputBorder.none,
                                    // labelText: '  Phone Number ',
                                    // labelStyle: AppStyles.labelStyle,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  ),

                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {});
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(height: 15),
                                Text('E mail',
                                    style: AppStyles.textFieldHeaderStyle),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: emailController,
                                  style: AppStyles.textFieldStyle2,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,

                                    filled: false,
                                    fillColor: AppColors.SECONDARY_COLOR_NEW,
                                    errorMaxLines: 2,
                                    errorStyle: AppStyles.errorTextStyle,
                                    border: InputBorder.none,
                                    // labelText: '  E mail ',
                                    // labelStyle: AppStyles.labelStyle,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  ),
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {});
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(height: 15),
                                Text('Address',
                                    style: AppStyles.textFieldHeaderStyle),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: addressController,
                                  style: AppStyles.textFieldStyle2,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,

                                    filled: false,
                                    fillColor: AppColors.PRIMARY_COLOR_LIGHT,
                                    errorMaxLines: 2,
                                    errorStyle: AppStyles.errorTextStyle,
                                    border: InputBorder.none,

                                    // labelText: '  Address ',
                                    // labelStyle: AppStyles.labelStyle,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  ),
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {});
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                /*  SizedBox(height: 8),
                                Text('Company',
                                    style: AppStyles.textFieldHeaderStyle),
                                Container(
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: AppColors.PRIMARY_COLOR_NEW,
                                    borderRadius: BorderRadius.circular(50),
                                    //  border: Border.all(width: 0.5)
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 50.0, right: 50),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      dropdownColor: AppColors.PRIMARY_COLOR_NEW,
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      isExpanded: true,
                                      value: myCompany,
                                      elevation: 5,
                                      underline:
                                          Container(color: Colors.transparent),
                                      style: AppStyles.textFieldStyle2,
                                      items: dropdownItems,
                                      hint: Text(
                                        "Company",
                                        // style: TextStyle(
                                        //     color:
                                        //         AppColors.SECONDARY_COLOR_NEW),
                                      ),
                                      onChanged: (String value) {
                                        setState(() {
                                          myCompany = value;
                                          // print('  myCompany'   + myCompany);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text('Register No',
                                    style: AppStyles.textFieldHeaderStyle),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: regNoController,
                                  style: AppStyles.textFieldStyle2,
                                  decoration: InputDecoration(
                                    hintText: '--',
                                    hintStyle: TextStyle(
                                        color: AppColors.SECONDARY_COLOR_NEW),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,

                                    filled: false,
                                    fillColor: AppColors.PRIMARY_COLOR_NEW_LIGHT,
                                    errorMaxLines: 2,
                                    errorStyle: AppStyles.errorTextStyle,
                                    border: InputBorder.none,

                                    // labelText: '  Address ',
                                    // labelStyle: AppStyles.labelStyle,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  ),
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {});
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(height: 8),
                                Text('Position',
                                    style: AppStyles.textFieldHeaderStyle),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: positionController,
                                  style: AppStyles.textFieldStyle2,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,

                                    filled: false,
                                    fillColor: AppColors.SECONDARY_COLOR_NEW,
                                    errorMaxLines: 2,
                                    errorStyle: AppStyles.errorTextStyle,
                                    border: InputBorder.none,
                                    // labelText: '  Position ',
                                    // labelStyle: AppStyles.labelStyle,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  ),
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {});
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                SizedBox(height: 8),
                                Text('Job Role',
                                    style: AppStyles.textFieldHeaderStyle),
                                Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.circular(50),
                                      // border: Border.all(width: 0.5),
                                      // color: AppColors.SECONDARY_COLOR_NEW
                                      ),
                                  padding: const EdgeInsets.only(
                                      // left: 15.0, right: 15
                                      ),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: _chosenValue,
                                    elevation: 5,
                                    dropdownColor: Colors.grey,
                                    underline:
                                        Container(color: Colors.transparent),
                                    // style: TextStyle(
                                    //     color: AppColors.PRIMARY_COLOR_NEW),
                                    style: AppStyles.textFieldStyle2,
                                    // items: dropdownItems,
                                    items: <String>[
                                      'Member',
                                      'Team Leader',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      "Job Role",
                                      style: TextStyle(
                                          // color: Colors.black,
                                          // fontSize: 16,
                                          // fontWeight: FontWeight.w600
                                          ),
                                    ),
                                    onChanged: (String value) {
                                      setState(() {
                                        _chosenValue = value;
                                        // print('_chosenValue' + _chosenValue);
                                      });
                                    },
                                  ),
                                ), */
                                SizedBox(height: 15),
                                Text('Country',
                                    style: AppStyles.textFieldHeaderStyle),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: countryController,
                                  onTap: () {
                                    selectCountry();
                                  },
                                  style: AppStyles.textFieldStyle2,
                                  readOnly: true,
                                  enableInteractiveSelection: false,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,

                                    filled: false,
                                    fillColor: AppColors.SECONDARY_COLOR_NEW,

                                    errorMaxLines: 2,
                                    errorStyle: AppStyles.errorTextStyle,
                                    border: InputBorder.none,

                                    // labelText: '  Country ',
                                    // labelStyle: AppStyles.labelStyle,

                                    contentPadding:
                                        EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    // hintText: country
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Spacer(),
                                    submitButton(
                                        context: context,
                                        submit: () {
                                          register();
                                        }),
                                    /* Container(
                                      height: 35,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.SECONDARY_COLOR_NEW),
                                        color: AppColors.PRIMARY_COLOR_NEW,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: FlatButton(
                                        height: 30,
                                        // minWidth: size.width / 2.2,
                                        onPressed: () {
                                          register();
                                        },
                                        child: Text(
                                          "Submit",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.SECONDARY_COLOR_NEW,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ), */
                                    Spacer(),
                                  ],
                                ),
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
