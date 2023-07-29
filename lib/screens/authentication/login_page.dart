import 'package:flutter/services.dart';
import 'package:international_phone_input/international_phone_input.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/services/api.dart';
import 'package:url_launcher/url_launcher.dart';

import 'otp_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileNumController = new TextEditingController();
  String mobileNo = "";
  String phoneIsoCode = "";

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      mobileNo = internationalizedPhoneNumber;
      phoneIsoCode = isoCode;
    });
  }

  login(BuildContext context, String url) async {
    try {
      await EasyLoading.show(
        status: 'loading...',
        dismissOnTap: false,
      );
      if (mobileNo == "" || mobileNo.length != 12) {
        await EasyLoading.dismiss();
        errorMessage(message: "Please enter valid mobile Number");
      } else {
        FocusScope.of(context).unfocus();
        await APIs().checkAuthorize(mobileNo: mobileNo).then((value) async {
          if (value != null) {
            if (value.done != null) {
              if (value.done) {
                if (value.body.registered) {
                  await EasyLoading.dismiss();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpScreen(
                          id: value.body.id,
                          registered: true,
                          mobileNo: mobileNo,
                        ),
                      ));
                } else {
                  await EasyLoading.dismiss();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(
                        id: value.body.id,
                        mobileNo: mobileNo,
                      ),
                    ),
                  );
                }
              }
            }
          }
        });
      }
    } catch (e) {
      await EasyLoading.dismiss();
      errorMessage(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: size.width / 1.5,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/pros_bot_logo.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'WELCOME',
                  style: TextStyle(
                      color: AppColors.SECONDARY_COLOR,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'PHONE NUMBER',
                  style: TextStyle(
                      color: AppColors.SECONDARY_COLOR,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 50, top: 30, left: 50, right: 50),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 85, 20, 20),
                    border: Border.all(
                      color: Color.fromARGB(255, 3, 0, 0),
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InternationalPhoneInput(
                      decoration: InputDecoration(
                          focusColor: Colors.orange,
                          counterStyle: TextStyle(color: Colors.black),
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          prefixStyle: TextStyle(color: Colors.black),
                          suffixStyle: TextStyle(color: Colors.black),
                          hoverColor: Colors.orange,
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black),
                          labelStyle:
                              TextStyle(fontSize: 14, color: Colors.black),
                          border: InputBorder.none,
                          filled: false,
                          fillColor: Color.fromARGB(255, 92, 9, 9)),
                      labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          backgroundColor: Colors.pink),
                      onPhoneNumberChange: onPhoneNumberChange,
                      initialPhoneNumber: mobileNo,
                      showCountryFlags: false,
                      // showCountryCodes: false,
                      initialSelection: "+94",
                      enabledCountries: ['+94']),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white)),
                  child: FlatButton(
                    height: 60,
                    minWidth: size.width,
                    onPressed: () {
                      login(context, "");
                    },
                    child: Icon(
                      Icons.check,
                      size: 40,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                /* Text(
                  'HOTLINE',
                  style: TextStyle(
                      color: AppColors.SECONDARY_COLOR,
                      // fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: AppColors.SECONDARY_COLOR,
                      ),
                      onPressed: () {
                        // Navigator.pop(context);
                        //  launch("tel://0775 675 625");
                        launchUrl(Uri(
                          scheme: 'tel',
                          path: '+94773848020',
                        ));
                      },
                      child: Text('+9477 384 80 20'),
                    ),
                    Text(
                      '/',
                      style: TextStyle(
                          color: AppColors.SECONDARY_COLOR,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: AppColors.SECONDARY_COLOR,
                      ),
                      onPressed: () {},
                      child: const Text('+9471 784 80 20'),
                    ),
                  ],
                ) */
              ],
            ),
          ),
        ));
  }
}
