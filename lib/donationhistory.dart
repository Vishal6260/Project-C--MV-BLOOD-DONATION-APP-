import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvblooddonationapp/models/donationhistory.dart';
import 'package:mvblooddonationapp/services/database.dart';
import 'package:provider/provider.dart';

class Donationhistory extends StatefulWidget {
  const Donationhistory({super.key});

  @override
  State<Donationhistory> createState() => _DonationhistoryState();
}

class _DonationhistoryState extends State<Donationhistory> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

        Database().writedonationhistory(
            donationhistory(date: value, userid: _auth.currentUser!.uid));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<donationhistory>?>.value(
      value: Database().loadDonationHistory(),
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70,
          backgroundColor: const Color.fromARGB(255, 200, 20, 7),
          title: const Text("Donation History"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final dates = Provider.of<List<donationhistory>?>(context);
                    List<Widget> childItems = [];
                    if (dates != null) {
                      for (var td in dates) {
                        childItems.add(
                          BigCard(
                            time: td.date,
                          ),
                        );
                      }
                    }
                    return ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: childItems,
                    );
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  onPressed: () => _showDatePicker(),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Record Donation",
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

class BigCard extends StatefulWidget {
  const BigCard({super.key, required this.time});

  final DateTime time;
  @override
  State<BigCard> createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 2.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "${widget.time.day}/${widget.time.month}/${widget.time.year}",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
