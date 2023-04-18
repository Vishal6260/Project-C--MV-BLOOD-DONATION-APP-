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
      body: Center(
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
                TextField(
                  obscureText: false,
                  controller: namecontroller,
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
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                TextField(
                  obscureText: false,
                  controller: emailcontroller,
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
                TextField(
                  obscureText: false,
                  controller: mobilecontroller,
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
                TextField(
                  obscureText: true,
                  controller: passcontroller,
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
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color.fromARGB(255, 200, 20, 7),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Login()),
                      // );
                      Myuser user = Myuser(
                          id: "id",
                          name: namecontroller.text,
                          bloodgroup: selectedBloodGroup,
                          location: selectedCity,
                          email: emailcontroller.text,
                          phone: mobilecontroller.text,
                          password: passcontroller.text);
                      Database().register(user);
                    },
                    child: Text(
                      "Submit",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
