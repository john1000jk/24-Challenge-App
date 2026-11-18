import 'package:shared_preferences/shared_preferences.dart';

/// Stores the Time Trial high score on the device.
class HighScore {
  static const _key = 'highScore';

  static Future<int> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 0;
  }

  /// Saves [score] if it beats the stored high score.
  /// Returns true when a new high score was recorded.
  static Future<bool> submit(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final best = prefs.getInt(_key) ?? 0;
    if (score <= best) return false;
    await prefs.setInt(_key, score);
    return true;
  }
}
