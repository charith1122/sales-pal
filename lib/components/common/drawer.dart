import 'package:flutter/material.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/main.dart';
import 'package:pros_bot/screens/home/privacy.dart';
import 'package:pros_bot/screens/home/profile.dart';
import 'package:pros_bot/screens/payment/payments.dart';
import 'package:pros_bot/services/firebase.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

Drawer myDrawer({
  Size size,
  BuildContext context,
}) {
  return Drawer(
      backgroundColor: AppColors.PRIMARY_COLOR_NEW,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 75,
            ),
            Container(
              width: size.width / 2,
              height: size.width / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  //  image: AssetImage("assets/img/pros_bot_logo.png"),
                  image: AssetImage("assets/logos/3.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: size.width / 1.5,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 237, 237, 237)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen(),
                    ));
                  },
                  child: Text(
                    "Profile",
                    style: TextStyle(
                        color: AppColors.SECONDARY_COLOR_NEW, fontSize: 18),
                  )),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              width: size.width / 1.5,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 237, 237, 237)),
                  onPressed: () {
                    SendUser().deleteDeviceToken();
                    removeUserAuthPref(key: "userAuth");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainSplashScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: AppColors.SECONDARY_COLOR_NEW, fontSize: 18),
                  )),
            ),
          ]));
}
