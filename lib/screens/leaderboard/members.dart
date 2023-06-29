import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/leaderboard/leaderboard.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class AddMember extends StatefulWidget {
  const AddMember({Key key}) : super(key: key);

  // final String title;

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  TextEditingController phoneController = TextEditingController();
  var selectedUser;
  String name = '';
  String regNo = '';
  String message = '';
  String id = '';

  bool canAdd = false;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    getuser();
    // checkIsEdit();
  }

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
  }

  getTodoById() async {
    try {
      if (selectedUser["body"]["contactNo"] == phoneController.text) {
        name = '';
        id = '';
        regNo = '';
        message = 'This is your Contact Number';
        canAdd = false;
      } else {
        await APIs()
            .getMemberByContact(
                userId: selectedUser["body"]["id"],
                contact: phoneController.text)
            .then((value) async {
          if (value.done) {
            if (value.body != null) {
              setState(() {
                name = value.body.name;
                id = value.body.id;
                regNo = value.body.regNo;
                canAdd = true;
              });
            } else {
              setState(() {
                name = '';
                id = '';
                regNo = '';
                message = value.message;
                canAdd = false;
              });
            }
            print(value);
          } else {
            // else
            errorMessage(message: value.message);
          }
          // print(appointments);
        });
      }
    } catch (e) {}
    setState(() {
      // isLoading = false;
    });
  }

  createRequest() async {
    var result = await APIs().sendMemberReq(
      user_id: selectedUser["body"]["id"],
      member_id: id,
    );
    // print(result);
    if (result.done != null) {
      if (result.done) {
        setState(() {
          isSubmitting = false;
        });
        // widget.getProspects;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
        );
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => LeaderBoard(),
        ));
        /* setState(() {
          verifiedUser = true;
          navigate();
        }); */
      } else {
        errorMessage(
            message: result.message != '' || result.message != null
                ? result.message
                : 'Please Try again Later');
        setState(() {
          isSubmitting = false;
        });
      }
    } else {
      errorMessage(
          message: result.message != '' || result.message != null
              ? result.message
              : 'Please Try again Later');
      setState(() {
        isSubmitting = false;
      });
    }
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
        title: Text('Add Member to List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: AppColors.PRIMARY_COLOR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Phone Number', style: AppStyles.drawerText),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: phoneController,
              style: AppStyles.textFieldStyle,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: AppColors.SECONDARY_COLOR,
                errorMaxLines: 2,
                errorStyle: AppStyles.errorTextStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                prefixIcon: Icon(
                  Icons.phone,
                  color: AppColors.PRIMARY_COLOR,
                ),
                labelText: '  Phone Number ',
                labelStyle: AppStyles.labelStyle,
                floatingLabelStyle: AppStyles.floatingLabelStyle,
                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              ),
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                setState(() {});
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
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
                      getTodoById();
                    },
                    child: Row(
                      children: [
                        Text(
                          "Get Details",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.download_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            canAdd
                ? Column(
                    children: [
                      Text(
                        'Name : ' + name,
                        style: AppStyles.drawerText,
                      ),
                      regNo != null
                          ? SizedBox(
                              height: 12,
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      regNo != null
                          ? Text(
                              'Reg No : ' + regNo,
                              style: AppStyles.drawerText,
                            )
                          : Container(),
                    ],
                  )
                : Text(
                    message,
                    style: AppStyles.drawerText,
                    textAlign: TextAlign.center,
                  ),
            SizedBox(
              height: 18,
            ),
            canAdd
                ? !isSubmitting
                    ? Container(
                        width: 150,
                        // margin: const EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                            color: AppColors.PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                                color: AppColors.SECONDARY_COLOR, width: 2)),
                        child: FlatButton(
                          minWidth: 50,
                          height: 50,
                          onPressed: () {
                            createRequest();
                          },
                          child: Row(
                            children: [
                              Text(
                                "Add Member",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        child: Center(
                            child: SpinKitThreeBounce(
                        color: AppColors.SECONDARY_COLOR,
                        size: 25.0,
                      )))
                : Container(),
          ],
        ),
      ),
    );
  }
}
