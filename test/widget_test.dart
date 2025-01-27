import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/main.dart'; // Import your main.dart file.

void main() {
  testWidgets('App starts with the Menu screen', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify the title "Main Menu" is present.
    expect(find.text('Main Menu'), findsOneWidget);

    // Verify the Tetris title is displayed.
    expect(find.text('Tetris'), findsOneWidget);

    // Verify the "Play" button is present.
    expect(find.text('Play'), findsOneWidget);
  });

  testWidgets('Navigates to GameScreen on Play button tap', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Tap the Play button.
    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle(); // Wait for animations to complete.

    // Verify the GameScreen is displayed.
    expect(find.text('Play'), findsOneWidget); // AppBar title.
    expect(find.byType(GameScreen), findsOneWidget); // Game widget.
  });

  testWidgets('Back button navigates to Main Menu from GameScreen', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Navigate to the GameScreen.
    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();

    // Tap the back button.
    final backButton = find.byTooltip('Back'); // Matches AppBar back button.
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Verify that the Main Menu is displayed again.
    expect(find.text('Main Menu'), findsOneWidget);
  });
}
