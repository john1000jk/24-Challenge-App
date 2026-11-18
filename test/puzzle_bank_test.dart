import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twenty_four_game/csv_reader.dart';
import 'package:twenty_four_game/screens/practice/normal.dart';
import 'package:twenty_four_game/screens/time_trial/time_trial.dart';

/// Playing a round must never change the puzzles stored in [Database].
void main() {
  late List<List<double>> original;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> loadBank(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.667;
    addTearDown(tester.view.reset);
    await tester.runAsync(Database.fetchVenueDatabase);
    original = [for (final nums in Database.getCombos()) List.of(nums)];
  }

  Future<void> playAMoveAndSkip(WidgetTester tester) async {
    final tiles = find.byType(MaterialButton);
    // Select the first number, pick +, then tap the second number.
    await tester.tap(tiles.at(0));
    await tester.tap(find.byIcon(Icons.add));
    await tester.tap(tiles.at(1));
    await tester.pump();
    // Skip to the next puzzle and dismiss the solutions popup.
    await tester.tap(find.text('SKIP'));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tapAt(const Offset(20, 20));
    await tester.pump(const Duration(milliseconds: 400));
  }

  void expectBankUnchanged() {
    final combos = Database.getCombos();
    for (var i = 0; i < combos.length; i++) {
      expect(combos[i], original[i], reason: 'puzzle $i was modified');
    }
  }

  testWidgets('Practice leaves the puzzle bank unchanged', (tester) async {
    await loadBank(tester);
    await tester.pumpWidget(const MaterialApp(home: Normal()));
    await playAMoveAndSkip(tester);
    expectBankUnchanged();
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('Time Trial leaves the puzzle bank unchanged', (tester) async {
    await loadBank(tester);
    await tester.pumpWidget(MaterialApp(home: TimeTrial()));
    await tester.pump();
    await playAMoveAndSkip(tester);
    expectBankUnchanged();
    await tester.pumpWidget(const SizedBox());
  });
}
