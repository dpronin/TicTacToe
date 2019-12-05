import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ttt/main.dart';

void main() {
  testWidgets('Display TicTacToe field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Main());

    // 9 empty squares on the screen.
    expect(find.byIcon(Icons.fullscreen), findsNWidgets(9));
  });

  testWidgets('Should win', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Main());

    // Tap the first tile.
    await tester.tap(find.byIcon(Icons.fullscreen).at(0));
    await tester.tap(find.byIcon(Icons.fullscreen).at(1));
    await tester.tap(find.byIcon(Icons.fullscreen).at(3));
    await tester.tap(find.byIcon(Icons.fullscreen).at(4));
    await tester.tap(find.byIcon(Icons.fullscreen).at(6));
    await tester.pump();

    expect(find.text("Wins"), findsOneWidget);
  });

  testWidgets('Should not win', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Main());

    // Tap the first tile.
    await tester.tap(find.byIcon(Icons.fullscreen).at(0));
    await tester.tap(find.byIcon(Icons.fullscreen).at(1));
    await tester.tap(find.byIcon(Icons.fullscreen).at(3));
    await tester.tap(find.byIcon(Icons.fullscreen).at(4));
    await tester.tap(find.byIcon(Icons.fullscreen).at(7));
    await tester.pump();

    expect(find.text("Wins"), findsNothing);
  });

  testWidgets('Should draw', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Main());

    // Tap the first tile.
    await tester.tap(find.byIcon(Icons.fullscreen).at(0));
    await tester.tap(find.byIcon(Icons.fullscreen).at(1));
    await tester.tap(find.byIcon(Icons.fullscreen).at(3));
    await tester.tap(find.byIcon(Icons.fullscreen).at(4));
    await tester.tap(find.byIcon(Icons.fullscreen).at(7));
    await tester.tap(find.byIcon(Icons.fullscreen).at(6));
    await tester.tap(find.byIcon(Icons.fullscreen).at(2));
    await tester.tap(find.byIcon(Icons.fullscreen).at(5));
    await tester.tap(find.byIcon(Icons.fullscreen).at(8));
    await tester.pump();

    expect(find.text("Draw"), findsOneWidget);
  });
}
