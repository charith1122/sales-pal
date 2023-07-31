import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/nop/get_prospect_with_plan.dart';
import 'package:pros_bot/models/nop/user_plans.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/nop/multiple_nop.dart';
import 'package:pros_bot/screens/nop/nop_create.dart';
import 'package:pros_bot/screens/nop/nop_view.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class NOPList extends StatefulWidget {
  const NOPList({Key key}) : super(key: key);

  // final String title;

  @override
  State<NOPList> createState() => _NOPListState();
}

class _NOPListState extends State<NOPList> {
  var selectedUser;
  List<BodyOfUserPlans> prospects = [];

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
          .getProspectsWithPlan(
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
        title: Text('NOP',
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
                    child: prospects.isNotEmpty
                        ? Container(
                            color: AppColors.PRIMARY_COLOR,
                            padding: EdgeInsets.only(
                                top: 68, left: 0, right: 0, bottom: 75),
                            child: ListView(
                              children: [
                                for (int i = 0; i < prospects.length; i++)
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
                                          // prospects[i].prosNo,
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
                                              prospects[i].prosName,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            Divider(
                                                indent: 25,
                                                endIndent: 25,
                                                color:
                                                    AppColors.SECONDARY_COLOR),
                                            Text('Policy No: ' +
                                                prospects[i].policyNo),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: prospects[i].planCount > 1
                                            ? IconButton(
                                                icon: Icon(Icons.list_alt_sharp,
                                                    // size: 30,
                                                    color: AppColors
                                                        .SECONDARY_COLOR),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        MultpleNOP(
                                                      // id: prospects[i].planId,
                                                      prosName:
                                                          prospects[i].prosName,
                                                      prosId: prospects[i].id,
                                                    ),
                                                  ));
                                                }
                                                // scaffoldKey.currentState.openDrawer(),
                                                )
                                            : IconButton(
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
                                                      id: prospects[i].id,
                                                      name:
                                                          prospects[i].prosName,
                                                      prosId:
                                                          prospects[i].prosId,
                                                    ),
                                                  ));
                                                }
                                                // scaffoldKey.currentState.openDrawer(),
                                                ),
                                      )
                                    ]),
                                  ),
                              ],
                            ))
                        : Center(
                            child: Text('No prospects with plan'),
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
                              builder: (BuildContext context) => NOPCreate(
                                  // id: null,
                                  ),
                              // builder: (BuildContext context) => DropDownDemo(),
                            ));
                          },
                          child: Text(
                            "Add +",
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.PRYMARY_COLOR2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        // color: AppColors.SECONDARY_COLOR,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            width: 1, color: AppColors.SECONDARY_COLOR)),
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
                                color: AppColors.SECONDARY_COLOR,
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                            color: AppColors.SECONDARY_COLOR,
                          ))
                    ]),
                  ),
                ),
              ],
            ),
    );
  }
}
