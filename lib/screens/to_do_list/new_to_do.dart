// import 'package:email_validator/email_validator.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pros_bot/components/auth/textField.dart';
import 'package:pros_bot/components/common/label.dart';
import 'package:pros_bot/components/common/messages.dart';
import 'package:pros_bot/components/todo/date_picker.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/constants/styles.dart';
import 'package:pros_bot/models/appointments/get_appointment_by_id.dart';
import 'package:pros_bot/models/prospect/get_prospects.dart';
import 'package:pros_bot/screens/authentication/otp_screen.dart';
import 'package:pros_bot/screens/home/home.dart';
import 'package:pros_bot/screens/to_do_list/to_do_list.dart';
import 'package:pros_bot/services/api.dart';
import 'package:pros_bot/services/localStorage/UserAuthenticationService.dart';

class NewToDo extends StatefulWidget {
  final String id;
  NewToDo({
    this.id,
  });
  @override
  _NewToDoState createState() => _NewToDoState();
}

class _NewToDoState extends State<NewToDo> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  TextEditingController deliverTimePickController = new TextEditingController();
  TextEditingController deliverDatePickController = new TextEditingController();
  String addressHome = "";
  String addressWork = "";
  // String dropdownValue = "";
  String setDeliveryTime = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  String _chosenValue;
  String selected;
  String selectedName;

  DateFormat dtFormatter = DateFormat('yyyy-MM-dd');

  var selectedUser;
  List<BodyOfGetProspects> prospects = [];
  GetAppointmentById todo;
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
      getTodoById();
    }
  }

  getProspects() async {
    try {
      await APIs()
          .getProspects(userId: selectedUser["body"]["id"])
          .then((value) {
        value.body.forEach((item) {
          prospects.add(item);
        });
        print(prospects);
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  getTodoById() async {
    try {
      await APIs()
          .getTodoById(userId: selectedUser["body"]["id"], id: widget.id)
          .then((value) async {
        if (value.done != null) {
          todo = new GetAppointmentById.fromJson(value.toJson());
          if (todo.done == true) {
            setState(() {
              isLoading = false;

              selected = todo.body.prospectId;
              noteController.text = todo.body.note;
              selectedName = todo.body.prosName;
              deliverDatePickController.text =
                  dtFormatter.format(DateTime.parse(todo.body.date));
              deliverTimePickController.text = DateFormat("HH:mm")
                  .format(DateFormat("HH:mm").parse(todo.body.time));
              _chosenValue = todo.body.reason;
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

  createTodo() async {
    if (selected == null &&
        (noteController.text == null || noteController.text == "")) {
      errorMessage(message: 'Atleast one from Name or Note is required');
    } else {
      if (_chosenValue == '' ||
          _chosenValue == null ||
          deliverDatePickController.text == '' ||
          deliverDatePickController == null ||
          deliverTimePickController.text == '' ||
          deliverTimePickController.text == null) {
        errorMessage(message: 'All Fields are required');
      } else {
        setState(() {
          isSubmitting = true;
        });
        var result = await APIs().createTodo(
            user_id: selectedUser["body"]["id"],
            pros_id: selected,
            time: deliverTimePickController.text,
            date: deliverDatePickController.text,
            note: noteController.text,
            reason: _chosenValue);
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
              builder: (BuildContext context) => ToDoList(),
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
    }
  }

  updateAppointment() async {
    if (selected == null &&
        (noteController.text == null || noteController.text == "")) {
      errorMessage(message: 'Atleast one from Name or Note is required');
    } else {
      if (deliverDatePickController.text == '' ||
          deliverDatePickController == null ||
          deliverTimePickController.text == '' ||
          deliverTimePickController.text == null ||
          _chosenValue == null) {
        errorMessage(message: 'All Fields are required');
      } else {
        setState(() {
          isSubmitting = true;
        });
        var result = await APIs().updateTodoById(
            id: widget.id,
            pros_id: selected != null ? selected : todo.body.prospectId,
            time: deliverTimePickController.text,
            date: deliverDatePickController.text,
            reason: _chosenValue,
            note: noteController.text,
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ToDoList(),
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
    }
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
      DateFormat formatter = DateFormat('yyyy-MM-dd EEEE HH:mm');
      DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
      DateFormat timeFormatter = DateFormat('HH:mm');

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
        DateFormat formatter = DateFormat('yyyy-MM-dd EEEE HH:mm');

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
        DateFormat formatter = DateFormat('yyyy-MM-dd EEEE HH:mm');
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
          title: Text('New To Do',
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
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(width: 0.5),
                                  color: AppColors.SECONDARY_COLOR),
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: CustomSearchableDropDown(
                                dropdownHintText: 'Search For Name Here... ',
                                showLabelInMenu: true,
                                primaryColor: AppColors.PRIMARY_COLOR,
                                menuMode: false,
                                labelStyle:
                                    TextStyle(color: AppColors.PRIMARY_COLOR),
                                items: prospects,
                                label: selectedName,
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
                                  print(selected);
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            labelText(label: 'Note'),
                            TextFormField(
                              controller: noteController,
                              style: AppStyles.textFieldStyle,
                              // obscureText: obsecure,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: AppColors.SECONDARY_COLOR,
                                errorMaxLines: 2,
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 182, 40, 30),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    overflow: TextOverflow.fade),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                prefixIcon: Icon(
                                  Icons.note_alt_outlined,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                                labelText: 'Note',
                                labelStyle: AppStyles.labelStyle,
                                floatingLabelStyle:
                                    AppStyles.floatingLabelStyle,
                                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                              ),
                              // controller: newPasswordController,
                              // textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                // FocusScope.of(context).nextFocus();
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  // passwordvalidate = true;
                                });
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(width: 0.5),
                                      color: AppColors.SECONDARY_COLOR),
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
                                            color: AppColors.SECONDARY_COLOR,
                                          ),
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
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(width: 0.5),
                                      color: AppColors.SECONDARY_COLOR),
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
                                            color: AppColors.SECONDARY_COLOR,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            labelText(label: 'Type'),
                            Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(width: 0.5),
                                  color: AppColors.SECONDARY_COLOR),
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: _chosenValue,
                                elevation: 5,
                                underline: Container(color: Colors.transparent),
                                style:
                                    TextStyle(color: AppColors.PRIMARY_COLOR),
                                // items: dropdownItems,
                                items: <String>[
                                  'Prospecting',
                                  'Appointment',
                                  'Sales Interview',
                                  'Follow Up',
                                  'Premium',
                                  'Other',
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
                                    // print('_chosenValue' + _chosenValue);
                                  });
                                },
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
                                        widget.id != null
                                            ? updateAppointment()
                                            : createTodo();
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
