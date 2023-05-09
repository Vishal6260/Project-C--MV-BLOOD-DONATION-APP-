import 'package:flutter/material.dart';
import 'package:mvblooddonationapp/models/donationhistory.dart';
import 'package:mvblooddonationapp/services/database.dart';

class Donationhistory extends StatefulWidget {
  const Donationhistory({super.key});

  @override
  State<Donationhistory> createState() => _DonationhistoryState();
}

class _DonationhistoryState extends State<Donationhistory> {
  // create datetime variable
  DateTime _dateTime = DateTime.now();

  // show date picker method
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2043),
    ).then((value) {
      setState(() {
        _dateTime = value!;

        Database().writedonationhistory(donationhistory(date: value));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Color.fromARGB(255, 200, 20, 7),
        title: Text("Donation History"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // display chosen dtae
            Text(
              _dateTime.toString(),
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
            ),

            // button
            ElevatedButton(
                onPressed: () {
                  _showDatePicker();
                },
                child: Text('Date Picker')),
          ],
        ),
      ),
    );
  }
}
