import 'package:flutter/material.dart';

class DosAndDontsScreen extends StatelessWidget {
  final String petType;

  DosAndDontsScreen({super.key, required this.petType});

  final Map<String, Map<String, List<String>>> dosAndDonts = {
    'dog': {
      'Dos': [
        'Provide daily exercise to keep your dog healthy.',
        'Train your dog with positive reinforcement.',
        'Keep your dog on a leash in public areas.',
        'Provide a balanced diet and clean water.',
        'Regularly visit the vet for checkups and vaccinations.',
      ],
      'Don\'ts': [
        'Don’t leave your dog in a hot car.',
        'Don’t feed your dog chocolate or other toxic foods.',
        'Don’t neglect grooming and dental care.',
        'Don’t allow your dog to roam unsupervised.',
        'Don’t ignore signs of illness or discomfort.',
      ],
    },
    'cat': {
      'Dos': [
        'Provide a clean litter box and fresh water daily.',
        'Ensure your cat has scratching posts.',
        'Keep your cat indoors to ensure safety.',
        'Feed your cat a balanced, high-quality diet.',
        'Take your cat for regular vet visits.',
      ],
      'Don\'ts': [
        'Don’t declaw your cat; it’s painful and unnecessary.',
        'Don’t ignore behavioral changes—they may signal health issues.',
        'Don’t give your cat human food without checking its safety.',
        'Don’t allow your cat near toxic plants or chemicals.',
        'Don’t skip regular play and interaction.',
      ],
    },
    'others': {
      'Dos': [
        'Provide species-specific care and diet.',
        'Maintain a clean and safe living environment.',
        'Ensure proper habitat setup (e.g., aquariums, cages).',
        'Handle your pet gently and only when necessary.',
        'Schedule regular health checkups with a vet.',
      ],
      'Don\'ts': [
        'Don’t use improper enclosures or habitats.',
        'Don’t feed them an inappropriate diet.',
        'Don’t expose your pet to extreme temperatures.',
        'Don’t ignore signs of stress or discomfort.',
        'Don’t keep your pet in isolation for long periods.',
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final dos = dosAndDonts[petType]?['Dos'] ?? dosAndDonts['others']!['Dos']!;
    final donts =
        dosAndDonts[petType]?['Don\'ts'] ?? dosAndDonts['others']!['Don\'ts']!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dos and Don\'ts for $petType'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Dos Section
            const Text(
              'Dos',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 8),
            ...dos.map((doItem) => ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(doItem),
                )),

            const SizedBox(height: 24),

            // Don'ts Section
            const Text(
              'Don\'ts',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 8),
            ...donts.map((dontItem) => ListTile(
                  leading: const Icon(Icons.cancel, color: Colors.red),
                  title: Text(dontItem),
                )),
          ],
        ),
      ),
    );
  }
}
