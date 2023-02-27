import 'package:cheetukaliapp/controllers/apimanger_controller.dart';
import 'package:cheetukaliapp/models/addwinnermodel.dart';
import 'package:cheetukaliapp/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cheetukaliapp/controllers/cheetukalilist_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cheetukaliapp/utils/urls.dart';

class ScreenAddWinner extends StatefulWidget {
  const ScreenAddWinner({super.key});

  @override
  State<ScreenAddWinner> createState() => _ScreenAddWinnerState();
}

class _ScreenAddWinnerState extends State<ScreenAddWinner> {
  var arguments = Get.arguments;
  final formkey = GlobalKey<FormState>();
  //Find controller instance
  final kaliListController = Get.find<CheetuKaliController>();
  //Declare and Initialize Controller
  final apiManager = Get.put(ApiManagerController());

  late AddWinnerModel addWinnerModel;

  String? _selected;
  // ignore: unused_field
  int? _amount;
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addWinnerModel = AddWinnerModel(wgId: arguments[0], playerId: 0, amount: 0);
  }

  @override
  void dispose() {
    super.dispose();
    if (!_amountController.isBlank!) {
      _amountController.dispose();
    }
  }

  //Callback fucntion for OK button pressed
  void _dialogOkButtonPressedforlogOut() {
    Urls.isLoggedIn = false; //Set logged out
    Urls.isAdminRole = false;
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
                            'Adding Winner',
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
                              labelText: 'Winner',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              hintText: 'Select winner',
                              labelStyle: const TextStyle(
                                  fontSize: 17, color: Colors.blue),
                            ),
                            validator: ((value) {
                              if (value == null) {
                                return 'Select winner';
                              }
                              return null;
                            }),
                            onChanged: (newValue) {
                              setState(() {
                                _selected = newValue;
                              });
                            },
                            items:
                                kaliListController.userlistwinners.map((value) {
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
                        controller: _amountController,
                        //readOnly: true,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: const EdgeInsets.only(
                              top: 20, left: 15, bottom: 20, right: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Amount',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          //floatingLabelAlignment: FloatingLabelAlignment.center,
                          labelStyle:
                              const TextStyle(fontSize: 17, color: Colors.blue),
                        ),
                        validator: ((value) {
                          if (value == null || value == '') {
                            return 'Enter amount';
                          } else if (int.parse(value) <= 0) {
                            return 'Amount not to be zero ';
                          }
                          return null;
                        }),
                        onSaved: (newValue) {
                          setState(() {
                            _amount = int.parse(newValue.toString());
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            //FocusScope.of(context).unfocus();
                            if (dataValidate()) {
                              //Saving routine
                              //Fille the values to the model
                              addWinnerModel.playerId = int.parse(_selected!);
                              addWinnerModel.amount = _amount!;

                              apiManager.addWinner(addWinnerModel).then(
                                (value) {
                                  if (value == 'Created') {
                                    //Sucessfully Created
                                    kaliListController.eventChanged.value =
                                        true;
                                    kaliListController.winnerChanged.value =
                                        true;

                                    DialogHelper.okcancelDialog(
                                        true, 'Winner added');
                                    //Clear controls
                                    setState(() {
                                      _selected = null;
                                      _amountController.clear();
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

  bool dataValidate() {
    final bool isvalidate = formkey.currentState!.validate();

    if (isvalidate) {
      formkey.currentState!.save();
    }
    return isvalidate;
  }
}
