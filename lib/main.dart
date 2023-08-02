import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/auth/getCustomerLoginUpdateDetails.dart';
import 'package:pros_bot/screens/authentication/detail_screen.dart';
import 'package:pros_bot/screens/authentication/login_page.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';
import 'package:store_redirect/store_redirect.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        unselectedWidgetColor: Colors.white,
        scaffoldBackgroundColor: Color.fromARGB(0, 51, 153, 102),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white, //<-- SEE HERE
              displayColor: Colors.white, //<-- SEE HERE
            ),
      ),
      home: MainSplashScreen(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}

// Future init() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
// }

class MainSplashScreen extends StatefulWidget {
  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  bool isNotify = false;
  var message;

  String newVersion;
  bool isUpdateAvailable;
  String localVersion;

  @override
  void initState() {
    super.initState();

    // navigate();
    getAppDetails();
  }

  //Auto Navigate to login register page
  navigate() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  getAppDetails() async {
    final newVersionPlus = NewVersionPlus();
    final version = await newVersionPlus.getVersionStatus();
    if (version != null) {
      setState(() {
        newVersion = version.storeVersion;
        isUpdateAvailable = version.canUpdate;
        localVersion = version.localVersion;
        // newVersion = '1.1.0';
        // isUpdateAvailable = true;
      });
      int getExtendedVersionNumber(String version) {
        List versionCells = version.split('.');
        versionCells = versionCells.map((i) => int.parse(i)).toList();
        return versionCells[0] * 100000 + versionCells[1] * 100;
      }

      int _localVersion = getExtendedVersionNumber(localVersion);
      int _newVersion = getExtendedVersionNumber(newVersion);
      // print(_newVersion > _localVersion);
      /*  if (_newVersion > _localVersion) {
        if (isUpdateAvailable) {
          showAppDetailDialogBox(newVersion: newVersion);
        } else {
          navigate();
        } */
      // } else {
      navigate();
      // }
    } else {
      navigate();
    }
  }

  showAppDetailDialogBox({String newVersion}) {
    return showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("New Update Available"),
            content: Center(
                child: Column(
              children: [
                Text('Version ' + newVersion + ' is available in Play Store.'),
              ],
            )),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  StoreRedirect.redirect(androidAppId: "com.charith.sales_pal");
                },
                child: Text("Update"),
              )
            ],
          );
        });
  }

  route() async {
    CustomerLoginUpdateDetails getCustomerLoginDetails;

    var selectedUser;

    selectedUser = await getUserAuthPref(key: "userAuth");

    if (selectedUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: double.infinity,
        color: AppColors.PRIMARY_COLOR_NEW,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Container(
                width: size.width / 1.5,
                // height: size.width / 5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //image: AssetImage("assets/img/pros_bot_logo.png"),
                    image: AssetImage("assets/logos/3_1.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
