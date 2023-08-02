import 'package:flutter/services.dart';
import 'package:international_phone_input/international_phone_input.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/components/common/buttons.dart';
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
        backgroundColor: AppColors.PRIMARY_COLOR_NEW,
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
                        image: AssetImage("assets/logos/3_1.png"),
                        // image: AssetImage("assets/img/pros_bot_logo.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin:
                      EdgeInsets.only(bottom: 50, top: 30, left: 50, right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                            color: AppColors.SECONDARY_COLOR_NEW,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.BUTTON_BG.withOpacity(0.8),
                        ),
                        child: InternationalPhoneInput(
                          decoration: InputDecoration(
                            //focusColor: AppColors.SECONDARY_COLOR_NEW,
                            labelStyle: TextStyle(
                              color: AppColors.SECONDARY_COLOR_NEW,
                            ),
                            border: InputBorder.none,
                          ),
                          onPhoneNumberChange: onPhoneNumberChange,
                          initialPhoneNumber: mobileNo,
                          showCountryFlags: false,
                          initialSelection: "+94",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                submitButton(
                    submit: () {
                      login(context, "");
                    },
                    context: context),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }
}
