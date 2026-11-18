import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twenty_four_game/services/high_score.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('starts at 0', () async {
    expect(await HighScore.load(), 0);
  });

  test('keeps only the best score', () async {
    expect(await HighScore.submit(5), isTrue);
    expect(await HighScore.submit(3), isFalse);
    expect(await HighScore.submit(5), isFalse);
    expect(await HighScore.load(), 5);

    expect(await HighScore.submit(8), isTrue);
    expect(await HighScore.load(), 8);
  });
}
