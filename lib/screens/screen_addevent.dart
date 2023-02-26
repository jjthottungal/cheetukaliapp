import 'package:cheetukaliapp/controllers/apimanger_controller.dart';
import 'package:cheetukaliapp/models/addeventmodel.dart';
import 'package:cheetukaliapp/utils/dialog_helper.dart';
import 'package:cheetukaliapp/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cheetukaliapp/controllers/cheetukalilist_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ScreenAddEvent extends StatefulWidget {
  const ScreenAddEvent({super.key});

  @override
  State<ScreenAddEvent> createState() => _ScreenAddEventState();
}

class _ScreenAddEventState extends State<ScreenAddEvent> {
  //var arguments = Get.arguments;
  final formkey = GlobalKey<FormState>();
  //Find controller instance
  final kaliListController = Get.find<CheetuKaliController>();
  //Declare and Initialize Controller
  final apiManager = Get.put(ApiManagerController());

  late AddEventModel addEventModel;

  String? _selected;
  DateTime dateTime = DateTime.now();
  // ignore: unused_field
  String? _eventdate;
  final _eventDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addEventModel = AddEventModel(wgId: 0, wgDate: '', note: 'Mobile', host: 0);
    //Set initial date
    //setInitialDate();
  }

  @override
  void dispose() {
    super.dispose();
    if (!_eventDateController.isBlank!) {
      _eventDateController.dispose();
    }
  }

  void setInitialDate() {
    DateTime now = DateTime.now();
    //Set today without time
    DateTime dateToday = DateTime(now.year, now.month, now.day);

    if (dateToday.compareTo(kaliListController.lastEventDate.value) < 1) {
      dateTime =
          kaliListController.lastEventDate.value.add(const Duration(days: 1));
    } else {
      dateTime = DateTime.now();
    }
  }

  //Callback fucntion for OK button pressed
  void _dialogOkButtonPressedforlogOut() {
    Urls.isLoggedIn = false; //Set logged out
    Get.offAllNamed('/login');
  }

  void goBack() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        goBack();
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            //elevation: 10,
            title: const Text(
              'Weekly Gathering',
              style: TextStyle(fontSize: 20),
            ),
            //centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  goBack();
                },
                icon: const Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.until((route) => Get.currentRoute == '/home');
                  },
                  icon: const Icon(Icons.home)),
              IconButton(
                  onPressed: () {
                    DialogHelper.okcancelDialog(false, 'Do you want to exit?',
                        'Logout', _dialogOkButtonPressedforlogOut);
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
          body: SafeArea(
            // ignore: avoid_unnecessary_containers
            child: Form(
              key: formkey,
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.users,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Adding Event',
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      height: 85,
                      //color: Colors.black12,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField(
                            value: _selected,
                            iconSize: 36,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.blue,
                            ),
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              //filled: true,
                              fillColor: Colors.blue,
                              contentPadding: const EdgeInsets.only(
                                  top: 12, left: 15, bottom: 12, right: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: 'Host',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              hintText: 'Select host',
                              labelStyle: const TextStyle(
                                  fontSize: 17, color: Colors.blue),
                            ),
                            validator: ((value) {
                              if (value == null) {
                                return 'Select host';
                              }
                              return null;
                            }),
                            onChanged: (newValue) {
                              setState(() {
                                _selected = newValue;
                              });
                            },
                            items:
                                kaliListController.userlisthosts.map((value) {
                              return DropdownMenuItem(
                                  value: value.playerId.toString(),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundImage: AssetImage(
                                            'assets/images/${value.playerName}.jpg'),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(value.playerName),
                                    ],
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 85,
                      //color: Colors.black12,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        controller: _eventDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 20, left: 15, bottom: 20, right: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Event Date',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          //floatingLabelAlignment: FloatingLabelAlignment.center,
                          labelStyle:
                              const TextStyle(fontSize: 17, color: Colors.blue),
                          hintText: 'Select date',
                          suffixIcon: IconButton(
                            padding: const EdgeInsets.only(right: 15),
                            onPressed: () {
                              //Call Date Picker
                              eventDatePicker(context);
                            },
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: ((value) {
                          if (value == null || value == '') {
                            return 'Select event date';
                          }
                          return null;
                        }),
                        onSaved: (newValue) {
                          setState(() {
                            _eventdate = newValue;
                          });
                        },
                        onTap: () {
                          //Call Date Picker
                          eventDatePicker(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (dataValidate()) {
                              //Saving routine
                              //Fille the values to the model
                              dateTime = DateFormat('dd/MM/yyyy')
                                  .parse(_eventDateController.text);
                              addEventModel.host = int.parse(_selected!);
                              addEventModel.wgDate =
                                  DateFormat('MM/dd/yyyy').format(dateTime);
                              // print(addEventModel.toJson());

                              apiManager.addEvent(addEventModel).then(
                                (value) {
                                  if (value == 'Created') {
                                    //Sucessfully Created
                                    kaliListController.eventChanged.value =
                                        true;
                                    DialogHelper.okcancelDialog(
                                        true, 'Event added');
                                    //Clear controls
                                    setState(() {
                                      _selected = null;
                                      _eventDateController.clear();
                                      kaliListController.lastEventDate.value =
                                          dateTime;
                                    });
                                  } else {
                                    //Alerts
                                    DialogHelper.okcancelDialog(true, value);
                                  }
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(), elevation: 10),
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void eventDatePicker(BuildContext ctx) {
    //Set the dateTime variable
    if (_eventDateController.text == '') {
      setInitialDate();
    } else {
      dateTime = DateFormat('dd/MM/yyyy').parse(_eventDateController.text);
    }

    DialogHelper.showSheet(ctx, child: BuildDatePicker(), title: 'Event Date',
        onClicked: () {
      final value = DateFormat('dd/MM/yyyy').format(dateTime);
      _eventDateController.text = value;
      Get.back();
    });
  }

  bool dataValidate() {
    final bool isvalidate = formkey.currentState!.validate();

    if (isvalidate) {
      formkey.currentState!.save();
    }
    return isvalidate;
  }

  // ignore: non_constant_identifier_names
  Widget BuildDatePicker() {
    return SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        //backgroundColor: Colors.blue.shade50,
        initialDateTime: dateTime,
        //minimumYear: 2015,
        minimumDate:
            kaliListController.lastEventDate.value.add(const Duration(days: 1)),
        maximumYear: DateTime.now().year,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (dateTime) {
          setState(() {
            this.dateTime = dateTime;
          });
        },
      ),
    );
  }
}
