import 'package:flutter_test/flutter_test.dart';
import 'package:water_tracker/main.dart';

void main() {
  testWidgets('App starts and shows the input screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const WaterTrackerApp());
    expect(find.text('Calculate Water Intake'), findsOneWidget);
  });
}