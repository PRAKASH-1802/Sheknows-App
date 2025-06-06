import 'package:flutter/material.dart';
import 'package:sheknows_app/Screens/DashBoard/components/chatbot_screen.dart';
import 'package:sheknows_app/Screens/DashBoard/components/doctors_info_screen.dart';
import 'package:sheknows_app/Screens/DashBoard/components/healthcare_screen.dart';
import 'package:sheknows_app/Screens/DashBoard/components/home_screen.dart';
import 'package:sheknows_app/Screens/DashBoard/components/profile_screen.dart';

class Home extends StatefulWidget {
  final String? email;

  const Home({Key? key, required this.email}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  bool isSearching = false;
  TextEditingController _searchController = TextEditingController();

  // Home Page ke UI se Automatically Data Extract Karne ke liye List
  List<String> homeData = [];
  List<String> searchResults = [];

  final List<Widget> _pages = [
    HomeScreen(),
    AskQuestionScreen(),
    DoctorInfoScreen(),
    HealthCare(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    extractHomeData();
  }

  // Function to Extract Data from UI Widgets
  void extractHomeData() {
    List<String> extractedData = [];

    List<Widget> homeWidgets = [
      Text("Emergency Contact"),
      Text("Women's Safety Guide"),
      Text("Self-defense Tips"),
      Text("Nearby Hospitals"),
      Text("24/7 Helpline"),
      Text("Mental Health Support"),
      Text("ChatBot Assistance"),
      Text("Doctor Consultation"),
      Text("First Aid Instructions"),
      Text("Profile Management"),
    ];

    for (var widget in homeWidgets) {
      if (widget is Text) {
        extractedData.add(widget.data ?? "");
      }
    }

    setState(() {
      homeData = extractedData;
    });
  }

  // Search Function (Filters Extracted Data)
  void _performSearch(String query) {
    setState(() {
      searchResults = homeData
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var onTabTapped;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            setState(() {
              _currentIndex = 4; //  Profile tab ko activate karein
            });
          },
          icon: Icon(Icons.menu),
        ),
        title: isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search...",
            border: InputBorder.none,
          ),
          onChanged: _performSearch,
        )
            : Text('SheKnows', style: TextStyle(color: Colors.red)),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.cancel : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  _searchController.clear();
                  searchResults.clear();
                }
              });
            },
          ),
        ],
      ),

      body: searchResults.isEmpty
          ? _pages[_currentIndex]
          : ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchResults[index]),
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // onTap: onTabTapped,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_chat),
            label: "ChatBot",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            label: "Doctor`s Info",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety_outlined),
            label: "Health_Care",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.pink,),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
