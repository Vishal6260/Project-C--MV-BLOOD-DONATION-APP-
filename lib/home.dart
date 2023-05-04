// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvblooddonationapp/donors.dart';
import 'package:mvblooddonationapp/makerequest.dart';
import 'package:mvblooddonationapp/request.dart';
import 'package:mvblooddonationapp/services/database.dart';
import 'package:mvblooddonationapp/userpage.dart';

import 'models/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    if (_auth.currentUser != null) {
      _pages = [
        HomeScreen(),
        SearchScreen(),
        ProfileScreen(),
      ];
    } else {
      _pages = [
        GuestHomeScreen(),
        SearchScreen(),
        ProfileScreen(),
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
        items: const [
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
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   focusColor: Colors.white,
      //   onPressed: () {
      //     // Add logout functionality here
      //   },
      //   child: const Icon(
      //     Icons.logout,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      // child: Text(
                      //   "Number of Donors : 00",
                      //   style: TextStyle(fontSize: 25, color: Colors.white),
                      // ),
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
                // SizedBox(
                //   height: 15,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Container(
                //     height: 75,
                //     width: 275,
                //     decoration: BoxDecoration(
                //       color: Color.fromARGB(255, 200, 20, 7),
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: TextButton(
                //       onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignUp()),
                // );
                //     },
                //     child: Text(
                //       "Donation History. ",
                //       style: TextStyle(fontSize: 25, color: Colors.white),
                //     ),
                //   ),
                // ),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SignUp()),
                      // );
                    },
                    child: Text(
                      "Share App ",
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
    return Container(
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
                      // child: Text(
                      //   "Number of Donors : 00",
                      //   style: TextStyle(fontSize: 25, color: Colors.white),
                      // ),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SignUp()),
                      // );
                    },
                    child: Text(
                      "Share App ",
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
  // Declare a list of blood donors
  List<String> bloodDonors = [
    // 'John Doe',
    // 'Jane Smith',
  ];

  // Declare a variable to store the search query
  String searchQuery = '';

  // Method to update the search query when the user types in the search bar
  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  // Method to filter the list of blood donors based on the search query
  List<String> filterBloodDonors() {
    List<String> filteredList = [];
    if (searchQuery.isNotEmpty) {
      for (String donor in bloodDonors) {
        if (donor.toLowerCase().contains(searchQuery.toLowerCase())) {
          filteredList.add(donor);
        }
      }
    } else {
      filteredList = bloodDonors;
    }
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                height: 200,
                width: 175,
                child: Image.asset("assets/image/1.jpeg"),
              ),
            ),
            SizedBox(
              height: .5,
            ),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Container(
                margin: EdgeInsets.all(0),
                child: TextField(
                  onChanged: (query) => updateSearchQuery(query),
                  decoration: InputDecoration(
                    hintText: 'Search for a blood donor',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filterBloodDonors().length,
                itemBuilder: (context, index) {
                  String donor = filterBloodDonors()[index];
                  return ListTile(
                    title: Text(donor),
                    leading: Icon(Icons.person),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Search Screen'),
//     );
//   }
// }

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FutureBuilder<Myuser?>(
        future: Database().loaduser(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            Myuser currentuser = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 150, 5, 5),
              child: Column(children: [
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
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(20)),
                //         ),
                //       ),
                //     ),
                //     onPressed: () {},
                //     child: Text(
                //       "Delet Account",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(fontSize: 18, color: Colors.white),
                //     ),
                //   ),
                // ),
              ]),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ],
            );
          }
        });
  }
}
