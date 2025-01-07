import 'package:flutter/material.dart';
import 'package:furtime/drawer/doanddont.dart';
import 'package:furtime/drawer/faqScreen.dart';
import 'package:furtime/drawer/tips.dart';
import 'package:get/get.dart';

class ViewHelpScreen extends StatelessWidget {
  ViewHelpScreen({super.key, required this.petType});
  String petType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        centerTitle: true,
        title: petType == 'others'
            ? const Text('About Pets')
            : Text('About ${GetUtils.capitalizeFirst(petType)}s'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  Get.to(() => TipsScreen(petType: petType));
                },
                contentPadding: const EdgeInsets.all(10),
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange.withOpacity(0.4),
                  child: const Icon(Icons.checklist_outlined),
                ),
                title: const Text('Tips',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Advice and tips for your pet.'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Get.to(() => DosAndDontsScreen(petType: petType));
                },
                contentPadding: const EdgeInsets.all(10),
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange.withOpacity(0.4),
                  child: const Icon(Icons.thumbs_up_down_sharp),
                ),
                title: const Text('Do\'s and Don\'ts',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Recommended actions for your pet.'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Get.to(() => FAQScreen(petType: petType));
                },
                contentPadding: const EdgeInsets.all(10),
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange.withOpacity(0.4),
                  child: const Icon(Icons.question_mark_sharp),
                ),
                title: const Text('FAQ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text(
                    'Owner\'s Frequently asked questions and answers.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
