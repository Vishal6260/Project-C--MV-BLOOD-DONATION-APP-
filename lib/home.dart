// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvblooddonationapp/donors.dart';
import 'package:mvblooddonationapp/makerequest.dart';
import 'package:mvblooddonationapp/models/request.dart';
import 'package:mvblooddonationapp/request.dart';
import 'package:mvblooddonationapp/services/database.dart';
import 'package:mvblooddonationapp/services/notification.dart';
import 'package:mvblooddonationapp/userpage.dart';

import 'about us.dart';
import 'donationhistory.dart';
import 'models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    if (!_auth.currentUser!.isAnonymous) {
      _pages = [
        Home(),
        SearchScreen(),
        ProfileScreen(),
      ];
    } else {
      _pages = [
        GuestHomeScreen(),
        SearchScreen(),
        //ProfileScreen(),
      ];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 201, 20, 7),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white30,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: !_auth.currentUser!.isAnonymous
            ? [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ]
            : [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (!auth.currentUser!.isAnonymous) {
      Database().requestlistsnapshot().then((value) {
        Database().loaduser().then((userdata) {
          for (Request iteam in value) {
            if (!iteam.isnotified && iteam.bloodgroup == userdata!.bloodgroup) {
              NotificationService().showNotification(
                id: DateTime.now().millisecond,
                title: 'Donation Request',
                body:
                    "${iteam.name} is requesting blood donation from ${iteam.location}. Contact them on ${iteam.phone}",
              );

              Database().updateNotified(iteam.id);
            }
          }
        });
      });
    }
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 30, 5, 5),
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white),
                height: 200,
                width: double.infinity,
                child: Image.asset("assets/image/1.jpeg"),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 75,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 200, 20, 7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DonorsList()),
                      );
                    },
                    child: FutureBuilder<int>(
                      future: Database().getDonorCount(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Text(
                            "Number of Donors : ${snapshot.data ?? -1}",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 75,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 200, 20, 7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RequestList()),
                      );
                    },
                    child: FutureBuilder<int>(
                      future: Database().getRequestcount(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Text(
                            "Number of Request : ${snapshot.data ?? -1}",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 75,
                  width: 275,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 200, 20, 7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutUsPage()),
                      );
                    },
                    child: Text(
                      "About Us ",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GuestHomeScreen extends StatelessWidget {
  const GuestHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 30, 5, 5),
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white),
                height: 200,
                width: double.infinity,
                child: Image.asset("assets/image/1.jpeg"),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 75,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 200, 20, 7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MakeRequest()),
                      );
                    },
                    child: Text(
                      "Make a Request",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 75,
                  width: 275,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 200, 20, 7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutUsPage()),
                      );
                    },
                    child: Text(
                      "About Us ",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  List<Myuser> searchresult = [];

  // Method to update the search query when the user types in the search bar
  void searchDonor(String query, List<Myuser>? users) {
    if (users != null) {
      setState(() {
        searchresult = filterDonors(users, query, query, query, query);
      });
    }
  }

  List<Myuser> filterDonors(List<Myuser> models, String name, String bloodGroup,
      String location, String phone) {
    return models.where((model) {
      final nameMatch = model.name!.toLowerCase().contains(name.toLowerCase());
      final bloodGroupMatch =
          model.bloodgroup!.toLowerCase() == bloodGroup.toLowerCase();
      final locationMatch =
          model.location!.toLowerCase() == location.toLowerCase();
      final phoneMatch =
          model.phone!.toLowerCase().contains(phone.toLowerCase());

      return nameMatch || bloodGroupMatch || locationMatch || phoneMatch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 200, 20, 7),
        title: const Text("Pleas Type Blood Group"),
      ),
      body: FutureBuilder(
        future: Database().getDonors(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final bloodDonors = snapshot.data;
            return Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (query) {
                        searchDonor(query, bloodDonors);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for a blood donor',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchresult.length,
                      itemBuilder: (context, index) {
                        Myuser donor = searchresult[index];
                        return ListTile(
                            title: Text("${donor.name}, ${donor.phone}"),
                            leading: Icon(Icons.person));
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FutureBuilder<Myuser?>(
        future: Database().loaduser(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            Myuser currentuser = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 70, 5, 5),
              child: Column(children: [
                Text(
                  "Profile",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 50,
                ),
                //from here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: theme.colorScheme.primary, width: 6),
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.person,
                        color: theme.colorScheme.primary,
                        size: 120,
                      ),
                    ),
                  ],
                ),
                //to here
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentuser.name!,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentuser.email!,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Blood Group: ${currentuser.bloodgroup!}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "City: ${currentuser.location!}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentuser.phone!,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Database().signout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Logout",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Database().signout();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Donationhistory()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Donation History",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              ],
            );
          }
        });
  }
}
