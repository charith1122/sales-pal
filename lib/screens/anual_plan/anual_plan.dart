import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pros_bot/components/annual_plan/textFiel.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/models/annual_plan/getAnnualPlans.dart';
import 'package:pros_bot/models/annual_plan/plan.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class AnualPlan extends StatefulWidget {
  const AnualPlan({Key key}) : super(key: key);

  // final String title;

  @override
  State<AnualPlan> createState() => _AnualPlanState();
}

class _AnualPlanState extends State<AnualPlan> {
  int selectedVal;

  final today = DateTime.now();

  String _chosenValue = '2023';
  String _lodedYear;

  TextEditingController numberController = TextEditingController();

  List<Plan> plans = [];

  List<BodyOfGetAnnualPlans> savedPlans = [];
  bool isLoading = true;
  bool isSubmitting = false;

  var selectedUser;

  TextEditingController janProsController = TextEditingController();
  TextEditingController janAppController = TextEditingController();
  TextEditingController janSiController = TextEditingController();
  TextEditingController janFuController = TextEditingController();
  TextEditingController janNopController = TextEditingController();
  TextEditingController janAnbpController = TextEditingController();

  TextEditingController febProsController = TextEditingController();
  TextEditingController febAppController = TextEditingController();
  TextEditingController febSiController = TextEditingController();
  TextEditingController febFuController = TextEditingController();
  TextEditingController febNopController = TextEditingController();
  TextEditingController febAnbpController = TextEditingController();

  TextEditingController marProsController = TextEditingController();
  TextEditingController marAppController = TextEditingController();
  TextEditingController marSiController = TextEditingController();
  TextEditingController marFuController = TextEditingController();
  TextEditingController marNopController = TextEditingController();
  TextEditingController marAnbpController = TextEditingController();

  TextEditingController aprlProsController = TextEditingController();
  TextEditingController aprlAppController = TextEditingController();
  TextEditingController aprlSiController = TextEditingController();
  TextEditingController aprlFuController = TextEditingController();
  TextEditingController aprlNopController = TextEditingController();
  TextEditingController aprlAnbpController = TextEditingController();

  TextEditingController mayProsController = TextEditingController();
  TextEditingController mayAppController = TextEditingController();
  TextEditingController maySiController = TextEditingController();
  TextEditingController mayFuController = TextEditingController();
  TextEditingController mayNopController = TextEditingController();
  TextEditingController mayAnbpController = TextEditingController();

  TextEditingController junProsController = TextEditingController();
  TextEditingController junAppController = TextEditingController();
  TextEditingController junSiController = TextEditingController();
  TextEditingController junFuController = TextEditingController();
  TextEditingController junNopController = TextEditingController();
  TextEditingController junAnbpController = TextEditingController();

  TextEditingController julProsController = TextEditingController();
  TextEditingController julAppController = TextEditingController();
  TextEditingController julSiController = TextEditingController();
  TextEditingController julFuController = TextEditingController();
  TextEditingController julNopController = TextEditingController();
  TextEditingController julAnbpController = TextEditingController();

  TextEditingController augProsController = TextEditingController();
  TextEditingController augAppController = TextEditingController();
  TextEditingController augSiController = TextEditingController();
  TextEditingController augFuController = TextEditingController();
  TextEditingController augNopController = TextEditingController();
  TextEditingController augAnbpController = TextEditingController();

  TextEditingController sepProsController = TextEditingController();
  TextEditingController sepAppController = TextEditingController();
  TextEditingController sepSiController = TextEditingController();
  TextEditingController sepFuController = TextEditingController();
  TextEditingController sepNopController = TextEditingController();
  TextEditingController sepAnbpController = TextEditingController();

  TextEditingController octProsController = TextEditingController();
  TextEditingController octAppController = TextEditingController();
  TextEditingController octSiController = TextEditingController();
  TextEditingController octFuController = TextEditingController();
  TextEditingController octNopController = TextEditingController();
  TextEditingController octAnbpController = TextEditingController();

  TextEditingController novProsController = TextEditingController();
  TextEditingController novAppController = TextEditingController();
  TextEditingController novSiController = TextEditingController();
  TextEditingController novFuController = TextEditingController();
  TextEditingController novNopController = TextEditingController();
  TextEditingController novAnbpController = TextEditingController();

  TextEditingController decProsController = TextEditingController();
  TextEditingController decAppController = TextEditingController();
  TextEditingController decSiController = TextEditingController();
  TextEditingController decFuController = TextEditingController();
  TextEditingController decNopController = TextEditingController();
  TextEditingController decAnbpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      _chosenValue = today.year.toString();
      _lodedYear = today.year.toString();

