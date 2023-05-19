import 'package:flutter/material.dart';
import 'package:mvblooddonationapp/services/database.dart';
import 'package:mvblooddonationapp/userpage.dart';

import 'models/request.dart';

class MakeRequest extends StatefulWidget {
  const MakeRequest({super.key});

  @override
  State<MakeRequest> createState() => _MakeRequestState();
}

class _MakeRequestState extends State<MakeRequest> {
  final _formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final mobilecontroller = TextEditingController();
  final remarkscontroller = TextEditingController();
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
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 200, 20, 7),
        title: const Text("Create Blood Request"),
      ),
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
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedBloodGroup,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedCity,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                    const SizedBox(
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
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Mobile",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: false,
                      controller: remarkscontroller,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Remarks ",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            Request request = Request(
                              id: "id",
                              name: namecontroller.text,
                              bloodgroup: selectedBloodGroup,
                              location: selectedCity,
                              phone: mobilecontroller.text,
                              remarks: remarkscontroller.text,
                              isnotified: false,
                            );
                            Database().writeRequestData(request);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserPage()),
                            );
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Submit",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
