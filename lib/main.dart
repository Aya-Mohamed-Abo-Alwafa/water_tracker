import 'package:flutter/material.dart';
import 'screens/input_screen.dart';
import 'utils/constants.dart';

void main() => runApp(const WaterTrackerApp());

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBackground,
        primaryColor: kWater,
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackground,
          foregroundColor: kTextPrimary,
          elevation: 0,
        ),
      ),
      home: const InputScreen(),
    );
  }
}