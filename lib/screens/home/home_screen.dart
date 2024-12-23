import 'package:flutter/material.dart';
import 'package:furtime/data/PostCard.dart';
import 'package:furtime/screens/CreatePost.dart';
import 'package:furtime/screens/allpets/allpets_screen.dart';
import 'package:furtime/screens/calendar/calendar_screen.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int _selectedIndex = 0;

  // List of widgets corresponding to each tab
  final List<Widget> _screens = [
    const Center(child: Text('Home Screen')), // Home tab content
    const Center(child: Text('Search Screen')), // Search tab content
    const Center(child: Text('Profile Screen')), // Profile tab content
  ];

  void _onItemTapped(int index) {
    setState(() {
      if(index == 2){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ToDoScreen()));
      }
      else if(index == 1){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllPets()));
      }
      else if(index == 4){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
      }
      else if(index == 3){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber[400],
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
            IconButton(onPressed: (){
              Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => createPost()));
                }, icon: Icon(Icons.add_to_photos_outlined), iconSize: 35,)
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Banner Section
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/budol.jpg', // Replace with your image asset
                  height: 60,
                  width: 60,
                  
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'We care about your PET',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              
              ],
            ),
          ),
          SizedBox(height: 16.0),
          // Post Cards
          PostCard(
            profileName: "Sam Guy",
            location: "Tempe, AZ",
            postText: "LIfe",
            postdesc: "Travel and you will born for a second time. ",
            imageUrl: "assets/images/ttalgi.jpg", // Replace with your image asset
          ),
          SizedBox(height: 16.0),
          PostCard(
            profileName: "Sam Guy",
            location: "Tempe, AZ",
            postText: "Travel",
            postdesc: "Travel and you will born for a second time.",
            imageUrl: "assets/images/ttalgi.jpg", // Replace with your image asset
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: false,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        fixedColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'All Pets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Check List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );  
  }
}
