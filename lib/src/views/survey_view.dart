import 'package:flutter/material.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  final _surveyQuestions = [
    'How satisfied are you with our service?',
    'Would you recommend our service to others?',
    'Any additional comments?'
  ];
  final Map<String, dynamic> _surveyResponses = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var question in _surveyQuestions) ...[
              Text(
                question,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (question == _surveyQuestions[2])
                TextField(
                  onChanged: (value) {
                    _surveyResponses[question] = value;
                  },
                  decoration: const InputDecoration(hintText: 'Your comments'),
                )
              else
                DropdownButton<String>(
                  value: _surveyResponses[question] as String,
                  items: const [
                    DropdownMenuItem(value: 'Very satisfied', child: Text('Very satisfied')),
                    DropdownMenuItem(value: 'Satisfied', child: Text('Satisfied')),
                    DropdownMenuItem(value: 'Neutral', child: Text('Neutral')),
                    DropdownMenuItem(value: 'Dissatisfied', child: Text('Dissatisfied')),
                    DropdownMenuItem(value: 'Very dissatisfied', child: Text('Very dissatisfied')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _surveyResponses[question] = value;
                    });
                  },
                ),
              const SizedBox(height: 20),
            ],
            Center(
              child: ElevatedButton(
                onPressed: _submitSurvey,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitSurvey() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Survey submitted successfully!')),
    );
  }
}
