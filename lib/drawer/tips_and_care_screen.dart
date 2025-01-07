import 'package:flutter/material.dart';
import 'package:furtime/drawer/doanddont.dart';
import 'package:furtime/drawer/faqScreen.dart';
import 'package:furtime/drawer/tips.dart';
import 'package:furtime/drawer/viewHelp.dart';
import 'package:get/get.dart';

class TipsAndCareScreen extends StatelessWidget {
  const TipsAndCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tips & Care'),
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
                  Get.to(() => ViewHelpScreen(petType: 'cat'));
                },
                contentPadding: const EdgeInsets.all(10),
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange.withOpacity(0.4),
                  child: const Icon(Icons.tips_and_updates),
                ),
                title: const Text('Cat Owners',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle:
                    const Text('Provided general information about cats.'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Get.to(() => ViewHelpScreen(petType: 'dog'));
                },
                contentPadding: const EdgeInsets.all(10),
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange.withOpacity(0.4),
                  child: const Icon(Icons.tips_and_updates),
                ),
                title: const Text('Dogs Owners',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle:
                    const Text('Provided general information about dogs.'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Get.to(() => ViewHelpScreen(petType: 'others'));
                },
                contentPadding: const EdgeInsets.all(10),
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange.withOpacity(0.4),
                  child: const Icon(Icons.tips_and_updates),
                ),
                title: const Text('Other Animal Owners',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text(
                    'A general information and tips about Other Animals.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
