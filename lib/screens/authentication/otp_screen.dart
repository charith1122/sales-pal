import 'dart:async';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/components/common/buttons.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pros_bot/models/auth/getCustomerLoginUpdateDetails.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/firebase.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

// import 'package:pinput/pin_put/pin_put.dart';

import 'detail_screen.dart';

class OtpScreen extends StatefulWidget {
  final String id;
  final bool registered;
  final String mobileNo;
  OtpScreen({
    this.id,
    this.registered = false,
    this.mobileNo,
  });
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController pinPutController = new TextEditingController();
  CustomerLoginUpdateDetails getCustomerLoginDetails;
  bool isResendButton = false;
  Timer timer;
  int countSecond = 10;

  @override
  void initState() {
    super.initState();
    countSeconds();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  confirm() async {
    try {
      changeButton();

      FocusScope.of(context).unfocus();
      await EasyLoading.show(
        status: 'loading...',
      );
      if (widget.registered) {
        await APIs()
            .verifyOtp("", pinPutController.text, widget.id, true)
            .then((value) async {
          if (value != null) {
            if (value.done != null) {
              if (value.done) {
                await APIs()
                    .postCustomerLogin(mobileNo: widget.mobileNo)
                    .then((value) async {
                  if (value != null) {
                    if (value.done != null) {
                      getCustomerLoginDetails =
                          new CustomerLoginUpdateDetails.fromJson(
                              value.toJson());
                      if (getCustomerLoginDetails.done == true) {
                        updateLoginDetails();
                      } else {
                        await EasyLoading.dismiss();
                        errorMessage(message: value.message);
                      }
                    } else {
                      await EasyLoading.dismiss();
                      errorMessage(message: value.message);
                    }
                  } else {
                    await EasyLoading.dismiss();
                    errorMessage(message: value.message);
                  }
                });
              } else {
                await EasyLoading.dismiss();
                errorMessage(message: value.message);
              }
            } else {
              await EasyLoading.dismiss();
              errorMessage(message: value.message);
            }
          } else {
            await EasyLoading.dismiss();
            errorMessage(message: value.message);
          }
        });
      } else {
        await APIs()
            .verifyOtp(widget.mobileNo, pinPutController.text, "", false)
            .then((value) async {
          if (value != null) {
            if (value.done != null) {
              if (value.done) {
                await EasyLoading.dismiss();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(
                      mobileNo: widget.mobileNo,
                    ),
                  ),
                );
              } else {
                await EasyLoading.dismiss();
                errorMessage(message: value.message);
              }
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
    } catch (e) {}
  }

  changeButton() {
    if (isResendButton == false) {
      setState(() {
        countSecond = 0;
        timer.cancel();
        isResendButton = true;
      });
    }
  }

  void countSeconds() {
    setState(() {
      countSecond = 60;
    });
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (countSecond <= 0) {
            timer.cancel();
            changeButton();
          } else {
            countSecond = countSecond - 1;
          }
        },
      ),
    );
  }

  updateLoginDetails() async {
    updateUserAuthPref(key: "userAuth", data: getCustomerLoginDetails);
    await EasyLoading.dismiss();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
      (Route<dynamic> route) => false,
    );
    SendUser().saveDeviceToken();
  }

  BoxDecoration get pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColors.PRIMARY_COLOR_NEW),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR_NEW,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: size.width / 1.5,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // image: AssetImage("assets/img/pros_bot_logo.png"),
                        image: AssetImage("assets/logos/3.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 210,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Text(
                    "We have sent an OTP to " +
                        widget.mobileNo.replaceRange(5, 10, 'XXXXX'),
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.SECONDARY_COLOR_NEW.withOpacity(0.8),
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("Enter the OTP correctly"),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: PinPut(
                    textStyle: TextStyle(
                        fontSize: 14, color: AppColors.SECONDARY_COLOR_NEW),
                    fieldsAlignment: MainAxisAlignment.spaceEvenly,
                    fieldsCount: 4,
                    onSubmit: (String pin) {},
                    controller: pinPutController,
                    submittedFieldDecoration: pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: AppColors.SECONDARY_COLOR_NEW, width: 2)),
                    selectedFieldDecoration: pinPutDecoration.copyWith(
                        border: Border.all(
                            color: AppColors.SECONDARY_COLOR_NEW, width: 2)),
                    followingFieldDecoration: pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: AppColors.SECONDARY_COLOR_NEW, width: 2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                submitButton(
                    context: context,
                    submit: () {
                      confirm();
                    }),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isResendButton
                            ? "Didn't receive the code "
                            : "Didn't receive the code ",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.SECONDARY_COLOR_NEW.withOpacity(0.8),
                        ),
                      ),
                      isResendButton
                          ? InkWell(
                              onTap: () {
                                //resendOTP();
                              },
                              child: Text(
                                "Resend",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.SECONDARY_COLOR_NEW,
                                    fontWeight: FontWeight.w900,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          : Text(
                              countSecond.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.SECONDARY_COLOR_NEW
                                    .withOpacity(0.3),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                      isResendButton
                          ? Container()
                          : Text(
                              "s",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.PRIMARY_COLOR_NEW,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
