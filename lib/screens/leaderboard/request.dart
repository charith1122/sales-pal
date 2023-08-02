import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/models/home/analyse_data.dart';
import 'package:pros_bot/models/leader/leaderboard.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

import 'members.dart';

class LeaderRequest extends StatefulWidget {
  const LeaderRequest({Key key}) : super(key: key);

  // final String title;

  @override
  State<LeaderRequest> createState() => _LeaderRequestState();
}

class _LeaderRequestState extends State<LeaderRequest> {
  TextEditingController phoneController = new TextEditingController();
  var selectedUser;
  LeadersRequests reqestData;
  bool isLoading = true;
  bool submitting = false;

  String name = '';
  String id = '';

  @override
  void initState() {
    super.initState();
    getuser();
  }

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    getRequests();
  }

  getRequests() async {
    try {
      await APIs()
          .getLeaderReq(userId: selectedUser["body"]["id"])
          .then((value) async {
        if (value.done != null) {
          reqestData = new LeadersRequests.fromJson(value.toJson());
          if (reqestData.done == true) {
            setState(() {
              name = reqestData.body.leaderName;
              id = reqestData.body.id;
              isLoading = false;
            });
            // login(mobileNo: analyseData.body.contactNo);
          } else {
            await EasyLoading.dismiss();
            // errorMessage(message: value.message);
          }
        } else {
          await EasyLoading.dismiss();
          // errorMessage(message: value.message);
        }
        // print(appointments);
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  acceptRequest() async {
    var result = await APIs().acceptRequest(id: id, status: 'Accept');

    if (result.done != null) {
      if (result.done) {
        setState(() {
          submitting = false;
        });
        Navigator.of(context, rootNavigator: true).pop();
      } else {
        setState(() {
          submitting = false;
        });
        errorMessage(
            message: result.message != '' || result.message != null
                ? result.message
                : 'Please Try again Later');
      }
    } else {
      setState(() {
        submitting = false;
      });
      errorMessage(
          message: result.message != '' || result.message != null
              ? result.message
              : 'Please Try again Later');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
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
        centerTitle: true,
        title: Text('Request From Leader',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.PRIMARY_COLOR_NEW,
      body: Center(
        // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        // color: AppColors.PRIMARY_COLOR_NEW,
        child: isLoading
            ? Container(
                // color: AppColors.PRIMARY_COLOR_NEW,
                child: Center(
                child: SpinKitCubeGrid(
                  color: AppColors.SECONDARY_COLOR_NEW,
                  size: 50.0,
                  // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                ),
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'You have request from ' +
                          name +
                          '. Accept the request to give access to your Reports',
                      textAlign: TextAlign.center,
                      style: AppStyles.drawerText,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  submitting
                      ? Container(
                          child: Center(
                              child: SpinKitThreeBounce(
                          color: AppColors.SECONDARY_COLOR_NEW,
                          size: 25.0,
                        )))
                      : Container(
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: AppColors.PRIMARY_COLOR_NEW,
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                  color: AppColors.SECONDARY_COLOR_NEW,
                                  width: 2)),
                          child: FlatButton(
                            minWidth: 50,
                            height: 50,
                            onPressed: () {
                              setState(() {
                                submitting = true;
                              });
                              acceptRequest();
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Accept",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
