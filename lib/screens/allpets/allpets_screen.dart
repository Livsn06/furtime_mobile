import 'package:flutter/material.dart';
import 'package:furtime/data/PetCard.dart';
import 'package:furtime/screens/allpets/AddPet.dart';
import 'package:furtime/screens/calendar/calendar_screen.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/screens/profile/profile_screen.dart';


class AllPets extends StatefulWidget {

  @override
  State<AllPets> createState() => _AllPetsState();
}

class _AllPetsState extends State<AllPets> {
  int _selectedIndex = 1;

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
      else if(index == 0){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
      if(index == 4){
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
          'My Pets',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
            IconButton(onPressed: (){
              Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => additionalPet()));
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
                  'assets/images/ttalgi.jpg', // Replace with your image asset
                  height: 60,
                  width: 60,
                ),
                SizedBox(width: 12),
                const Expanded(
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
          // Pet Cards
            PetCard(
               imageUrl: "assets/images/ash.jpg", // Replace with your image asset
            petName: "Ash",
            age: "2"+ " Yrs old",
            breed: "Persian",
            gender: 'Female',
          ),
          SizedBox(height: 16.0),
           PetCard(
               imageUrl: "assets/images/ashh.jpg", // Replace with your image asset
            petName: "Ash",
            age: "2"+ " Yrs old",
            breed: "Persian",
            gender: 'Female',
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'imageUrl', // Replace with your image asset
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
      
              const Row(
                children: [
                 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'profileName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'location',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'postText',
                style: TextStyle(fontSize: 14),
              ),           
            ],
          ),
        ),
      ),
    );
  }

