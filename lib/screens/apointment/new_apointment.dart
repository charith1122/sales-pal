// import 'package:email_validator/email_validator.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pros_bot/components/auth/textField.dart';
import 'package:pros_bot/components/common/label.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/components/todo/date_picker.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/models/appointments/get_appointment_by_id.dart';
import 'package:pros_bot/models/auth/get_company.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/models/prospect/prospect_by_id.dart';
import 'package:pros_bot/screens/apointment/appointment.dart';
import 'package:pros_bot/screens/apointment/appointment_new.dart';
import 'package:pros_bot/screens/authentication/otp_screen.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/to_do_list/to_do_list.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class NewAppointment extends StatefulWidget {
  final String id;
  bool todo;
  NewAppointment({this.id, this.todo = false});
  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  TextEditingController deliverTimePickController = new TextEditingController();
  TextEditingController deliverDatePickController = new TextEditingController();
  String addressHome = "";
  String addressWork = "";
  // String dropdownValue = "";
  String setDeliveryTime = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  DateFormat dtFormatter = DateFormat('yyyy-MM-dd');
  DateFormat tmFormatter = DateFormat('HH:mm');

  // List<BodyOfGetCompany> companies = [];

  String _chosenValue;
  String selectedValue;

  var selectedUser;
  List<BodyOfGetProspects> prospects = [];

  GetAppointmentById appointment;

  // String myCompany;
  String selected;
  String selectedName;

  bool isLoading = true;
  bool isSubmitting = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getuser();

    // checkIsEdit();
  }

  getuser() async {
    selectedUser = await getUserAuthPref(key: "userAuth");
    print(selectedUser);
    getProspects();
    if (widget.id != null) {
      setState(() {
        isLoading = true;
      });
      getAppointmentById();
    }
  }

  getProspects() async {
    try {
      await APIs()
          .getProspectsWithNoAppoints(userId: selectedUser["body"]["id"])
          .then((value) {
        if (value.done) {
          value.body.forEach((item) {
            prospects.add(item);
          });
          setState(() {
            isLoading = false;
          });
        } else {
          errorMessage(message: value.message);
          setState(() {
            isLoading = false;
          });
          Navigator.of(context, rootNavigator: true).pop();
        }
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  getAppointmentById() async {
    try {
      await APIs()
          .getAppointmentId(userId: selectedUser["body"]["id"], id: widget.id)
          .then((value) async {
        if (value.done != null) {
          appointment = new GetAppointmentById.fromJson(value.toJson());
          if (appointment.done == true) {
            setState(() {
              isLoading = false;

              selected = appointment.body.prospectId;
              selectedName = appointment.body.prosName;
              deliverDatePickController.text =
                  dtFormatter.format(DateTime.parse(appointment.body.date));
              deliverTimePickController.text = DateFormat("HH:mm")
                  .format(DateFormat("hh:mm a").parse(appointment.body.time));
            });
          } else {
            await EasyLoading.dismiss();
            errorMessage(message: value.message);
            setState(() {
              isLoading = false;
            });
            Navigator.of(context, rootNavigator: true).pop();
          }
        } else {
          await EasyLoading.dismiss();
          errorMessage(message: value.message);
          setState(() {
            isLoading = false;
          });
          Navigator.of(context, rootNavigator: true).pop();
        }
        // print(appointments);
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  createAppointment() async {
    // if (descriptionController.text != '' || base64Image.toString() != null) {
    setState(() {
      isSubmitting = true;
    });
    var result = await APIs().createAppointment(
        user_id: selectedUser["body"]["id"],
        pros_id: selected,
        time: deliverTimePickController.text,
        date: deliverDatePickController.text);
    if (result.done != null) {
      if (result.done) {
        setState(() {
          isSubmitting = false;
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
        );
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => AppointmentMain(),
        ));
        successMessage(message: 'Succesfully created');
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
    /* } else {
      messageToastRed('Description or Media URL is required');
    } */
  }

  updateAppointment() async {
    /*  if (nameController.text == '' ||
        phoneController.text == null) {
      errorMessage(
          message: 'Name,NIC,Address and phone number fields are required');
    } else { */
    setState(() {
      isSubmitting = true;
    });
    var result = await APIs().updateAppointmentById(
        id: widget.id,
        pros_id: selected != null ? selected : appointment.body.prospectId,
        time: deliverTimePickController.text,
        date: deliverDatePickController.text,
        status: 'Active');
    // print(result);
    if (result.done != null) {
      if (result.done) {
        setState(() {
          isSubmitting = false;
        });
        successMessage(
            message: result.message != '' || result.message != null
                ? result.message
                : 'Successfully Updated');
        // widget.getProspects;
        if (widget.todo) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ToDoList(),
          ));
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => AppointmentMain(),
          ));
        }

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
    /* } else {
      messageToastRed('Description or Media URL is required');
    } */
    // }
  }

  //function of date selector
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: selectedDate,
      firstDate: DateTime(-100),
      lastDate: DateTime(5000),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.PRIMARY_COLOR, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: AppColors.PRIMARY_COLOR, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.PRIMARY_COLOR, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      // selectTime(context);
      DateTime dt = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      DateFormat formatter = DateFormat('yyyy-MM-dd EEEE HH:mm a');
      DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
      DateFormat timeFormatter = DateFormat('HH:mm ');

      String formatted = formatter.format(dt);
      this.setDeliveryTime = formatted;

      String dateFormatted = dateFormatter.format(dt);
      String timeFormatted = timeFormatter.format(dt);

      deliverTimePickController.text = timeFormatted;
      deliverDatePickController.text = dateFormatted;
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.PRIMARY_COLOR, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: AppColors.PRIMARY_COLOR, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.PRIMARY_COLOR, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        DateTime dt = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        DateFormat formatter = DateFormat('yyyy-MM-dd EEEE HH:mm a');

        DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
        DateFormat timeFormatter = DateFormat('HH:mm');

        String formatted = formatter.format(dt);
        // this.setDeliveryTime = formatted;

        String dateFormatted = dateFormatter.format(dt);
        String timeFormatted = timeFormatter.format(dt);

        deliverTimePickController.text = timeFormatted;
        deliverDatePickController.text = dateFormatted;

        // deliverTimePickController.text = formatted;
        // deliverDatePickController.text = formatted;
      });
      setState(() {
        selectedTime = picked;
        DateTime dt = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour - 5,
          selectedTime.minute - 30,
        );
        DateFormat formatter = DateFormat('yyyy-MM-dd EEEE HH:mm a');
        String formatted = formatter.format(dt);
        this.setDeliveryTime = formatted;
        print(setDeliveryTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(),
      child: Scaffold(
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
          title: Text('New Appoinment',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          // automaticallyImplyLeading: false,
        ),
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
            : Container(
                height: size.height,
                width: double.infinity,
                color: AppColors.PRIMARY_COLOR,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40.0, left: 15, right: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            labelText(label: 'Name'),
                            Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.SECONDARY_COLOR,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(width: 0.5)),
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: CustomSearchableDropDown(
                                dropdownHintText: 'Search For Name Here... ',
                                showLabelInMenu: false,
                                primaryColor: AppColors.PRIMARY_COLOR,
                                menuMode: false,
                                items: prospects,
                                label: selectedName,
                                labelStyle:
                                    TextStyle(color: AppColors.PRIMARY_COLOR),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(Icons.search),
                                ),
                                dropDownMenuItems: prospects?.map((item) {
                                      return item.name;
                                    })?.toList() ??
                                    [],
                                onChanged: (value) {
                                  if (value != null) {
                                    selected = value.id.toString();
                                  } else {
                                    selected = null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            labelText(label: 'Date'),
                            DatePickerContainer(
                              child: GestureDetector(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(left: 15.0),
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: AppColors.SECONDARY_COLOR,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(width: 0.5)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          deliverDatePickController.text,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.PRIMARY_COLOR),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      MaterialButton(
                                        height: 50,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(50),
                                              topRight: Radius.circular(50),
                                            ),
                                            side: BorderSide(
                                                color:
                                                    AppColors.SECONDARY_COLOR,
                                                width: 2)),
                                        onPressed: () => _selectDate(context),
                                        color: AppColors.PRIMARY_COLOR,
                                        child: Text(
                                          "Change Date",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.SECONDARY_COLOR),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            labelText(label: 'Time'),
                            DatePickerContainer(
                              child: GestureDetector(
                                onTap: () => selectTime(context),
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(left: 15.0),
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: AppColors.SECONDARY_COLOR,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(width: 0.5)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          deliverTimePickController.text,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.PRIMARY_COLOR),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      MaterialButton(
                                        height: 50,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(50),
                                              topRight: Radius.circular(50),
                                            ),
                                            side: BorderSide(
                                                color:
                                                    AppColors.SECONDARY_COLOR,
                                                width: 2)),
                                        onPressed: () => selectTime(context),
                                        color: AppColors.PRIMARY_COLOR,
                                        child: Text(
                                          "Change Time",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.SECONDARY_COLOR),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            SizedBox(height: 20),
                            isSubmitting
                                ? Container(
                                    child: Center(
                                    child: SpinKitThreeBounce(
                                      color: AppColors.SECONDARY_COLOR,
                                      size: 25.0,
                                    ),
                                  ))
                                : Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.PRIMARY_COLOR,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        border: Border.all(
                                            color: AppColors.SECONDARY_COLOR,
                                            width: 2)),
                                    child: FlatButton(
                                      height: 50,
                                      // minWidth: size.width,
                                      onPressed: () {
                                        widget.id == null
                                            ? createAppointment()
                                            : updateAppointment();

                                        print(_chosenValue);
                                      },
                                      child: Text(
                                        widget.id == null
                                            ? "Submit"
                                            : "Save Changes",
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
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
