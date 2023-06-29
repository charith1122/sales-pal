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
      backgroundColor: AppColors.PRIMARY_COLOR,
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
                  image: AssetImage("assets/img/pros_bot_logo.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfileScreen(),
                ));
              },
              child: Text(
                'Profile',
                style: AppStyles.drawerText,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'LinkedIn',
                style: AppStyles.drawerText,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Facebook',
                style: AppStyles.drawerText,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'YouTube',
                style: AppStyles.drawerText,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Web',
                style: AppStyles.drawerText,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Contact',
                style: AppStyles.drawerText,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Payments(),
                ));
              },
              child: Text(
                'Payment',
                style: AppStyles.drawerText,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {
                SendUser().deleteDeviceToken();
                removeUserAuthPref(key: "userAuth");
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainSplashScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text(
                'Logout',
                style: AppStyles.drawerText,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Privacy(),
                ));
              },
              child: Text(
                'Privacy Policy',
                style: AppStyles.drawerText2,
              ),
            ),
          ]));
}
