// import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pros_bot/components/common/label.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/components/common/buttons.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/models/auth/PostCustomerSignUp.dart';
import 'package:pros_bot/models/auth/getCustomerLoginUpdateDetails.dart';
import 'package:pros_bot/models/auth/get_company.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/firebase.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

import 'package:country_picker/country_picker.dart';

class RegisterScreen extends StatefulWidget {
  final String mobileNo;
  RegisterScreen({
    this.mobileNo,
  });
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  PostCustomerSignUp postCustomerSignUp;
  CustomerLoginUpdateDetails getCustomerLoginDetails;

  List<BodyOfGetCompany> companies = [];

  bool isLoading = true;

  String country = "";

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
  String _chosenValue = 'Member';

  String myCompany;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      for (int k = 0; k < companies.length; k++)
        DropdownMenuItem(
            child: Text(companies[k].name), value: companies[k].id),
    ];
    return menuItems;
  }

  @override
  void initState() {
    super.initState();
    getCompanies();
    setState(() {
      phoneController.text = widget.mobileNo;
    });
    /* NewVersion(
      context: context,
      iOSId: 'com.sahasa.buyer',
      androidId: 'com.sahasa.buyer',
    ).showAlertIfNecessary(); */
  }

  @override
  void dispose() {
    super.dispose();
    // getCompanies();
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
            labelText: 'Search',
            hintText: 'Start typing to search',
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
      isLoading = false;
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
          /*    myCompany == "" ||
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
            .postCustomerSignUp(
          contactNo: phoneController.text,
          name: nameController.text,
          nic: nicController.text,
          email: emailController.text,
          address: addressController.text,
          /*   companyId: myCompany,
                position: positionController.text, */
          country: countryController.text,
          /*   regNo: regNoController.text,
                jobRole: _chosenValue */
        )
            .then((value) async {
          if (value.done != null) {
            postCustomerSignUp =
                new PostCustomerSignUp.fromJson(value.toJson());
            if (postCustomerSignUp.done == true) {
              login(mobileNo: postCustomerSignUp.body.contactNo);
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
    SendUser().saveDeviceToken();
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
                builder: (context) => HomePage(),
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
        child: WillPopScope(
          onWillPop: () {
            errorMessage(message: "Your can't back.. Please fill the form..");
            return;
          },
          child: Scaffold(
              backgroundColor: AppColors.PRIMARY_COLOR_NEW,
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
                                top: 40.0, left: 30, right: 30),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    "Create profile Details",
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: AppColors.PRYMARY_COLOR2,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Your Profile",
                                    style: TextStyle(
                                        color: AppColors.SECONDARY_COLOR_NEW
                                            .withOpacity(0.6)),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: 75,
                                    height: 75,
                                    child: Icon(
                                      Icons.person_outline_outlined,
                                      size: 60,
                                      color: AppColors.SECONDARY_COLOR_NEW,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: /* AppColors.SECONDARY_COLOR_NEW, */ Colors
                                                .transparent,
                                            width: 3),
                                        shape: BoxShape.circle,
                                        color: AppColors.PRYMARY_COLOR2),
                                  ),
                                  SizedBox(height: 30),
                                  labelText(label: 'Your Name'),
                                  TextFormField(
                                    controller: nameController,
                                    style: AppStyles.textFieldStyle,
                                    decoration: InputDecoration(
                                      labelText: '  Name ',
                                      labelStyle: AppStyles.labelStyle,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: false,
                                      fillColor: AppColors.SECONDARY_COLOR_NEW,
                                      errorMaxLines: 2,
                                      errorStyle: AppStyles.errorTextStyle,
                                      focusColor: AppColors.SECONDARY_COLOR_NEW,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      /*  prefixIcon: Icon(
                                        Icons.person,
                                        color: AppColors.PRIMARY_COLOR_NEW,
                                      ), */
                                      //labelText: ' Name ',
                                      // labelStyle: AppStyles.labelStyle,
                                      /* floatingLabelStyle:
                                          AppStyles.floatingLabelStyle, */
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 0, 8, 0),
                                    ),
                                    onEditingComplete: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {});
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                  SizedBox(height: 15),
                                  labelText(label: 'NIC'),
                                  TextFormField(
                                    controller: nicController,
                                    style: AppStyles.textFieldStyle,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      /* filled: true,
                                      fillColor: AppColors.SECONDARY_COLOR_NEW, */
                                      errorMaxLines: 2,
                                      errorStyle: AppStyles.errorTextStyle,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      /* prefixIcon: Icon(
                                        Icons.account_box_outlined,
                                        color: AppColors.PRIMARY_COLOR_NEW,
                                      ), */
                                      labelText: '  ID ',
                                      labelStyle: AppStyles.labelStyle,
                                      floatingLabelStyle:
                                          AppStyles.floatingLabelStyle,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 0, 8, 0),
                                    ),
                                    onEditingComplete: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {});
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                  SizedBox(height: 15),
                                  labelText(label: 'Phone Number'),
                                  TextFormField(
                                    controller: phoneController,
                                    style: AppStyles.textFieldStyle,
                                    readOnly: true,
                                    // enabled: false,
                                    // obscureText: obsecure,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      /*  filled: true,
                                      fillColor: AppColors.SECONDARY_COLOR_NEW, */
                                      errorMaxLines: 2,
                                      errorStyle: AppStyles.errorTextStyle,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      /*  prefixIcon: Icon(
                                        Icons.phone,
                                        color: AppColors.PRIMARY_COLOR_NEW,
                                      ), */
                                      labelText: '  Phone Number ',
                                      labelStyle: AppStyles.labelStyle,
                                      floatingLabelStyle:
                                          AppStyles.floatingLabelStyle,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 0, 8, 0),
                                    ),

                                    onEditingComplete: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {});
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                  SizedBox(height: 15),
                                  labelText(label: 'E mail'),
                                  TextFormField(
                                    controller: emailController,
                                    style: AppStyles.textFieldStyle,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      /*  filled: true,
                                      fillColor: AppColors.SECONDARY_COLOR_NEW, */
                                      errorMaxLines: 2,
                                      errorStyle: AppStyles.errorTextStyle,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      /*   prefixIcon: Icon(
                                        Icons.email,
                                        color: AppColors.PRIMARY_COLOR_NEW,
                                      ), */
                                      labelText: '  E mail ',
                                      labelStyle: AppStyles.labelStyle,
                                      floatingLabelStyle:
                                          AppStyles.floatingLabelStyle,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 0, 8, 0),
                                    ),
                                    onEditingComplete: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {});
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                  SizedBox(height: 15),
                                  labelText(label: 'Address'),
                                  TextFormField(
                                    controller: addressController,
                                    style: AppStyles.textFieldStyle,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      /* filled: true,
                                      fillColor: AppColors.SECONDARY_COLOR_NEW, */
                                      errorMaxLines: 2,
                                      errorStyle: AppStyles.errorTextStyle,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      /*   prefixIcon: Icon(
                                        Icons.home_work_outlined,
                                        color: AppColors.PRIMARY_COLOR_NEW,
                                      ), */
                                      labelText: '  Address ',
                                      labelStyle: AppStyles.labelStyle,
                                      floatingLabelStyle:
                                          AppStyles.floatingLabelStyle,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 0, 8, 0),
                                    ),
                                    onEditingComplete: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {});
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                  SizedBox(height: 15),
                                  labelText(label: 'Country'),
                                  TextFormField(
                                    controller: countryController,
                                    onTap: () {
                                      selectCountry();
                                    },
                                    style: AppStyles.textFieldStyle,
                                    readOnly: true,
                                    enableInteractiveSelection: false,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      /*  filled: true,
                                      fillColor: AppColors.SECONDARY_COLOR_NEW, */

                                      errorMaxLines: 2,
                                      errorStyle: AppStyles.errorTextStyle,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors
                                                  .SECONDARY_COLOR_NEW),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          )),
                                      /*  prefixIcon: Icon(
                                        Icons.location_pin,
                                        color: AppColors.PRIMARY_COLOR_NEW,
                                      ), */
                                      labelText: '  Country ',
                                      labelStyle: AppStyles.labelStyle,
                                      floatingLabelStyle:
                                          AppStyles.floatingLabelStyle,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(12, 0, 8, 0),
                                      // hintText: country
                                    ),
                                  ),
                                  SizedBox(height: 35),
                                  /*          labelText(label: 'Company'),
                                  Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: AppColors.SECONDARY_COLOR_NEW,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(width: 0.5)),
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_city_outlined,
                                          color: AppColors.PRIMARY_COLOR_NEW,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: myCompany,
                                            elevation: 5,
                                            underline: Container(
                                                color: Colors.transparent),
                                            style: AppStyles.textFieldStyle,
                                            items: dropdownItems,
                                            hint: Text(
                                              "Company",
                                              style: TextStyle(),
                                            ),
                                            onChanged: (String value) {
                                              setState(() {
                                                myCompany = value;
                                                // print('  myCompany'   + myCompany);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  labelText(label: 'Register No'),
                                  TextFormField(
                                    controller: regNoController,
                                    style: AppStyles.textFieldStyle,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      fillColor: AppColors.SECONDARY_COLOR_NEW,
                                      errorMaxLines: 2,
                                      errorStyle: AppStyles.errorTextStyle,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      prefixIcon: Icon(
                                        Icons.app_registration,
                                        color: AppColors.PRIMARY_COLOR_NEW,
                                      ),
                                      labelText: '  Register No ',
                                      labelStyle: AppStyles.labelStyle,
                                      floatingLabelStyle:
                                          AppStyles.floatingLabelStyle,
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
                                  labelText(label: 'Position'),
                                  TextFormField(
                                    controller: positionController,
                                    style: AppStyles.textFieldStyle,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      fillColor: AppColors.SECONDARY_COLOR_NEW,
                                      errorMaxLines: 2,
                                      errorStyle: AppStyles.errorTextStyle,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      prefixIcon: Icon(
                                        Icons.person_pin_sharp,
                                        color: AppColors.PRIMARY_COLOR_NEW,
                                      ),
                                      labelText: '  Position ',
                                      labelStyle: AppStyles.labelStyle,
                                      floatingLabelStyle:
                                          AppStyles.floatingLabelStyle,
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
                                  labelText(label: 'Job Role'),
                                  Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(width: 0.5),
                                        color: AppColors.SECONDARY_COLOR_NEW),
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _chosenValue,
                                      elevation: 5,

                                      underline:
                                          Container(color: Colors.transparent),
                                      // style: TextStyle(
                                      //     color: AppColors.PRIMARY_COLOR_NEW),
                                      style: AppStyles.textFieldStyle,
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
                                  ),
                                  SizedBox(height: 20), */
                                  submitButton(
                                    context: context,
                                    submit: () {
                                      register();
                                    },
                                  ),
                                  /* Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                          color: AppColors.SECONDARY_COLOR_NEW,
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        child: FlatButton(
                                          height: 40,
                                          // minWidth: size.width / 2.2,
                                          onPressed: () {
                                            register();
                                          },
                                          child: Text(
                                            "Submit",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.PRIMARY_COLOR_NEW,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ), */
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
        ),
      ),
    );
  }
}
