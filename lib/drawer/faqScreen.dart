import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'faqDetails.dart';

class FAQScreen extends StatelessWidget {
  final String petType;

  FAQScreen({super.key, required this.petType});

  final Map<String, List<Map<String, String>>> faqs = {
    'dog': [
      {
        'question': 'How often should I walk my dog?',
        'answer':
            'It depends on the breed, but most dogs benefit from at least 30 minutes of exercise daily.'
      },
      {
        'question': 'What foods are toxic to dogs?',
        'answer':
            'Foods like chocolate, grapes, onions, and garlic can be toxic to dogs.'
      },
      {
        'question': 'How do I groom my dog properly?',
        'answer':
            'Brush your dog regularly, bathe them as needed, and trim their nails when they get too long.'
      },
    ],
    'cat': [
      {
        'question': 'Why does my cat scratch furniture?',
        'answer':
            'Cats scratch to mark territory, stretch, and maintain their claws. Provide a scratching post as an alternative.'
      },
      {
        'question': 'How often should I clean the litter box?',
        'answer':
            'Litter boxes should be scooped daily and fully cleaned weekly.'
      },
      {
        'question': 'Is it okay to let my cat roam outside?',
        'answer':
            'It is safer to keep your cat indoors to protect them from predators, traffic, and diseases.'
      },
    ],
    'others': [
      {
        'question': 'What should I feed my small pets?',
        'answer':
            'Diet varies by species. Consult your vet or reliable care guide for specifics.'
      },
      {
        'question': 'How often should I clean their habitat?',
        'answer':
            'Habitat cleaning depends on the pet. For example, aquariums may need weekly maintenance, while cages may require daily spot cleaning.'
      },
      {
        'question': 'How do I handle exotic pets?',
        'answer':
            'Handle them gently and only as needed to avoid stress. Learn their specific needs from a professional.'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final selectedFAQs = faqs[petType] ?? faqs['others']!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: Text('FAQs for ${GetUtils.capitalizeFirst(petType)} Pets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: selectedFAQs.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  selectedFAQs[index]['question']!,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FAQDetailScreen(
                        question: selectedFAQs[index]['question']!,
                        answer: selectedFAQs[index]['answer']!,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
