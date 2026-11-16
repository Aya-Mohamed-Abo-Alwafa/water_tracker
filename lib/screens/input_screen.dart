import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/water_calculator.dart';
import '../widgets/bottom_button.dart';
import '../widgets/counter_card.dart';
import '../widgets/gender_card.dart';
import 'result_screen.dart';

enum Gender { male, female }

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  Gender? selectedGender;
  double activityHours = 1;
  int weight = 60;
  int age = 20;

  void increaseWeight() => setState(() {
        if (weight < kMaxWeight) weight++;
      });

  void decreaseWeight() => setState(() {
        if (weight > kMinWeight) weight--;
      });

  void increaseAge() => setState(() {
        if (age < kMaxAge) age++;
      });

  void decreaseAge() => setState(() {
        if (age > kMinAge) age--;
      });

  void onCalculate() {
    // Validation
    if (selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your gender first.')),
      );
      return;
    }
    if (weight < kMinWeight ||
        weight > kMaxWeight ||
        age < kMinAge ||
        age > kMaxAge ||
        activityHours < kMinActivity ||
        activityHours > kMaxActivity) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Some values are out of range.')),
      );
      return;
    }

    final litres = calculateWaterLitres(
      weightKg: weight,
      activityHours: activityHours,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          litres: litres,
          weight: weight,
          age: age,
          activityHours: activityHours,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.water_drop, color: kWater),
            SizedBox(width: 8),
            Text('Water Tracker'),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gender cards
                    Row(
                      children: [
                        Expanded(
                          child: GenderCard(
                            icon: Icons.male,
                            label: 'MALE',
                            isSelected: selectedGender == Gender.male,
                            onTap: () =>
                                setState(() => selectedGender = Gender.male),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: GenderCard(
                            icon: Icons.female,
                            label: 'FEMALE',
                            isSelected: selectedGender == Gender.female,
                            onTap: () =>
                                setState(() => selectedGender = Gender.female),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Activity slider
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kActiveCard,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ACTIVITY (hours/day)',
                            style: TextStyle(
                              color: kTextSecondary,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              '${activityHours.toStringAsFixed(1)} h',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: kTextPrimary,
                              ),
                            ),
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: kWater,
                              inactiveTrackColor: const Color(0xFF2A2C47),
                              thumbColor: kWater,
                              overlayColor: kWater.withValues(alpha: 0.2),                            ),
                            child: Slider(
                              value: activityHours,
                              min: kMinActivity,
                              max: kMaxActivity,
                              divisions: 16,
                              onChanged: (v) =>
                                  setState(() => activityHours = v),
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('0', style: TextStyle(color: kTextSecondary)),
                              Text('8', style: TextStyle(color: kTextSecondary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Weight & Age
                    Row(
                      children: [
                        Expanded(
                          child: CounterCard(
                            title: 'WEIGHT (kg)',
                            value: weight,
                            onIncrement: increaseWeight,
                            onDecrement: decreaseWeight,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CounterCard(
                            title: 'AGE (years)',
                            value: age,
                            onIncrement: increaseAge,
                            onDecrement: decreaseAge,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: BottomButton(
                label: 'Calculate Water Intake',
                onPressed: onCalculate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
