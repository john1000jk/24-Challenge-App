import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twenty_four_game/onboarding/models/onboard_page_model.dart';

List<OnboardPageModel> onboardData = [
  OnboardPageModel(
    Colors.white,
    Colors.blue,
    Colors.black12,
    1,
    'assets/logo.png',
    '',
    '',
    'Introduction',
    'Welcome!',
    'The goal of this game is to use whatever operations '
        'possible to convert 4 numbers into the elusive 24. '
        'There are currently two game modes: practice and time trial. '
        'Scroll right to learn how they work',
  ),
  OnboardPageModel(
    Colors.amber,
    Colors.white,
    Colors.blue,
    2,
    'assets/numbers1.png',
    'assets/numbers2.png',
    '',
    'Rules',
    'Getting Started',
    'In both game modes'
        ', 4 numbers and 4 operatione will appear on screen. To select a '
        'number or operation, simply click on the button. If a number and an '
        'operation are selected, click on another number to perform the operation ',
  ),
  OnboardPageModel(
    Colors.blue,
    Colors.yellow,
    Colors.black12,
    3,
    'assets/numbers3.png',
    'assets/numbers4.png',
    '',
    'Additional Features',
    'Stuck? Skip the Question',
    'You will find two more buttons: UNDO and SKIP. '
        'UNDO reverses the last '
        'operation and SKIP sends you to a set of 4 new numbers. Once you solve '
        'or skip the problem, the app tells you a list of unique solutions',
  ),
  OnboardPageModel(
      Color.fromRGBO(0, 31, 63, 1.0),
      Color.fromRGBO(57, 204, 204, 1.0),
      Colors.white,
      4,
      'assets/numbers5.png',
      'assets/numbers6.png',
      'assets/numbers7.png',
      'Time Trial',
      'Special Icons',
      'The time trial screen also features the three icons above. '
          'The timer ticks down from 120 seconds, telling you when the game '
          'will end. The star gives you the number of problems solved this round. And '
          'the 24 store shows your high score. Hey, that rhymed!'),
];
