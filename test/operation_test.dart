import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twenty_four_game/buttons/operation.dart';
import 'package:twenty_four_game/screens/practice/numbers.dart';

const add = 0, subtract = 1, multiply = 2, divide = 3;

void main() {
  group('applyOperation', () {
    test('does basic arithmetic', () {
      expect(applyOperation(add, 5, 3), 8);
      expect(applyOperation(subtract, 5, 3), 2);
      expect(applyOperation(multiply, 5, 3), 15);
      expect(applyOperation(divide, 6, 3), 2);
      expect(applyOperation(divide, 8, 3), closeTo(2.667, 0.001));
    });

    test('refuses division by zero', () {
      expect(applyOperation(divide, 5, 0), isNull);
      expect(applyOperation(divide, 0, 0), isNull);
    });

    test('allows zero on the left of a division', () {
      expect(applyOperation(divide, 0, 5), 0);
    });
  });

  group('board', () {
    Future<List<double>> pumpBoard(WidgetTester tester, List<double> nums) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.667;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: Numbers(nums, 0)),
      ));
      return nums;
    }

    testWidgets('undo after multiplying by 0 restores the number',
        (tester) async {
      final nums = await pumpBoard(tester, [5, 0, 3, 8]);

      await tester.tap(find.text('5'));
      await tester.tap(find.byIcon(Icons.close)); // ×
      await tester.tap(find.text('0'));
      await tester.pump();
      expect(nums[1], 0); // 5 × 0 = 0 replaced the 0 tile
      expect(find.text('5'), findsNothing); // the 5 tile was used up

      await tester.tap(find.text('UNDO'));
      await tester.pump();
      expect(nums, [5, 0, 3, 8]);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('undo after dividing 0 restores the divisor', (tester) async {
      final nums = await pumpBoard(tester, [0, 5, 3, 8]);

      await tester.tap(find.text('0'));
      await tester.tap(find.byType(Image)); // ÷
      await tester.tap(find.text('5'));
      await tester.pump();
      expect(nums[1], 0); // 0 ÷ 5 = 0

      await tester.tap(find.text('UNDO'));
      await tester.pump();
      expect(nums, [0, 5, 3, 8]);
    });

    testWidgets('dividing by 0 is refused and the board is unchanged',
        (tester) async {
      final nums = await pumpBoard(tester, [5, 0, 3, 8]);

      await tester.tap(find.text('5'));
      await tester.tap(find.byType(Image)); // ÷
      await tester.tap(find.text('0'));
      await tester.pump();

      expect(nums, [5, 0, 3, 8]);
      expect(find.text("Can't divide by 0"), findsOneWidget);
      // Nothing was used up, so UNDO stays disabled.
      final undo = tester.widget<MaterialButton>(
          find.ancestor(of: find.text('UNDO'), matching: find.byType(MaterialButton)));
      expect(undo.onPressed, isNull);
    });
  });
}
