import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  final String petType;

  TipsScreen({Key? key, required this.petType}) : super(key: key);

  final Map<String, List<String>> tips = {
    'dog': [
      'Feed your dog a balanced diet.',
      'Ensure regular exercise to keep your dog fit.',
      'Take your dog for routine vet checkups.',
      'Provide clean water at all times.',
      'Groom your dog regularly to maintain hygiene.'
    ],
    'cat': [
      'Provide a scratching post for your cat.',
      'Feed your cat high-quality cat food.',
      'Clean the litter box daily.',
      'Ensure regular veterinary visits for your cat.',
      'Give your cat plenty of love and attention.'
    ],
    'others': [
      'For detailed care, consult your nearest vet clinic.',
      'Provide appropriate food and shelter.',
      'Keep the living area clean and safe.',
      'Ensure regular health checkups for your pet.'
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<String> selectedTips = tips[petType] ?? tips['others']!;

    return Scaffold(
      appBar: AppBar(
        title: Text('$petType Tips & Care'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: selectedTips.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text(
                  selectedTips[index],
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