      janAnbpController.text = '0';
      febAnbpController.text = '0';
      marAnbpController.text = '0';
      aprlAnbpController.text = '0';
      mayAnbpController.text = '0';
      junAnbpController.text = '0';
      julAnbpController.text = '0';
      augAnbpController.text = '0';
      sepAnbpController.text = '0';
      octAnbpController.text = '0';
      novAnbpController.text = '0';
      decAnbpController.text = '0';
    });

    getuser();
  }

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    getAnnualPlan();
  }

  setPlanList() {
    plans.clear();

    plans.add(Plan(
        month: 'January',
        pros: janProsController.text != "" ? janProsController.text : "0",
        app: janAppController.text != "" ? janAppController.text : "0",
        sale: janSiController.text != "" ? janSiController.text : "0",
        /*  follow: janFuController.text != "" ? janFuController.text : "0",
        nop: janNopController.text != "" ? janNopController.text : "0", */
        anbp: janNopController.text != "" ? janAnbpController.text : "0"));
    plans.add(Plan(
        month: 'February',
        pros: febProsController.text != "" ? febProsController.text : "0",
        app: febAppController.text != "" ? febAppController.text : "0",
        sale: febSiController.text != "" ? febSiController.text : "0",
        /* follow: febFuController.text != "" ? febFuController.text : "0",
        nop: febNopController.text != "" ? febNopController.text : "0", */
        anbp: febNopController.text != "" ? febAnbpController.text : "0"));
    plans.add(Plan(
        month: 'March',
        pros: marProsController.text != "" ? marProsController.text : "0",
        app: marAppController.text != "" ? marAppController.text : "0",
        sale: marSiController.text != "" ? marSiController.text : "0",
        /* follow: marFuController.text != "" ? marFuController.text : "0",
        nop: marNopController.text != "" ? marNopController.text : "0", */
        anbp: marNopController.text != "" ? marAnbpController.text : "0"));
    plans.add(Plan(
        month: 'April',
        pros: aprlProsController.text != "" ? aprlProsController.text : "0",
        app: aprlAppController.text != "" ? aprlAppController.text : "0",
        sale: aprlSiController.text != "" ? aprlSiController.text : "0",
        /* follow: aprlFuController.text != "" ? aprlFuController.text : "0",
        nop: aprlNopController.text != "" ? aprlNopController.text : "0", */
        anbp: aprlNopController.text != "" ? aprlAnbpController.text : "0"));
    plans.add(Plan(
        month: 'May',
        pros: mayProsController.text != "" ? mayProsController.text : "0",
        app: mayAppController.text != "" ? mayAppController.text : "0",
        sale: maySiController.text != "" ? maySiController.text : "0",
        /* follow: mayFuController.text != "" ? mayFuController.text : "0",
        nop: mayNopController.text != "" ? mayNopController.text : "0", */
        anbp: mayNopController.text != "" ? mayAnbpController.text : "0"));
    plans.add(Plan(
        month: 'June',
        pros: junProsController.text != "" ? junProsController.text : "0",
        app: junAppController.text != "" ? junAppController.text : "0",
        sale: junSiController.text != "" ? junSiController.text : "0",
        /*  follow: junFuController.text != "" ? junFuController.text : "0",
        nop: junNopController.text != "" ? junNopController.text : "0", */
        anbp: junNopController.text != "" ? junAnbpController.text : "0"));
    plans.add(Plan(
        month: 'July',
        pros: julProsController.text != "" ? julProsController.text : "0",
        app: julAppController.text != "" ? julAppController.text : "0",
        sale: julSiController.text != "" ? julSiController.text : "0",
        /*  follow: julFuController.text != "" ? julFuController.text : "0",
        nop: julNopController.text != "" ? julNopController.text : "0", */
        anbp: julNopController.text != "" ? julAnbpController.text : "0"));
    plans.add(Plan(
        month: 'August',
        pros: augProsController.text != "" ? augProsController.text : "0",
        app: augAppController.text != "" ? augAppController.text : "0",
        sale: augSiController.text != "" ? augSiController.text : "0",
        /* follow: augFuController.text != "" ? augFuController.text : "0",
        nop: augNopController.text != "" ? augNopController.text : "0", */
        anbp: augNopController.text != "" ? augAnbpController.text : "0"));
    plans.add(Plan(
        month: 'September',
        pros: sepProsController.text != "" ? sepProsController.text : "0",
        app: sepAppController.text != "" ? sepAppController.text : "0",
        sale: sepSiController.text != "" ? sepSiController.text : "0",
        /* follow: sepFuController.text != "" ? sepFuController.text : "0",
        nop: sepNopController.text != "" ? sepNopController.text : "0", */
        anbp: sepNopController.text != "" ? sepAnbpController.text : "0"));
    plans.add(Plan(
        month: 'October',
        pros: octProsController.text != "" ? octProsController.text : "0",
        app: octAppController.text != "" ? octAppController.text : "0",
        sale: octSiController.text != "" ? octSiController.text : "0",
        /* follow: octFuController.text != "" ? octFuController.text : "0",
        nop: octNopController.text != "" ? octNopController.text : "0", */
        anbp: octNopController.text != "" ? octAnbpController.text : "0"));
    plans.add(Plan(
        month: 'November',
        pros: novProsController.text != "" ? novProsController.text : "0",
        app: novAppController.text != "" ? novAppController.text : "0",
        sale: novSiController.text != "" ? novSiController.text : "0",
        /* follow: novFuController.text != "" ? novFuController.text : "0",
        nop: novNopController.text != "" ? novNopController.text : "0", */
        anbp: novNopController.text != "" ? novAnbpController.text : "0"));
    plans.add(Plan(
        month: 'December',
        pros: decProsController.text != "" ? decProsController.text : "0",
        app: decAppController.text != "" ? decAppController.text : "0",
        sale: decSiController.text != "" ? decSiController.text : "0",
        /* follow: decFuController.text != "" ? decFuController.text : "0",
        nop: decNopController.text != "" ? decNopController.text : "0", */
        anbp: decNopController.text != "" ? decAnbpController.text : "0"));

    // print(plans);
  }

  createNewPlanList() async {
    setState(() {
      isSubmitting = true;
    });
    await setPlanList();

    var result = await APIs().createAnnualPlan(
        user_id: selectedUser["body"]["id"],
        year: _chosenValue,
        children: plans);
    // print(result);
    if (result.done != null) {
      if (result.done) {
        setState(() {
          isSubmitting = false;
        });
      } else {
        setState(() {
          isSubmitting = false;
        });
        errorMessage(
            message: result.message != '' || result.message != null
                ? result.message
                : 'Please Try again Later');
      }
    } else {
      setState(() {
        isSubmitting = false;
      });
      errorMessage(
          message: result.message != '' || result.message != null
              ? result.message
              : 'Please Try again Later');
    }
  }

  getAnnualPlan() async {
    try {
      savedPlans.clear();
      await APIs()
          .getAnnualPlans(
              userId: selectedUser["body"]["id"], year: _chosenValue)
          .then((value) {
        value.body.forEach((item) {
          savedPlans.add(item);
        });
        if (savedPlans.isNotEmpty) {
          setDataFields();
        } else {
          setTextFieldsNull();
        }
        setState(() {
          _lodedYear = _chosenValue;
          isLoading = false;
        });
        print(savedPlans);
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  setDataFields() {
    for (int a = 0; a < savedPlans.length; a++) {
      if (savedPlans[a].month == 'January') {
        setState(() {
          janProsController.text = savedPlans[a].pros;
          janAppController.text = savedPlans[a].app;
          janSiController.text = savedPlans[a].sale;
          /* janFuController.text = savedPlans[a].follow;
          janNopController.text = savedPlans[a].nop; */
          janAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'February') {
        setState(() {
          febProsController.text = savedPlans[a].pros;
          febAppController.text = savedPlans[a].app;
          febSiController.text = savedPlans[a].sale;
          /*  febFuController.text = savedPlans[a].follow;
          febNopController.text = savedPlans[a].nop; */
          febAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'March') {
        setState(() {
          marProsController.text = savedPlans[a].pros;
          marAppController.text = savedPlans[a].app;
          marSiController.text = savedPlans[a].sale;
          /*  marFuController.text = savedPlans[a].follow;
          marNopController.text = savedPlans[a].nop; */
          marAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'April') {
        setState(() {
          aprlProsController.text = savedPlans[a].pros;
          aprlAppController.text = savedPlans[a].app;
          aprlSiController.text = savedPlans[a].sale;
          /* aprlFuController.text = savedPlans[a].follow;
          aprlNopController.text = savedPlans[a].nop; */
          aprlAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'May') {
        setState(() {
          mayProsController.text = savedPlans[a].pros;
          mayAppController.text = savedPlans[a].app;
          maySiController.text = savedPlans[a].sale;
          /*   mayFuController.text = savedPlans[a].follow;
          mayNopController.text = savedPlans[a].nop; */
          mayAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'June') {
        setState(() {
          junProsController.text = savedPlans[a].pros;
          junAppController.text = savedPlans[a].app;
          junSiController.text = savedPlans[a].sale;
          /* junFuController.text = savedPlans[a].follow;
          junNopController.text = savedPlans[a].nop; */
          junAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'July') {
        setState(() {
          julProsController.text = savedPlans[a].pros;
          julAppController.text = savedPlans[a].app;
          julSiController.text = savedPlans[a].sale;
          /*  julFuController.text = savedPlans[a].follow;
          julNopController.text = savedPlans[a].nop; */
          julAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'August') {
        setState(() {
          augProsController.text = savedPlans[a].pros;
          augAppController.text = savedPlans[a].app;
          augSiController.text = savedPlans[a].sale;
          /* augFuController.text = savedPlans[a].follow;
          augNopController.text = savedPlans[a].nop; */
          augAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'September') {
        setState(() {
          sepProsController.text = savedPlans[a].pros;
          sepAppController.text = savedPlans[a].app;
          sepSiController.text = savedPlans[a].sale;
          /* sepFuController.text = savedPlans[a].follow;
          sepNopController.text = savedPlans[a].nop; */
          sepAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'October') {
        setState(() {
          octProsController.text = savedPlans[a].pros;
          octAppController.text = savedPlans[a].app;
          octSiController.text = savedPlans[a].sale;
          /*  octFuController.text = savedPlans[a].follow;
          octNopController.text = savedPlans[a].nop; */
          octAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'November') {
        setState(() {
          novProsController.text = savedPlans[a].pros;
          novAppController.text = savedPlans[a].app;
          novSiController.text = savedPlans[a].sale;
          /* novFuController.text = savedPlans[a].follow;
          novNopController.text = savedPlans[a].nop; */
          novAnbpController.text = savedPlans[a].anbp;
        });
      } else if (savedPlans[a].month == 'December') {
        setState(() {
          decProsController.text = savedPlans[a].pros;
          decAppController.text = savedPlans[a].app;
          decSiController.text = savedPlans[a].sale;
          /*  decFuController.text = savedPlans[a].follow;
          decNopController.text = savedPlans[a].nop; */
          decAnbpController.text = savedPlans[a].anbp;
        });
      } else {
        // setTextFieldsNull();
      }
    }
  }

  setTextFieldsNull() {
    setState(() {
      janProsController.text = '0';
      janAppController.text = '0';
      janSiController.text = '0';
      janFuController.text = '0';
      janNopController.text = '0';
      janAnbpController.text = '0';
      febProsController.text = '0';
      febAppController.text = '0';
      febSiController.text = '0';
      febFuController.text = '0';
      febNopController.text = '0';
      febAnbpController.text = '0';
      marProsController.text = '0';
      marAppController.text = '0';
      marSiController.text = '0';
      marFuController.text = '0';
      marNopController.text = '0';
      marAnbpController.text = '0';
      aprlProsController.text = '0';
      aprlAppController.text = '0';
      aprlSiController.text = '0';
      aprlFuController.text = '0';
      aprlNopController.text = '0';
      aprlAnbpController.text = '0';
      mayProsController.text = '0';
      mayAppController.text = '0';
      maySiController.text = '0';
      mayFuController.text = '0';
      mayNopController.text = '0';
      mayAnbpController.text = '0';
      junProsController.text = '0';
      junAppController.text = '0';
      junSiController.text = '0';
      junFuController.text = '0';
      junNopController.text = '0';
      junAnbpController.text = '0';
      julProsController.text = '0';
      julAppController.text = '0';
      julSiController.text = '0';
      julFuController.text = '0';
      julNopController.text = '0';
      julAnbpController.text = '0';
      augProsController.text = '0';
      augAppController.text = '0';
      augSiController.text = '0';
      augFuController.text = '0';
      augNopController.text = '0';
      augAnbpController.text = '0';
      sepProsController.text = '0';
      sepAppController.text = '0';
      sepSiController.text = '0';
      sepFuController.text = '0';
      sepNopController.text = '0';
      sepAnbpController.text = '0';
      octProsController.text = '0';
      octAppController.text = '0';
      octSiController.text = '0';
      octFuController.text = '0';
      octNopController.text = '0';
      octAnbpController.text = '0';
      novProsController.text = '0';
      novAppController.text = '0';
      novSiController.text = '0';
      novFuController.text = '0';
      novNopController.text = '0';
      novAnbpController.text = '0';
      decProsController.text = '0';
      decAppController.text = '0';
      decSiController.text = '0';
      decFuController.text = '0';
      decNopController.text = '0';
      decAnbpController.text = '0';
    });
  }

  showNumberDialog({BuildContext context, TextEditingController txtControl}) {
    final size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: AppColors.SECONDARY_COLOR,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here

            child: Container(
              padding: const EdgeInsets.all(10),
              // height: 400, //280,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Insert Value',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          numberController.clear();
                        });
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: numberController,

                    style:
                        TextStyle(fontSize: 12, color: AppColors.PRIMARY_COLOR),
                    // obscureText: obsecure,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorMaxLines: 2,
                      errorStyle: TextStyle(
                          color: Color.fromARGB(255, 182, 40, 30),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          overflow: TextOverflow.fade),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      labelText: 'Number',
                      labelStyle: AppStyles.labelStyle,
                      floatingLabelStyle: AppStyles.floatingLabelStyle,
                      contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    ),

                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      setState(() {});
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(),
                      ),
                      onPressed: () {
                        setState(() {
                          txtControl.text = numberController.text;
                        });
                        Navigator.pop(context);
                        setState(() {
                          numberController.clear();
                        });
                      },
                      child: const Text('OK'),
                    ),
                  ],
                )
              ]),
            ),
          );
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
              color: Colors.black,
            ),
            onPressed: () {}
            // scaffoldKey.currentState.openDrawer(),
            ), */
        actions: [
          IconButton(
              icon: Icon(
                Icons.home_filled,
                size: 30,
                color: AppColors.SECONDARY_COLOR,
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
        title: Text('Anual Plan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: isLoading
          ? Container(
              child: Center(
              child: SpinKitCubeGrid(
                color: AppColors.SECONDARY_COLOR,
                size: 50.0,
              ),
            ))
          : ListView(
              children: [
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 0.5)),
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _chosenValue,
                        elevation: 5,
                        underline: Container(color: Colors.transparent),
                        style: TextStyle(color: Colors.black),
                        // items: dropdownItems,
                        items: <String>[
                          '2022',
                          '2023',
                          '2024',
                          '2025',
                          '2026',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: Text(
                          "Reason",
                          style: TextStyle(
                              // color: Colors.black,
                              // fontSize: 16,
                              // fontWeight: FontWeight.w600
                              ),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _chosenValue = value;
                            if (_lodedYear != _chosenValue) {
                              setState(() {
                                isLoading = true;
                              });
                              getAnnualPlan();
                            }
                          });
                        },
                      ),
                    ),
                    isSubmitting
                        ? Container(
                            child: Center(
                            child: SpinKitThreeBounce(
                              color: AppColors.SECONDARY_COLOR,
                              size: 32.0,
                            ),
                          ))
                        : Container(
                            // margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                color: AppColors.PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                    color: AppColors.SECONDARY_COLOR,
                                    width: 2)),
                            child: FlatButton(
                              height: 45,
                              // minWidth: size.width,
                              onPressed: () {
                                // print('object');
                                createNewPlanList();
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.PRYMARY_COLOR2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                    /* Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: _lodedYear == _chosenValue
                              ? Colors.grey.withOpacity(.8)
                              : AppColors.PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(
                              color: AppColors.SECONDARY_COLOR, width: 2)),
                      child: FlatButton(
                        height: 50,
                        minWidth: 120,
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          getAnnualPlan();
                        },
                        child: Text(
                          "Load Data",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ), */
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // margin: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width - 124,
                          child: Table(
                            border: TableBorder.all(
                                color: AppColors.SECONDARY_COLOR),
                            columnWidths: const <int, TableColumnWidth>{
                              0: IntrinsicColumnWidth(),
                              // 1: FlexColumnWidth(25),
                              //1: FixedColumnWidth(40),
                              //2: FixedColumnWidth(40),
                              // 3: FixedColumnWidth(40),
                              //4: FixedColumnWidth(40),
                              //5: FixedColumnWidth(40),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: <TableRow>[
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 70,
                                        child: Center(child: Text('Month'))),
                                  ),
                                  TableCell(
                                    child: Center(child: Text('Cust:')),
                                  ),
                                  TableCell(
                                    child: Center(child: Text('App:')),
                                  ),
                                  TableCell(
                                    child: Center(child: Text('S.I:')),
                                  ),
                                  /*  TableCell(
                                    child: Center(child: Text('F.Up')),
                                  ), */
                                  /* TableCell(
                                    child: Center(child: Text('NOP')),
                                  ), */
                                ],
                              ),
                              // January
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('Jan'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: janProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: janProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: janAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: janAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: janSiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: janSiController);
                                          },
                                          context: context)),
                                  /*  TableCell(
                                      child: reportText(
                                          txtControl: janFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: janFuController);
                                          },
                                          context: context)), */
                                  /* TableCell(
                                      child: reportText(
                                          txtControl: janNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: janNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                              //February
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('Feb'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: febProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: febProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: febAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: febAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: febSiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: febSiController);
                                          },
                                          context: context)),
                                  /*  TableCell(
                                      child: reportText(
                                          txtControl: febFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: febFuController);
                                          },
                                          context: context)), */
                                  /* TableCell(
                                      child: reportText(
                                          txtControl: febNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: febNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                              //March
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('Mar'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: marProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: marProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: marAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: marAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: marSiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: marSiController);
                                          },
                                          context: context)),
                                  /* TableCell(
                                      child: reportText(
                                          txtControl: marFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: marFuController);
                                          },
                                          context: context)), */
                                  /*  TableCell(
                                      child: reportText(
                                          txtControl: marNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: marNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                              //April
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('Apr'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: aprlProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: aprlProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: aprlAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: aprlAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: aprlSiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: aprlSiController);
                                          },
                                          context: context)),
                                  /* TableCell(
                                      child: reportText(
                                          txtControl: aprlFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: aprlFuController);
                                          },
                                          context: context)), */
                                  /*  TableCell(
                                      child: reportText(
                                          txtControl: aprlNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: aprlNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                              //May
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('May'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: mayProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: mayProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: mayAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: mayAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: maySiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: maySiController);
                                          },
                                          context: context)),
                                  /*  TableCell(
                                      child: reportText(
                                          txtControl: mayFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: mayFuController);
                                          },
                                          context: context)), */
                                  /*   TableCell(
                                      child: reportText(
                                          txtControl: mayNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: mayNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                              //June
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('Jun'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: junProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: junProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: junAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: junAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: junSiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: junSiController);
                                          },
                                          context: context)),
                                  /*  TableCell(
                                      child: reportText(
                                          txtControl: junFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: junFuController);
                                          },
                                          context: context)), */
                                  /*   TableCell(
                                      child: reportText(
                                          txtControl: junNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: junNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                              //July
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('Jul'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: julProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: julProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: julAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: julAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: julSiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: julSiController);
                                          },
                                          context: context)),
                                  /*  TableCell(
                                      child: reportText(
                                          txtControl: julFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: julFuController);
                                          },
                                          context: context)), */
                                  /* TableCell(
                                      child: reportText(
                                          txtControl: julNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: julNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                              //August
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('Aug'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: augProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: augProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: augAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: augAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: augSiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: augSiController);
                                          },
                                          context: context)),
                                  /* TableCell(
                                      child: reportText(
                                          txtControl: augFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: augFuController);
                                          },
                                          context: context)), */
                                  /* TableCell(
                                      child: reportText(
                                          txtControl: augNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: augNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                              // September
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('Sept'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: sepProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: sepProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: sepAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: sepAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: sepSiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: sepSiController);
                                          },
                                          context: context)),
                                  /*   TableCell(
                                      child: reportText(
                                          txtControl: sepFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: sepFuController);
                                          },
                                          context: context)), */
                                  /*   TableCell(
                                      child: reportText(
                                          txtControl: sepNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: sepNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                              // October
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('Oct:'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: octProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: octProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: octAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: octAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: octSiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: octSiController);
                                          },
                                          context: context)),
                                  /*  TableCell(
                                      child: reportText(
                                          txtControl: octFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: octFuController);
                                          },
                                          context: context)), */
                                  /*   TableCell(
                                      child: reportText(
                                          txtControl: octNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: octNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                              // November
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('Nov'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: novProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: novProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: novAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: novAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: novSiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: novSiController);
                                          },
                                          context: context)),
                                  /* TableCell(
                                      child: reportText(
                                          txtControl: novFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: novFuController);
                                          },
                                          context: context)), */
                                  /* TableCell(
                                      child: reportText(
                                          txtControl: novNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: novNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                              // December
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                        height: 50,
                                        child: Center(child: Text('Dec'))),
                                  ),
                                  TableCell(
                                      child: reportText(
                                          txtControl: decProsController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: decProsController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: decAppController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: decAppController);
                                          },
                                          context: context)),
                                  TableCell(
                                      child: reportText(
                                          txtControl: decSiController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: decSiController);
                                          },
                                          context: context)),
                                  /*  TableCell(
                                      child: reportText(
                                          txtControl: decFuController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: decFuController);
                                          },
                                          context: context)), */
                                  /*   TableCell(
                                      child: reportText(
                                          txtControl: decNopController,
                                          function: () {
                                            showNumberDialog(
                                                context: context,
                                                txtControl: decNopController);
                                          },
                                          context: context)), */
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Column(
                            children: [
                              Table(
                                  border: TableBorder.all(
                                      color: AppColors.SECONDARY_COLOR),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: <TableRow>[
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                              height: 35,
                                              child:
                                                  Center(child: Text('ANBP:'))),
                                        ),
                                      ],
                                    ),
                                  ]),
                              Table(
                                  border: TableBorder.all(
                                      color: AppColors.SECONDARY_COLOR),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: <TableRow>[
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                              height: 35,
                                              child:
                                                  Center(child: Text('Month'))),
                                        ),
                                        TableCell(
                                          child: Center(child: Text('Total')),
                                        ),
                                      ],
                                    ),
                                    //january
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: janAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        janAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text(
                                                    janAnbpController.text))),
                                      ],
                                    ),
                                    //Feb
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: febAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        febAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text((int.parse(
                                                            janAnbpController
                                                                .text) +
                                                        int.parse(
                                                            febAnbpController
                                                                .text))
                                                    .toString()))),
                                      ],
                                    ),
                                    //March
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: marAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        marAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text((int.parse(
                                                            janAnbpController
                                                                .text) +
                                                        int.parse(
                                                            febAnbpController
                                                                .text) +
                                                        int.parse(
                                                            marAnbpController
                                                                .text))
                                                    .toString()))),
                                      ],
                                    ),
                                    // April
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: aprlAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        aprlAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text((int.parse(
                                                            janAnbpController
                                                                .text) +
                                                        int.parse(
                                                            febAnbpController
                                                                .text) +
                                                        int.parse(
                                                            marAnbpController
                                                                .text) +
                                                        int.parse(
                                                            aprlAnbpController
                                                                .text))
                                                    .toString()))),
                                      ],
                                    ),
                                    // May
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: mayAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        mayAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text((int.parse(
                                                            janAnbpController
                                                                .text) +
                                                        int.parse(
                                                            febAnbpController
                                                                .text) +
                                                        int.parse(
                                                            marAnbpController
                                                                .text) +
                                                        int.parse(
                                                            aprlAnbpController
                                                                .text) +
                                                        int.parse(
                                                            mayAnbpController
                                                                .text))
                                                    .toString()))),
                                      ],
                                    ),
                                    // june
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: junAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        junAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text((int.parse(
                                                            janAnbpController
                                                                .text) +
                                                        int.parse(
                                                            febAnbpController
                                                                .text) +
                                                        int.parse(
                                                            marAnbpController
                                                                .text) +
                                                        int.parse(
                                                            aprlAnbpController
                                                                .text) +
                                                        int.parse(
                                                            mayAnbpController
                                                                .text) +
                                                        int.parse(
                                                            junAnbpController
                                                                .text))
                                                    .toString()))),
                                      ],
                                    ),
                                    // july
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: julAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        julAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text((int.parse(
                                                            janAnbpController
                                                                .text) +
                                                        int.parse(
                                                            febAnbpController
                                                                .text) +
                                                        int.parse(
                                                            marAnbpController
                                                                .text) +
                                                        int.parse(
                                                            aprlAnbpController
                                                                .text) +
                                                        int.parse(
                                                            mayAnbpController
                                                                .text) +
                                                        int.parse(
                                                            junAnbpController
                                                                .text) +
                                                        int.parse(
                                                            julAnbpController
                                                                .text))
                                                    .toString()))),
                                      ],
                                    ),
                                    // aug
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: augAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        augAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text((int.parse(
                                                            janAnbpController
                                                                .text) +
                                                        int.parse(
                                                            febAnbpController
                                                                .text) +
                                                        int.parse(
                                                            marAnbpController
                                                                .text) +
                                                        int.parse(
                                                            aprlAnbpController
                                                                .text) +
                                                        int.parse(
                                                            mayAnbpController
                                                                .text) +
                                                        int.parse(
                                                            junAnbpController
                                                                .text) +
                                                        int.parse(
                                                            julAnbpController
                                                                .text) +
                                                        int.parse(
                                                            augAnbpController.text))
                                                    .toString()))),
                                      ],
                                    ),
                                    // sep
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: sepAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        sepAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text((int.parse(
                                                            janAnbpController
                                                                .text) +
                                                        int.parse(febAnbpController
                                                            .text) +
                                                        int.parse(
                                                            marAnbpController
                                                                .text) +
                                                        int.parse(
                                                            aprlAnbpController
                                                                .text) +
                                                        int.parse(
                                                            mayAnbpController
                                                                .text) +
                                                        int.parse(
                                                            junAnbpController
                                                                .text) +
                                                        int.parse(
                                                            julAnbpController
                                                                .text) +
                                                        int.parse(
                                                            augAnbpController.text) +
                                                        int.parse(sepAnbpController.text))
                                                    .toString()))),
                                      ],
                                    ),
                                    // oct
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: octAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        octAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text((int.parse(
                                                            janAnbpController
                                                                .text) +
                                                        int.parse(
                                                            febAnbpController
                                                                .text) +
                                                        int.parse(
                                                            marAnbpController
                                                                .text) +
                                                        int.parse(
                                                            aprlAnbpController
                                                                .text) +
                                                        int.parse(
                                                            mayAnbpController
                                                                .text) +
                                                        int.parse(
                                                            junAnbpController
                                                                .text) +
                                                        int.parse(
                                                            julAnbpController
                                                                .text) +
                                                        int.parse(
                                                            augAnbpController.text) +
                                                        int.parse(sepAnbpController.text) +
                                                        int.parse(octAnbpController.text))
                                                    .toString()))),
                                      ],
                                    ),
                                    // nov
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: novAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        novAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text((int.parse(
                                                            janAnbpController
                                                                .text) +
                                                        int.parse(febAnbpController
                                                            .text) +
                                                        int.parse(
                                                            marAnbpController
                                                                .text) +
                                                        int.parse(
                                                            aprlAnbpController
                                                                .text) +
                                                        int.parse(
                                                            mayAnbpController
                                                                .text) +
                                                        int.parse(
                                                            junAnbpController
                                                                .text) +
                                                        int.parse(
                                                            julAnbpController
                                                                .text) +
                                                        int.parse(
                                                            augAnbpController.text) +
                                                        int.parse(sepAnbpController.text) +
                                                        int.parse(octAnbpController.text) +
                                                        int.parse(novAnbpController.text))
                                                    .toString()))),
                                      ],
                                    ),
                                    // dec
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          height: 50,
                                          child: reportText(
                                              txtControl: decAnbpController,
                                              function: () {
                                                showNumberDialog(
                                                    context: context,
                                                    txtControl:
                                                        decAnbpController);
                                              },
                                              context: context),
                                        )),
                                        TableCell(
                                            child: Center(
                                                child: Text((int.parse(
                                                            janAnbpController
                                                                .text) +
                                                        int.parse(febAnbpController
                                                            .text) +
                                                        int.parse(
                                                            marAnbpController
                                                                .text) +
                                                        int.parse(
                                                            aprlAnbpController
                                                                .text) +
                                                        int.parse(
                                                            mayAnbpController
                                                                .text) +
                                                        int.parse(
                                                            junAnbpController
                                                                .text) +
                                                        int.parse(
                                                            julAnbpController
                                                                .text) +
                                                        int.parse(
                                                            augAnbpController.text) +
                                                        int.parse(sepAnbpController.text) +
                                                        int.parse(octAnbpController.text) +
                                                        int.parse(novAnbpController.text) +
                                                        int.parse(decAnbpController.text))
                                                    .toString()))),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                isSubmitting
                    ? Container(
                        child: Center(
                        child: SpinKitThreeBounce(
                          color: AppColors.SECONDARY_COLOR,
                          size: 40.0,
                        ),
                      ))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                color: AppColors.PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                    color: AppColors.SECONDARY_COLOR,
                                    width: 2)),
                            child: FlatButton(
                              height: 50,
                              // minWidth: size.width,
                              onPressed: () {
                                // print('object');
                                createNewPlanList();
                              },
                              child: Text(
                                "Submit",
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
                SizedBox(height: 15),
              ],
            ),
    );
  }
}
