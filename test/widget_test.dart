import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:abc_wonder/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    expect(find.text('ABC Wonder'), findsOneWidget);
  });
}
