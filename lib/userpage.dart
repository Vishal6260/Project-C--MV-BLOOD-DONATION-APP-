import 'package:flutter/material.dart';
import 'package:mvblooddonationapp/services/database.dart';

import 'home.dart';
import 'loginpage.dart';
import 'signupform.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              height: 250,
              width: double.infinity,
              child: Image.asset("assets/image/1.jpeg"),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                "Pleas Select Your Choice!",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 200, 20, 7)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 200, 20, 7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text(
                "As a Donor",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 200, 20, 7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              onPressed: () {
                Database().signInguest();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                "As a Requester",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text(
                "I Have an account!",
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 200, 20, 7)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
