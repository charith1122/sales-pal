import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/prospecting/new_prospect.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class Prospecting extends StatefulWidget {
  // const Prospecting({Key? key, required this.title}) : super(key: key);

  // final String title;

  @override
  State<Prospecting> createState() => _ProspectingState();
}

class _ProspectingState extends State<Prospecting> {
  var selectedUser;
  List<BodyOfGetProspects> prospects = [];
  bool isLoading = true;
  bool isSearchResult = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getuser();
  }

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    getProspects();
  }

  getProspects() async {
    try {
      await APIs()
          .getProspects(userId: selectedUser["body"]["id"])
          .then((value) {
        if (value.done) {
          prospects.clear();
          value.body.forEach((item) {
            prospects.add(item);
          });
          print(prospects);
        }
      });
    } catch (e) {}
    setState(() {
      EasyLoading.dismiss();
      isLoading = false;
      isSearchResult = false;
    });
  }

  getProspectsSearh() async {
    try {
      await APIs()
          .getProspectsBySearch(
              userId: selectedUser["body"]["id"], search: searchController.text)
          .then((value) {
        if (value.done) {
          prospects.clear();
          value.body.forEach((item) {
            prospects.add(item);
          });
          // print(prospects);
        }
      });
    } catch (e) {}
    setState(() {
      EasyLoading.dismiss();
      // isLoading = false;
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
        title: Text('Prospecting',
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
                ),
              ))
          : Container(
              color: AppColors.PRIMARY_COLOR,
              padding: EdgeInsets.only(top: 6, left: 0, right: 0, bottom: 2),
              child: Stack(
                children: [
                  prospects.isEmpty
                      ? Container(
                          margin: const EdgeInsets.only(bottom: 70, top: 68),
                          child: Center(
                            child: Text('No Prospectors'),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(bottom: 70, top: 68),
                          child: ListView(
                            children: [
                              for (int i = 0; i < prospects.length; i++)
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: AppColors.PRIMARY_COLOR,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.SECONDARY_COLOR)),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(children: [
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                        prospects[i].prosNo ?? "",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.SECONDARY_COLOR),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width - 165,
                                      child: Text(prospects[i].name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color:
                                                  AppColors.SECONDARY_COLOR)),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: 50,
                                      child: IconButton(
                                          icon: Icon(Icons.edit,
                                              // size: 30,
                                              color: AppColors.SECONDARY_COLOR),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  NewProspect(
                                                getProspects: getProspects,
                                                id: prospects[i].id,
                                              ),
                                            ));
                                          }
                                          // scaffoldKey.currentState.openDrawer(),
                                          ),
                                    )
                                  ]),
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
                                getProspectsSearh();
                              }
                            },
                            icon: Icon(
                              Icons.search,
                              color: AppColors.SECONDARY_COLOR,
                            ))
                      ]),
                    ),
                  ),
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
                                color: AppColors.SECONDARY_COLOR, width: 2),
                          ),
                          child: FlatButton(
                            height: 50,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => NewProspect(
                                  getProspects: getProspects,
                                  id: null,
                                ),
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
              )),
    );
  }
}
