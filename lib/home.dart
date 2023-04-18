// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

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
        // fixedColor: Colors.white,
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
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.red,
        onPressed: () {
          // Add logout functionality here
        },
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
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
                height: 175,
                width: double.infinity,
                child: Image.asset("assets/image/1.jpeg"),
              ),
              // Text("dfsfsdfdsf"),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 100,
                  width: 300,
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
                      "Number of Donors : ",
                      style: TextStyle(fontSize: 25, color: Colors.white),
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
                  height: 100,
                  width: 300,
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
                      "Number of Request : ",
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
      body: Column(
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
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(0.0),
            child: Container(
              margin: EdgeInsets.all(15),
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
    return Center(
      child: Text('Profile Screen'),
    );
  }
}
