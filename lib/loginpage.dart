import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvblooddonationapp/forgotpassword.dart';
import 'package:mvblooddonationapp/services/database.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  // ignore: non_constant_identifier_names
  String Errormsg = "";

  get mobilecontroller => null;

  get namecontroller => null;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
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
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
    );

    final passwordField = TextFormField(
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
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: const Color.fromARGB(255, 200, 20, 7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
        onPressed: () async {
          if (_formkey.currentState!.validate()) {
            dynamic result = await Database()
                .signIn(emailcontroller.text, passcontroller.text);
            print(result);
            if (result == null) {
              setState(() {
                Errormsg = "Invalid credential";
              });
            } else {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          }
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      body: Form(
        key: _formkey,
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 200, 20, 7),
                      )),
                  const SizedBox(height: 25.0),
                  emailField,
                  const SizedBox(height: 25.0),
                  passwordField,
                  const SizedBox(
                    height: 35.0,
                  ),
                  Text(Errormsg),
                  loginButon,
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()),
                        );
                      },
                      child: const Text("Forgot Password!",
                          style: TextStyle(color: Colors.red, fontSize: 15))),
                  const SizedBox(
                    height: 50.0,
                  ),
                ],
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
    child: const Text("Got It"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('alert');
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("My title"),
    content: const Text("tet"),
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
