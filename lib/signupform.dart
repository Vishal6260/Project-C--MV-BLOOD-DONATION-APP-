import 'package:flutter/material.dart';
import 'package:mvblooddonationapp/models/user.dart';
import 'package:mvblooddonationapp/services/database.dart';
import 'package:mvblooddonationapp/userpage.dart';

import 'loginpage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final mobilecontroller = TextEditingController();
  final passcontroller = TextEditingController();
  String selectedGender = 'M';
  String selectedBloodGroup = 'A+';
  String selectedCity = 'Male';
  late List<String> gender = ['Male', 'Female'];
  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  late List<String> cities = ['Male', 'Hulhumale', 'Vilimale'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign up Form",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 200, 20, 7),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: false,
                      controller: namecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name canot be empty!";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          // labelText: 'Name',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedBloodGroup,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: 'Select you Blood Group',
                        // labelText: 'Blood Group',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedBloodGroup = newValue!;
                        });
                      },
                      items: bloodGroups
                          .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedCity,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        labelText: 'Location',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedCity = newValue!;
                        });
                      },
                      items: cities
                          .map<DropdownMenuItem<String>>(
                              (value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: false,
                      controller: emailcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email canot be empty";
                        } else {
                          return validateEmail(value);
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Email ",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: false,
                      controller: mobilecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mobile canot be empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Mobile",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // DropdownButtonFormField<String>(
                    //   value: selectedGender,
                    //   decoration: InputDecoration(
                    //     labelText: 'Gender',
                    //     border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(20),
                    //         borderSide:
                    //             BorderSide(color: Color.fromARGB(255, 220, 7, 7))),
                    //   ),
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       gender = newValue! as List<String>;
                    //     });
                    //   },
                    //   items: [
                    //     'Male',
                    //     'Female',
                    //   ]
                    //       .map<DropdownMenuItem<String>>(
                    //           (value) => DropdownMenuItem<String>(
                    //                 value: value,
                    //                 child: Text(value),
                    //               ))
                    //       .toList(),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passcontroller,
                      validator: (value) {
                        if (value!.length < 8) {
                          return "Password must be more than 8 chractors";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Password ",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            Myuser user = Myuser(
                                id: "id",
                                name: namecontroller.text,
                                bloodgroup: selectedBloodGroup,
                                location: selectedCity,
                                email: emailcontroller.text,
                                phone: mobilecontroller.text,
                                password: passcontroller.text);
                            Database().register(user);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          }
                        },
                        child: Text(
                          "Submit",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Have an account!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    )
                    // ElevatedButton(
                    //   style: ButtonStyle(
                    //     shape:
                    //         MaterialStateProperty.all<RoundedRectangleBorder>(
                    //       RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(20)),
                    //       ),
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => Login()),
                    //     );
                    //   },
                    //   child: Text(
                    //     "Have an account!",
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
}

showAlertDialog(BuildContext context, User user) {
  Widget gotIt = ElevatedButton(
    child: Text("Got It"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('alert');
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("tet"),
    actions: [
      gotIt,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
