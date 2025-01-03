import 'package:flutter/material.dart';
import 'package:furtime/controllers/pet_screen_controller.dart';
import 'package:furtime/data/PetCard.dart';
import 'package:furtime/helpers/db_sqflite.dart';
import 'package:furtime/models/pet_model.dart';
import 'package:furtime/screens/allpets/AddPet.dart';
import 'package:furtime/screens/calendar/calendar_screen.dart';
import 'package:furtime/screens/checklist/checklist.dart';
import 'package:furtime/screens/home/home_screen.dart';
import 'package:furtime/screens/profile/profile_screen.dart';
import 'package:furtime/utils/_constant.dart';
import 'package:get/get.dart';

class AllPets extends StatefulWidget {
  const AllPets({super.key});

  @override
  State<AllPets> createState() => _AllPetsState();
}

class _AllPetsState extends State<AllPets> {
  final int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        Get.offAll(() => ToDoScreen(), transition: Transition.fadeIn);
      } else if (index == 0) {
        Get.offAll(() => const HomeScreen(), transition: Transition.fadeIn);
      }
      if (index == 4) {
        Get.offAll(() => const ProfileScreen(), transition: Transition.fadeIn);
      } else if (index == 3) {
        Get.offAll(() => const CalendarScreen(), transition: Transition.fadeIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SCREEN_SIZE.value = MediaQuery.of(context).size;
    APP_THEME.value = Theme.of(context);

    //
    return GetBuilder<PetScreenController>(
        init: PetScreenController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              foregroundColor: Colors.white,
              backgroundColor: APP_THEME.value.colorScheme.secondary,
              elevation: 0,
              title: const Text(
                'My Pets',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(() => const additionalPet(),
                        transition: Transition.fadeIn, preventDuplicates: true);
                  },
                  icon: const Icon(Icons.add_circle_outlined),
                  iconSize: 35,
                )
              ],
            ),
            body: Obx(() {
              if (ALL_PET_DATA.value.isEmpty) {
                return Center(
                  child: Text(
                    '- No pets added yet -',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic),
                  ),
                );
              }
              return ListView.builder(
                itemCount: ALL_PET_DATA.value.length,
                itemBuilder: (context, index) {
                  var pet = ALL_PET_DATA.value[index];
                  return PetCard(
                    imageUrl: pet.imagePath!, // Replace with your image asset
                    petName: pet.fullname!,
                    age: "${pet.age}" " Yrs old",
                    breed: pet.breed!,
                    gender: pet.gender!,
                  );
                },
              );
            }),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              useLegacyColorScheme: false,
              unselectedLabelStyle: const TextStyle(color: Colors.black),
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
        });
  }
}

// @override
// Widget build(BuildContext context) {
//   return SingleChildScrollView(
//     child: Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       elevation: 3.0,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 12),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.asset(
//                 'imageUrl', // Replace with your image asset
//                 height: 160,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const Row(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'profileName',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                     Text(
//                       'location',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               'postText',
//               style: TextStyle(fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }


// Container(
//             padding: const EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               color: Colors.orange[100],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: [
//                 Image.asset(
//                   'assets/images/ttalgi.jpg', // Replace with your image asset
//                   height: 60,
//                   width: 60,
//                 ),
//                 const SizedBox(width: 12),
//                 const Expanded(
//                   child: Text(
//                     'We care about your PET',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),