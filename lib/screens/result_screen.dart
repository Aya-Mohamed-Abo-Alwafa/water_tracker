import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/bottom_button.dart';

class ResultScreen extends StatelessWidget {
  final double litres;
  final int weight;
  final int age;
  final double activityHours;

  const ResultScreen({
    super.key,
    required this.litres,
    required this.weight,
    required this.age,
    required this.activityHours,
  });

  String get guidance {
    if (litres < 2.0) {
      return 'Relatively low estimate under this educational formula. '
          'You can spread your drinking over the day.';
    } else if (litres <= 3.0) {
      return 'Medium estimate under this educational formula. '
          'Try to spread your drinking over the day.';
    } else {
      return 'Relatively high estimate because of weight or activity hours. '
          'Actual needs vary from person to person; consult a specialist '
          'if needed.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Daily Water Intake'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Result card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 16),
                      decoration: BoxDecoration(
                        color: kActiveCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kWater, width: 2),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.water_drop, size: 56, color: kWater),
                          const SizedBox(height: 12),
                          Text(
                            litres.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.w900,
                              color: kWater,
                            ),
                          ),
                          const Text(
                            'L / Day',
                            style: TextStyle(
                              fontSize: 22,
                              color: kTextPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Estimated value (educational formula)',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kTextSecondary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Disclaimer
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: kInactiveCard,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline, color: kTextSecondary),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              'Educational estimate only - not medical advice.',
                              style: TextStyle(color: kTextSecondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Guidance text (inside a card)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kActiveCard,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        guidance,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: kTextPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Input summary: Weight & Age on the left, Activity on the right
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kInactiveCard,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weight: $weight kg',
                                style: const TextStyle(
                                  color: kTextPrimary,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Age: $age years',
                                style: const TextStyle(
                                  color: kTextPrimary,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Activity: ${activityHours.toStringAsFixed(1)} h',
                            style: const TextStyle(
                              color: kTextPrimary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: BottomButton(
                label: 'Re-calculate',
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}