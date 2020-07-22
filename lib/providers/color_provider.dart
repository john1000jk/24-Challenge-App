import 'package:flutter/material.dart';
import 'package:twenty_four_game/onboarding/data/onboard_page_data.dart';

class ColorProvider with ChangeNotifier {
  Color _color = onboardData[0].secondColor;
  Color get color => _color;

  set color(Color color) {
    _color = color;
    notifyListeners();
  }

}