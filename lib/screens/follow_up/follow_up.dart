import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/follow_up/coverage.dart';
import 'package:pros_bot/models/pros_child.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/nop/nop.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class FollowUp extends StatefulWidget {
  const FollowUp({Key key}) : super(key: key);

  // final String title;

  @override
  State<FollowUp> createState() => _FollowUpState();
}

class _FollowUpState extends State<FollowUp> {
  var selectedUser;
  List<BodyOfGetProspects> prospects = [];

  bool isLoading = true;

  bool isSearchResult = false;
  TextEditingController searchController = TextEditingController();

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    getProspects();
  }

  @override
  void initState() {
    super.initState();
    getuser();
  }

  getProspects() async {
    try {
      await APIs()
          .getProspectsWithNoPlan(
              userId: selectedUser["body"]["id"], search: searchController.text)
          .then((value) {
        prospects.clear();
        value.body.forEach((item) {
          prospects.add(item);
        });
        print(prospects);
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
      EasyLoading.dismiss();
      isSearchResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        // drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: AppColors.PRIMARY_COLOR_NEW,
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
          title: Text('Follow Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: AppColors.PRIMARY_COLOR_NEW,
        body: isLoading
            ? Container(
                color: AppColors.PRIMARY_COLOR_NEW,
                child: Center(
                  child: SpinKitCubeGrid(
                    color: AppColors.SECONDARY_COLOR_NEW,
                    size: 50.0,
                    // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                  ),
                ))
            : Container(
                child: Stack(children: [
                  prospects.isNotEmpty
                      ? Container(
                          color: AppColors.PRIMARY_COLOR_NEW,
                          padding: EdgeInsets.only(
                              top: 6, left: 0, right: 0, bottom: 2),
                          child: Container(
                            margin: const EdgeInsets.only(top: 68),
                            child: ListView(
                              children: [
                                for (int i = 0; i < prospects.length; i++)
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 15),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color:
                                                AppColors.SECONDARY_COLOR_NEW,
                                            width: 2)),
                                    child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 55,
                                            child: Text(
                                              prospects[i].prosNo,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                              width: size.width - 200,
                                              child: Text(prospects[i].name)),
                                          Spacer(),
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          NOP(
                                                    name: prospects[i].name,
                                                    prosId: prospects[i].id,
                                                  ),
                                                ));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .SECONDARY_COLOR_NEW,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  'NOP',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .PRIMARY_COLOR_NEW),
                                                ),
                                              ))
                                        ]),
                                  ),
                              ],
                            ),
                          ))
                      : Center(
                          child: Text('No prospects with plan'),
                        ),
                  Positioned(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          // color: AppColors.SECONDARY_COLOR_NEW,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              width: 1, color: AppColors.SECONDARY_COLOR_NEW)),
                      child: Row(children: [
                        isSearchResult
                            ? IconButton(
                                onPressed: () {
                                  EasyLoading.show();
                                  setState(() {
                                    searchController.text = '';
                                  });
                                  getProspects();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: AppColors.SECONDARY_COLOR_NEW,
                                ))
                            : SizedBox(
                                height: 5,
                                width: 45,
                              ),
                        Flexible(
                          child: TextFormField(
                            controller: searchController,
                            style: TextStyle(fontSize: 12),
                            // obscureText: obsecure,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              errorMaxLines: 2,
                              errorStyle: TextStyle(
                                  color: Color.fromARGB(255, 182, 40, 30),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  overflow: TextOverflow.fade),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            ),

                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              setState(() {});
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              EasyLoading.show();
                              if (searchController.text == null ||
                                  searchController.text == '') {
                                getProspects();
                              } else {
                                getProspects();
                              }
                            },
                            icon: Icon(
                              Icons.search,
                              color: AppColors.SECONDARY_COLOR_NEW,
                            ))
                      ]),
                    ),
                  ),
                ]),
              ));
  }
}
