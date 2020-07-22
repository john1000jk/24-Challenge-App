import 'package:flutter/material.dart';
import 'package:twenty_four_game/screens/onboarding/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:twenty_four_game/providers/color_provider.dart';

class HowToPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (context) => ColorProvider(),
      child: Onboarding(),
    ));
  }
}
