import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/nop/get_prospect_with_plan.dart';
import 'package:pros_bot/models/nop/multiple_plans.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/nop/nop_create.dart';
import 'package:pros_bot/screens/nop/nop_view.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class MultpleNOP extends StatefulWidget {
  final String prosId;
  final String prosName;

  const MultpleNOP({this.prosId, this.prosName, Key key}) : super(key: key);

  // final String title;

  @override
  State<MultpleNOP> createState() => _MultpleNOPState();
}

class _MultpleNOPState extends State<MultpleNOP> {
  var selectedUser;
  List<BodyOfMultiplePlans> plans = [];
  DateFormat dtFormatter = DateFormat('yyyy-MM-dd');
  bool isLoading = true;

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
      await APIs().getPlansByPros(prosId: widget.prosId).then((value) {
        value.body.forEach((item) {
          plans.add(item);
        });
        print(plans);
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
        title: Text('Multiple NOPs',
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
          : Stack(
              children: [
                Container(
                    child: plans.isNotEmpty
                        ? Container(
                            color: AppColors.PRIMARY_COLOR_NEW,
                            padding: EdgeInsets.only(
                                top: 6, left: 0, right: 0, bottom: 2),
                            child: ListView(
                              children: [
                                for (int i = 0; i < plans.length; i++)
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color:
                                                AppColors.SECONDARY_COLOR_NEW,
                                            width: 2)),
                                    child: Row(children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Policy No: ' +
                                              plans[i].policyNo),
                                          SizedBox(height: 8),
                                          Text('Commencement Date: ' +
                                              // plans[i].commenceDate
                                              dtFormatter.format(DateTime.parse(
                                                  plans[i].commenceDate))),
                                          SizedBox(height: 8),
                                          Text('Premium: ' +
                                              plans[i].premium.toString()),
                                        ],
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        width: 40,
                                        child: IconButton(
                                            icon: Icon(Icons.edit,
                                                // size: 30,
                                                color: AppColors
                                                    .SECONDARY_COLOR_NEW),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        NOPView(
                                                  id: plans[i].id,
                                                  name: widget.prosName,
                                                  prosId: plans[i].prosId,
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
                            child: Text('No plans'),
                          )),
                /*  Positioned(
                  bottom: 10,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // margin: const EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            color: AppColors.PRIMARY_COLOR_NEW,
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                                color: AppColors.SECONDARY_COLOR_NEW, width: 2)),
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
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ) */
              ],
            ),
    );
  }
}
