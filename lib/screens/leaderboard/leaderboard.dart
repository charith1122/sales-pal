import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/leader/leaderboard.dart';
import 'package:pros_bot/models/nop/get_prospect_with_plan.dart';
import 'package:pros_bot/models/nop/user_plans.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/leaderboard/leader_report_main.dart';
import 'package:pros_bot/screens/leaderboard/leader_reports.dart';
import 'package:pros_bot/screens/leaderboard/members.dart';
import 'package:pros_bot/screens/nop/multiple_nop.dart';
import 'package:pros_bot/screens/nop/nop_create.dart';
import 'package:pros_bot/screens/nop/nop_view.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key key}) : super(key: key);

  // final String title;

  @override
  State<LeaderBoard> createState() => _NOPListState();
}

class _NOPListState extends State<LeaderBoard> {
  var selectedUser;
  List<BodyOfLeaderMembers> members = [];

  bool isLoading = true;

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    getMyMembers();
  }

  @override
  void initState() {
    super.initState();
    getuser();
  }

  getMyMembers() async {
    try {
      await APIs()
          .getMyMembers(userId: selectedUser["body"]["id"])
          .then((value) {
        value.body.forEach((item) {
          members.add(item);
        });
        print(members);
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
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
        title: Text('Leader\'s Dashboard',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: isLoading
          ? Container(
              color: AppColors.PRIMARY_COLOR,
              child: Center(
                child: SpinKitCubeGrid(
                  color: AppColors.SECONDARY_COLOR,
                  size: 50.0,
                  // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                ),
              ))
          : Stack(
              children: [
                Container(
                    child: members.isNotEmpty
                        ? Container(
                            color: AppColors.PRIMARY_COLOR,
                            padding: EdgeInsets.only(
                                top: 6, left: 0, right: 0, bottom: 75),
                            child: ListView(
                              children: [
                                for (int i = 0; i < members.length; i++)
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.SECONDARY_COLOR,
                                            width: 2)),
                                    child: Row(children: [
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          // members[i].prosNo,
                                          ((i + 1).toString().padLeft(3, '0')),
                                          // ((i + 1) * (k + 5)).toString(),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Container(
                                        width: size.width - 160,
                                        // color: Colors.green[200],
                                        child: Column(
                                          children: [
                                            Text(
                                              members[i].memberName,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            if (members[i].regNo != "")
                                              Divider(
                                                  indent: 25,
                                                  endIndent: 25,
                                                  color: AppColors
                                                      .SECONDARY_COLOR),
                                            if (members[i].regNo != "")
                                              Text('Reg No: ' +
                                                  members[i].regNo.toString()),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          width: 40,
                                          child: members[i].status == "Accept"
                                              ? IconButton(
                                                  icon: Icon(
                                                      Icons.remove_red_eye,
                                                      // size: 30,
                                                      color: AppColors
                                                          .SECONDARY_COLOR),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          LeaderReportMain(
                                                              // id: members[i].planId,
                                                              name:
                                                                  members[i]
                                                                      .memberName,
                                                              id: members[i]
                                                                  .memberId,
                                                              company:
                                                                  members[i]
                                                                      .company,
                                                              regNo: members[i]
                                                                  .regNo,
                                                              contact:
                                                                  members[i]
                                                                      .contact),
                                                    ));
                                                  }
                                                  // scaffoldKey.currentState.openDrawer(),
                                                  )
                                              : Container() /* IconButton(
                                                icon: Icon(Icons.remove_red_eye,
                                                    // size: 30,
                                                    color: AppColors
                                                        .SECONDARY_COLOR),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        NOPView(
                                                            id: members[i].id,
                                                            name: members[i]
                                                                .memberName
                                                            // prosId:
                                                            //     members[i].prosId,
                                                            ),
                                                  ));
                                                }
                                                // scaffoldKey.currentState.openDrawer(),
                                                ), */
                                          )
                                    ]),
                                  ),
                              ],
                            ))
                        : Center(
                            child: Text('No members with plan'),
                          )),
                Positioned(
                  bottom: 10,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // margin: const EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            color: AppColors.PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                                color: AppColors.SECONDARY_COLOR, width: 2)),
                        child: FlatButton(
                          height: 50,
                          onPressed: () {
                            // login(context, "");
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => AddMember(
                                  // id: null,
                                  ),
                              // builder: (BuildContext context) => DropDownDemo(),
                            ));
                          },
                          child: Text(
                            "Add +",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
