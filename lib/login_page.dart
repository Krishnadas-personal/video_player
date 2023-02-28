import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'otp_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController phnno = TextEditingController();
  TextEditingController code = TextEditingController();
  final _phoneNumberFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  // FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;
  DateTime? selectedDate;
  String verificationID = "";
  String phoneNumber = "";
  @override
  void initState() {
    code.text = '91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/video.png', height: 100.0),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      readOnly: true,
                      controller: code,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Country Code';
                        }

                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          label: Text("Code"),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 8,
                    child: TextFormField(
                      controller: phnno,
                      onSaved: ((newValue) {
                        print(newValue);
                        phoneNumber = newValue!;
                      }),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }

                        if (int.parse(value) < 10) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          label: Text("Phone Number"),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      //border radius equal to or more than 50% of width
                    )),
                    onPressed: () {
                      final validater = _form.currentState?.validate();
                      if (validater == false) {
                        return;
                      }
                      print(phnno.text + " noo");
                      print(code.text + " code");
                      print("phoneNumber");
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return OTPScreen(
                          phone: code.text + phnno.text,
                        );
                      })));
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Login")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() {
    return showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2015),
            lastDate: DateTime(2101))
        .then((value) {
      if (value != null && value != selectedDate) {
        setState(() {
          selectedDate = value;
          dob.text = DateFormat('dd-MM-yyyy').format(selectedDate!);
        });
      }
    });
  }
}
